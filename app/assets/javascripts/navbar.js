/*
 * Main client menu bar
 * Simple hide/show with cool hamburger
*/

$(document).on('ready', function() {
  $('.hamburger').on('click', function() {
    $(this).toggleClass('is-active');
    $('.nav ul').toggleClass('is-active');
  });
});
