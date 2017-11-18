using Newtonsoft.Json;
using RicardoPalma.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core;
using System.Data.Entity.SqlServer;
using System.Linq;
using System.Text;
using System.Web;
using System.Net.Mail;
using System.Net;

namespace RicardoPalma.Business
{
    public class BLRequerimientoInsumo
    {
        #region Insumos
        public BEAtencionSalaObservacion InsumoMantenimiento()
        {
            BEAtencionSalaObservacion atencion = new BEAtencionSalaObservacion();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    atencion.ListadoMedicos = bdRicardo.PersonalEmergencia.ToList();
                    atencion.ListadoInsumo = bdRicardo.Insumo.ToList();
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
            return atencion;
        }

        public int GuardarRequerimientoInsumo(int idAprobador, string insumos)
        {
            RequerimientoInsumo req = new RequerimientoInsumo();
            try
            {
                List<BEInsumo> listainsumo = JsonConvert.DeserializeObject<List<BEInsumo>>(insumos);

                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    req.IdPersonalEmergencia = idAprobador;
                    req.FechaSolicitud = DateTime.Now;

                    bdRicardo.RequerimientoInsumo.Add(req);
                    bdRicardo.SaveChanges();


                    //agregar insumos
                    foreach (BEInsumo item in listainsumo.Where(f => f.eseliminado == false).ToList())
                    {
                        Requerimiento_Insumo reqinsu = new Requerimiento_Insumo();
                        reqinsu.IdInsumo = item.idinsumo;
                        reqinsu.IdRequerimientoInsumo = req.IdRequerimientoInsumo;
                        reqinsu.Cantidad = item.cantidad;
                        reqinsu.Motivo = item.motivo;
                        reqinsu.EsAutorizado = false;
                        reqinsu.IdEstado = 2;/*No Aprobado*/

                        if (item.idsala == 1)
                        { //1=trauma
                            reqinsu.IdSala = item.idsala;
                            reqinsu.Sala = "Trauma";
                        }
                        else
                        {
                            reqinsu.IdSala = item.idsala;
                            reqinsu.Sala = "Topico";
                        }

                        bdRicardo.Requerimiento_Insumo.Add(reqinsu);
                        bdRicardo.SaveChanges();
                    }
                }


                ////aqui es el enviar correo
                //if (!EnviarCorreo(req.IdRequerimientoInsumo))
                //{
                //    throw new Exception("Hubo un error al enviar el correo");
                //}

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
            return req.IdRequerimientoInsumo;
        }
        #endregion



        #region Requerimiento
        public BEAtencionSalaObservacion InsumoListado()
        {
            BEAtencionSalaObservacion atencion = new BEAtencionSalaObservacion();
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    PersonalEmergencia personal = new PersonalEmergencia() { IdPersonalEmergencia = -1, Nombres = "-Todos-", ApellidoMaterno = string.Empty, ApellidoPaterno = string.Empty };
                    atencion.ListadoMedicos = bdRicardo.PersonalEmergencia.ToList();
                    atencion.ListadoMedicos.Insert(0, personal);

                    Insumo insumo = new Insumo() { IdInsumo = -1, NombreInsumo = "-Todos-" };
                    atencion.ListadoInsumo = bdRicardo.Insumo.ToList();
                    atencion.ListadoInsumo.Insert(0, insumo);
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
            return atencion;
        }

