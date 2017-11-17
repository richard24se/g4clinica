using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.Entity.Core;
using System.Linq;
using System.Web;
using RicardoPalma.Models;


namespace RicardoPalma.Business
{
    public class BLAtencionEmergenciaObservacion
    {
        public BEAtencionSalaObservacion AtencionSalaObservacion()
        {
            BEAtencionSalaObservacion atencion = new BEAtencionSalaObservacion();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    Destino destino = new Destino() { IdDestino = -1, Descripcion = "-Todos-" };
                    atencion.ListadoDestino = bdRicardo.Destino.ToList();
                    atencion.ListadoDestino.Insert(0, destino);

                    PersonalEmergencia personal = new PersonalEmergencia() { IdPersonalEmergencia = -1, Nombres = "-Todos-", ApellidoMaterno = string.Empty, ApellidoPaterno = string.Empty };
                    atencion.ListadoMedicos = bdRicardo.PersonalEmergencia.ToList();
                    atencion.ListadoMedicos.Insert(0, personal);

                    Paciente paciente = new Paciente() { IdPaciente = -1, Nombre = "-Todos-", ApellidoMaterno = string.Empty, ApellidoPaterno = string.Empty };
                    atencion.ListadoPacientes = bdRicardo.Paciente.ToList();
                    atencion.ListadoPacientes.Insert(0, paciente);

                    PersonalEmergencia medico = new PersonalEmergencia() { IdPersonalEmergencia = -1, Nombres = "-Todos-", ApellidoMaterno = string.Empty, ApellidoPaterno = string.Empty };
                    atencion.ListadoMedicos = bdRicardo.PersonalEmergencia.ToList();
                    atencion.ListadoMedicos.Insert(0, medico);

                    atencion.ListadoTratamiento = bdRicardo.Tratamiento.ToList();
                    atencion.ListadoMedicoMantenimiento = bdRicardo.PersonalEmergencia.ToList();
                }
            }
            catch (EntityException exx)
            {
                if (exx.InnerException != null && (exx.InnerException.Message.Contains("A network-related") || exx.InnerException.Message.Contains("Error relacionado con la red")))
                    throw new TimeoutException(ConfigurationManager.AppSettings["strErrorTimeout"]);
                else
                    throw exx;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return atencion;
        }

