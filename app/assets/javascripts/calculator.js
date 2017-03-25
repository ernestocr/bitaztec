/*
 *
 * Ridiculous amount of code for a simple
 * amount <-> money calculator
 *
 * ... maybe no code at all with vue.js
 *
 * REMEMBER! How much precision?
 *           And what are the rounding rules?
 */

function updateFinalCost(price, result, val) {
  var n = price.val()*val;
  if ( $.isNumeric(n) && n > 0 ) {
    // round up
    n = Math.ceil(n);
    
    // add commas and stuff
    var res = n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
    
    // update dom
    result.text('$' + res);
  } else {
    result.text('');
  }
}


$(document).on('turbolinks:load', function() {

  /* Calculator */
  var price  = $('#order_price');
  var input1 = $('#order_amount');
  var input2 = $('#order_amount_m');
  var result = $('.calculator .money');

  // amount -> money 
  input1.on('input', function(e) {
    var val = input1.val();
    if ( $.isNumeric(val) && val >= 0 ) {
      var money = price.val()*val;
      // update other input
      input2.val(money);
    } else {
      input2.val('');
    }
    updateFinalCost(price, result, val);
  });

  // money -> amount
  input2.on('input', function(e) {
    var val = input2.val();
    if ( $.isNumeric(val) && val >= 0 ) {
      var amount = val/price.val();
      // amount = Math.round( (10000*amount) )/10000;
      // update other input
      input1.val(amount);
    } else {
      input1.val('');
    }
    updateFinalCost(price, result, amount);
  });

});


