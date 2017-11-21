using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RicardoPalma.Models;
using RicardoPalma.Business;
using System.Data.Entity.Core;

namespace TecnologiaGMOS.Controllers
{
    public class LoginController : Controller
    {
        //
        // GET: /Login/
        public ActionResult Login()
        {
            return View();
        }


        public ActionResult ValidarUsuario(string sUsuario, string sPassword)
        {
            bool blResult = false;
            string nombres = string.Empty;
            int cod=0;
            try
            {
                blResult = new BLLogin().ValidarUsuario(sUsuario, sPassword, ref nombres, ref cod);


                if (blResult)
                {
                    Session["Usuario"] = cod;
                    Session["NombreUsuario"] = nombres;

                    return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, responseText = "Usuario o clave incorrecta" }, JsonRequestBehavior.AllowGet);
                }
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