using RicardoPalma.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core;
using System.Linq;
using System.Web;

namespace RicardoPalma.Business
{
    public class BLRequerimientoTurno
    {


        public void Modificar(int idrequerimiento, string motivo)
        {
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    DetalleTurno req = bdRicardo.DetalleTurno.Where(h => h.IdDetalleTurno== idrequerimiento).First();
                    req.Comentario = motivo;
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

        public void AprobarDesaprobar(int idrequerimiento, bool esAprobado)
        {
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    DetalleTurno req = bdRicardo.DetalleTurno.Where(h => h.IdDetalleTurno == idrequerimiento).First();
                    req.IdEstado = (esAprobado ? 1 : 2);
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

        public List<BERequerimientoTurno> BuscarRequerimientos(string fechaDesde, string fechaHasta, int IdRequerimiento)
        {
            List<BERequerimientoTurno> listado = new List<BERequerimientoTurno>();
            try
            {
                DateTime dfechaInicio = DateTime.ParseExact(fechaDesde + " 00:00:00", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
                DateTime dfechaFin = DateTime.ParseExact(fechaHasta + " 23:59:59", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);

                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    var reporte = bdRicardo.DetalleTurno.Where(h => (h.Fecha >= dfechaInicio
                        && h.Fecha <= dfechaFin) &&
                        h.IdDetalleTurno == (IdRequerimiento == 0 ? h.IdDetalleTurno : IdRequerimiento)).
                        Select(g => new
                    {
                        IdRequerimientoTurno = g.IdDetalleTurno,
                        Solicitante = g.PersonalEmergencia.Nombres + " " + g.PersonalEmergencia.ApellidoPaterno + " " + g.PersonalEmergencia.ApellidoMaterno,
                        g.Fecha,
                        g.Turno.Rango1,
                        g.Turno.Rango2,
                        g.Comentario,
                        EsAprobado = (g.IdEstado == 1 ? true : false)
                    }).ToList();

                    foreach (var item in reporte)
                    {
                        string disabledAprobar = string.Empty;
                        string disabledDesaprobar = string.Empty;

                        if (item.EsAprobado)
                            disabledAprobar = "disabled='disabled'";
                        else
                            disabledDesaprobar = "disabled='disabled'";

                        BERequerimientoTurno fila = new BERequerimientoTurno();
                        fila.BotonAprobar = "<button type='button' " + disabledAprobar + " onclick='AprobarDesaprobar(" + item.IdRequerimientoTurno + ",true);' class='btn btn-primary btn-xs' >Aprobar</button>";
                        fila.BotonDesaprobar = "<button type='button' " + disabledDesaprobar + " onclick='AprobarDesaprobar(" + item.IdRequerimientoTurno + ",false);' class='btn btn-primary btn-xs' >Desaprobar</button>";
                        fila.BotonModificar = "<button type='button' onclick='MostrarModificacion(" + item.IdRequerimientoTurno.ToString() + ");' class='btn btn-primary btn-xs' >Modificar</button>";
                        fila.IdRequerimiento = item.IdRequerimientoTurno.ToString();
                        fila.Solicitante = item.Solicitante;
                        fila.FechaSolicitud = item.Fecha.ToString("dd/MM/yyyy");
                        fila.HoraInicio = item.Rango1;
                        fila.HoraFinal = item.Rango2;
                        fila.Motivo = item.Comentario;
                        listado.Add(fila);
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