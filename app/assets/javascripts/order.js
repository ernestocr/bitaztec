/*
 * Show file before actual upload
 */

$(document).on('ready', function() {
  if ( !$('.receipt').length ) { return false; }
  
  // evidence preview
  $('#order_attachments').on('change', function() {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('.evidence-preview img').attr('src', e.target.result);
    };

    reader.readAsDataURL(this.files[0]);
  })
});
