using System;
using RicardoPalma.Business;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Entity;
using RicardoPalma.Models;
using System.Collections.Generic;

namespace UnitTestRicardoPalma
{

    [TestClass]
    public class UnitTestTurnoMedico
    {

        
        [TestMethod]
        public void BuscarTurno()
        {
            //Arange o Planteamiento
            const string fecha = "01/11/2017";
            const int size = 3;
            List<BETurnoMedico> res = new List<BETurnoMedico>();

            //Act o Prueba
            BLTurnoMedico blTurnoMedico = new BLTurnoMedico();
            res = blTurnoMedico.BuscarTurno(fecha);

            //Assert o Afirmación
            Assert.AreEqual(size, res.Count);
        }

        [TestMethod]
        public void Nuevo()
        {
            //Arange o Planteamiento
            const String fechaInicio = "11/12/2017";
            const String fechaFin = "17/12/2017";

            //Act o Prueba
            BLTurnoMedico blTurnoMedico = new BLTurnoMedico();
            blTurnoMedico.NuevoTurno(fechaInicio,fechaFin);
            
        }

        [TestMethod]
        public void Modificar()
        {
            //Arange o Planteamiento
           
            const int iddetalleturno = 286;
            const int idestado = 1;
            const int idpersonal = 3;
            const string motivo = "Asignación de Médico";

            //Act o Prueba
            BLTurnoMedico blTurnoMedico = new BLTurnoMedico();
            blTurnoMedico.ModificarTurno(iddetalleturno, idpersonal, idestado, motivo);
        }

        [TestMethod]
        public void AprobarDesaprobar()
        {
            //Arange o Planteamiento

            const int idRequerimiento = 1;
            const bool isaprobado = true;

            //Act o Prueba
            BLRequerimientoTurno blReqTurnoMedico = new BLRequerimientoTurno();
            blReqTurnoMedico.AprobarDesaprobar(idRequerimiento, isaprobado);
        }
        
    }
}
