'use strict';

var RequestPage = function() {
    $(document).on('turbolinks:load', this.init.bind(this));
};

RequestPage.prototype = {
    init: function() {
        if (!$('#request-items-list').length) {
            return;
        }

        $('.js-item-status').on('ajax:complete', function (e) {
            var result = JSON.parse(e.detail[0].responseText);
            var $el = $(e.currentTarget).closest('.item');

            $el.removeClass('item-swap-status-new_item item-swap-status-approved item-swap-status-declined');
            $el.addClass('item-swap-status-' + result.item.state);

            $('#request_state').html(result.request_state);
            $('#cnt_items').html(result.itemsCnt);

            $('#request_state').parent().attr('data-state', result.request_state);
            $('#items').attr('data-state', result.request_state);
        }.bind(this));

        $('.request-state a').on('ajax:complete', function (e) {
            var result = JSON.parse(e.detail[0].responseText);
            $('#request_state').html(result.request_state);
            $('#request_state').parent().attr('data-state', result.request_state);
            $('#items').attr('data-state', result.request_state);
        });
    }
};

var reqPage = new RequestPage();