using System;
using RicardoPalma.Business;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Entity;
using RicardoPalma.Models;
using System.Collections.Generic;

namespace UnitTestRicardoPalma
{

    [TestClass]
    public class UnitTestAtencionTrauma
    {

        
        [TestMethod]
        public void BuscarAtencion()
        {
            //Arange o Planteamiento
            const string fechaDesde = "31/10/2017";
            const string fechaHasta = "01/11/2017";
            const int paciente = 2;
            const int medico = 2;
            const int destino = 1;
            const int size = 1;
            List<BEReporteAtencionEmergencia> res;
            //Act o Prueba
            BLAtencionEmergenciaTrauma blAtencionTrauma = new BLAtencionEmergenciaTrauma();
            res = blAtencionTrauma.BuscarAtencionEmergencia(fechaDesde, fechaHasta, paciente, medico,destino);

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
            BEAtencionEmergencia res = null;

            //Act o Prueba
            BLAtencionEmergenciaTrauma blAtencionTrauma = new BLAtencionEmergenciaTrauma();
            res = blAtencionTrauma.AtencionEmergencia();
            
            //Assert o Afirmación
            Assert.AreEqual(sizeDestino, res.ListadoDestino.Count);
            Assert.AreEqual(sizeMedico, res.ListadoMedicos.Count);
            Assert.AreEqual(sizeSala, res.ListadoSala.Count);
            Assert.AreEqual(sizeTratamiento, res.ListadoTratamiento.Count);
        }

        [TestMethod]
        public void insertarAtencion()
        {
            //Arange o Planteamiento
            const int idTicketEmergencia = 12;
            const int idsala = 1;
            
            //Act o Prueba
            BLAtencionEmergenciaTrauma blAtencionTrauma = new BLAtencionEmergenciaTrauma();
            blAtencionTrauma.RegistrarAtencionEmergencia( idTicketEmergencia,  idsala);
         
        }


        [TestMethod]
        public void modificarAtencion()
        {
            //Arange o Planteamiento
            const int idTicketEmergencia = 12;
            const int idMedico = 1;
            const int idTrataiento = 1;
            const int idsala = 1;

            //Act o Prueba
            BLAtencionEmergenciaTrauma blAtencionTrauma = new BLAtencionEmergenciaTrauma();
            blAtencionTrauma.ModificarAtencionEmergencia(idTicketEmergencia, idMedico, idTrataiento, idsala);

        }

        [TestMethod]
        public void eliminarAtencion()
        {
            //Arange o Planteamiento
            const int idTicketEmergencia = 6;
            
            //Act o Prueba
            BLAtencionEmergenciaTrauma blAtencionTrauma = new BLAtencionEmergenciaTrauma();
            blAtencionTrauma.EliminarAtencionEmergencia(idTicketEmergencia);

        }

      
    }
}
