/*
 * Show file before actual upload
 * and BTC address validation
 */

$(document).on('ready', function() {
  if ( !$('.receipt').length ) { return false; }
  
  // evidence preview
  $('#order_attachments').on('change', function() {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('.evidence-preview img').attr('src', e.target.result);
    };

    reader.readAsDataURL(this.files[0]);
  });

  // validate btc address before form submit
  $('.complete-order').on('submit', function(e) {
    var btc_address = $('.wallet').val();
    
    if ( btc_address == '' ) {
      alert('Debes ingresar el domicilio de tu wallet.');
      return false;
    }

    if ( !WAValidator.validate(btc_address) ) {
      alert('El domiclio ingresado no es válido.');
      return false;
    }

    return true;
  });
});
