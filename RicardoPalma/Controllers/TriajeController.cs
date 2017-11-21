using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TecnologiaGMOS.Helpers;
using RicardoPalma.Models;
using System.Configuration;
using System.Transactions;
using RicardoPalma.Business;


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
                triaje = new BLTriaje().ListarSintomasPacientes();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return View(triaje);
        }


        public ActionResult GetSintomaById(string sintoma)
        {
            string cadena = string.Empty;
            try
            {
                cadena = new BLTriaje().GetSintomaById(sintoma);
                return Json(new { success = true, responseText = "OK", data = cadena }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public ActionResult BuscarPaciente(int dni)
        {
            Paciente bPaciente;
            try
            {
                bPaciente = new BLTriaje().BuscarPaciente(dni);

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
        public ActionResult GuardarPaciente(int dni, string nombre, string appPaterno, string appMaterno, int tipoCliente)
        {
            try
            {
                new BLTriaje().GuardarPaciente(dni, nombre, appPaterno, appMaterno, tipoCliente);
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
        public ActionResult GuardarTriaje(int dni, string sintoma, bool esViolencia)
        {
            List<BEReporteTriaje> reporteFinal = new List<BEReporteTriaje>();
            try
            {
                reporteFinal = new BLTriaje().GuardarTriaje(dni, sintoma, esViolencia);
                return Json(new { success = true, responseText = "OK", data = reporteFinal }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }


    }
}