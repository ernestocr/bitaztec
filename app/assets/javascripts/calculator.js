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
  var n = price*val;
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

$(document).on('ready', function() {

  /* Calculator */
  var price  = $('#order_price').data('value');
  var $input1 = $('#order_amount');
  var $input2 = $('#order_amount_m');
  var result = $('.calculator .money');

  if ( !$input1.length ) { return false; }

  // amount -> money
  $input1.on('input', function(e) {
    var val = $input1.val();
    if ( $.isNumeric(val) && val >= 0 ) {
      var money = price*val;

      // update other input
      var formatted = money.toLocaleString( "en-US" );
      if ( formatted === '0' ) { formatted = ''; }
      $input2.val(formatted);
    } else {
      $input2.val('');
    }
    updateFinalCost(price, result, val);
  });

  // money -> amount
  $input2.on('input', function(event) {
    
    // makes a selection within the input
    var selection = window.getSelection().toString();
    if ( selection !== '' ) {
      return;
    }

    // presses the arrow keys
    if ( $.inArray( event.keyCode, [38, 40, 37, 39] ) !== -1 ) {
      return;
    }

    var $this = $(this);
    var input = $(this).val();

    // remove unnecessary characters
    var input = input.replace(/[\D\s\._\-]+/g, '');

    // make sure it is a whole number
    input = input ? parseInt( input, 10 ) : 0;
    
    var formatted = input.toLocaleString( "en-US" );
    if ( formatted === '0' ) { formatted = ''; }
    $this.val( formatted );
    
    // NOW CHANGE BITCOIN AMOUNT
    
    if ( $.isNumeric(input) && input >= 0 ) {
      var amount = input/price;
      amount = Math.round( (1000000*amount) )/1000000;
      // update other number input
      $input1.val(amount);
    } else {
      $input1.val('');
    }
    updateFinalCost(price, result, amount);
  });

});


