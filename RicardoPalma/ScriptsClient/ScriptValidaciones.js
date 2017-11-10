function SoloTextoNumero(e) {
    if (e.charCode != 0) {
        //var regex = new RegExp("^[a-zA-Z0-9\\-\\s]+$");
        //var regex = new RegExp("^[a-z0-9\-\s]+$/i");
        //var patronAcentos = /^[a-zA-ZáéíóúAÉÍÓÚÑñ0-9]+$/;
        var patronAcentos = /^[a-zA-Z áéíóúÁÉÍÓÚñÑ0-9]/;
        var key = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (!patronAcentos.test(key)) {
            e.preventDefault();
            return false;
        }
    }
}

var ie = (navigator.appName.indexOf("Microsoft") >= 0)
function SoloNumerico(e) { var tecla = (ie) ? e.keyCode : e.which; var patron = /^[0-9]*$/; te = String.fromCharCode(tecla); if (!patron.test(te)) { (ie) ? e.keyCode = 0 : e.which = 0; return false; } else return true; }


function SoloDecimal(evt, rangeEnt, rangeDec) {
    //var regex = /^\d{0,5}(\.\d{0,2})?$/;


    var el = document.getElementById(document.activeElement.id);
    var charCode = (evt.which) ? evt.which : event.keyCode;
    var x = ['', ''];
    var number = el.value.split('.');
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }

    if (number.length > 1 && charCode == 46) {
        return false;
    }
    if (number[0].length == 0 && charCode == 46) {
        return false;
    }

    var caratPos = getSelectionStart(el);
    var dotPos = el.value.indexOf(".");
    if (caratPos > dotPos && dotPos > -1 && (number[1].length > 1)) {
        return false;
    }

    if (number[0].length < rangeEnt) {
        var max = el.value.length + 1;
        $("#" + el.id).attr('maxlength', max);
    }
    if (charCode == 46) {
        var max = el.value.length + 1;
        $("#" + el.id).attr('maxlength', max);
    }

    if (number.length > 1) {
        if (number[1].length < rangeDec) {
            var max = el.value.length + 1;
            $("#" + el.id).attr('maxlength', max);
        }
    }
    return true;
}
function getSelectionStart(o) {
    if (o.createTextRange) {
        var r = document.selection.createRange().duplicate()
        r.moveEnd('character', o.value.length)
        if (r.text == '') return o.value.length
        return o.value.lastIndexOf(r.text)
    } else return o.selectionStart
}



