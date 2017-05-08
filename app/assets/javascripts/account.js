$(document).ready(function() {
  $('.mark-as-read').on('click', function() {
    $.ajax({
      url: '/notifications/mark_as_read',
      method: 'POST'
    }).done(function(data) {
      if ( data.success == true ) {
        $('.notification').hide();
        $('.no-notifs').show();
      }
    });
  });
});
