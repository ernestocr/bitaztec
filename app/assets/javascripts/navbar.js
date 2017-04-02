/*
 * Main client menu bar
 * Simple hide/show with cool hamburger
*/

$(document).on('turbolinks:load', function() {
  $('.nav ul').removeClass('is-acitve');

  $('.hamburger').on('click', function() {
    $(this).toggleClass('is-active');
    $('.nav ul').toggleClass('is-active');
  });
});
