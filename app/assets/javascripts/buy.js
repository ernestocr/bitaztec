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

function confirmBuy() {
  var price = $('#order_price').data('value');
  var amount = $('#order_amount').val();
  var total = price * amount;

  $('.verify-price').text(price.formatMoney(0));
  $('.verify-amount').text(amount);
  $('.verify-total').text(total.formatMoney(0));
}

function changeTab(tab) {
  $('.tab').removeClass('active');
  $('.tab-' + tab).addClass('active');
}

function submitForm() {
  // update hidden form
  var amount = $('#order_amount').val();
  $('.buy form input[name="order[amount]"]').val(amount);

  var method = $('#order_payment_method').val();
  $('.buy form select').val(method);

  // submit form
  $('.buy form').submit();
}

$(document).ready(function() {

  var steps = $('.steps');
  var current_step = 1;

  $('.make-order').on('click', function() {
    submitForm();
  });

  $('.next').on('click', function() {
    if ( $('#order_amount').val() == '' ) { return false; }
    
    $('.step').hide();
    $('.make-order').hide();

    if ( current_step == 1 ) {
      $('.step-2').show();
      $('.prev').show();

      current_step = 2;
    } else if ( current_step == 2) {
      $('.step-3').show();
      $('.next').hide();
      $('.make-order').show();

      confirmBuy();

      current_step = 3;
    }
    
    changeTab(current_step); 
  });

  $('.prev').on('click', function() {
    $('.step').hide();
    $('.make-order').hide();

    if ( current_step == 2 ) {
      $('.step-1').show();
      $('.prev').hide();

      current_step = 1;
    } else if ( current_step == 3 ) {
      $('.step-2').show();
      $('.prev').show();
      $('.next').show();

      current_step = 2;
    }
    changeTab(current_step); 
  });

});
