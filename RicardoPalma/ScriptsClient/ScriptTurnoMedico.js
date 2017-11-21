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

    $('#txtFechaInicioNuevo').datetimepicker({
        format: 'DD/MM/YYYY',
        defaultDate: fechahoy
    });

    $('#txtFechaFinNuevo').datetimepicker({
        format: 'DD/MM/YYYY',
        defaultDate: fechahoy
    });



    $('#btnSalir').click(function () {
        window.location.href = urlestatica + 'Principal/Index';
    });




});


function NuevoTurnoModal() {
    $('#divNuevoTurno').modal({ backdrop: 'static', keyboard: false })
}



function ModificarTurnoMedico(idDetalleturno, inicio, fin, fecha, turno, idpersonal, idestado, comentario) {
    $('#lsPersonal option[value=' + idpersonal + ']').prop('selected', true);
    $('#lsEstado option[value=' + idestado + ']').prop('selected', true);
    $('#spInicio').text(inicio);
    $('#spFin').text(fin);
    $('#spFecha').text(fecha);
    $('#spTurno').text(turno);
    $('#txtComentario').val(comentario);

    $('#hdIDetalleTurnoModificar').val(idDetalleturno);
    $('#divModificarTurno').modal({ backdrop: 'static', keyboard: false })
}


///guardarmodificar
function ModificarTurno() {
    if (confirm('Desea guardar los cambios?')) {
        $.ajax({
            type: 'GET',
            url: urlestatica + "TurnoMedico/ModificarTurno",
            data: { "iddetalleturno": $('#hdIDetalleTurnoModificar').val(), "idpersonal": $('#lsPersonal').val(), "idestado": $('#lsEstado').val(), "motivo": $('#txtComentario').val() },
            dataType: 'json',
            success: function (response) {
                if (response != null && response.success && response.responseText == 'OK') {
                    alert('Se actualizó correctamente');
                    $("#divModificarTurno").modal("hide");
                    $('#hdIDetalleTurnoModificar').val('');
                    $('#spInicio').text('');
                    $('#spFin').text('');
                    $('#spFecha').text('');
                    $('#spTurno').text('');
                    $('#txtComentario').val('');
                    $("#lsPersonal").prop('selectedIndex', 0);
                    $("#lsEstado").prop('selectedIndex', 0);
                    BuscarTurnos();
                } else {
                    alert(response.responseText);
                }
            }
        });
    }

}





function NuevoTurno() {
    fechaInicio = moment($('#txtFechaInicioNuevo').val(), "DD/MM/YYYY");
    fechaFin = moment($('#txtFechaFinNuevo').val(), "DD/MM/YYYY");
    totaldias = fechaFin.diff(fechaInicio, 'days') + 1;

    if (totaldias > 30) {
        alert('El rango máximo permitido de fechas es 30 dias');
    }
    else {

        if (confirm('Desea guardar los cambios?')) {
            $.ajax({
                type: 'GET',
                url: urlestatica + "TurnoMedico/NuevoTurno",
                data: { "fechainicio": $('#txtFechaInicioNuevo').val(), "fechafin": $('#txtFechaFinNuevo').val() },
                dataType: 'json',
                success: function (response) {
                    if (response != null && response.success && response.responseText == 'OK') {
                        alert('Se insertó correctamente');
                        $("#divNuevoTurno").modal("hide");
                        BuscarTurnos();
                    } else {
                        alert(response.responseText);
                    }
                }
            });
        }

    }


}


function BuscarTurnos() {
    vartablaOT = $('#tblListado').DataTable({
        "scrollY": 300,
        "scrollX": true,
        "ajax": {
            url: urlestatica + "TurnoMedico/BuscarTurno",
            data: { "fecha": $("#txtFechaInicio").val() },
            dataType: 'json',
            dataSrc: function (d) {
                if (!d.success) {
                    alert(d.responseText);
                }
                return d.data;
            }
        },
        "columns": [
            { "data": "BotonModificar" },
            { "data": "Inicio" },
            { "data": "Fin" },
            { "data": "Personal" },
            { "data": "Turno" },
            { "data": "Dia" },
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
//    "targets": [0, 1, 2, 3],
//    "width": "20px"
//},
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
            title: 'Turno medico',
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




