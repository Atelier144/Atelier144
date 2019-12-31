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
//= require jquery.cookie
//= require popper
//= require bootstrap-sprockets

$(document).ready(function () {
    var emailRegExp = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;

    $(".pagetop").click(function () {
        $("html, body").animate({
            "scrollTop": 0
        }, "slow");
    });

    $("header .user-image").click(function () {
        $("header .popup-menu").show();
    });

    $("header .popup-menu .close").click(function () {
        $("header .popup-menu").hide();
    });

    $("header .hamburger").click(function () {
        if ($(this).hasClass("open")) {
            $(this).removeClass("open");
            $("header .pulldown-menu").slideUp();
        } else {
            $(this).addClass("open");
            $("header .pulldown-menu").slideDown();
        }
    });

    $(".flash").delay(2000).fadeOut();

    $("#top-carousel").carousel({
        interval: 10000
    });

    $("#js-signup-form-username").on("change", function () {
        var username = $(this).prop("value");
        if (username === "") {
            $(this).removeClass("ok").addClass("warning");
            $("#js-signup-message-username").text("ユーザー名を入力してください").show().removeClass("ok").addClass("warning");
        } else {
            $(this).removeClass("warning").addClass("ok");
            $("#js-signup-message-username").text("OK").show().removeClass("warning").addClass("ok");
        }
        signupConfirmation();
    });

    $("#js-signup-form-email").on("change", function () {
        var email = $(this).prop("value");
        if (email.match(emailRegExp)) {
            $.ajax({
                url: "signup/email_confirmation",
                type: "post",
                data: {
                    email: email
                },
                dataType: "json",
                success: function (data) {
                    if (data === null) {
                        $("#js-signup-form-email").removeClass("warning").addClass("ok");
                        $("#js-signup-message-email").text("OK").show().removeClass("warning").addClass("ok");
                    } else {
                        $("#js-signup-form-email").removeClass("ok").addClass("warning");
                        $("#js-signup-message-email").text("そのメールアドレスは既に使用されています").show().removeClass("ok").addClass("warning");
                    }
                },
                error: function (data) {
                    $(this).removeClass("ok").addClass("warning");
                    $("#js-signup-message-email").text("サーバー内部でエラーが発生しました。").show().removeClass("ok").addClass("warning");
                }
            });
        } else {
            $(this).removeClass("ok").addClass("warning");
            $("#js-signup-message-email").text("メールアドレスを入力してください").show().removeClass("ok").addClass("warning");
        }
        signupConfirmation();
    });

    $("#js-signup-form-password").on("change", function () {

        var password = $("#js-signup-form-password").prop("value");
        if (password === "") {
            $("#js-signup-form-password").removeClass("ok").addClass("warning");
            $("#js-signup-message-password").text("パスワードを入力してください").show().removeClass("ok").addClass("warning");
            $("#js-signup-form-password-confirmation").prop("disabled", "disabled");

        } else if (password.length < 8 || password.length > 32) {
            $("#js-signup-form-password").removeClass("ok").addClass("warning");
            $("#js-signup-message-password").text("8字以上、32字以下のパスワードを入力してください").show().removeClass("ok").addClass("warning");
            $("#js-signup-form-password-confirmation").prop("disabled", "disabled");
        } else {
            $("#js-signup-form-password").removeClass("warning").addClass("ok");
            $("#js-signup-message-password").text("OK").show().removeClass("warning").addClass("ok");
            $("#js-signup-form-password-confirmation").prop("disabled", "");
        }
        $("#js-signup-form-password-confirmation").prop("value", "").removeClass("ok").removeClass("warning");;
        $("#js-signup-message-password-confirmation").hide();
    });


    $("#js-signup-form-password-confirmation").on("change", function () {
        var password = $("#js-signup-form-password").prop("value");
        var passwordConfirmation = $("#js-signup-form-password-confirmation").prop("value");
        if (passwordConfirmation === "") {
            $("#js-signup-form-password-confirmation").removeClass("ok").addClass("warning");
            $("#js-signup-message-password-confirmation").text("パスワードを再入力してください").show().removeClass("ok").addClass("warning");
        } else if (password !== passwordConfirmation) {
            $("#js-signup-form-password-confirmation").removeClass("ok").addClass("warning");
            $("#js-signup-message-password-confirmation").text("もう一度入力してください").show().removeClass("ok").addClass("warning");
        } else {
            $("#js-signup-form-password-confirmation").removeClass("warning").addClass("ok");
            $("#js-signup-message-password-confirmation").text("OK").show().removeClass("warning").addClass("ok");
        }
        signupConfirmation();
    });

    function signupConfirmation() {
        var isUsernameOK = $("#js-signup-form-username").hasClass("ok");
        var isEmailOK = $("#js-signup-form-email").hasClass("ok");
        var isPasswordOK = $("#js-signup-form-password").hasClass("ok");
        var isPasswordConfirmationOK = $("#js-signup-form-password-confirmation").hasClass("ok");
        if (isUsernameOK && isEmailOK && isPasswordOK && isPasswordConfirmationOK) {
            $("#js-signup-submit").prop("disabled", "");
        } else {
            $("#js-signup-submit").prop("disabled", "disabled");
        }
    }

    */
    $("#js-setting-image-select").click(function () {
        $("#js-setting-image-file").click();
    });

    $("#js-setting-image-default").click(function () {
        if ($("#js-setting-image-file").prop("files")[0] !== undefined || $("#js-setting-image-is-default").prop("checked")) {
            $("#js-setting-image-is-default").prop("checked", false);
            $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
            $("#js-setting-image-name").text("");
            $("#js-setting-image-default").text("デフォルトに戻す");
            $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));

        } else {
            $("#js-setting-image-is-default").prop("checked", true);
            $("#js-setting-image-status").css("color", "white").css("background-color", "#FF8080").text("デフォルト");
            $("#js-setting-image-name").text("");
            $("#js-setting-image-default").text("デフォルト解除");
            $("#js-setting-image-image").attr("src", $("#js-setting-image-default-image").attr("src"));
        }
        $("#js-setting-image-file").val(undefined);
    });

    $("#js-setting-image-file").on("change", function () {
        var file = $(this).prop("files")[0];
        if (file === undefined) {
            if ($("#js-setting-image-is-default").prop("checked")) {
                $("#js-setting-image-status").css("color", "white").css("background-color", "#FF8080").text("デフォルト");
                $("#js-setting-image-name").text("");
                $("#js-setting-image-default").text("デフォルト解除");
                $("#js-setting-image-image").attr("src", $("#js-setting-image-default-image").attr("src"));
            } else {
                $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
                $("#js-setting-image-name").text("");
                $("#js-setting-image-default").text("デフォルトに戻す");
                $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));
            }
        } else {
            if (file.type.match("image.*")) {
                $("#js-setting-image-status").css("color", "#008000").css("background-color", "#80FF80").text("選択中");
                $("#js-setting-image-name").text("ファイル名：" + file.name).css("color", "black");
                $("#js-setting-image-is-default").prop("checked", false);
                $("#js-setting-image-default").text("選択解除");

                var reader = new FileReader();
                reader.onload = function () {
                    $("#js-setting-image-image").attr("src", reader.result);
                }
                reader.readAsDataURL(file);
            } else {
                $(this).val(undefined);
                $("#js-setting-image-is-default").prop("checked", false);
                $("#js-setting-image-status").css("color", "black").css("background-color", "#E6E6E6").text("未選択");
                $("#js-setting-image-name").text("画像ファイルをアップロードしてください").css("color", "red");
                $("#js-setting-image-default").text("デフォルトに戻す");
                $("#js-setting-image-image").attr("src", $("#js-setting-image-current-image").attr("src"));
            }
        }
    });
});

