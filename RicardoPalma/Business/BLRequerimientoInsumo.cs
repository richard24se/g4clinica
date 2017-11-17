using RicardoPalma.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core;
using System.Linq;
using System.Web;

namespace RicardoPalma.Business
{
    public class BLRequerimientoInsumo
    {
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

        public int GuardarRequerimientoInsumo(int idAprobador, object insumos)
        {
            RequerimientoInsumo req = new RequerimientoInsumo();
            try
            {
                List<BEInsumo> listainsumo = (List<BEInsumo>)insumos;

                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    req.IdPersonalEmergencia = idAprobador;
                    bdRicardo.RequerimientoInsumo.Add(req);
                    bdRicardo.SaveChanges();


                    //agregar insumos
                    foreach (BEInsumo item in listainsumo)
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
                            Insumos = bdRicardo.Requerimiento_Insumo.Where(j => j.IdRequerimientoInsumo == g.IdRequerimientoInsumo).Select(h => new
                            {
                                h.IdInsumo,
                                h.Insumo.NombreInsumo,
                                h.Sala,
                                h.Cantidad,
                                h.Estados.Descripcion,
                                h.Motivo
                            }).ToList()
                        }
                        ).ToList();


                        foreach (var item in reporte)
                        {
                            BERequerimiento req = new BERequerimiento();
                            req.IdRequerimiento = item.IdRequerimiento;
                            req.FechaSolicitud = item.FechaSolicitud.ToString("dd/MM/yyyy");
                            req.Solicitante = item.Solicitante;
                            req.Insumos = item.Insumos.Select(g => new BEInsumo()
                            {
                                idinsumo = g.IdInsumo,
                                nombreinsumo = g.NombreInsumo,
                                sala=g.Sala,
                                cantidad = g.Cantidad,
                                Estado = g.Descripcion,
                                motivo = g.Motivo
                            }).ToList();

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


    }
}