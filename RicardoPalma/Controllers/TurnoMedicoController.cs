using RicardoPalma.Business;
using RicardoPalma.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RicardoPalma.Controllers
{
    public class TurnoMedicoController : Controller
    {

        public ActionResult TurnoMedico()
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
        public ActionResult ModificarTurno(int iddetalleturno, int idpersonal, int idestado, string motivo)
        {
            try
            {
                new BLTurnoMedico().ModificarTurno(iddetalleturno, idpersonal, idestado, motivo);
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
        public ActionResult NuevoTurno(string fechainicio, string fechafin)
        {
            try
            {
                new BLTurnoMedico().NuevoTurno(fechainicio, fechafin);
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
        public ActionResult BuscarTurno(string fecha)
        {
            try
            {
                List<BETurnoMedico> reporte = new BLTurnoMedico().BuscarTurno(fecha);

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


    }
}