        public List<BEReporteAtencionSalaObservacion> BuscarAtencionSalaObservacion(string fechaDesde, string fechaHasta, int paciente, int medico, int destino)
        {
            List<BEReporteAtencionSalaObservacion> reporte = new List<BEReporteAtencionSalaObservacion>();            
            DateTime dfechaInicio = DateTime.ParseExact(fechaDesde + " 00:00:00", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
            DateTime dfechaFin = DateTime.ParseExact(fechaHasta + " 23:59:59", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
            //List<TicketEmergencia> bticket = new List<TicketEmergencia>();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    if (bdRicardo.TicketEmergencia.Where(
                        d => (d.Ingreso >= dfechaInicio &&
                            d.Ingreso <= dfechaFin) &&
                            d.Paciente.IdPaciente == (paciente == -1 ? d.Paciente.IdPaciente : paciente) &&
                            d.PersonalEmergencia.IdPersonalEmergencia == (medico == -1 ? d.PersonalEmergencia.IdPersonalEmergencia : medico) &&
                            d.Destino.IdDestino == (destino == -1 ? d.Destino.IdDestino : destino) &&
                            d.IdTicketTrauma == null &&
                            d.IdTicketSala != null
                            ).Count() > 0)
                    {
                        var resultado = bdRicardo.TicketEmergencia.Where(
                        d => (d.Ingreso >= dfechaInicio &&
                            d.Ingreso <= dfechaFin) &&
                            d.Paciente.IdPaciente == (paciente == -1 ? d.Paciente.IdPaciente : paciente) &&
                            d.PersonalEmergencia.IdPersonalEmergencia == (medico == -1 ? d.PersonalEmergencia.IdPersonalEmergencia : medico) &&
                            d.Destino.IdDestino == (destino == -1 ? d.Destino.IdDestino : destino) &&
                            d.IdTicketTrauma == null &&
                            d.IdTicketSala != null
                            ).Select(g => new
                            {
                                IdTicketEmergencia = g.IdTicketEmergencia,
                                IdPersonalEmergencia = (g.PersonalEmergencia == null ? -1 : g.PersonalEmergencia.IdPersonalEmergencia),
                                IdTratamiento = (g.Tratamiento == null ? -1 : g.Tratamiento.IdTratamiento),
                                IdTicketSala = g.IdTicketSala,
                                Ingreso = g.Ingreso,
                                Egreso = g.Egreso,
                                Paciente = g.Paciente.Nombre + " " + g.Paciente.ApellidoPaterno + " " + g.Paciente.ApellidoMaterno,
                                Medico = g.PersonalEmergencia.Nombres + " " + g.PersonalEmergencia.ApellidoPaterno + " " + g.PersonalEmergencia.ApellidoMaterno,
                                Tratamiento = (g.Tratamiento == null ? string.Empty : g.Tratamiento.Descripcion),
                                DiagnosticoObservacion = (g.IdTicketSala != null ? g.TicketSalaObservacion.Diagnostico : g.TicketTraumaShockTopico.Diagnostico),
                                Sala = (g.IdTicketSala == null && g.IdTicketTrauma != null ? "Unidad Trauma" : "Sala Observación"),
                                g.TicketSalaObservacion.CondicionIngreso,
                                g.TicketSalaObservacion.CondicionEgreso
                            }
                            ).ToList();

                        reporte = resultado.Select(g => new BEReporteAtencionSalaObservacion()
                        {
                            Modificar = "<button type='button' id='btnModificarAtencion' onclick=\"ModificarAtencionSalaObservacion(" + g.IdTicketEmergencia + "," +
                             g.IdPersonalEmergencia + "," +
                               g.IdTratamiento + "," +
                               "'" + g.DiagnosticoObservacion + "'," +
                               "'" + g.CondicionIngreso + "'," +
                               "'" + g.CondicionEgreso + "'" + ");\" class='btn btn-primary btn-xs' >Modificar</button>",
                            Eliminar = "<button type='button' id='btnEliminarAtencion' onclick='ValidarSupervisor(" + g.IdTicketEmergencia + ");' class='btn btn-primary btn-xs' >Eliminar</button>",
                            Ingreso = ((DateTime)g.Ingreso).ToString("dd/MM/yyyy"),
                            Egreso = ((DateTime)g.Egreso).ToString("dd/MM/yyyy"),
                            Paciente = g.Paciente,
                            Medico = g.Medico,
                            Tratamiento = g.Tratamiento,
                            Diagnostico = g.DiagnosticoObservacion,
                            Sala = g.Sala,
                            CondicionIngreso = g.CondicionIngreso,
                            CondicionEgreso = g.CondicionEgreso
                        }).ToList();

                    }
                }
            }
            catch (EntityException exx)
            {
                if (exx.InnerException != null && (exx.InnerException.Message.Contains("A network-related") || exx.InnerException.Message.Contains("Error relacionado con la red")))
                    throw new TimeoutException(ConfigurationManager.AppSettings["strErrorTimeout"]);
                else
                    throw exx;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return reporte;
        }

        public void ModificarAtencionSalaObservacion(int idTicketEmergencia, int idmedico, int idtratamiento, string diagnostico, string condicioningreso, string condicionegreso)
        {
            TicketEmergencia bTicket = new TicketEmergencia();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    bTicket = bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First();
                    bTicket.IdPersonalEmergencia = idmedico;
                    bTicket.IdTratamiento = idtratamiento;

                    TicketSalaObservacion observacion = bdRicardo.TicketSalaObservacion.Where(f => f.IdTicketSala == bTicket.IdTicketSala).First();
                    observacion.Diagnostico = diagnostico;
                    observacion.CondicionIngreso = condicioningreso;
                    observacion.CondicionEgreso = condicionegreso;

                    bdRicardo.SaveChanges();
                }
                
            }
            catch (EntityException exx)
            {
                if (exx.InnerException != null && (exx.InnerException.Message.Contains("A network-related") || exx.InnerException.Message.Contains("Error relacionado con la red")))
                    throw new TimeoutException(ConfigurationManager.AppSettings["strErrorTimeout"]);
                else
                    throw exx;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public void EliminarAtencionSalaObservacion(int idTicketEmergencia)
        {
            int idTicketSala = 0;
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    idTicketSala = Convert.ToInt32(bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First().IdTicketSala);

                    bdRicardo.Triaje.RemoveRange(bdRicardo.Triaje.Where(g => g.IdTicketEmergencia == idTicketEmergencia).ToList());
                    bdRicardo.TicketEmergencia.Remove(bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First());
                    bdRicardo.TicketSalaObservacion.Remove(bdRicardo.TicketSalaObservacion.Where(h => h.IdTicketSala == idTicketSala).First());

                    bdRicardo.SaveChanges();
                }
            }
            catch (EntityException exx)
            {
                if (exx.InnerException != null && (exx.InnerException.Message.Contains("A network-related") || exx.InnerException.Message.Contains("Error relacionado con la red")))
                    throw new TimeoutException(ConfigurationManager.AppSettings["strErrorTimeout"]);
                else
                    throw exx;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



    }
}