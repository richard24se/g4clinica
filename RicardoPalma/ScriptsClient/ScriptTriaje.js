var vartablaOT;

$(document).ready(function () {

    $body = $("body");
    $(document).on({
        ajaxStart: function () { $body.addClass("loading"); },
        ajaxStop: function () { $body.removeClass("loading"); }
    });


    $('#txtDNI').bind('copy paste cut', function (e) {
        e.preventDefault();
    });

    $('#btnSalir').click(function () {
        window.location.href = urlestatica + 'Principal/Index';
    });

    $('#txtSintoma').typeahead({
        source: function (query, process) {
            return $.get(urlestatica + 'Triaje/GetSintomaById', { sintoma: query }, function (data) {
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
            $('#hdIdSintoma').val(item.id);
        }


    });

});


function BuscarPaciente() {
    if ($('#txtDNI').val().length != 8) {
        alert('El DNI debe tener 8 dígitos');
    }
    else {
        $.ajax({
            type: 'GET',
            url: urlestatica + "Triaje/BuscarPaciente",
            data: { "dni": $('#txtDNI').val() },
            dataType: 'json',
            success: function (response) {
                if (response != null && response.success && response.responseText == 'OK') {
                    $('#txtNombrePaciente').text(response.nombrePaciente);
                    $('#txtDNIPaciente').text(response.dniPaciente);
                    $('#txtTipoPaciente').text(response.tipoPaciente);
                }
                else if (response != null && response.success && response.responseText == 'NOPACIENTE') {
                    alert('El paciente con DNI ' + $('#txtDNI').val() + ' no se encuentra registrado.\n')
                    if (confirm('Desea ingresar un nuevo paciente?')) {
                        $('#txtNuevoNombrePaciente').val('');
                        $('#txtNuevoPaterno').val('');
                        $('#txtNuevoMaterno').val('');
                        $("#cmbTipoPaciente").prop('selectedIndex', 0);

                        $('#divNuevoPaciente').modal({ backdrop: 'static', keyboard: false })
                    }
                }
                else {
                    alert(response.responseText);
                }
            }
        });
    }




}




function GuardarPaciente() {
    if ($('#txtNuevoNombrePaciente').val().trim() == '') {
        alert('Ingrese el nombre del paciente');
    }
    else if ($('#txtNuevoPaterno').val().trim() == '') {
        alert('Ingrese el apellido paterno del paciente');
    }
    else if ($('#txtNuevoMaterno').val().trim() == '') {
        alert('Ingrese el apellido materno del paciente');
    }
    else {
        $.ajax({
            type: 'GET',
            url: urlestatica + "Triaje/GuardarPaciente",
            data: { "dni": $('#txtDNI').val(), "nombre": $('#txtNuevoNombrePaciente').val(), "appPaterno": $('#txtNuevoPaterno').val(), "appMaterno": $('#txtNuevoMaterno').val(), "tipoCliente": $('#cmbTipoPaciente').val() },
            dataType: 'json',
            success: function (response) {
                if (response != null && response.success && response.responseText == 'OK') {
                    alert('Se guardó correctamente');
                    $("#divNuevoPaciente").modal("hide");
                    //$('#txtDNI').val(response.dni);
                    BuscarPaciente();
                } else {
                    alert(response.responseText);
                }
            }
        });



    }
}



function GenerarTriaje() {
    //var idSintomas = '';
    //$('#lsSintomas > option:selected').each(function () {
    //    idSintomas = idSintomas + $(this).val() + ',';
    //    //alert($(this).text() + ' ' + $(this).val());
    //});
    //idSintomas = idSintomas.substring(0, idSintomas.length - 1);


    if ($("#txtDNI").val().trim() == '' || $('#txtNombrePaciente').text() == '') {
        alert('Debe buscar un paciente');
    }
    else if ($("#txtSintoma").val() == '') {
        alert('Debe tipear un síntoma');
    }
    else {
        if (confirm('Desea grabar la información?')) {
            GenerarGrilla($("#hdIdSintoma").val());
        }
    }


}


function GenerarGrilla(sintomas) {
    vartablaOT = $('#tblListado').DataTable({
        "scrollY": 300,
        "scrollX": true,
        "ajax": {
            url: urlestatica + "Triaje/GuardarTriaje",
            data: { "dni": $("#txtDNI").val(), "sintoma": sintomas, "esViolencia": $("#ckViolencia").prop('checked') },
            dataType: 'json',
            dataSrc: function (d) {
                if (!d.success) {
                    alert(d.responseText);
                }
                return d.data;
            }
        },
        "columns": [
            { "data": "NombrePaciente" },
            { "data": "DNI" },
            { "data": "TipoPaciente" },
            { "data": "Sintoma" },
            { "data": "Prioridad" },
            { "data": "Destino" },
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

