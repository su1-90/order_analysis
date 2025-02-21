document.addEventListener('DOMContentLoaded', () => {
  // フラッシュメッセージの表示確認用コード
  console.log("DOMContentLoaded");

  const alerts = document.querySelectorAll('.alert-dismissible');
  alerts.forEach(alert => {
    alert.querySelector('.close').addEventListener('click', () => {
      alert.style.display = 'none';
    });
  });

  // フラッシュメッセージの表示確認用コード
  console.log("Alerts:", alerts);
  alerts.forEach(alert => console.log(alert.innerHTML));
});