function GetUserIdFromUnity() {
    return document.getElementById("unity-user-id").textContent;
}

function GetLanguageCodeFromUnity() {
    return document.getElementById("unity-language-code").textContent;
}

function SendInfiniteBlocksRecordFromUnity(userId, score, level) {
    $.ajax({
        url: "/games/infinite_blocks/record",
        type: "POST",
        data: {
            user_id: userId,
            score: score,
            level: level
        },
        dataType: "html",
        success: function (data) {
            console.log("SUCCESS");
            window.location.href = "/games/infinite_blocks/records";
        },
        error: function (data) {
            console.log("FAILED");
            alert("ランキングの登録に失敗しました。");
        }
    });
}

function GetInfiniteBlocksHighScoreFromUnity() {
    var value = $.cookie("Atelier144InfiniteBlocksHighScore");
    return value;
}

function SetInfiniteBlocksHighScoreFromUnity(highScore) {
    $.cookie("Atelier144InfiniteBlocksHighScore", highScore);

}

function DestroyInfiniteBlocksHighScoreFromUnity() {
    $.cookie("Atelier144InfiniteBlocksHighScore", 0);
}

function GetInfiniteBlocksMaxLevelFromUnity() {
    var value = $.cookie("Atelier144InfiniteBlocksMaxLevel");
    return value;
}

function SetInfiniteBlocksMaxLevelFromUnity(maxLevel) {
    $.cookie("Atelier144InfiniteBlocksMaxLevel", maxLevel);
}

function DestroyInfiniteBlocksMaxLevelFromUnity() {
    $.cookie("Atelier144InfiniteBlocksMaxLevel", 0);
}