        public List<BERequerimiento> BuscarRequerimientos(string fechaDesde, string fechaHasta, int Idsolicitante)
        {
            List<BERequerimiento> listado = new List<BERequerimiento>();
            try
            {
                DateTime dfechaInicio = DateTime.ParseExact(fechaDesde + " 00:00:00", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
                DateTime dfechaFin = DateTime.ParseExact(fechaHasta + " 23:59:59", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);

                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    if (bdRicardo.RequerimientoInsumo.Where(f => (f.FechaSolicitud >= dfechaInicio && f.FechaSolicitud <= dfechaFin)
                        & f.IdPersonalEmergencia == (Idsolicitante == -1 ? f.IdPersonalEmergencia : Idsolicitante)
                        ).Count() > 0)
                    {
                        var reporte = bdRicardo.RequerimientoInsumo.Where(f => (f.FechaSolicitud >= dfechaInicio && f.FechaSolicitud <= dfechaFin)
                        & f.IdPersonalEmergencia == (Idsolicitante == -1 ? f.IdPersonalEmergencia : Idsolicitante)
                        ).Select(
                        g => new
                        {
                            IdRequerimiento = g.IdRequerimientoInsumo,
                            FechaSolicitud = g.FechaSolicitud,
                            Solicitante = g.PersonalEmergencia.Nombres + " " + g.PersonalEmergencia.ApellidoPaterno + " " + g.PersonalEmergencia.ApellidoMaterno,
                            //Insumos = bdRicardo.Requerimiento_Insumo.Where(j => j.IdRequerimientoInsumo == g.IdRequerimientoInsumo).Select(h => new
                            //{
                            //    h.IdInsumo,
                            //    h.Insumo.NombreInsumo,
                            //    h.Sala,
                            //    h.Cantidad,
                            //    h.Estados.Descripcion,
                            //    h.Motivo
                            //}).ToList()
                        }
                        ).ToList();


                        foreach (var item in reporte)
                        {
                            BERequerimiento req = new BERequerimiento();
                            req.CheckSeleccionar = "<input type='checkbox' value='" + item.IdRequerimiento.ToString() + "' class='check-mark' />";
                            req.BotonDetalle = "<button type='button' id='btnMostrarInsumos' onclick='MostrarRequerimientoDetalle(" + item.IdRequerimiento + ");' class='btn btn-primary btn-xs' >Insumos</button>";
                            req.IdRequerimiento = item.IdRequerimiento;
                            req.FechaSolicitud = item.FechaSolicitud.ToString("dd/MM/yyyy");
                            req.Solicitante = item.Solicitante;
                            //req.Insumos="<table cellpadding='5' cellspacing='0' border='0.5' width='500px'><tbody><tr><td style='font-weight: bold;text-align:left;width:80px'>Actividad</td><td style='font-weight: bold;text-align:left;'>Descripción</td></tr><tr><td class='control-label col-sm-2 '>ACTIVIDAD 1</td><td class='control-label col-sm-2 '>AD</td></tr></tbody></table>";
                            //req.Insumos = item.Insumos.Select(g => new BEInsumoForJson()
                            //{
                            //    //IdInsumo = g.IdInsumo,
                            //    NombreInsumo= g.NombreInsumo,
                            //    Sala= g.Sala,
                            //    //Cantidad= g.Cantidad,
                            //    //Estado = g.Descripcion,
                            //    //Motivo = g.Motivo
                            //}).ToList();

                            listado.Add(req);
                        }

                    }
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
            return listado;
        }

        public string ListarRequerimientoDetalle(int idrequerimiento)
        {
            StringBuilder cadenaHTML = new StringBuilder();
            List<Estados> listaestados;
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    var listado = bdRicardo.Requerimiento_Insumo.Where(g => g.IdRequerimientoInsumo == idrequerimiento).Select(
                        f => new
                        {
                            f.IdInsumo,
                            f.Insumo.NombreInsumo,
                            f.Cantidad,
                            f.IdEstado,
                            Estado = f.Estados.Descripcion,
                            f.Sala,
                            f.Motivo
                        }
                        ).ToList();


                    listaestados = bdRicardo.Estados.ToList();

                    foreach (var item in listado)
                    {
                        cadenaHTML.AppendLine("<tr role='row' class ='odd'>");
                        cadenaHTML.AppendLine("<td>" + item.NombreInsumo + "</td>");
                        cadenaHTML.AppendLine("<td>" + item.Cantidad + "</td>");

                        StringBuilder cadenaEstado = new StringBuilder();
                        cadenaEstado.AppendLine("<select  class='form-control' onchange='CambiarEstadoInsumo(this.value);' style='width:150px;font-size:11px'>");
                        foreach (Estados estado in listaestados)
                        {
                            if (estado.IdEstado == item.IdEstado)
                                cadenaEstado.AppendLine("<option selected='selected' value='" + item.IdInsumo + "|" + estado.IdEstado + "'>" + estado.Descripcion + "</option>");
                            else
                                cadenaEstado.AppendLine("<option value='" + item.IdInsumo + "|" + estado.IdEstado + "'>" + estado.Descripcion + "</option>");
                        }
                        cadenaEstado.AppendLine("</select>");


                        cadenaHTML.AppendLine("<td>" + cadenaEstado.ToString() + "</td>");
                        cadenaHTML.AppendLine("<td>" + item.Sala + "</td>");
                        cadenaHTML.AppendLine("<td>" + item.Motivo + "</td>");
                        cadenaHTML.AppendLine("</tr>");
                    }
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
            return cadenaHTML.ToString();
        }

        public void CambiarEstadoInsumo(int idrequerimiento, int idinsumo, int idestado)
        {
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    Requerimiento_Insumo req = bdRicardo.Requerimiento_Insumo.Where(f => f.IdRequerimientoInsumo == idrequerimiento && f.IdInsumo == idinsumo).First();
                    req.IdEstado = idestado;
                    bdRicardo.SaveChanges();
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
        }

        public void CambiarEstadoInsumoTodos(string listaidrequerimiento, bool checkAprobarTodos)
        {
            int[] idarray;

            try
            {
                idarray = Array.ConvertAll(listaidrequerimiento.Split(','), int.Parse);
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    List<Requerimiento_Insumo> listado = bdRicardo.Requerimiento_Insumo.Where(g => idarray.Contains(g.IdRequerimientoInsumo))
                        .ToList();
                    foreach (Requerimiento_Insumo item in listado)
                    {
                        if (checkAprobarTodos)
                            item.IdEstado = 1;
                        else
                            item.IdEstado = 2;

                    }

                    bdRicardo.SaveChanges();
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
        }

        private bool EnviarCorreo(int idrequerimiento)
        {
            try
            {
                Requerimiento_Insumo req = new Requerimiento_Insumo();
                List<Insumo> insumo = new List<Insumo>();
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    req = bdRicardo.Requerimiento_Insumo.Where(g => g.IdRequerimientoInsumo == idrequerimiento).First();
                    //insumo=bdRicardo.Requerimiento_Insumo.Where(g => g.IdRequerimientoInsumo == idrequerimiento).
                }
                



                StringBuilder cadenaHMLT = new StringBuilder();
                cadenaHMLT.AppendLine("<div  style='width:600px' >" +
    "<span style='font-weight:bold;font-size:15px'>Notificación: Requerimiento de Insumos de Emergencia</span>" +
    "<table width='100%' cellspacing='8' cellpadding='0' border='0' align='center' bgcolor='#999999'>" +

    "<tr>" +
    "<td >N° de Requerimiento:</td>" +
    "<td ></td>	" +
    "</tr>" +

    "<tr>	" +
    "<td >Solicitante: </td>" +
    "<td ></td>	" +
    "</tr>" +


    "<tr>	" +
    "<td >Fecha Solicitud: </td>" +
    "<td ></td>" +
    "</tr>" +

    "<tr>	" +
    "<td >Motivo: </td>" +
    "<td ></td>" +
    "</tr>" +

    "<tr>" +
        "<td colspan='2' >" +
            "<table>		" +
                "<tr>" +
                "</tr>			" +
            "</table>			" +
        "</td>	" +
    "</tr>" +

    "<tr>	" +
    "<td colspan='2'><a href=''>Autorizar Requerimiento</a></td>	" +
    "</tr>" +

    "</table>" +
    "</div>");



                var fromAddress = new MailAddress(ConfigurationManager.AppSettings["strCorreoRemitente"], ConfigurationManager.AppSettings["strNombreRemitente"]);
                var toAddress = new MailAddress(ConfigurationManager.AppSettings["strCorreoDestinatario"], ConfigurationManager.AppSettings["strNombreDestinatario"]);
                string fromPassword = ConfigurationManager.AppSettings["strPassword"];
                const string subject = "Requerimiento Insumo Emergencia";
                const string body = "holaaaaa";

                var smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Credentials = new NetworkCredential(fromAddress.Address, fromPassword),
                    Timeout = 20000
                };
                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    Subject = subject,
                    Body = body
                })
                {
                    smtp.Send(message);
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }
        #endregion
    }
}