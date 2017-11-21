using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BERequerimientoTurno
    {
        public string BotonAprobar { get; set; }
        public string BotonDesaprobar { get; set; }
        public string BotonModificar { get; set; }
        public string IdRequerimiento { get; set; }
        public string Solicitante { get; set; }
        public string FechaSolicitud { get; set; }
        public string HoraInicio { get; set; }
        public string HoraFinal { get; set; }
        public string Motivo { get; set; }
    }
}