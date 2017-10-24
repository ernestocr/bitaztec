/*
 * ORDER flow control
  - Show file before actual upload
  - and BTC address validation
  - permit re-upload of evidence
 */

$(document).on('ready', function() {
  if ( !$('.receipt').length ) { return false; }

  // - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - -
  // FORM VALIDATION
  // - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - -

  $('.evidence form').on('submit', function(e) {
    $(this).find('button')
      .attr('disabled', 'disabled')
      .text('Subiendo...')
      .css('opacity', 0.2);
    $(this).find('.loader').show();
    return true;
  });

  // validate form before form submit
  $('.complete-order').on('submit', function(e) {
    var btc_address = $('.wallet').val();

    /*if ( typeof $('.current-evidence img').attr('src') == 'undefined' ) {
      alert('Debes subir una imagen o un pdf de tu recibo.');
      return false;
    }*/

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

    return true;
  });

  // - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - -
  // CHATBOX
  // - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - -

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

  // - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - -
  // EVIDENCE UPLOAD
  // - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - -

  if ( !('File' in window && 'FileReader' in window && 'FileList' in window && 'Blob' in window) ) {
    $('.file-upload, .re-upload').hide();
    $('.no-file-api').show();
    return false;
  }

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
  var white_list = ['image/jpeg', 'image/png', 'image/gif', 'application/pdf'];
  $('#order_attachments').on('change', function() {
    $('.evidence-preview .images *').remove();

    if ( this.files.length == 0 ) {
      $('.evidence-preview').addClass('hidden');
      return false;
    }

    for ( var i = 0; i < this.files.length; i++ ) {

      // check file type
      if ( white_list.indexOf(this.files[i].type) === -1 ) {
        alert('Solo puedes subir imágenes (jpeg, png, gif) or archivos PDF');
        $('.evidence-preview').addClass('hidden');
        $('#order_attachments').val('');
        break;
      }

      // check file size
      var file_size = this.files[i].size/1024/1024;
      if ( file_size > 3 ) {
        alert('El archivo es muy pesado. Debe pesar menos de 3 megabytes.');
        $('.evidence-preview').addClass('hidden');
        $('#order_attachments').val('');
        break;
      }

      if ( this.files[i].type === 'application/pdf' ) {
        
        $('.evidence-preview .images').append('<div class="pdf-file"></div>');
        $('.evidence-preview').removeClass('hidden');

      } else {

        try {
          var reader = new FileReader();
          reader.onload = function(e) {
            var img = $('<img />', {
              src: e.target.result
            });
            $('.evidence-preview .images').append(img);
            $('.evidence-preview').removeClass('hidden');
          };
          reader.readAsDataURL(this.files[i]);
        } catch (e) {
          console.log(e);
          $('.evidence-preview').addClass('hidden');
        }

      }

    }
  });

});

