/*
 * ORDER flow control
  - Show file before actual upload
  - and BTC address validation
  - permit re-upload of evidence
 */

$(document).on('ready', function() {
  if ( !$('.receipt').length ) { return false; }

  // re-upload-evidence
  $('.re-upload').on('click', function(e) {
    e.preventDefault();
    
    $('.file-upload').toggleClass('hidden');
    $('.current-evidence-wrap').toggle();

    var tmp = $(this).text();
    $(this).text($(this).attr('text'));
    $(this).attr('text', tmp);
  });

  // evidence preview
  $('#order_attachments').on('change', function() {
    try {
      var reader = new FileReader();
      reader.onload = function(e) { $('.evidence-preview img').attr('src', e.target.result);
        $('.evidence-preview').removeClass('hidden');
      };
      reader.readAsDataURL(this.files[0]);
    } catch (e) {
      $('.evidence-preview').addClass('hidden');
    }
  });

  // validate form before form submit
  $('.complete-order').on('submit', function(e) {
    var btc_address = $('.wallet').val();

    if ( typeof $('.current-evidence img').attr('src') == 'undefined' ) {
      alert('Debes subir una imagen o un pdf de tu recibo.');
      return false;
    }

    if ( btc_address == '' ) {
      alert('Debes ingresar el domicilio de tu wallet.');
      $('.wallet').focus();
      return false;
    }

    // check: 16b9JaRAafNkNrtstspGzdRk5cRhj9MThZ
    btc_address = btc_address.trim();
    if ( !WAValidator.validate(btc_address) ) {
      alert('El domiclio ingresado no es válido.');
      $('.wallet').focus();
      return false;
    }

    // confirm address
    // var wallet_confirmation = prompt('Por favor confirme el domicilio receptor')
    // if ( btc_address == wallet_confirmation.trim() ) {
    //   return true;
    // }

    return true;
  });

  // Toggle Chatbox
  $('.chatbox .head').on('click', function(e) {
    if ( $(e.target).hasClass('close') ) {
      $('.chatbox').addClass('hidden');
    } else {
      $('.chatbox').removeClass('hidden');
    }
  });

  // If url has #newmsg -> show chat box by default
  if ( window.location.hash == '#newmsg' ) {
    $('.chatbox').removeClass('hidden');
  }

});

