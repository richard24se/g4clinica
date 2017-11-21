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
    public class RequerimientoTurnoController : Controller
    {
        public ActionResult RequerientoTurno()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        [HttpGet]
        public ActionResult Modificar(int idrequerimiento, string motivo)
        {
            try
            {
                new BLRequerimientoTurno().Modificar(idrequerimiento, motivo);
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
        public ActionResult AprobarDesaprobar(int idrequerimiento, bool esAprobado)
        {
            try
            {
                new BLRequerimientoTurno().AprobarDesaprobar(idrequerimiento, esAprobado);
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
        public ActionResult BuscarRequerimientos(string fechaDesde, string fechaHasta, int IdRequerimiento)
        {
            try
            {
                List<BERequerimientoTurno> reporte = new BLRequerimientoTurno().BuscarRequerimientos(fechaDesde, fechaHasta, IdRequerimiento);

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