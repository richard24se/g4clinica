//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace RicardoPalma.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Protocolo
    {
        public int IdProtocolo { get; set; }
        public int IdSintoma { get; set; }
        public int IdPrioridad { get; set; }
        public int IdDestino { get; set; }
        public string Sala { get; set; }
        public string Diagnostico { get; set; }
        public string CondicionIngreso { get; set; }
        public string CondicionEgreso { get; set; }
        public int DiasAtencion { get; set; }
    
        public virtual Destino Destino { get; set; }
        public virtual Prioridad Prioridad { get; set; }
        public virtual Sintoma Sintoma { get; set; }
    }
}
