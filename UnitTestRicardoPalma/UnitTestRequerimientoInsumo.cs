using System;
using RicardoPalma.Business;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Entity;
using RicardoPalma.Models;
using System.Collections.Generic;

namespace UnitTestRicardoPalma
{

    [TestClass]
    public class UnitTestRequerimientoInsumo
    {

        
        [TestMethod]
        public void GuardarRequerimientoInsumo()
        {
            //Arange o Planteamiento
            const int idAprobador = 1;
            string insumo = string.Empty;
            insumo = insumo + "[{\"codigo\":1,\"idinsumo\":\"14\",\"idsala\":\"1\",\"nombresala\":\"Unidad Trauma\",\"nombreinsumo\":\"AGUJA DESCT.# 23 1 1/4\",\"cantidad\":\"10\",\"motivo\":\"rrrrrrrr\",\"eseliminado\":0},";
            insumo = insumo + "{\"codigo\":2,\"idinsumo\":\"4\",\"idsala\":\"1\",\"nombresala\":\"Unidad Trauma\",\"nombreinsumo\":\"ACIDO POLIG. 1 AG. REDONDA 1/2 CIRC. 37 MM.\",\"cantidad\":\"10\",\"motivo\":\"rrrrrrrr\",\"eseliminado\":0}]";

            int idRequerimiento;
            BETriaje res = new BETriaje();

            //Act o Prueba
            BLRequerimientoInsumo blRequerimientoInsumo = new BLRequerimientoInsumo();
            idRequerimiento = blRequerimientoInsumo.GuardarRequerimientoInsumo(idAprobador,insumo);

            //Assert o Afirmación
            Assert.IsNotNull(idRequerimiento);
        }

        [TestMethod]
        public void ListadoInsumo()
        {
            //Arange o Planteamiento
            const int size = 120;
            BEAtencionSalaObservacion res = new BEAtencionSalaObservacion();

            //Act o Prueba
            BLRequerimientoInsumo blRequerimientoInsumo = new BLRequerimientoInsumo();
            res = blRequerimientoInsumo.InsumoListado();

            //Assert o Afirmación
            Assert.AreEqual(size,res.ListadoInsumo.Count);
        }

        [TestMethod]
        public void BuscarRequerimiento()
        {
            //Arange o Planteamiento
            const string fechaDesde = "16/11/2017";
            const string fechaHasta = "19/11/2017";
            const int idsolicitante = 1;
            const int size = 3;
            List<BERequerimiento> res;

            //Act o Prueba
            BLRequerimientoInsumo blRequerimientoInsumo = new BLRequerimientoInsumo();
            res = blRequerimientoInsumo.BuscarRequerimientos(fechaDesde,fechaHasta,idsolicitante);

            //Assert o Afirmación
            Assert.AreEqual(size, res.Count);
        }


        [TestMethod]
        public void BuscarRequerimientoDetalle()
        {
            //Arange o Planteamiento
            const int idrequerimiento = 3;
            String res = String.Empty;

            //Act o Prueba
            BLRequerimientoInsumo blRequerimientoInsumo = new BLRequerimientoInsumo();
            res = blRequerimientoInsumo.ListarRequerimientoDetalle(idrequerimiento);

            //Assert o Afirmación
            Assert.AreNotEqual(res, "[]");

        }

        [TestMethod]
        public void cambiarEstado()
        {
            //Arange o Planteamiento
            const int idrequerimiento = 18;
            const int idinsumo = 1;
            const int idestado = 1;

            //Act o Prueba
            BLRequerimientoInsumo blRequerimientoInsumo = new BLRequerimientoInsumo();
            blRequerimientoInsumo.CambiarEstadoInsumo(idrequerimiento, idinsumo, idestado);
            
        }

        [TestMethod]
        public void cambiarEstadoTodos()
        {
            //Arange o Planteamiento
            const string listaidrequerimiento = "18,19";
            const bool todosSel = true;

            //Act o Prueba
            BLRequerimientoInsumo blRequerimientoInsumo = new BLRequerimientoInsumo();
            blRequerimientoInsumo.CambiarEstadoInsumoTodos(listaidrequerimiento, todosSel);

        }

    }
}
