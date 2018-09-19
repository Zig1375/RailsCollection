// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var ItemsPage = function() {
    $(document).on('turbolinks:load', this.init.bind(this));
};

ItemsPage.prototype = {
    init: function() {
        if (!$('#items-list').length) {
            return;
        }

        $('.js-swap').on('ajax:complete', function (e) {
            $('.inswap').removeClass('inswap');


            var result = JSON.parse(e.detail[0].responseText);
            result.request.forEach(function (v) {
                $('#item' + v).addClass('inswap');
            });

            this.updateButtonState();
        }.bind(this));

        this.updateButtonState();
    },

    updateButtonState: function() {
        let cnt = $('.inswap').length;
        $('#exchange-btn').toggleClass('hidden-btn', !cnt).html('Request exchange (' + cnt + ')');
    }
};

var itemPage = new ItemsPage();