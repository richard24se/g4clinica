using RicardoPalma.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core;
using System.Linq;
using System.Web;

namespace RicardoPalma.Business
{
    public class BLTurnoMedico
    {

        public void ModificarTurno(int iddetalleturno, int idpersonal, int idestado, string motivo)
        {
            try
            {
                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    DetalleTurno req = bdRicardo.DetalleTurno.Where(f => f.IdDetalleTurno == iddetalleturno).First();
                    req.IdPersonalEmergencia = idpersonal;
                    req.IdEstado = idestado;//1=aprobado;2=noaprobado
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


        public void NuevoTurno(string fechainicio, string fechafin)
        {
            try
            {
                DateTime dfechaInicio = DateTime.ParseExact(fechainicio + " 00:00:00", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
                DateTime dfechaFin = DateTime.ParseExact(fechafin + " 00:00:00", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);

                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    List<Turno> turnos = bdRicardo.Turno.ToList();
                    List<DetalleTurno> detlistado = new List<DetalleTurno>();

                    DateTime fechacontador = dfechaInicio.AddDays(-1);
                    while (dfechaInicio <= dfechaFin)
                    {
                        dfechaInicio = dfechaInicio.AddDays(1);
                        fechacontador = fechacontador.AddDays(1);
                        foreach (Turno item in turnos)
                        {
                            if (bdRicardo.DetalleTurno.Where(f => f.Fecha.Day == fechacontador.Day && f.Fecha.Month == fechacontador.Month && f.Fecha.Year == fechacontador.Year).Count() == 0)
                            {
                                DetalleTurno det = new DetalleTurno();
                                det.Fecha = fechacontador;
                                det.IdEstado = 2;
                                det.IdTurno = item.IdTurno;
                                detlistado.Add(det);
                            }
                        }
                    }

                    bdRicardo.DetalleTurno.AddRange(detlistado);
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


        public List<BETurnoMedico> BuscarTurno(string fecha)
        {
            List<BETurnoMedico> listado = new List<BETurnoMedico>();
            try
            {
                DateTime dfechaFin = DateTime.ParseExact(fecha + " 00:00:00", "dd/MM/yyyy HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);

                using (ConnectionRicardoPalma bdRicardo = new ConnectionRicardoPalma())
                {
                    var reporte = bdRicardo.DetalleTurno.
                        Where(h => h.Fecha.Day == dfechaFin.Day && h.Fecha.Month == dfechaFin.Month && h.Fecha.Year == dfechaFin.Year).Select(g => new
                    {
                        g.IdDetalleTurno,
                        Personal = g.PersonalEmergencia.Nombres + " " + g.PersonalEmergencia.ApellidoPaterno + " " + g.PersonalEmergencia.ApellidoMaterno,
                        g.Turno.Rango1,
                        g.Turno.Rango2,
                        g.Turno.NombreTurno,
                        g.Fecha,
                        g.IdPersonalEmergencia,
                        g.IdEstado,
                        g.Comentario
                    }).ToList();

                    foreach (var item in reporte)
                    {
                        BETurnoMedico fila = new BETurnoMedico();
                        fila.BotonModificar =
                            "<button type='button' onclick=\"ModificarTurnoMedico(" + item.IdDetalleTurno.ToString() + ",'" + item.Rango1 + "','" + item.Rango2 + "','" + item.Fecha.ToString("dd/MM/yyyy") + "','" + item.NombreTurno + "'," + (item.IdPersonalEmergencia == null ? 0 : item.IdPersonalEmergencia) + "," + item.IdEstado + ",'" + item.Comentario + "');\" " +
                            " class='btn btn-primary btn-xs' >Modificar</button>";
                        fila.Inicio = item.Rango1;
                        fila.Fin = item.Rango2;
                        fila.Personal = item.Personal;
                        fila.Turno = item.NombreTurno;
                        fila.Dia = item.Fecha.ToString("dd/MM/yyyy");
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