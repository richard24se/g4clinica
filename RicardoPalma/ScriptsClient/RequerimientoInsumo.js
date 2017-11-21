function BEArrayInsumo(codigo, idinsumo, nombreinsumo, idsala, nombresala, cantidad, motivo, eseliminado) {
    this.codigo = codigo;
    this.idinsumo = idinsumo;
    this.idsala = idsala;
    this.nombresala = nombresala;
    this.nombreinsumo = nombreinsumo;
    this.cantidad = cantidad;
    this.motivo = motivo;
    this.eseliminado = eseliminado;
}
var ArrayInsumo = new Array();



function AgregarInsumo() {
    var valor = true;
    if ($("#txtCantidadInsumo").val() == '') {
        alert('Ingrese la cantidad');
        return;
    }
    else if ($("#txtMotivoInsumo").val() == '') {
        alert('Ingrese el motivo');
        return;
    }


    $.each(ArrayInsumo, function (index, value) {
        if (value.idinsumo == $("#lsInsumo").val() && value.eseliminado == 0) {
            alert('el insumo ' + $("#lsInsumo option:selected").text() + ' ya ha sido agregado');
            valor = false;
        }
    });

    if (valor) {
        var contar = ArrayInsumo.length + 1;
        ArrayInsumo.push(
                             new BEArrayInsumo(contar,
                                                $("#lsInsumo").val(),
                                                $("#lsInsumo option:selected").text(),
                                                $("#lsSala").val(),
                                                 $("#lsSala option:selected").text(),
                                                $("#txtCantidadInsumo").val(),
                                                $("#txtMotivoInsumo").val(),
                                                0

                      ));
        LlenarGrillaInsumo('tblListado', ArrayInsumo);
    }
}



function LlenarGrillaInsumo(tabla, lista) {
    //Limpia todos los registros
    $('#' + tabla + ' tbody').empty();

    //llena todos los registros de la grilla    
    $.each(lista, function (index, value) {
        if (value.eseliminado == 0) {
            var obj = document.getElementById(tabla).getElementsByTagName('tbody')[0];

            lastRow = obj.rows.length, row = obj.insertRow(lastRow);

            var cellLeft = row.insertCell(0);
            obj.rows[lastRow].cells[0].innerHTML = "<input type='hidden' value ='" + value.codigo + "'>";

            var cellLeft = row.insertCell(1);
            obj.rows[lastRow].cells[1].innerHTML = "<img id='imgEditarConfigMixta' src='../Images/remove.png' width='16px' onclick='EliminarFilaGrilla(\"tblListado\",this.parentNode.parentNode.rowIndex - 1 );' />";

            cellLeft = row.insertCell(2);
            obj.rows[lastRow].cells[2].innerText = value.nombreinsumo;

            cellLeft = row.insertCell(3);
            obj.rows[lastRow].cells[3].innerText = value.nombresala;

            cellLeft = row.insertCell(4);
            obj.rows[lastRow].cells[4].innerText = value.cantidad;

            cellLeft = row.insertCell(5);
            obj.rows[lastRow].cells[5].innerText = value.motivo;
        }
    });
}




function EliminarFilaGrilla(tabla, rowindex) {
    var codigo = $('#' + tabla + ' tbody tr:eq(' + rowindex + ')').find('input[type=hidden]').val();

    for (var i = 0; i < ArrayInsumo.length; i++) {
        if (ArrayInsumo[i].codigo == codigo) {
            ArrayInsumo[i].eseliminado = 1;
            //ConfigMixtaArray.splice(i, 1);
            break;
        }
    }

    LlenarGrillaInsumo(tabla, ArrayInsumo);
}



function GuardarInsumo() {
    $.ajax({
        type: 'GET',
        url: urlestatica + "RequerimientoInsumo/GuardarRequerimientoInsumo",
        data: { "insumos": JSON.stringify(ArrayInsumo) },
        dataType: 'json',
        success: function (response) {
            if (response != null && response.success && response.responseText == 'OK') {
                alert('Se guardó correctamente. N° de Requerimiento: ' + response.IdRequerimiento);
                ArrayInsumo = [];
                $("#txtCantidadInsumo").val(''),
                $("#txtMotivoInsumo").val(''),
                LlenarGrillaInsumo('tblListado', ArrayInsumo);
            } else {
                alert(response.responseText);
            }
        }
    });
}


function IrAutorizaciones() {
    window.location.href = urlestatica + 'RequerimientoInsumo/Autorizaciones';
}








/////////////////////////////////////////requerimientos/////////////////////////////////////////requerimientos/////////////////////////////////////////
var vartablaOT;

$(document).ready(function () {

    $body = $("body");
    $(document).on({
        ajaxStart: function () { $body.addClass("loading"); },
        ajaxStop: function () { $body.removeClass("loading"); }
    });


    var fechahoy = new Date();
    //fechahoy.setMonth(fechahoy.getMonth() - 2);
    $('#txtFechaInicio').datetimepicker({
        format: 'DD/MM/YYYY',
        defaultDate: fechahoy
    });

    $('#txtFechaFin').datetimepicker({
        format: 'DD/MM/YYYY',
        defaultDate: fechahoy
    });





    $('#btnSalir').click(function () {
        window.location.href = urlestatica + 'Principal/Index';
    });


    vartablaOT = $('#tblListadoOT').DataTable({
        "scrollY": 300,
        "scrollX": true,
        "bDestroy": true,
        "ordering": true,
        "responsive": true,
        "order": [],
        "columnDefs": [{
            "targets": "no-sort",
            "orderable": false
        }]
    });


});




