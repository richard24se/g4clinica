using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TecnologiaGMOS.Helpers;

namespace TecnologiaGMOS.Controllers
{
    [SessionExpire]
    public class PrincipalController : Controller
    {
        /// <summary>
        /// Redirecciona a la página principal del menú
        /// </summary>
        /// <returns></returns>
        [SessionExpire]
        public ActionResult Index()
        {
            return View();
        }
    }
}