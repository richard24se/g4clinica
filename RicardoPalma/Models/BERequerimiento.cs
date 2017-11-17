using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BERequerimiento
    {
        public string CheckSeleccionar { get; set; }
        public string BotonDetalle { get; set; }        
        public int IdRequerimiento { get; set; }
        public string FechaSolicitud { get; set; }
        public string Solicitante { get; set; }
        public List<BEInsumoForJson> Insumos { get; set; }
    }

}