using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TecnologiaGMOS.Helpers;
using RicardoPalma.Models;
using System.Configuration;
using System.Transactions;


namespace RicardoPalma.Controllers
{
    [SessionExpire]
    public class TriajeController : Controller
    {


        public ActionResult GenerarTriaje()
        {
            BETriaje triaje = new BETriaje();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    triaje.ListadoSintomas = bdRicardo.Sintoma.OrderBy(g => g.Descripcion).ToList();
                    triaje.ListadoTipoPaciente = bdRicardo.TipoPaciente.ToList();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return View(triaje);
        }


        [HttpGet]
        public ActionResult BuscarPaciente(int dni)
        {
            Paciente bPaciente;
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    bPaciente = bdRicardo.Paciente.Where(f => f.dni == dni).FirstOrDefault();
                    if (bPaciente != null)
                        bPaciente.TipoPaciente = bdRicardo.TipoPaciente.Where(g => g.IdTipoPaciente == bPaciente.IdTipoPaciente).FirstOrDefault();
                }
                if (bPaciente != null)
                    return Json(new
                    {
                        success = true,
                        responseText = "OK",
                        nombrePaciente = bPaciente.Nombre + " " + bPaciente.ApellidoPaterno + " " + bPaciente.ApellidoMaterno,
                        tipoPaciente = bPaciente.TipoPaciente.Descripcion,
                        dniPaciente = bPaciente.dni.ToString()
                    }, JsonRequestBehavior.AllowGet);
                else
                    return Json(new { success = true, responseText = "NOPACIENTE" }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }




