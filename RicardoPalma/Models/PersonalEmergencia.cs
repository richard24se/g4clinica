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
    
    public partial class PersonalEmergencia
    {
        public PersonalEmergencia()
        {
            this.TicketEmergencia = new HashSet<TicketEmergencia>();
        }
    
        public int IdPersonalEmergencia { get; set; }
        public string Nombres { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public int DNI { get; set; }
        public string Rol { get; set; }
    
        public virtual ICollection<TicketEmergencia> TicketEmergencia { get; set; }
    }
}
