using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RicardoPalma.Models;
using System.Configuration;
using System.Data.Objects.SqlClient;

namespace RicardoPalma.Controllers
{
    public class AtencionController : Controller
    {
        #region AtencionEmergencia
        public ActionResult AtencionEmergencia()
        {
            BEAtencionEmergencia atencion = new BEAtencionEmergencia();
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
            catch (Exception ex)
            {
                throw ex;
            }
            return View(atencion);
        }

        [HttpGet]
        public ActionResult RegistrarAtencionEmergencia(int idTicketEmergencia, int idsala)
        {
            TicketEmergencia bTicket = new TicketEmergencia();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    bTicket = bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First();
                    if (idsala == 1/*trauma*/ )
                    {
                        if (bTicket.IdTicketTrauma == null)
                        {
                            //registrar a trauma
                            TicketTraumaShockTopico trauma = new TicketTraumaShockTopico();
                            trauma.Ingreso = DateTime.Now;
                            trauma.EsTraumaShock = true;
                            bdRicardo.TicketTraumaShockTopico.Add(trauma);
                            bdRicardo.SaveChanges();

                            ///despues de crear el truma asignar el id
                            bTicket.IdTicketTrauma = trauma.IdTicketTrauma;

                            ///borrar la sala topico
                            bdRicardo.TicketSalaObservacion.Remove(bdRicardo.TicketSalaObservacion.Where(f => f.IdTicketSala == bTicket.IdTicketSala).First());
                            bdRicardo.SaveChanges();

                            //asignar null  a topico
                            bTicket.IdTicketSala = null;
                            bdRicardo.SaveChanges();
                        }
                    }
                    else
                    {
                        if (bTicket.IdTicketSala == null)
                        {
                            //registrar a sala topico
                            TicketSalaObservacion observacion = new TicketSalaObservacion();
                            observacion.Ingreso = DateTime.Now;
                            bdRicardo.TicketSalaObservacion.Add(observacion);
                            bdRicardo.SaveChanges();

                            ///despues de crear el topico observacion asignar el id
                            bTicket.IdTicketSala = observacion.IdTicketSala;

                            //borrar la sala trauma
                            bdRicardo.TicketTraumaShockTopico.Remove(bdRicardo.TicketTraumaShockTopico.Where(g => g.IdTicketTrauma == bTicket.IdTicketTrauma).First());
                            bdRicardo.SaveChanges();

                            //asignar null a trauma
                            bTicket.IdTicketTrauma = null;
                            bdRicardo.SaveChanges();
                        }
                    }
                }
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public ActionResult ModificarAtencionEmergencia(int idTicketEmergencia, int idmedico, int idtratamiento, string diagnostico, int idsala)
        {
            TicketEmergencia bTicket = new TicketEmergencia();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    bTicket = bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First();
                    bTicket.IdPersonalEmergencia = idmedico;
                    bTicket.IdTratamiento = idtratamiento;

                    if (idsala == 1/*trauma*/ )
                    {
                        if (bTicket.IdTicketTrauma == null)
                        {
                            //registrar a trauma
                            TicketTraumaShockTopico trauma = new TicketTraumaShockTopico();
                            trauma.Ingreso = DateTime.Now;
                            trauma.EsTraumaShock = true;
                            trauma.Diagnostico = diagnostico;
                            bdRicardo.TicketTraumaShockTopico.Add(trauma);
                            bdRicardo.SaveChanges();

                            ///despues de crear el truma asignar el id
                            bTicket.IdTicketTrauma = trauma.IdTicketTrauma;

                            ///borrar la sala topico
                            bdRicardo.TicketSalaObservacion.Remove(bdRicardo.TicketSalaObservacion.Where(f => f.IdTicketSala == bTicket.IdTicketSala).First());
                            bdRicardo.SaveChanges();

                            //asignar null  a topico
                            bTicket.IdTicketSala = null;
                            bdRicardo.SaveChanges();
                        }
                        else
                        {
                            TicketTraumaShockTopico trauma = bdRicardo.TicketTraumaShockTopico.Where(g => g.IdTicketTrauma == bTicket.IdTicketTrauma).First();
                            trauma.Diagnostico = diagnostico;
                            bdRicardo.SaveChanges();
                        }
                    }
                    else
                    {
                        if (bTicket.IdTicketSala == null)
                        {
                            //registrar a sala topico
                            TicketSalaObservacion observacion = new TicketSalaObservacion();
                            observacion.Ingreso = DateTime.Now;
                            observacion.Diagnostico = diagnostico;
                            bdRicardo.TicketSalaObservacion.Add(observacion);
                            bdRicardo.SaveChanges();

                            ///despues de crear el topico observacion asignar el id
                            bTicket.IdTicketSala = observacion.IdTicketSala;

                            //borrar la sala trauma
                            bdRicardo.TicketTraumaShockTopico.Remove(bdRicardo.TicketTraumaShockTopico.Where(g => g.IdTicketTrauma == bTicket.IdTicketTrauma).First());
                            bdRicardo.SaveChanges();

                            //asignar null a trauma
                            bTicket.IdTicketTrauma = null;
                            bdRicardo.SaveChanges();
                        }
                        else
                        {
                            TicketSalaObservacion observacion = bdRicardo.TicketSalaObservacion.Where(g => g.IdTicketSala == bTicket.IdTicketSala).First();
                            observacion.Diagnostico = diagnostico;
                            bdRicardo.SaveChanges();
                        }
                    }
                    bdRicardo.SaveChanges();
                }
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public ActionResult EliminarAtencionEmergencia(int idTicketEmergencia)
        {
            TicketEmergencia bTicket = new TicketEmergencia();
            List<Triaje> bTriaje = new List<Triaje>();
            TicketTraumaShockTopico trauma = new TicketTraumaShockTopico();
            TicketSalaObservacion topico = new TicketSalaObservacion();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    bTriaje = bdRicardo.Triaje.Where(g => g.IdTicketEmergencia == idTicketEmergencia).ToList();
                    bTicket = bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First();
                    if (bTicket.IdTicketSala != null)
                    {
                        topico = bdRicardo.TicketSalaObservacion.Where(g => g.IdTicketSala == bTicket.IdTicketSala).First();
                        bdRicardo.TicketSalaObservacion.Remove(topico);
                    }
                    else
                    {
                        trauma = bdRicardo.TicketTraumaShockTopico.Where(g => g.IdTicketTrauma == bTicket.IdTicketTrauma).First();
                        bdRicardo.TicketTraumaShockTopico.Remove(trauma);
                    }
                    bdRicardo.Triaje.RemoveRange(bTriaje);
                    bdRicardo.TicketEmergencia.Remove(bTicket);
                    bdRicardo.SaveChanges();
                }
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public ActionResult BuscarAtencionEmergencia(string fechaDesde, string fechaHasta, int paciente, int medico, int destino, int sala)
        {
            List<BEReporteAtencionEmergencia> reporte = new List<BEReporteAtencionEmergencia>();
            DateTime dfechaInicio = DateTime.ParseExact(fechaDesde, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime dfechaFin = DateTime.ParseExact(fechaHasta, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
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
                            d.IdTicketTrauma == (sala == -1 || sala == 1 ? d.IdTicketTrauma : null) &&
                            d.IdTicketSala == (sala == -1 || sala == 2 ? d.IdTicketSala : null)
                            ).Count() > 0)
                    {

                        var resultado = bdRicardo.TicketEmergencia.Where(
                        d => (d.Ingreso >= dfechaInicio &&
                            d.Ingreso <= dfechaFin) &&
                            d.Paciente.IdPaciente == (paciente == -1 ? d.Paciente.IdPaciente : paciente) &&
                            d.PersonalEmergencia.IdPersonalEmergencia == (medico == -1 ? d.PersonalEmergencia.IdPersonalEmergencia : medico) &&
                            d.Destino.IdDestino == (destino == -1 ? d.Destino.IdDestino : destino) &&
                            d.IdTicketTrauma == (sala == -1 || sala == 1 ? d.IdTicketTrauma : null) &&
                            d.IdTicketSala == (sala == -1 || sala == 2 ? d.IdTicketSala : null)
                            ).Select(g => new
                            {
                                IdTicketEmergencia = g.IdTicketEmergencia,
                                IdPersonalEmergencia = (g.PersonalEmergencia == null ? -1 : g.PersonalEmergencia.IdPersonalEmergencia),
                                IdTratamiento = (g.Tratamiento == null ? -1 : g.Tratamiento.IdTratamiento),
                                IdTicketSala = g.IdTicketSala,
                                IdTicketTrauma = g.IdTicketTrauma,
                                Ingreso = g.Ingreso,
                                Paciente = g.Paciente.Nombre + " " + g.Paciente.ApellidoPaterno + " " + g.Paciente.ApellidoMaterno,
                                Medico = g.PersonalEmergencia.Nombres + " " + g.PersonalEmergencia.ApellidoPaterno + " " + g.PersonalEmergencia.ApellidoMaterno,
                                Tratamiento = (g.Tratamiento == null ? string.Empty : g.Tratamiento.Descripcion),
                                DiagnosticoObservacion = (g.IdTicketSala != null ? g.TicketSalaObservacion.Diagnostico : g.TicketTraumaShockTopico.Diagnostico),
                                DiagnosticoTrauma = (g.IdTicketTrauma != null ? g.TicketTraumaShockTopico.Diagnostico : g.TicketSalaObservacion.Diagnostico),
                                Sala = (g.IdTicketSala == null && g.IdTicketTrauma != null ? "Unidad Trauma" : "Sala Observación")
                            }
                            ).ToList();

                        reporte = resultado.Select(g => new BEReporteAtencionEmergencia()
                             {
                                 Registrar = "<button type='button' id='btnRegistrarAtencion' onclick=\"RegistrarAtencionEmergencia(" + g.IdTicketEmergencia + "," + (g.IdTicketSala != null ? 2/*Sala*/ : 1/*Trauma*/) + ");\" class='btn btn-primary btn-xs' >Registrar</button>",
                                 Modificar = "<button type='button' id='btnModificarAtencion' onclick=\"ModificarAtencionEmergencia(" + g.IdTicketEmergencia + "," +
                                  g.IdPersonalEmergencia + "," +
                                    g.IdTratamiento + ",'" +
                                     (g.IdTicketTrauma != null ? g.DiagnosticoTrauma : g.DiagnosticoObservacion) + "'," +
                                     (g.IdTicketSala != null ? 2/*Sala*/ : 1/*Trauma*/) + ");\" class='btn btn-primary btn-xs' >Modificar</button>",
                                 Eliminar = "<button type='button' id='btnEliminarAtencion' onclick='ValidarSupervisor(" + g.IdTicketEmergencia + ");' class='btn btn-primary btn-xs' >Eliminar</button>",
                                 Ingreso = ((DateTime)g.Ingreso).ToString("dd/MM/yyyy"),
                                 Paciente = g.Paciente,
                                 Medico = g.Medico,
                                 Tratamiento = g.Tratamiento,
                                 Diagnostico = (g.IdTicketSala != null ? g.DiagnosticoObservacion : g.DiagnosticoTrauma),
                                 Sala = (g.IdTicketSala == null && g.IdTicketTrauma != null ? "Unidad Trauma" : "Sala Observación")
                             }).ToList();

                    }



                }
                return Json(new { success = true, responseText = "OK", data = reporte }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion





        #region AtencionSalaObservacion
        public ActionResult AtencionSalaObservacion()
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
            catch (Exception ex)
            {
                throw ex;
            }
            return View(atencion);
        }

