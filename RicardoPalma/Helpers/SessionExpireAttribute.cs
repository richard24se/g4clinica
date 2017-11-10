using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace TecnologiaGMOS.Helpers
{
    public class SessionExpireAttribute : ActionFilterAttribute
    {
        /// <summary>
        /// Verifica si la sesión esta activo. De lo contrario redirecciona al login
        /// </summary>
        /// <param name="filterContext">ActionExecutingContext clase propia del MVC</param>
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpContext ctx = HttpContext.Current;            
            if (HttpContext.Current.Session["Usuario"] == null)
            {
                filterContext.Result = new RedirectResult("~/Login");
                return;
            }
            base.OnActionExecuting(filterContext);
        }
    }
}