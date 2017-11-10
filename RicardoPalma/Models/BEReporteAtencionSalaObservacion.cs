using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BEReporteAtencionSalaObservacion
    {
        public string Modificar{ get; set; }
        public string Eliminar{ get; set; }

        public string Ingreso { get; set; }
        public string Egreso{ get; set; }
        public string Paciente { get; set; }
        public string Medico { get; set; }
        public string Tratamiento { get; set; }
        public string Diagnostico { get; set; }
        public string Sala { get; set; }
        public string CondicionIngreso { get; set; }
        public string CondicionEgreso { get; set; }
    }
}