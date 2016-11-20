// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


// fill and hide input field for detecting dumb spam bots
$(document).on('turbolinks:load', function (event) {
    $('#poll_calculation, #comment_calculation').val('0x17').closest('.calculation').css('display', 'none');
});


// add new choice to the list
$(document).on('turbolinks:load', function (event) {
    $('#add_choice').on('click', function (event) {
        var choices = $('#choices').children('p');
        var new_choice = choices.first().clone();
        var update_index = function (_, str) {
            return str.replace('0', choices.size());
        };
        new_choice.find('label').prop('for', update_index);
        new_choice.find('input').val('').prop('id', update_index).prop('name', update_index);
        new_choice.appendTo(choices.parent());
        return false;
    });
});
