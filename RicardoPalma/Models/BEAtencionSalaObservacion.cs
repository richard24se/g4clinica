using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RicardoPalma.Models
{
    public class BEAtencionSalaObservacion
    {
        public IList<Paciente> ListadoPacientes { get; set; }
        public IList<PersonalEmergencia> ListadoMedicos { get; set; }
        public IList<PersonalEmergencia> ListadoMedicoMantenimiento { get; set; }
        public IList<Destino> ListadoDestino { get; set; }
        public IList<Tratamiento> ListadoTratamiento { get; set; }
        public IList<Insumo> ListadoInsumo { get; set; }
        public IList<BESala> ListadoSala
        {
            get
            {
                List<BESala> sala = new List<BESala>();
                sala.Add(new BESala() { IdSala = -1, Sala = "-Todos-" });
                sala.Add(new BESala() { IdSala = 1, Sala = "Unidad Trauma" });
                sala.Add(new BESala() { IdSala = 2, Sala = "Sala Observación" });
                return sala;
            }
        }


        public IList<BESala> ListadoSalaMantenimiento
        {
            get
            {
                List<BESala> sala = new List<BESala>();
                sala.Add(new BESala() { IdSala = 1, Sala = "Unidad Trauma" });
                sala.Add(new BESala() { IdSala = 2, Sala = "Sala Observación" });
                return sala;
            }
        }
    }
}