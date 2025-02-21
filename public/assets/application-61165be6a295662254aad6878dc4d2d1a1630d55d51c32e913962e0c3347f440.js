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
  });
};
