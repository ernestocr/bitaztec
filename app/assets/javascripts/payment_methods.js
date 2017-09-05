$(document).ready(function() {
  if ( $('#payment_method_account_ids').length == 0 ) { return false; }

  var pm_accounts_and_cards = $.parseJSON( $('.pm_accounts').val() );
  
  var accounts = $('#payment_method_account_ids');
  var cards    = $('#payment_method_card_ids');

  var saved_card = cards.val();

  var opt_html = ['<option value="', '">', '</option>'];
  accounts.on('change', function() {
    var account_val = $(this).val();
    var account = pm_accounts_and_cards.filter(function(account) {
      return account_val == account.id;
    })[0];

    if ( typeof account == 'undefined' ) {
      var html = '<option></option>';
    } else {
      var html = '<option>' + account.cards.length + ' tarjeta(s) - selecciona una</option>';
      account.cards.forEach(function(card){
        html += opt_html[0] + card.id + opt_html[1] + card.name + opt_html[2];
      });
    }
  
    cards.find('option').remove();
    cards.append(html);
  }).change();

  cards.val(saved_card);
});
