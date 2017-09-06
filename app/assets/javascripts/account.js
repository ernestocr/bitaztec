/*
 * USER home page
 * - click handler for marking notifications
 *   as read
*/

$(document).ready(function() {
  var dont_close = $('.notifications, .show-notifications');
  
  $('.show-notifications').on('click', function() {
    $('.notifications').toggle();
  });
  
  $(document).on('click', function(e) {
    if (
      !dont_close.is(e.target) && 
      dont_close.has(e.target).length === 0
    ) {
      $('.notifications').hide();
    }
  });
  
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
