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



    //$('#txtIdRequerimiento').typeahead({
    //    source: function (query, process) {
    //        return $.get(urlestatica + 'RequerimientoTurno/GetIdRequerimientoById', { idrequerimiento: query }, function (data) {
    //            if (data != null && data.success && data.responseText == 'OK') {
    //                data = $.parseJSON(data.data);
    //                return process(data);
    //            }
    //            else
    //                alert(data.responseText);
    //        });
    //    },
    //    limit: 10,
    //    displayText: function (item) { return item.name; },
    //    afterSelect: function (item) {
    //        $('#hdIdPaciente').val(item.id);
    //    }
    //});




    $('#btnSalir').click(function () {
        window.location.href = urlestatica + 'Principal/Index';
    });


    vartablaOT = $('#tblListado').DataTable({
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


function MostrarModificacion(idrequerimiento) {
    $('#hdIdRequerimiento').val(idrequerimiento);
    $('#divModificacion').modal({ backdrop: 'static', keyboard: false })
}



function ModificarMotivo(idrequerimiento) {
    $.ajax({
        type: 'GET',
        url: urlestatica + "RequerimientoTurno/Modificar",
        data: { "idrequerimiento": idrequerimiento, "motivo": $("#txtMotivoModificacion").val() },
        dataType: 'json',
        success: function (response) {
            if (response != null && response.success && response.responseText == 'OK') {
                alert('Se cambió correctamente');
                $("#divModificacion").modal("hide");
                $('#hdIdRequerimiento').val('');
                $('#txtMotivoModificacion').val('');
                BuscarRequerimientos();
            } else {
                alert(response.responseText);
            }
        }
    });
}




function AprobarDesaprobar(idrequerimiento, esAprobado) {
    $.ajax({
        type: 'GET',
        url: urlestatica + "RequerimientoTurno/AprobarDesaprobar",
        data: { "idrequerimiento": idrequerimiento, "esAprobado": esAprobado },
        dataType: 'json',
        success: function (response) {
            if (response != null && response.success && response.responseText == 'OK') {
                alert('Se cambió correctamente');
                BuscarRequerimientos();
            } else {
                alert(response.responseText);
            }
        }
    });
}



function BuscarRequerimientos() {
    vartablaOT = $('#tblListado').DataTable({
        "scrollY": 300,
        "scrollX": true,
        "ajax": {
            url: urlestatica + "RequerimientoTurno/BuscarRequerimientos",
            data: { "fechaDesde": $("#txtFechaInicio").val(), "fechaHasta": $("#txtFechaFin").val(), "IdRequerimiento": ($("#txtIdRequerimiento").val() == '' ? 0 : $("#txtIdRequerimiento").val()) },
            dataType: 'json',
            dataSrc: function (d) {
                if (!d.success) {
                    alert(d.responseText);
                }
                return d.data;
            }
        },
        "columns": [
            { "data": "BotonAprobar" },
            { "data": "BotonDesaprobar" },
            { "data": "BotonModificar" },
            { "data": "IdRequerimiento" },
            { "data": "Solicitante" },
            { "data": "FechaSolicitud" },
            { "data": "HoraInicio" },
            { "data": "HoraFinal" },
            { "data": "Motivo" },
        ],
        "bDestroy": true,
        "ordering": true,
        "responsive": true,
        "order": [],
        "columnDefs": [{
            "targets": "no-sort",
            "orderable": false
        },
        //{
        //    "targets": [0],
        //    "width": "20px"
        //},
{
    "targets": [0, 1, 2, 3],
    "width": "20px"
},
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
            title: 'Atenciones',
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


