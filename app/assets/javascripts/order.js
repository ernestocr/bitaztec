/*
 * Show file before actual upload
 */

$(document).on('turbolinks:load', function() {
  if ( !$('.pending-buy').length ) { return false; }

  // evidence preview
  $('#order_attachments').on('change', function() {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('.evidence-preview img').attr('src', e.target.result);
    };

    reader.readAsDataURL(this.files[0]);
  })
});
