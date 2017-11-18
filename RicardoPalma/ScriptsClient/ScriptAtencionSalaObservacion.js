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


    $('#txtPaciente').typeahead({
        source: function (query, process) {
            return $.get(urlestatica + 'Atencion/GetPacientesById', { nombrepaciente: query }, function (data) {
                if (data != null && data.success && data.responseText == 'OK') {
                    data = $.parseJSON(data.data);
                    return process(data);
                }
                else
                    alert(data.responseText);
            });
        },
        limit: 10,
        displayText: function (item) { return item.name; },
        afterSelect: function (item) {
            $('#hdIdPaciente').val(item.id);
        }
    });





    $('#btnSalir').click(function () {
        window.location.href = urlestatica + 'Principal/Index';
    });

});



//modificar
function ModificarAtencionSalaObservacion(idticketemergencia, idmedico, idtratamiento, diagnostico, codicioningreso, condicionegreso) {
    $('#lsMedicoModificar option[value=' + idmedico + ']').prop('selected', true);
    $('#lsTratamientoModificar option[value=' + idtratamiento + ']').prop('selected', true);
    $('#txtDiagnosticoModificar').val(diagnostico);
    $('#txtCondicionIngresoModificar').val(codicioningreso);
    $('#txtCondicionEgresoModificar').val(condicionegreso);

    $('#hdIdTicketSalaObservacion_Modificar').val(idticketemergencia);
    $('#divModificarAtencionSalaObservacion').modal({ backdrop: 'static', keyboard: false })
}

//modificar
function GuardarModificarAtencionSalaObservacion() {
    $.ajax({
        type: 'GET',
        url: urlestatica + "Atencion/ModificarAtencionSalaObservacion",
        data: { "idTicketEmergencia": $('#hdIdTicketSalaObservacion_Modificar').val(), "idmedico": $('#lsMedicoModificar').val(), "idtratamiento": $('#lsTratamientoModificar').val(), "diagnostico": $('#txtDiagnosticoModificar').val(), "condicioningreso": $('#txtCondicionIngresoModificar').val(), "condicionegreso": $('#txtCondicionEgresoModificar').val() },
        dataType: 'json',
        success: function (response) {
            if (response != null && response.success && response.responseText == 'OK') {
                alert('Se modificó correctamente');
                $("#divModificarAtencionSalaObservacion").modal("hide");
                $('#hdIdTicketSalaObservacion_Modificar').val('');
                BuscarAtencionSalaObservacion();
            } else {
                alert(response.responseText);
            }
        }
    });
}


function ValidarSupervisor(idticketemergencia) {
    if (confirm('Está seguro de eliminar la atención?')) {
        $('#hdIdTicketEmergencia_Supervisor').val(idticketemergencia);
        $('#divSupervisor').modal({ backdrop: 'static', keyboard: false })
    }
}


//eliminar falta implementar todo eliminar
function EliminarAtencionSalaObservacion(idticketemergencia) {
    if (claveSupervisor == $('#txtClaveSupervisor').val().trim()) {
        $.ajax({
            type: 'GET',
            url: urlestatica + "Atencion/EliminarAtencionSalaObservacion",
            data: { "idTicketEmergencia": idticketemergencia },
            dataType: 'json',
            success: function (response) {
                if (response != null && response.success && response.responseText == 'OK') {
                    alert('Se eliminó correctamente');
                    $("#divSupervisor").modal("hide");
                    $('#hdIdTicketEmergencia_Supervisor').val('');
                    $('#txtClaveSupervisor').val('');
                    BuscarAtencionSalaObservacion();
                } else {
                    alert(response.responseText);
                }
            }
        });
    }
    else {
        alert('Clave incorrecta');
    }
}



function BuscarAtencionSalaObservacion() {
    vartablaOT = $('#tblListado').DataTable({
        "scrollY": 300,
        "scrollX": true,
        "ajax": {
            url: urlestatica + "Atencion/BuscarAtencionSalaObservacion",
            data: { "fechaDesde": $("#txtFechaInicio").val(), "fechaHasta": $("#txtFechaFin").val(), "paciente": ($("#txtPaciente").val() == '' ? -1 : $("#hdIdPaciente").val()), "medico": $("#lsMedico").val(), "destino": $("#lsDestino").val() },
            dataType: 'json',
            dataSrc: function (d) {
                if (!d.success) {
                    alert(d.responseText);
                }
                return d.data;
            }
        },
        "columns": [
            { "data": "Modificar" },
            { "data": "Eliminar" },
            { "data": "Ingreso" },
            { "data": "Egreso" },
            { "data": "Paciente" },
            { "data": "Medico" },
            { "data": "Tratamiento" },
            { "data": "Diagnostico" },
            { "data": "Sala" },
            { "data": "CondicionIngreso" },
            { "data": "CondicionEgreso" },
        ],
        "bDestroy": true,
        "ordering": true,
        "responsive": true,
        "order": [],
        "columnDefs": [{
            "targets": "no-sort",
            "orderable": false
        }
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
            title: 'Órdenes de Trabajo',
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