function MostrarRequerimientoDetalle(idrequerimiento) {
    $.ajax({
        type: 'GET',
        url: urlestatica + "RequerimientoInsumo/ListarRequerimientoDetalle",
        data: { "idrequerimiento": idrequerimiento },
        dataType: 'json',
        success: function (response) {
            if (response != null && response.success && response.responseText == 'OK') {
                $("#tblRequerimientoDetalle tbody").append(response.Detalle);
                $("#hdIdRequerimientoDetalle").val(idrequerimiento);
                $('#divRequerimientoDetalle').modal({ backdrop: 'static', keyboard: false });
            } else {
                alert(response.responseText);
            }
        }
    });
}


function CambiarEstadoInsumo(valor) {
    var idinsumo, idestado;
    idinsumo = valor.split("|")[0];
    idestado = valor.split("|")[1];

    $.ajax({
        type: 'GET',
        url: urlestatica + "RequerimientoInsumo/CambiarEstadoInsumo",
        data: { "idrequerimiento": $("#hdIdRequerimientoDetalle").val(), "idinsumo": idinsumo, "idestado": idestado },
        dataType: 'json',
        success: function (response) {
            if (response != null && response.success && response.responseText == 'OK') {
                alert('Se cambió correctamente');
            } else {
                alert(response.responseText);
            }
        }
    });

}


function LimpiarDatosRequerimientoDetalle() {
    $("#hdIdRequerimientoDetalle").val('');
    $("#tblRequerimientoDetalle tbody").empty();
}


//function ProbarDesaprobar(valor) {
//    $('#tblListado tbody').find('tr').each(function () {
//        var row = $(this);
//        if (valor == 0) ///desactivar
//            row.find('input[type="checkbox"]').prop('checked',false);
//        else
//            row.find('input[type="checkbox"]').prop('checked', true);
//    });
//}


function AutorizarSegunCheck() {
    var listaidrequerimiento = '';
    var checkAprobarTodos;

    if ($('#rdTodos').is(':checked'))
        checkAprobarTodos = true;
    else
        checkAprobarTodos = false;


    $('#tblListado tbody').find('tr input[type="checkbox"]:checked').each(function () {
        listaidrequerimiento = listaidrequerimiento + $(this).val() + ",";
    });
    //if (checkAprobarTodos) {
    //    $('#tblListado tbody').find('tr input[type="checkbox"]:checked').each(function () {
    //        listaidrequerimiento = listaidrequerimiento + $(this).val() + ",";
    //    });
    //}
    //else {
    //    $('#tblListado tbody').find('tr input[type="checkbox"]:not(:checked)').each(function () {
    //        listaidrequerimiento = listaidrequerimiento + $(this).val() + ",";
    //    });
    //}


    listaidrequerimiento = listaidrequerimiento.substr(0, listaidrequerimiento.length - 1);



    $.ajax({
        type: 'GET',
        url: urlestatica + "RequerimientoInsumo/CambiarEstadoInsumoTodos",
        data: { "listaidrequerimiento": listaidrequerimiento, "checkAprobarTodos": checkAprobarTodos },
        dataType: 'json',
        success: function (response) {
            if (response != null && response.success && response.responseText == 'OK') {
                alert('Se actualizó los estados correctamente');
            } else {
                alert(response.responseText);
            }
        }
    });


}



function BuscarAtencionEmergencia() {
    vartablaOT = $('#tblListado').DataTable({
        "scrollY": 300,
        "scrollX": true,
        "ajax": {
            url: urlestatica + "RequerimientoInsumo/BuscarRequerimientos",
            data: { "fechaDesde": $("#txtFechaInicio").val(), "fechaHasta": $("#txtFechaFin").val(), "Idsolicitante": $("#lsSolicitante").val() },
            dataType: 'json',
            dataSrc: function (d) {
                if (!d.success) {
                    alert(d.responseText);
                }
                return d.data;
            }
        },
        "columns": [
            { "data": "CheckSeleccionar" },
            { "data": "BotonDetalle" },
            { "data": "IdRequerimiento" },
            { "data": "FechaSolicitud" },
            { "data": "Solicitante" },
        ],
        "bDestroy": true,
        "ordering": true,
        "responsive": true,
        "order": [],
        "columnDefs": [{
            "targets": "no-sort",
            "orderable": false
        },
        {
            "targets": [0],
            "width": "20px"
        },
//{
//    "targets": [3, 4, 5, 6, 7],
//    "width": "auto"
//}
        ],
        dom: 'lBfrtip',
        buttons: [
            {
                extend: 'excelHtml5',
                title: 'Listado_OT',
                exportOptions: {
                    //columns: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
                    columns: ':visible'
                },
                customize: function (xls) {
                    var sheet = xls.xl.worksheets['sheet1.xml'];
                    // jQuery selector to add a border
                    $('row c[r*="10"]', sheet).attr('s', '25');
                }
            },
        {
            extend: 'pdfHtml5',
            title: 'Requerimientos',
            orientation: 'landscape',
            pageSize: 'LEGAL',
            exportOptions: {
                columns: ':visible'
                //columns: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
            },
            customize: function (doc) {
                doc.pageMargins = [10, 10, 10, 10];
                doc.styles.title = {
                    //color: 'Black',
                    fontSize: '16',
                    //background: 'blue',
                    alignment: 'center'
                }
            }
        }
        ]

    });
}

