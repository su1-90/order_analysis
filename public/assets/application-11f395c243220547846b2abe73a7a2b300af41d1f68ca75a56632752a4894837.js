import Rails from "@rails/ujs";
Rails.start();

// Turboを無効にするためのコメントアウト
// import "@hotwired/turbo-rails";
import "controllers";
import * as bootstrap from "bootstrap";

document.addEventListener('DOMContentLoaded', () => {
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
