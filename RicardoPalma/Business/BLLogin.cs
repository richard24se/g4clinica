using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RicardoPalma.Models;
using System.Data.Entity.Core;
using System.Configuration;

namespace RicardoPalma.Business
{
    public class BLLogin
    {

        public bool ValidarUsuario(string sUsuario, string sPassword, ref string sNombres,ref int cod)
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
                    sNombres = bUsuario.Nombres;
                    cod = bUsuario.IdUsuario;
                }

            }
            catch (EntityException exx)
            {
                if (exx.InnerException != null && (exx.InnerException.Message.Contains("A network-related") || exx.InnerException.Message.Contains("Error relacionado con la red")))
                    throw new TimeoutException(ConfigurationManager.AppSettings["strErrorTimeout"]);
                else
                    throw exx;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return blResult;
        }


    }
}