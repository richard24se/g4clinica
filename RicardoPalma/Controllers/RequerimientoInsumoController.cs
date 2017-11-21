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
    public class RequerimientoInsumoController : Controller
    {

        #region Insumos
        public ActionResult Insumo()
        {
            BEAtencionSalaObservacion atencion = new BEAtencionSalaObservacion();
            try
            {
                atencion = new BLRequerimientoInsumo().InsumoMantenimiento();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return View(atencion);
        }


        public ActionResult AprobarPorCorreo(string id)
        {
            try
            {
                TempData["Id"] = id;
                new BLRequerimientoInsumo().CambiarEstadoInsumoTodos(id, true);
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        [HttpGet]
        public ActionResult GuardarRequerimientoInsumo(string insumos)
        {
            int id = 0;
            try
            {
                id = new BLRequerimientoInsumo().GuardarRequerimientoInsumo(Convert.ToInt32( Session["Usuario"]), insumos);
                return Json(new { success = true, responseText = "OK", IdRequerimiento = id }, JsonRequestBehavior.AllowGet);
            }
            catch (TimeoutException exx)
            {
                return Json(new { success = false, responseText = exx.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                if (ex.Message == "Hubo un error al enviar el correo")
                    return Json(new { success = false, responseText = ex.Message }, JsonRequestBehavior.AllowGet);
                else
                    return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        public ActionResult Autorizaciones()
        {
            BEAtencionSalaObservacion atencion = new BEAtencionSalaObservacion();
            try
            {
                atencion = new BLRequerimientoInsumo().InsumoListado();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return View(atencion);
        }


        [HttpGet]
        public ActionResult BuscarRequerimientos(string fechaDesde, string fechaHasta, int Idsolicitante)
        {
            List<BERequerimiento> listado = new List<BERequerimiento>();
            try
            {
                listado = new BLRequerimientoInsumo().BuscarRequerimientos(fechaDesde, fechaHasta, Idsolicitante);
                return Json(new { success = true, responseText = "OK", data = listado }, JsonRequestBehavior.AllowGet);
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
        public ActionResult ListarRequerimientoDetalle(int idrequerimiento)
        {
            string cadena;
            try
            {
                cadena = new BLRequerimientoInsumo().ListarRequerimientoDetalle(idrequerimiento);
                return Json(new { success = true, responseText = "OK", Detalle = cadena }, JsonRequestBehavior.AllowGet);
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
        public ActionResult CambiarEstadoInsumo(int idrequerimiento, int idinsumo, int idestado)
        {
            try
            {
                new BLRequerimientoInsumo().CambiarEstadoInsumo(idrequerimiento, idinsumo, idestado);
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
        public ActionResult CambiarEstadoInsumoTodos(string listaidrequerimiento, bool checkAprobarTodos)
        {
            try
            {
                new BLRequerimientoInsumo().CambiarEstadoInsumoTodos(listaidrequerimiento, checkAprobarTodos);
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


    }
}