        [HttpGet]
        public ActionResult BuscarAtencionSalaObservacion(string fechaDesde, string fechaHasta, int paciente, int medico, int destino)
        {
            List<BEReporteAtencionSalaObservacion> reporte = new List<BEReporteAtencionSalaObservacion>();
            DateTime dfechaInicio = DateTime.ParseExact(fechaDesde, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime dfechaFin = DateTime.ParseExact(fechaHasta, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
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
                return Json(new { success = true, responseText = "OK", data = reporte }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public ActionResult ModificarAtencionSalaObservacion(int idTicketEmergencia, int idmedico, int idtratamiento, string diagnostico, string condicioningreso, string condicionegreso)
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
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public ActionResult EliminarAtencionSalaObservacion(int idTicketEmergencia)
        {
            int idTicketSala = 0;
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    idTicketSala =Convert.ToInt32( bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First().IdTicketSala);

                    bdRicardo.Triaje.RemoveRange(bdRicardo.Triaje.Where(g => g.IdTicketEmergencia == idTicketEmergencia).ToList());
                    bdRicardo.TicketEmergencia.Remove(bdRicardo.TicketEmergencia.Where(f => f.IdTicketEmergencia == idTicketEmergencia).First());
                    bdRicardo.TicketSalaObservacion.Remove(bdRicardo.TicketSalaObservacion.Where(h => h.IdTicketSala == idTicketSala).First());

                    bdRicardo.SaveChanges();
                }
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion


    }
}