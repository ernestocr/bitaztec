/*
 * A button to save all changes.
 * The problem is each setting is an active record
 * so we must batch update all of them.
 */

$(document).ready(function() {
  if ( !$('.settings').length ) { return false; }

  $('.save-all').on('click', function(e) {
    e.preventDefault();
    $(this).attr('disabled', 'disabled');
    $(this).text('Guardando los cambios...');

    var forms = $('.settings form');
    forms.each(function(form) {
      var id = $(this).attr('id').match(/\d+$/)[0];
      var data = $(this).serialize();
      $.ajax({
        url: '/admin/settings/' + id,
        data: data,
        method: 'POST'
      });
    });

    // wait two seconds till xhr requests return
    setTimeout(function() {
      location.reload();
    }, 2000);

    return false;
  });
});
