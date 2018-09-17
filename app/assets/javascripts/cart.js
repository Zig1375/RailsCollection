// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var CartPage = function() {
    $(document).on('turbolinks:load', this.init.bind(this));
};

CartPage.prototype = {
    init: function() {
        if (!$('#cart-items-list').length) {
            return;
        }

        $('.js-swap').on('ajax:complete', function (e) {
            $(e.currentTarget).remove();
            Turbolinks.visit(window.location, { action: 'replace' });
        }.bind(this));
    }
};

var cartPage = new CartPage();