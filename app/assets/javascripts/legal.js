$(document).ready(function() {
  if ( $('.legal').length == 0 ) { return false; }

  $('.tabs button').on('click', function() {
    $('.tabs button').removeClass('active');
    $(this).addClass('active');

    var tab = $(this).data('tab');
    $('.text').removeClass('active');
    $('.' + tab).addClass('active');
  });
});
