// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs

$(document).ready(function () {
    $(".pagetop").click(function () {
        $("html, body").animate({
            "scrollTop": 0
        }, "slow");
    });

    $(".records-button").click(function () {
        $(".records-button").removeClass("records-button-active");
        $(this).addClass("records-button-active");
        var category = $(this).attr("id");
        $(".records-board").hide();
        $(".records-boards").children("." + category).fadeIn();
    })
});
