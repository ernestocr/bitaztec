/* Flow control for the buy page */

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
  var total = price * amount;

  $('.verify-price').text(price.formatMoney(0));
  $('.verify-amount').text(amount);
  $('.verify-total').text(total.formatMoney(0));
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

/* Initiate script */
$(document).ready(function() {

  var CURRENT_STEP         = 1;
  var SELECTED_METHOD      = '';
  var SELECTED_METHOD_TYPE = '';
  
  // NEXT STEP
  $('.next').on('click', function() {
    if ( $('#order_amount').val() == '' ) { return false; }
    
    $('.make-order').hide();

    if ( CURRENT_STEP == 1 ) {
      
      $('.step').hide();
      $('.step-2').show();
      $('.prev').show();

      CURRENT_STEP = 2;
    
    } else if ( CURRENT_STEP == 2) {
      
      if ( SELECTED_METHOD != '' ) {
        $('.step').hide();
        $('.step-3').show();
        $('.next').hide();
        $('.make-order').show();

        confirmBuy();
        CURRENT_STEP = 3;
      }

    }
    
    changeTab(CURRENT_STEP); 
  });
  
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

  // SHOW METHOD OPTIONS
  $('.types div').on('click', function() {
    $('.types div').removeClass('selected');
    $(this).addClass('selected');

    var method_type = $(this).data('type');

    $('.options div').hide();
    $('.options div[data-type="' + method_type + '"]').show();
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

