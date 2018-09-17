// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function updateButtonState() {
    let cnt = $('.inswap').length;
    $('#exchange-btn').toggleClass('hidden-btn', !cnt).html('Request exchange (' + cnt + ')');
}

function initItems() {
    $('.js-swap').on('ajax:complete', function(e) {
        $('.inswap').removeClass('inswap');


        var result = JSON.parse(e.detail[0].responseText);
        result.swap.forEach(function(v) {
            $('#item' + v).addClass('inswap');
        });

        updateButtonState();
    });

    updateButtonState();
}

$(document).ready(initItems);
$(document).on('turbolinks:load', initItems);
