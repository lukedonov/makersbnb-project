$(document).ready(function () {
  $("#property").html("IT WORKS!");
  $(function () {
    $('#sort').change(function () {
      this.form.submit();
    })
  })
});