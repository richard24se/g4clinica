using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BEInsumo
    {
        public string codigo{ get; set; }
        public int idinsumo { get; set; }
        public int idsala{ get; set; }
        public string sala{ get; set; }
        public string nombreinsumo { get; set; }
        public int cantidad { get; set; }
        public string motivo { get; set; }
        public bool eseliminado { get; set; }


        public string IdEstado{ get; set; }
        public string Estado{ get; set; }

    }
}