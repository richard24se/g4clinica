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
    
    public partial class Destino
    {
        public Destino()
        {
            this.Protocolo = new HashSet<Protocolo>();
            this.TicketEmergencia = new HashSet<TicketEmergencia>();
        }
    
        public int IdDestino { get; set; }
        public string Descripcion { get; set; }
    
        public virtual ICollection<Protocolo> Protocolo { get; set; }
        public virtual ICollection<TicketEmergencia> TicketEmergencia { get; set; }
    }
}