        [HttpGet]
        public ActionResult GuardarPaciente(int dni, string nombre, string appPaterno, string appMaterno, int tipoCliente)
        {
            Paciente bPaciente = new Paciente();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    bPaciente.Nombre = nombre;
                    bPaciente.ApellidoPaterno = appPaterno;
                    bPaciente.ApellidoMaterno = appMaterno;
                    bPaciente.dni = dni;
                    bPaciente.IdTipoPaciente = tipoCliente;

                    bdRicardo.Paciente.Add(bPaciente);
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
        public ActionResult GuardarTriaje(int dni, string sintoma, bool esViolencia)
        {
            Paciente bPaciente = new Paciente();
            List<BEReporteTriaje> reporteFinal = new List<BEReporteTriaje>();
            int idticketemergencia = 0;
            bool EsTrauma = false;
            string sala = string.Empty;
            int iddestino;
            int countTrauma, countObservacion, countPrioridad, countNoPrioridad;
            int[] arrSintoma;
            try
            {
                arrSintoma = sintoma.Split(',').Select(f => Int32.Parse(f.ToString())).ToArray();

                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    using (TransactionScope scope = new TransactionScope())
                    {
                        TicketEmergencia ticket = new TicketEmergencia();
                        TicketTraumaShockTopico trauma = new TicketTraumaShockTopico();
                        TicketSalaObservacion observacion = new TicketSalaObservacion();

                        ticket.IdPaciente = bdRicardo.Paciente.Where(g => g.dni == dni).First().IdPaciente;
                        ticket.EsViolencia = esViolencia;
                        bdRicardo.TicketEmergencia.Add(ticket);
                        bdRicardo.SaveChanges();
                        idticketemergencia = ticket.IdTicketEmergencia;

                        foreach (string sintomaitem in sintoma.Split(','))
                        {
                            int sint = Convert.ToInt32(sintomaitem);
                            Triaje triaje = new Triaje();
                            triaje.IdSintoma = Convert.ToInt32(sintomaitem);
                            triaje.IdTicketEmergencia = idticketemergencia;
                            triaje.IdPrioridad = bdRicardo.Protocolo.Where(g => g.IdSintoma == sint).First().IdPrioridad;

                            bdRicardo.Triaje.Add(triaje);
                        }
                        bdRicardo.SaveChanges();

                        //countTrauma = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Trauma").Count();
                        //countObservacion = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Topico").Count();
                        countPrioridad = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Trauma" && d.IdPrioridad == 1).Count();
                        countNoPrioridad = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Trauma" && (d.IdPrioridad == 2 || d.IdPrioridad == 3 || d.IdPrioridad == 4)).Count();
                        //-------------------------------------------
                        if (countPrioridad > 0)
                        {
                            EsTrauma = true;
                        }
                        else if (countNoPrioridad > 0)
                        {
                            EsTrauma = false;
                        }
                        //else if (countObservacion > countTrauma)
                        //{
                        //    EsTrauma = true;
                        //}
                        //else if (countTrauma >= 2 && countPrioridad == 0)
                        //{
                        //    EsTrauma = true;
                        //}
                        //else if (countObservacion < countTrauma)
                        //{
                        //    EsTrauma = true;
                        //}
                        else
                        {
                            EsTrauma = false;
                        }

                        //-------------------------------------------
                        if (EsTrauma)
                        {
                            int dias = Convert.ToInt32(Math.Ceiling(bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Trauma").Average(f => f.DiasAtencion)));
                            string diagnostico = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Trauma").OrderByDescending(h => h.IdPrioridad).First().Diagnostico;
                            iddestino = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Trauma").OrderByDescending(h => h.IdPrioridad).First().IdDestino;

                            trauma.Ingreso = DateTime.Now;
                            trauma.Egreso = DateTime.Now.AddDays(dias);
                            trauma.Diagnostico = diagnostico;
                            trauma.EsTraumaShock = EsTrauma;

                            bdRicardo.TicketTraumaShockTopico.Add(trauma);
                        }
                        else
                        {
                            int dias = Convert.ToInt32(Math.Ceiling(bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Topico").Average(f => f.DiasAtencion)));
                            string diagnostico = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Topico").OrderByDescending(h => h.IdPrioridad).First().Diagnostico;
                            string condicioningreso = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Topico").OrderByDescending(h => h.IdPrioridad).First().CondicionIngreso;
                            string condicionegreso = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Topico").OrderByDescending(h => h.IdPrioridad).First().CondicionEgreso;
                            iddestino = bdRicardo.Protocolo.Where(d => arrSintoma.Contains(d.IdSintoma) && d.Sala == "Topico").OrderByDescending(h => h.IdPrioridad).First().IdDestino;

                            observacion.Ingreso = DateTime.Now;
                            observacion.Egreso = DateTime.Now.AddDays(dias);
                            observacion.Diagnostico = diagnostico;
                            observacion.CondicionIngreso = condicioningreso;
                            observacion.CondicionEgreso = condicionegreso;

                            bdRicardo.TicketSalaObservacion.Add(observacion);
                        }
                        bdRicardo.SaveChanges();

                        //-------------------------------------------
                        ticket.IdDestino = iddestino;
                        if (EsTrauma)
                            ticket.IdTicketTrauma = trauma.IdTicketTrauma;
                        else
                            ticket.IdTicketSala = observacion.IdTicketSala;
                        observacion.Ingreso = DateTime.Now;
                        if (EsTrauma)
                        {
                            ticket.Ingreso = trauma.Ingreso;
                            ticket.Egreso = trauma.Egreso;
                        }
                        else
                        {
                            ticket.Ingreso = observacion.Ingreso;
                            ticket.Egreso = observacion.Egreso;
                        }

                        bdRicardo.SaveChanges();
                        scope.Complete();
                    }

                    reporteFinal = bdRicardo.Triaje.Where(m => m.IdTicketEmergencia == idticketemergencia).Select(d =>
                        new BEReporteTriaje()
                        {
                            NombrePaciente = d.TicketEmergencia.Paciente.Nombre + " " + d.TicketEmergencia.Paciente.ApellidoPaterno + " " + d.TicketEmergencia.Paciente.ApellidoMaterno,
                            DNI = d.TicketEmergencia.Paciente.dni,
                            TipoPaciente = d.TicketEmergencia.Paciente.TipoPaciente.Descripcion,
                            Sintoma = d.Sintoma.Descripcion,
                            Prioridad = d.Prioridad.Descripcion,
                            Destino = (d.TicketEmergencia.IdTicketSala == null && d.TicketEmergencia.IdTicketTrauma != null ? "Unidad Trauma" : "Sala Observación")
                        }).ToList();
                }
                return Json(new { success = true, responseText = "OK", data = reporteFinal }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }


    }
}