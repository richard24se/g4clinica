using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BETriaje
    {
        public IList<Sintoma> ListadoSintomas { get; set; }
        public IList<TipoPaciente> ListadoTipoPaciente { get; set; }
    }
}