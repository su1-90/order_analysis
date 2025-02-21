document.addEventListener('turbo:load', () => {
  console.log("Turbo Drive loaded");
  handleFlashMessages();
});

document.addEventListener('turbo:frame-load', (event) => {
  if (event.target.id === 'flash-messages-frame') {
    console.log("Flash messages frame loaded");
    handleFlashMessages();
  }
});

function handleFlashMessages() {
  const alerts = document.querySelectorAll('[id^="flash-message-"]'); // id が flash-message- で始まる要素を取得
  alerts.forEach(alert => {
    const closeButton = alert.querySelector('.close');
    if (closeButton) {
      closeButton.addEventListener('click', () => {
        alert.style.display = 'none';
      });
    }
  });

  console.log("Alerts:", alerts);
  alerts.forEach(alert => console.log(alert.innerHTML));
};
