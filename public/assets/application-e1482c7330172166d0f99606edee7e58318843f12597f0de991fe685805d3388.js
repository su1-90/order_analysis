document.addEventListener('DOMContentLoaded', () => {
  console.log("DOMContentLoaded");

  const alerts = document.querySelectorAll('.alert-dismissible');
  alerts.forEach(alert => {
    const closeButton = alert.querySelector('.close');
    if (closeButton) { // closeButton が存在する場合のみイベントリスナーを追加
      closeButton.addEventListener('click', () => {
        alert.style.display = 'none';
      });
    }
  });

  console.log("Alerts:", alerts);
  alerts.forEach(alert => console.log(alert.innerHTML));
});
