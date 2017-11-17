using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BERequerimiento
    {
        public int IdRequerimiento { get; set; }
        public string FechaSolicitud { get; set; }
        public string Solicitante { get; set; }
        public List<BEInsumo> Insumos{ get; set; }
    }

}