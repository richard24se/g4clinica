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
    
    public partial class Turno
    {
        public Turno()
        {
            this.DetalleTurno = new HashSet<DetalleTurno>();
        }
    
        public int IdTurno { get; set; }
        public string NombreTurno { get; set; }
        public string Rango1 { get; set; }
        public string Rango2 { get; set; }
    
        public virtual ICollection<DetalleTurno> DetalleTurno { get; set; }
    }
}