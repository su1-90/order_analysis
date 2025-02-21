!function(t,e){"object"==typeof exports&&"undefined"!=typeof module?e(exports):"function"==typeof define&&define.amd?define(["exports"],e):e((t="undefined"!=typeof globalThis?globalThis:t||self).ActionCable={})}(this,(function(t){"use strict";function e(t){if("function"==typeof t&&(t=t()),t&&!/^wss?:/i.test(t)){const e=document.createElement("a");return e.href=t,e.href=e.href,e.protocol=e.protocol.replace("http","ws"),e.href}return t}function n(t=i("url")||l.default_mount_path){return new y(t)}function i(t){const e=document.head.querySelector(`meta[name='action-cable-${t}']`);if(e)return e.getAttribute("content")}var s={logger:"undefined"!=typeof console?console:void 0,WebSocket:"undefined"!=typeof WebSocket?WebSocket:void 0},o={log(...t){this.enabled&&(t.push(Date.now()),s.logger.log("[ActionCable]",...t))}};const r=()=>(new Date).getTime(),c=t=>(r()-t)/1e3;class h{constructor(t){this.visibilityDidChange=this.visibilityDidChange.bind(this),this.connection=t,this.reconnectAttempts=0}start(){this.isRunning()||(this.startedAt=r(),delete this.stoppedAt,this.startPolling(),addEventListener("visibilitychange",this.visibilityDidChange),o.log(`ConnectionMonitor started. stale threshold = ${this.constructor.staleThreshold} s`))}stop(){this.isRunning()&&(this.stoppedAt=r(),this.stopPolling(),removeEventListener("visibilitychange",this.visibilityDidChange),o.log("ConnectionMonitor stopped"))}isRunning(){return this.startedAt&&!this.stoppedAt}recordMessage(){this.pingedAt=r()}recordConnect(){this.reconnectAttempts=0,delete this.disconnectedAt,o.log("ConnectionMonitor recorded connect")}recordDisconnect(){this.disconnectedAt=r(),o.log("ConnectionMonitor recorded disconnect")}startPolling(){this.stopPolling(),this.poll()}stopPolling(){clearTimeout(this.pollTimeout)}poll(){this.pollTimeout=setTimeout((()=>{this.reconnectIfStale(),this.poll()}),this.getPollInterval())}getPollInterval(){const{staleThreshold:t,reconnectionBackoffRate:e}=this.constructor;return 1e3*t*Math.pow(1+e,Math.min(this.reconnectAttempts,10))*(1+(0===this.reconnectAttempts?1:e)*Math.random())}reconnectIfStale(){this.connectionIsStale()&&(o.log(`ConnectionMonitor detected stale connection. reconnectAttempts = ${this.reconnectAttempts}, time stale = ${c(this.refreshedAt)} s, stale threshold = ${this.constructor.staleThreshold} s`),this.reconnectAttempts++,this.disconnectedRecently()?o.log(`ConnectionMonitor skipping reopening recent disconnect. time disconnected = ${c(this.disconnectedAt)} s`):(o.log("ConnectionMonitor reopening"),this.connection.reopen()))}get refreshedAt(){return this.pingedAt?this.pingedAt:this.startedAt}connectionIsStale(){return c(this.refreshedAt)>this.constructor.staleThreshold}disconnectedRecently(){return this.disconnectedAt&&c(this.disconnectedAt)<this.constructor.staleThreshold}visibilityDidChange(){"visible"===document.visibilityState&&setTimeout((()=>{!this.connectionIsStale()&&this.connection.isOpen()||(o.log(`ConnectionMonitor reopening stale connection on visibilitychange. visibilityState = ${document.visibilityState}`),this.connection.reopen())}),200)}}h.staleThreshold=6,h.reconnectionBackoffRate=.15;var l={message_types:{welcome:"welcome",disconnect:"disconnect",ping:"ping",confirmation:"confirm_subscription",rejection:"reject_subscription"},disconnect_reasons:{unauthorized:"unauthorized",invalid_request:"invalid_request",server_restart:"server_restart",remote:"remote"},default_mount_path:"/cable",protocols:["actioncable-v1-json","actioncable-unsupported"]};const{message_types:u,protocols:a}=l,d=a.slice(0,a.length-1),p=[].indexOf;class g{constructor(t){this.open=this.open.bind(this),this.consumer=t,this.subscriptions=this.consumer.subscriptions,this.monitor=new h(this),this.disconnected=!0}send(t){return!!this.isOpen()&&(this.webSocket.send(JSON.stringify(t)),!0)}open(){if(this.isActive())return o.log(`Attempted to open WebSocket, but existing socket is ${this.getState()}`),!1;{const t=[...a,...this.consumer.subprotocols||[]];return o.log(`Opening WebSocket, current state is ${this.getState()}, subprotocols: ${t}`),this.webSocket&&this.uninstallEventHandlers(),this.webSocket=new s.WebSocket(this.consumer.url,t),this.installEventHandlers(),this.monitor.start(),!0}}close({allowReconnect:t}={allowReconnect:!0}){if(t||this.monitor.stop(),this.isOpen())return this.webSocket.close()}reopen(){if(o.log(`Reopening WebSocket, current state is ${this.getState()}`),!this.isActive())return this.open();try{return this.close()}catch(t){o.log("Failed to reopen WebSocket",t)}finally{o.log(`Reopening WebSocket in ${this.constructor.reopenDelay}ms`),setTimeout(this.open,this.constructor.reopenDelay)}}getProtocol(){if(this.webSocket)return this.webSocket.protocol}isOpen(){return this.isState("open")}isActive(){return this.isState("open","connecting")}triedToReconnect(){return this.monitor.reconnectAttempts>0}isProtocolSupported(){return p.call(d,this.getProtocol())>=0}isState(...t){return p.call(t,this.getState())>=0}getState(){if(this.webSocket)for(let t in s.WebSocket)if(s.WebSocket[t]===this.webSocket.readyState)return t.toLowerCase();return null}installEventHandlers(){for(let t in this.events){const e=this.events[t].bind(this);this.webSocket[`on${t}`]=e}}uninstallEventHandlers(){for(let t in this.events)this.webSocket[`on${t}`]=function(){}}}g.reopenDelay=500,g.prototype.events={message(t){if(!this.isProtocolSupported())return;const{identifier:e,message:n,reason:i,reconnect:s,type:r}=JSON.parse(t.data);switch(this.monitor.recordMessage(),r){case u.welcome:return this.triedToReconnect()&&(this.reconnectAttempted=!0),this.monitor.recordConnect(),this.subscriptions.reload();case u.disconnect:return o.log(`Disconnecting. Reason: ${i}`),this.close({allowReconnect:s});case u.ping:return null;case u.confirmation:return this.subscriptions.confirmSubscription(e),this.reconnectAttempted?(this.reconnectAttempted=!1,this.subscriptions.notify(e,"connected",{reconnected:!0})):this.subscriptions.notify(e,"connected",{reconnected:!1});case u.rejection:return this.subscriptions.reject(e);default:return this.subscriptions.notify(e,"received",n)}},open(){if(o.log(`WebSocket onopen event, using '${this.getProtocol()}' subprotocol`),this.disconnected=!1,!this.isProtocolSupported())return o.log("Protocol is unsupported. Stopping monitor and disconnecting."),this.close({allowReconnect:!1})},close(t){if(o.log("WebSocket onclose event"),!this.disconnected)return this.disconnected=!0,this.monitor.recordDisconnect(),this.subscriptions.notifyAll("disconnected",{willAttemptReconnect:this.monitor.isRunning()})},error(){o.log("WebSocket onerror event")}};const b=function(t,e){if(null!=e)for(let n in e){const i=e[n];t[n]=i}return t};class f{constructor(t,e={},n){this.consumer=t,this.identifier=JSON.stringify(e),b(this,n)}perform(t,e={}){return e.action=t,this.send(e)}send(t){return this.consumer.send({command:"message",identifier:this.identifier,data:JSON.stringify(t)})}unsubscribe(){return this.consumer.subscriptions.remove(this)}}class m{constructor(t){this.subscriptions=t,this.pendingSubscriptions=[]}guarantee(t){-1==this.pendingSubscriptions.indexOf(t)?(o.log(`SubscriptionGuarantor guaranteeing ${t.identifier}`),this.pendingSubscriptions.push(t)):o.log(`SubscriptionGuarantor already guaranteeing ${t.identifier}`),this.startGuaranteeing()}forget(t){o.log(`SubscriptionGuarantor forgetting ${t.identifier}`),this.pendingSubscriptions=this.pendingSubscriptions.filter((e=>e!==t))}startGuaranteeing(){this.stopGuaranteeing(),this.retrySubscribing()}stopGuaranteeing(){clearTimeout(this.retryTimeout)}retrySubscribing(){this.retryTimeout=setTimeout((()=>{this.subscriptions&&"function"==typeof this.subscriptions.subscribe&&this.pendingSubscriptions.map((t=>{o.log(`SubscriptionGuarantor resubscribing ${t.identifier}`),this.subscriptions.subscribe(t)}))}),500)}}class S{constructor(t){this.consumer=t,this.guarantor=new m(this),this.subscriptions=[]}create(t,e){const n="object"==typeof t?t:{channel:t},i=new f(this.consumer,n,e);return this.add(i)}add(t){return this.subscriptions.push(t),this.consumer.ensureActiveConnection(),this.notify(t,"initialized"),this.subscribe(t),t}remove(t){return this.forget(t),this.findAll(t.identifier).length||this.sendCommand(t,"unsubscribe"),t}reject(t){return this.findAll(t).map((t=>(this.forget(t),this.notify(t,"rejected"),t)))}forget(t){return this.guarantor.forget(t),this.subscriptions=this.subscriptions.filter((e=>e!==t)),t}findAll(t){return this.subscriptions.filter((e=>e.identifier===t))}reload(){return this.subscriptions.map((t=>this.subscribe(t)))}notifyAll(t,...e){return this.subscriptions.map((n=>this.notify(n,t,...e)))}notify(t,e,...n){let i;return i="string"==typeof t?this.findAll(t):[t],i.map((t=>"function"==typeof t[e]?t[e](...n):void 0))}subscribe(t){this.sendCommand(t,"subscribe")&&this.guarantor.guarantee(t)}confirmSubscription(t){o.log(`Subscription confirmed ${t}`),this.findAll(t).map((t=>this.guarantor.forget(t)))}sendCommand(t,e){const{identifier:n}=t;return this.consumer.send({command:e,identifier:n})}}class y{constructor(t){this._url=t,this.subscriptions=new S(this),this.connection=new g(this),this.subprotocols=[]}get url(){return e(this._url)}send(t){return this.connection.send(t)}connect(){return this.connection.open()}disconnect(){return this.connection.close({allowReconnect:!1})}ensureActiveConnection(){if(!this.connection.isActive())return this.connection.open()}addSubProtocol(t){this.subprotocols=[...this.subprotocols,t]}}t.Connection=g,t.ConnectionMonitor=h,t.Consumer=y,t.INTERNAL=l,t.Subscription=f,t.SubscriptionGuarantor=m,t.Subscriptions=S,t.adapters=s,t.createConsumer=n,t.createWebSocketURL=e,t.getConfig=i,t.logger=o,Object.defineProperty(t,"__esModule",{value:!0})}));