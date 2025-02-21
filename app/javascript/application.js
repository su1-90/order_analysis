document.addEventListener('turbo:load', () => {
  handleFlashMessages();
});

document.addEventListener('turbo:frame-load', (event) => {
  if (event.target.id === 'flash-messages-frame') {
    handleFlashMessages();
  }
});

function handleFlashMessages() {
  const alerts = document.querySelectorAll('[id^="flash-message-"]');
  alerts.forEach(alert => {
    alert.classList.add('show');
    // フラッシュメッセージを5秒後に非表示にする
    setTimeout(() => {
      alert.classList.remove('show');
      alert.classList.add('hide');
    }, 5000);
  });
}
