$(document).ready(function () {
  //$('.header').load("views/header.html");
  $(function () {
    $('#sort').change(function () {
      this.form.submit();
    })
  })
});