using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BEReporteTriaje
    {
        public string NombrePaciente{ get; set; }
        public int DNI{ get; set; }
        public string TipoPaciente{ get; set; }
        public string Sintoma { get; set; }
        public string Prioridad{ get; set; }
        public string Destino{ get; set; }
    }
}