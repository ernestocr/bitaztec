function saveOrder(state) {
  state.time = new Date().getTime();
  Cookies.set('home-order', state);

  document.location = '/comprar';
}


$(document).ready(function() {
  if ( $('.home').length == 0 ) { return false; }

  var btc_prices = JSON.parse( $('.selector input[type=hidden]').val() );
  
  var state = {
    pack: null,
    amount: 0,
    price: null,
    total: 0
  };

  $('.pack button').on('click', function() {
    var pack    = $(this).parent().parent();
    var pack_id = pack.attr('id');
    var amount  = parseFloat( pack.data('amount') );
    var price   = parseFloat( pack.data('price') );
    
    $('.pack').removeClass('selected');
    pack.addClass('selected');
    
    state.pack   = pack_id;
    state.amount = amount;
    state.price  = price;
    state.total  = amount * price;

    saveOrder(state);
  });

  $('.buy-right-now').on('click', function() {
    saveOrder(state);
  });

  $('.exchange input').on('input', function(e) {
    var value = $(this).val();
    var type  = $(this).attr('name');
  
    if ( value == '' ) {
      $('.exchange input').val('');
      return false;
    }
    
    if ( type == 'bitcoin' ) {
      if ( input <= 0 ) {
        $('.exchange input[name=peso]').val('');
        return false;
      }

      var $this = $(this);
      var input = $(this).val();

      var total = 0;
      for ( var i = btc_prices.length - 1; i >= 0; i-- ) {
        if ( input > btc_prices[i].minb ) {
          total = btc_prices[i].price * input;

          state.pack = null;
          state.amount = parseFloat( input );
          state.price = btc_prices[i].price;
          state.total = input * state.price;

          break;
        }
      }
      
      var formatted = total.toLocaleString( "en-US" );
      if ( formatted === '0' ) { formatted = ''; }
      
      $('.exchange input[name=peso]').val(formatted);
    
    } else if ( type == 'peso' ) {
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

      var amount = 0;
      for ( var i = btc_prices.length - 1; i > -1; i-- ) {
        if ( input >= btc_prices[i].min ) {
          amount = input / btc_prices[i].price;

          state.pack = null;
          state.amount = parseFloat( amount );
          state.price = btc_prices[i].price;
          state.total = amount * state.price;

          break;
        }
      }
    
      amount = parseFloat( amount.toString().substr(0, 10) );
      $('.exchange input[name=bitcoin]').val(amount);
    }
  });

  // initialize some values...
  $('.bitcoin input').val(0.05).trigger('input');
});
