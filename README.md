# README
---
# 開発環境　
* Apple M3
* macOS sequoia 15.1.1
---
# 開発言語
* Ruby version 3.3.0 
* Rails version 7.2.2.1
---
# 実行手順
```
$ git clone git@github.com:su1-90/order_analysis.git
$ cd order_analysis
$ bundle install
$ rails db:create && rails db:migrate
$ rails s
```
---
# カタログ設計
https://docs.google.com/spreadsheets/d/1MYK-Xq9TiWdAyoOWqrJhX0jcO-QdpfM7lRy6tlCkGUg/edit?usp=sharing
---
# テーブル定義書
https://docs.google.com/spreadsheets/d/1MYK-Xq9TiWdAyoOWqrJhX0jcO-QdpfM7lRy6tlCkGUg/edit?usp=sharing
---
# ワイヤーフレーム
https://www.figma.com/design/c6RvyDDqYy68EmfK6WMkfl/%E7%B5%82%E5%A3%B2%E7%AE%A1%E7%90%86%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0?node-id=0-1&t=bE4tGquU5HMMYKpc-1
---
# ER図
![Image](/public/er.png)
---
# 画面遷移図
![Image](/public/screen-transition-diagram.png)

# 開発要件

- [ ] Ruby on Railsを使ったアプリケーションであること
- [ ] HerokuもしくはAWS EC2を使ってデプロイすること
- [ ] トップページを作成すること
- [ ] トップページでサービスの概要やコンセプト、機能についての説明がなされていること
- [ ] 500と404のエラーが発生した際は独自のエラーページを表示させ、適切な内容で表示されること
- [ ] モデルとデータベースに適切なバリデーションが組まれていること
- [ ] バリデーションエラーが発生した際、該当するエラーメッセージを表示させること
- [ ] アプリケーションを利用している際に例外を発生させないこと
- [ ] seedデータを使って、各テーブルの初期データがそれぞれ5件以上投入されていること
- [ ] CRUD機能を実装すること

# デザイン要件

- [ ] 各ページで扱われているコンテンツの内容がわかるようにページのタイトルや説明が表示されていること
- [ ] ITに詳しくないユーザでも操作方法がわかるよう、デザインを工夫したり操作に関する案内が示されていること
- [ ] すべての文字があなたの国の公用語で表示されていること（可能な限り辞書機能を使って国際化しましょう。）
- [ ] バリデーションエラーメッセージやフラッシュメッセージを表示した際、レイアウトを崩さないようにすること
- [ ] デザインが適用されていない、あるいはデフォルトに近く、アプリケーションの完成度を損ねるような画面が存在していないこと
- [ ] 表示させるべき要素が他の要素の影響で隠れてしまわないようにすること
- [ ] 表示させている要素が表示領域からはみ出さないようにすること
- [ ] ヘッダーとフッターを表示させること（画面によって表示、非表示を切り替えていただいても構いません。）
- [ ] ヘッダーを画面の最上部、フッターを画面の最下部に配置すること
- [ ] リンクは遷移先のページに関連する文字を表示させること
- [ ] ボタンは実行される処理に関連する文字を表示させること
- [ ] フォームには入力する内容がわかるような文言でラベルやプレースホルダーを表示させること

# 画面遷移要件

- [ ] rootを設定すること
- [ ] 初めてアプリケーションにアクセスした際、トップページを表示させること
- [ ] ログイン後、コンテンツの利用を開始するのに相応しい画面に遷移させること

# 機能要件

- [ ] ログイン機能を実装すること
- [ ] 管理者機能を実装すること
- [ ] 管理者と一般ユーザそれぞれのゲストログイン機能を実装すること
- [ ] 管理者画面には管理者しかアクセスができないよう、コントローラにアクセスを制限するロジックが書かれていること
- [ ] 管理者のみ利用可能なリンクやボタンを一般ユーザには表示させないこと
- [ ] 不適切であったり、不必要な画面遷移をさせないこと
