using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RicardoPalma.Models;

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
            try
            {
                Usuario bUsuario;
                using (ConnectionRicardoPalma modelRicardo = new ConnectionRicardoPalma())
                {
                    bUsuario = modelRicardo.Usuario.Where(d => d.CodigoUsuario == sUsuario && d.Clave == sPassword).FirstOrDefault();

                    if (bUsuario != null && bUsuario.CodigoUsuario == sUsuario && bUsuario.Clave == sPassword)
                        blResult = true;
                }

                if (blResult)
                {
                    Session["Usuario"] = sUsuario;
                    Session["NombreUsuario"] = bUsuario.Nombres;

                    return Json(new { success = true, responseText = "OK" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, responseText = "Usuario o clave incorrecta" }, JsonRequestBehavior.AllowGet);
                }

            }
            catch (Exception ex)
            {
                return Json(new { success = false, responseText = ConfigurationManager.AppSettings["strErrorGeneral"] }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}