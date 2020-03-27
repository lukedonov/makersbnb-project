$(document).ready(function () {
  $(function () {
    $('#sort').change(function () {
      this.form.submit();
    })
  })

  $(function(){
    var pageAddress = window.location.href;
    if (pageAddress.includes("recent") == true){
      $('#sort-recent').prop('selected', true);
    }
    else if (pageAddress.includes("price") == true){
      $('#sort-price').prop('selected', true);
    }
    else{
      $('#sort-all').prop('selected', true);
    };

  });
  

});