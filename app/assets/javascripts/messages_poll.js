/*
 * CHAT/MESSAGES
 * - polling
 * - new message
*/

function rescrollChat() {
  $('.message-list').scrollTop($('.message-list')[0].scrollHeight);
}

$(document).ready(function() {
  //return false;
  // Only run if there is a chatbox
  if ( $('.messages, .chatbox').length == 0 ) { return false; }

  var order_id = $('.msgs').data('order');
  var prev_count = 0;
  var seconds = 5000;

  setInterval(function() {
    $.ajax({
      url: '/messages',
      method: 'GET',
      data: {
        order: order_id
      }
    }).done(function(data) {
      data = $(data).find('.msgs');
      var msg_count = data.find('.msg').length;
      
      if ( msg_count > 0 ) {
        $('.empty-messages').remove();
      }

      if ( msg_count > prev_count ) {
        prev_count = msg_count;
        $('.msgs').replaceWith(data);
        rescrollChat();
      } // else don't update DOM
    }).error(function(data, request) {
      alert('Existe un error de connexión, por favor recargue la página...');
    });
  }, seconds);
 
  // Submit new message 
  $('form.reply').on('submit', function() {
    var form = $(this);
    if ( form.find('textarea').val() == '' ) {
      form.find('textarea').focus();
      return false;
    }

    var data = form.serialize();
    $.ajax({
      url: '/messages?' + data,
      method: 'POST',
    }).done(function(data){
      $('.msgs').append(data);
      prev_count += 1;
      rescrollChat();
      form.find('textarea').val('').focus();
    });

    return false;
  });
  
});
