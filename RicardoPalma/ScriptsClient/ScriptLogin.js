$(document).ready(function () {

    $body = $("body");
    $(document).on({
        ajaxStart: function () { $body.addClass("loading"); },
        ajaxStop: function () { $body.removeClass("loading"); }
    });


    $("#txtPassword").keyup(function (event) {
        if (event.keyCode === 13) {
            $("#btnValidar").trigger("click");
        }
    });


    $('#btnValidar').click(function () {
        if ($("#txtUsuario").val().trim() == '') {
            alert('Ingrese el usuario');
        }
        else if ($("#txtPassword").val().trim() == '') {
            alert('Ingrese el password');
        }
        else {
            DeshabilitarTextoxButtons();
            $.ajax({
                type: 'POST',
                url: urlestatica + 'Login/ValidarUsuario',
                data: { "sUsuario": $("#txtUsuario").val().trim(), "sPassword": $("#txtPassword").val().trim() },
                dataType: 'json',
                success: function (response) {
                    if (response != null && response.success && response.responseText == 'OK') {
                        window.location.href = urlestatica + 'Principal/Index';
                    }
                    else {
                        HabilitarTextoxButtons();
                        alert(response.responseText);
                    }
                }
            });
        }

    });



});



function DeshabilitarTextoxButtons() {
    $("#txtUsuario").attr("disabled", "disabled");
    $("#txtPassword").attr("disabled", "disabled");
    $("#btnValidar").attr("disabled", "disabled");
}

function HabilitarTextoxButtons() {
    $("#txtUsuario").removeAttr('disabled');
    $("#txtPassword").removeAttr('disabled');
    $("#btnValidar").removeAttr('disabled');;
}

