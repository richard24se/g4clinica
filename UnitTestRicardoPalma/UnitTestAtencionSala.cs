using System;
using RicardoPalma.Business;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Entity;
using RicardoPalma.Models;
using System.Collections.Generic;

namespace UnitTestRicardoPalma
{

    [TestClass]
    public class UnitTestAtencionSala
    {

        
        [TestMethod]
        public void BuscarAtencion()
        {
            //Arange o Planteamiento
            const string fechaDesde = "31/10/2017";
            const string fechaHasta = "01/11/2017";
            const int paciente = 1;
            const int medico = 1;
            const int destino = 1;
            const int size = 2;
            List<BEReporteAtencionSalaObservacion> res;
            //Act o Prueba
            BLAtencionEmergenciaObservacion blAtencionObservacion = new BLAtencionEmergenciaObservacion();
            res = blAtencionObservacion.BuscarAtencionSalaObservacion(fechaDesde, fechaHasta, paciente, medico,destino);

            //Assert o Afirmación
            Assert.AreEqual(size, res.Count);
        }

        [TestMethod]
        public void obtenerAtencion()
        {
            //Arange o Planteamiento
            const int sizeDestino = 3;
            const int sizeMedico = 4;
            const int sizeSala = 3;
            const int sizeTratamiento = 34;
            BEAtencionSalaObservacion res = null;

            //Act o Prueba
            BLAtencionEmergenciaObservacion blAtencionObservacion = new BLAtencionEmergenciaObservacion();
            res = blAtencionObservacion.AtencionSalaObservacion();
            
            //Assert o Afirmación
            Assert.AreEqual(sizeDestino, res.ListadoDestino.Count);
            Assert.AreEqual(sizeMedico, res.ListadoMedicos.Count);
            Assert.AreEqual(sizeSala, res.ListadoSala.Count);
            Assert.AreEqual(sizeTratamiento, res.ListadoTratamiento.Count);
        }


        [TestMethod]
        public void modificarAtencion()
        {
            //Arange o Planteamiento
            const int idTicketEmergencia = 28;
            const int idMedico = 1;
            const int idTrataiento = 12;
            const string diagnostico = "Receta médica";
            const string condicioningreso = "Internado si es necesario";
            const string condicionegreso = "Descanso médico";

            //Act o Prueba
            BLAtencionEmergenciaObservacion blAtencionObservacion = new BLAtencionEmergenciaObservacion();
            blAtencionObservacion.ModificarAtencionSalaObservacion(idTicketEmergencia, idMedico, idTrataiento, diagnostico, condicioningreso, condicionegreso);

        }

        [TestMethod]
        public void eliminarAtencion()
        {
            //Arange o Planteamiento
            const int idTicketEmergencia = 52;

            //Act o Prueba
            BLAtencionEmergenciaObservacion blAtencionObservacion = new BLAtencionEmergenciaObservacion();
            blAtencionObservacion.EliminarAtencionSalaObservacion(idTicketEmergencia);

        }
    }
}
