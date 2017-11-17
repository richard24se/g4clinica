using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RicardoPalma.Models;
using System.Configuration;
using System.Data.Objects.SqlClient;
using RicardoPalma.Business;

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
                atencion = new BLAtencionEmergenciaTrauma().AtencionEmergencia();
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
            try
            {
                new BLAtencionEmergenciaTrauma().RegistrarAtencionEmergencia(idTicketEmergencia, idsala);

                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (TimeoutException exx)
            {
                return Json(new { success = false, responseText = exx.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public ActionResult ModificarAtencionEmergencia(int idTicketEmergencia, int idmedico, int idtratamiento, string diagnostico, int idsala)
        {
            try
            {
                new BLAtencionEmergenciaTrauma().ModificarAtencionEmergencia(idTicketEmergencia, idmedico, idtratamiento, diagnostico, idsala);
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (TimeoutException exx)
            {
                return Json(new { success = false, responseText = exx.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public ActionResult EliminarAtencionEmergencia(int idTicketEmergencia)
        {

            try
            {
                new BLAtencionEmergenciaTrauma().EliminarAtencionEmergencia(idTicketEmergencia);
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (TimeoutException exx)
            {
                return Json(new { success = false, responseText = exx.Message }, JsonRequestBehavior.AllowGet);
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
            try
            {
                reporte = new BLAtencionEmergenciaTrauma().BuscarAtencionEmergencia(fechaDesde, fechaHasta, paciente, medico, destino, sala);
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
                atencion = new BLAtencionEmergenciaObservacion().AtencionSalaObservacion();
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
            try
            {
                reporte = new BLAtencionEmergenciaObservacion().BuscarAtencionSalaObservacion(fechaDesde, fechaHasta, paciente, medico, destino);
                return Json(new { success = true, responseText = "OK", data = reporte }, JsonRequestBehavior.AllowGet);

            }
            catch (TimeoutException exx)
            {
                return Json(new { success = false, responseText = exx.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public ActionResult ModificarAtencionSalaObservacion(int idTicketEmergencia, int idmedico, int idtratamiento, string diagnostico, string condicioningreso, string condicionegreso)
        {
            try
            {
                new BLAtencionEmergenciaObservacion().ModificarAtencionSalaObservacion(idTicketEmergencia, idmedico, idtratamiento, diagnostico, condicioningreso, condicionegreso);
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (TimeoutException exx)
            {
                return Json(new { success = false, responseText = exx.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public ActionResult EliminarAtencionSalaObservacion(int idTicketEmergencia)
        {
            try
            {
                new BLAtencionEmergenciaObservacion().EliminarAtencionSalaObservacion(idTicketEmergencia);
                return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (TimeoutException exx)
            {
                return Json(new { success = false, responseText = exx.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion


    }
}