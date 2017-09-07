/*
 * BUY PAGE (orders/new)
 * - flow control
*/

/* Currency format */
Number.prototype.formatMoney = function(c, d, t){
  var n = this,
    c = isNaN(c = Math.abs(c)) ? 2 : c,
    d = d == undefined ? "." : d,
    t = t == undefined ? "," : t,
    s = n < 0 ? "-" : "",
    i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
    j = (j = i.length) > 3 ? j % 3 : 0;
  return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};


/* Set text details for user confirmation */
function confirmBuy() {
  var price = $('#order_price').data('value');
  var amount = $('#order_amount').val();
  var total = Math.ceil(price * amount);
  var method = $('.options div[data-value="' +
                $('#order_payment_method').val() +
                 '"] .method-name').text();

  $('.verify-price').text(price.formatMoney(2));
  $('.verify-amount').text(amount);
  $('.verify-total').text(total.formatMoney(2));
  $('.payment-method-chosen').text(method)
}


/* Helper function for visually changing tabs */
function changeTab(tab) {
  $('.tab').removeClass('active');
  $('.tab-' + tab).addClass('active');
}

/* Pre-process order data, and then submit it to server */
function submitForm() {
  // update hidden form
  var amount = $('#order_amount').val();
  $('.buy form input[name="order[amount]"]').val(amount);

  // must be changed
  var method = $('#order_payment_method').val();
  $('.buy form select').val(method);

  // submit form
  $('.buy form').submit();
}

/* Initiate flow */
$(document).ready(function() {

  // Only run on the buy page
  if ( !$('#new-order').length ) { return false; }

  var CURRENT_STEP         = 1;
  var SELECTED_METHOD      = '';
  var SELECTED_METHOD_TYPE = '';

  // NEXT STEP
  $('.next').on('click', function() {
    if ( $('#order_amount').val() == '' ) { return false; }

    $('.make-order').hide();

    var amount = parseFloat( $('#order_amount_m').val().replace(',', '') );
    if ( amount < MIN ) {
      alert('La cantidad minima es $' + MIN + ' pesos.');
      $('#order_amount_m').focus();
      return false;
    }

    if ( CURRENT_STEP == 1 ) {

      $('.step').hide();
      $('.step-2').show();
      $('.prev').css('display', 'inline-block');
      CURRENT_STEP = 2;

    } else if ( CURRENT_STEP == 2) {

      if ( SELECTED_METHOD != '' ) {
        $('.step').hide();
        $('.step-3').show();
        $('.next').hide();
        $('.make-order').css('display', 'inline-block');
        confirmBuy();
        CURRENT_STEP = 3;

      }
    }
    changeTab(CURRENT_STEP);
  }); // END NEXT STEP

  // GO BACK
  $('.prev').on('click', function() {
    $('.step').hide();
    $('.make-order').hide();

    if ( CURRENT_STEP == 2 ) {

      $('.step-1').show();
      $('.prev').hide();

      CURRENT_STEP = 1;

    } else if ( CURRENT_STEP == 3 ) {

      $('.step-2').show();
      $('.prev').show();
      $('.next').show();

      CURRENT_STEP = 2;
    }

    changeTab(CURRENT_STEP);
  });

  // SHOW PAYMENT METHOD SUB-OPTIONS
  $('.types div').on('click', function() {
    $('.types div').removeClass('selected');
    $(this).addClass('selected');

    var method_type = $(this).data('type');

    $('.options div').removeClass('visible');
    $('.options div[data-type="' + method_type + '"]').addClass('visible');
  });

  // CHOOSE METHOD OPTION
  $('.options div').on('click', function() {
    $('.options div').removeClass('selected');
    $(this).addClass('selected');

    SELECTED_METHOD = $(this).data('value');
    $('#order_payment_method').val(SELECTED_METHOD);
  });

  // FINAL STEP
  $('.make-order').on('click', function() {
    submitForm();
  });

});
