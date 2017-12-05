/*
 * A button to save all changes.
 * The problem is each setting is an active record
 * so we must batch update all of them.
 */

$(document).ready(function() {
  if ( !$('.settings').length ) { return false; }

  var csrf_token = $('meta[name="csrf-token"').attr('content');

  $('.save-all').on('click', function() {
    $(this).prop('disabled', true);
    $(this).text('Guardando los cambios...');
    
    var forms = {};
    $('form').each(function() {
      var setting_id = $(this).attr('id').split('_').pop();
      var form_data = $(this).serializeArray();
      forms[setting_id] = form_data.pop().value;
    });
  
    $.ajax({
      url: '/admin/settings/update_all',
      method: 'POST',
      data: {
        settings: forms
      }
    }).done(function(data) {
      $('.save-all').prop('disabled', false);
      $('.save-all').text('Guardar todos los cambios');
      
      if ( data == true ) {
        alert('Los cambios se han guardados!');
      }
    });

  });
  
    
});
