using System;
using RicardoPalma.Business;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Entity;
using RicardoPalma.Models;
using System.Collections.Generic;

namespace UnitTestRicardoPalma
{

    [TestClass]
    public class UnitTestTriaje
    {

        
        [TestMethod]
        public void ListarSintomasPacientes()
        {
            //Arange o Planteamiento
            const int size = 112;
            BETriaje res = new BETriaje();

            //Act o Prueba
            BLTriaje blTriaje = new BLTriaje();
            res = blTriaje.ListarSintomasPacientes();

            //Assert o Afirmación
            Assert.AreEqual(size, res.ListadoSintomas.Count);
        }

        [TestMethod]
        public void GetSintomaById()
        {
            //Arange o Planteamiento
            const String id = "Paro Cardio Respiratorio";
            String res = string.Empty;

            //Act o Prueba
            BLTriaje blTriaje = new BLTriaje();
            res = blTriaje.GetSintomaById(id);
            
            //Assert o Afirmación
            Assert.AreNotEqual(res,"[]");
        }

        [TestMethod]
        public void BuscarPaciente()
        {
            //Arange o Planteamiento
            const int dni = 12345678;
            Paciente res = new Paciente();

            //Act o Prueba
            BLTriaje blTriaje = new BLTriaje();
            res = blTriaje.BuscarPaciente(dni);

            //Assert o Afirmación
            Assert.IsNotNull(res);
        }


        [TestMethod]
        public void GuardarPaciente()
        {
            //Arange o Planteamiento
            const int dni = 46668322;
            const String nombre = "Daniel";
            const String appPaterno = "Valenzuela";
            const String appMaterno = "Rivas";
            const int tipoCliente = 1;

            //Act o Prueba
            BLTriaje blTriaje = new BLTriaje();
            blTriaje.GuardarPaciente(dni,nombre,appPaterno,appMaterno,tipoCliente );

        }

        [TestMethod]
        public void GuardarTriaje()
        {
            //Arange o Planteamiento
            const int dni = 46668322;
            const String sintoma = "101,104,108";
            const bool esViolencia = false;
            const int sint = 3;
            List<BEReporteTriaje> resultado = new List<BEReporteTriaje>();

            //Act o Prueba
            BLTriaje blTriaje = new BLTriaje();
            resultado = blTriaje.GuardarTriaje(dni, sintoma, esViolencia);

            //Assert o Afirmación
            Assert.AreEqual(resultado.Count, sint);
        }

      
    }
}
