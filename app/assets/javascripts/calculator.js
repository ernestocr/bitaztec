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
  var prec = Math.pow(10, 8);
  val = Math.round(val*prec)/prec;

  if ( $.isNumeric(val) && val > 0 ) {
    $('#order_price').data('value', price);
  } else {
    $('#order_price').data('value', null);
  }
}

function getPrice(amount) {
  for ( var i = PRICE_RANGES.length - 1; i >= 0; i-- ) {
    if ( amount > PRICE_RANGES[i].minb ) {
      return PRICE_RANGES[i].price
    }
  }
}

function getPriceFromMoney(amount) {
  for ( var i = PRICE_RANGES.length - 1; i >= 0; i-- ) {
    if ( amount > PRICE_RANGES[i].min ) {
      return PRICE_RANGES[i].price
    }
  }
}

$(document).on('ready', function() {

  /* Calculator */
  var $input1 = $('#order_amount');
  var $input2 = $('#order_amount_m');
  var result = $('.calculator .money');

  if ( !$input1.length ) { return false; }

  // amount -> money
  $input1.on('input', function(e) {
    $('.price-block').removeClass('active');

    var val = $input1.val();
    var input = parseFloat(val);
    var price = getPrice(input);

    if ( input == 0 || typeof price == 'undefined' ) {
      $input2.val('');
      return false;
    }

    if ( input*price > LIMIT.size ) {
      if ( LIMIT.reason === 'first' ) {
        alert('Solo puedes comprar hasta $' + LIMIT.size + ' pesos ya que es tu primera compra.');
      } else {
        alert('Solo puedes comprar hasta $' + LIMIT.size + ' pesos.');
      }

      var s = $(this).val();
      var s = parseFloat( s.substr(0, s.length - 1) );
      $(this).val(s);
      return false;
    }

    if ( $.isNumeric(val) && val >= 0 ) {
      var money = price*val;
      money = Math.round(100*money)/100;

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

    // for decimal inputs...
    input = Math.ceil(parseFloat(input)).toString();

    // remove unnecessary characters
    var input = input.replace(/[\D\s\._\-]+/g, '');

    // make sure it is a whole number
    input = input ? parseInt( input, 10 ) : 0;

    if ( input > LIMIT.size ) {
      if ( LIMIT.reason === 'first' ) {
        alert('Solo puedes comprar hasta $' + LIMIT.size + ' pesos ya que es tu primera compra.');
      } else {
        alert('Solo puedes comprar hasta $' + LIMIT.size + ' pesos.');
      }
      
      var s = $this.val();
      $this.val( s.substr(0, s.length - 1) );
      return false;
    }

    var formatted = input.toLocaleString( "en-US" );
    if ( formatted === '0' ) { formatted = ''; }
    $this.val( formatted );

    if ( $.isNumeric(input) && input >= 0 ) {
      var price = getPriceFromMoney(input);
      var amount = input / price;
      var precision = 8;
      var factor = Math.pow(10, precision);
      var tmp_amount = amount * factor;
      var tmp_amount = Math.round(tmp_amount);
      amount = tmp_amount / factor;
      
      // update other number input
      $input1.val(amount);
    } else {
      $input1.val('');
    }
    updateFinalCost(price, result, amount);
  });

  // Cookie Order?
  var saved_order = Cookies.getJSON('home-order');
  if ( saved_order ) {
    var now = new Date().getTime();
    if ( now - saved_order.time < 1000*60*5 ) {
      $('#order_amount_m').val(saved_order.total).trigger('input');
      $('.next').trigger('click');
      Cookies.remove('home-order');
    } else {
      console.log('order is not valid anymore');
    }
  }

});
