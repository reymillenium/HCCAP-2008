unit UModuloPlanillasProvinciales;

interface

uses
  Classes, DB, Dialogs,

  {Units echas por mi}
  UPlanillaProvincial,

  {DataModules echos por mi.}
  UDataModuleConexionGeneral, UDataModulePlanillasProvinciales,
  UDataModuleReportesPlanillasProvinciales;

type
  TModuloPlanillasProvinciales = Class(TObject)


  //** Procedimientos del M�dulo de Planillas Provinciales **

  procedure MostrarPlanillasProvinciales(aProvincia: String);
  procedure MostrarReporteAmpliadoProvincial(aAnno: Integer);
  procedure InsertarPlanilla(aPlanilla: TPlanillaProvincial);
  //procedure ModificarPlanilla(aNuevaPlanilla: TPlanilla);
  procedure EliminarPlanilla(aAnno: Integer; aProvincia: String);
  procedure GenerarReporte(aPlanilla: TPlanillaProvincial);
  
  function ExisteLaPlanilla(aAnno: Integer; aProvincia: String): Boolean;
  function ExisteAlMenosUnaPlanillaProvincial: Boolean;
  function ExisteAlMenosUnResumenProvincial: Boolean;

  procedure MostrarResumen(aAnno: String);
  function CantidadDePlanillas: Integer;

  procedure GenerarReportePlanillaProvincialPorAnnoYProvincia(aPlanilla: TPlanillaProvincial);

  private
    { Private declarations }

  public
    { Public declarations }

end;

implementation

uses SysUtils, ConvUtils;



// *** Procedimientos del m�dulo de Planillas Provinciales ***


procedure TModuloPlanillasProvinciales.InsertarPlanilla(aPlanilla: TPlanillaProvincial);
begin
  //Se realiza la conexi�n con la BD
      DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Active:= False;

      //Le pasamos los par�metros (parte 1), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vanno').Value:= aPlanilla.Anno;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vprovincia').Value:= aPlanilla.Provincia;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalEntOrg').Value:= aPlanilla.TotalEntOrg;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vEntOrgConPlanAnualCap').Value:= aPlanilla.EntOrgConPlanAnualCap;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalTrabOrg').Value:= aPlanilla.TotalTrabOrg;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalGradAccCap').Value:= aPlanilla.TotalGradAccCap;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vRelacionGradXTotal').Value:= aPlanilla.RelacionGradXTotal;

      //Le pasamos los par�metros (parte 2), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnEmpInternas').Value:= aPlanilla.GradEnEmpInternas;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnInstExternas').Value:= aPlanilla.GradEnInstExternas;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vDirectivos').Value:= aPlanilla.Directivos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTecnicos').Value:= aPlanilla.Tecnicos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vAdministrativos').Value:= aPlanilla.Administrativos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTrabServicios').Value:= aPlanilla.TrabServicios;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vOperarios').Value:= aPlanilla.Operarios;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnCurHab').Value:= aPlanilla.GradEnCurHab;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnCurPerfec').Value:= aPlanilla.GradEnCurPerfec;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradenAdiestLab').Value:= aPlanilla.GradEnAdiestLab;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnEntPTrab').Value:= aPlanilla.GradEnEntPTrab;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnCurPostGrado').Value:= aPlanilla.GradEnCurPostGrado;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnDiplomados').Value:= aPlanilla.GradEnDiplomados;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnMaestrias').Value:= aPlanilla.GradEnMaestrias;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnDoctorados').Value:= aPlanilla.GradEnDoctorados;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnCurFormCompMINED').Value:= aPlanilla.GradEnCurFormCompMINED;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnCurFormCompMES').Value:= aPlanilla.GradEnCurFormCompMES;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnCurIdiomaExt').Value:= aPlanilla.GradEnCurIdiomaExt;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnCurComp').Value:= aPlanilla.GradEnCurComp;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnEntrenEnExt').Value:= aPlanilla.GradEnEntrenEnExt;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGradEnOtrasAcc').Value:= aPlanilla.GradEnOtrasAcc;

      //Le pasamos los par�metros (parte 3), desde la Planilla, al StoreProcedure.
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vInstTotalUtilEnCapac').Value:= aPlanilla.InstTotalUtilEnCapac;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vInstEventUtilEnCapac').Value:= aPlanilla.InstEventUtilEnCapac;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vInstPermUtilEnCapac').Value:= aPlanilla.InstPermUtilEnCapac;

      //Le pasamos los par�metros (parte 4), desde la Planilla, al StoreProcedure.
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vMaestriasXMatric').Value:= aPlanilla.MaestriasXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vDiplomadosXMatric').Value:= aPlanilla.DiplomadosXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurPostgradosXMatric').Value:= aPlanilla.CurPostgradosXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurIdiomasXMatric').Value:= aPlanilla.CurIdiomasXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurCompXMatric').Value:= aPlanilla.CurCompXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vHabilitacionXMatric').Value:= aPlanilla.HabilitacionXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vPerfecXMatric').Value:= aPlanilla.PerfecXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTallSemConfXMatric').Value:= aPlanilla.TallSemConfXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalXMatric').Value:= aPlanilla.TotalXMatric;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vMaestriasXGrad').Value:= aPlanilla.MaestriasXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vDiplomadosXGrad').Value:= aPlanilla.DiplomadosXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurPostgradosXGrad').Value:= aPlanilla.CurPostgradosXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurIdiomasXGrad').Value:= aPlanilla.CurIdiomasXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurCompXGrad').Value:= aPlanilla.CurCompXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vHabilitacionXGrad').Value:= aPlanilla.HabilitacionXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vPerfecXGrad').Value:= aPlanilla.PerfecXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTallSemConfXGrad').Value:= aPlanilla.TallSemConfXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalXGrad').Value:= aPlanilla.TotalXGrad;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vValTrabDesPorEscRamales').Value:= aPlanilla.ValTrabDesPorEscRamales;



      //Le pasamos los par�metros (secci�n 5_1), desde la Planilla, al StoreProcedure.
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalTrabNoIdoneos').Value:= aPlanilla.TotalTrabNoIdoneos;

      //Le pasamos los par�metros (secci�n 5_2), desde la Planilla, al StoreProcedure.
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoIdoneosSinCalificFormal').Value:= aPlanilla.NoIdoneosSinCalificFormal;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoIdoneosSinEficiencia').Value:= aPlanilla.NoIdoneosSinEficiencia;
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoIdoneosSinBConducta').Value:= aPlanilla.NoIdoneosSinBConducta;

      //Le pasamos los par�metros (secci�n 5_3), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado6XTotalNoIdoneos').Value:= aPlanilla.Grado6XTotalNoIdoneos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado9XTotalNoIdoneos').Value:= aPlanilla.Grado9XTotalNoIdoneos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado12XTotalNoIdoneos').Value:= aPlanilla.Grado12XTotalNoIdoneos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTecMedioXTotalNoIdoneos').Value:= aPlanilla.TecMedioXTotalNoIdoneos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNivSupXTotalNoIdoneos').Value:= aPlanilla.NivSupXTotalNoIdoneos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalNivelXTotalNoIdoneos').Value:= aPlanilla.TotalNivelXTotalNoIdoneos;

      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado6XMatric').Value:= aPlanilla.Grado6XMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado9XMatric').Value:= aPlanilla.Grado9XMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado12XMatric').Value:= aPlanilla.Grado12XMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTecMedioXMatric').Value:= aPlanilla.TecMedioXMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNivSupXMatric').Value:= aPlanilla.NivSupXMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalNivelXMatric').Value:= aPlanilla.TotalNivelXMatric;
      
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado6XNoMatric').Value:= aPlanilla.Grado6XNoMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado9XNoMatric').Value:= aPlanilla.Grado9XNoMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vGrado12XNoMatric').Value:= aPlanilla.Grado12XNoMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTecMedioXNoMatric').Value:= aPlanilla.TecMedioXNoMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNivSupXNoMatric').Value:= aPlanilla.NivSupXNoMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalNivelXNoMatric').Value:= aPlanilla.TotalNivelXNoMatric;

      //Le pasamos los par�metros (secci�n 5_4), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalTrabProxEdadJub').Value:= aPlanilla.NoFormalTrabProxEdadJub;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalTrabProblemasSalud').Value:= aPlanilla.NoFormalTrabProblemasSalud;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalLicEnfermedadYMaternidad').Value:= aPlanilla.NoFormalLicEnfermedadYMaternidad;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalTrabProblemasFamiliares').Value:= aPlanilla.NoFormalTrabProblemasFamiliares;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalNoDisponibMatricXMINED').Value:= aPlanilla.NoFormalNoDisponibMatricXMINED;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalNoDisponibMatricXMES').Value:= aPlanilla.NoFormalNoDisponibMatricXMES;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalLimMatricNivSup').Value:= aPlanilla.NoFormalLimMatricNivSup;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalImposibEntidAbrirAulas').Value:= aPlanilla.NoFormalImposibEntidAbrirAulas;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalTrabNoAcredit').Value:= aPlanilla.NoFormalTrabNoAcredit;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalTrabTurnosRotativos').Value:= aPlanilla.NoFormalTrabTurnosRotativos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalTrabNieganIncorp').Value:= aPlanilla.NoFormalTrabNieganIncorp;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalMovilConstruc').Value:= aPlanilla.NoFormalMovilConstruc;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoFormalOtrasCausas').Value:= aPlanilla.NoFormalOtrasCausas;

      //Le pasamos los par�metros (secci�n 5_5), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vExplicNoMatric').Value:= aPlanilla.ExplicNoMatric;

      //Le pasamos los par�metros (secci�n 5_6), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurHabilXTotalNoIdoneos').Value:= aPlanilla.CurHabilXTotalNoIdoneos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vEntrenamientoXTotalNoIdoneos').Value:= aPlanilla.EntrenamientoXTotalNoIdoneos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalNoIdoneosXTotalNoIdoneos').Value:= aPlanilla.TotalNoIdoneosXTotalNoIdoneos;

      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurHabilXMatric').Value:= aPlanilla.CurHabilXMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vEntrenamientoXMatric').Value:= aPlanilla.EntrenamientoXMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalNoIdoneosXMatric').Value:= aPlanilla.TotalNoIdoneosXMatric;

      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCurHabilXNoMatric').Value:= aPlanilla.CurHabilXNoMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vEntrenamientoXNoMatric').Value:= aPlanilla.EntrenamientoXNoMatric;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalNoIdoneosXNoMatric').Value:= aPlanilla.TotalNoIdoneosXNoMatric;

      //Le pasamos los par�metros (secci�n 5_7), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficTrabProxEdadJub').Value:= aPlanilla.NoEficTrabProxEdadJub;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficTrabProblemasSalud').Value:= aPlanilla.NoEficTrabProblemasSalud;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficLicEnfermedadYMaternidad').Value:= aPlanilla.NoEficLicEnfermedadYMaternidad;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficTrabProblemasFamiliares').Value:= aPlanilla.NoEficTrabProblemasFamiliares;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficTrabTurnosRotativos').Value:= aPlanilla.NoEficTrabTurnosRotativos;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficTrabNieganIncorp').Value:= aPlanilla.NoEficTrabNieganIncorp;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficMovilConstruc').Value:= aPlanilla.NoEficMovilConstruc;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vNoEficOtrasCausas').Value:= aPlanilla.NoEficOtrasCausas;

      //Le pasamos los par�metros (secci�n 5_8), desde la Planilla, al StoreProcedure.
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCasilla1XPendiente').Value:= aPlanilla.Casilla1XPendiente;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCasilla2XPendiente').Value:= aPlanilla.Casilla2XPendiente;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalXPendiente').Value:= aPlanilla.TotalXPendiente;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCasilla1XCausas').Value:= aPlanilla.Casilla1XCausas;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vCasilla2XCausas').Value:= aPlanilla.Casilla2XCausas;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vTotalXCausas').Value:= aPlanilla.TotalXCausas;


      
      //Le pasamos los par�metros (parte 6), desde la Planilla, al StoreProcedure.
	    DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.Parameters.ParamByName('@vValoracionCualitativaDelProcesoCapac').Value:= aPlanilla.ValoracionCualitativaDelProcesoCapac;
      
      //Aqu� se hace la inserci�n en la BD
      //DataModule1.ADOStoredProcInsertarPlanillaProvincial.Open;
      DataModulePlanillasProvinciales.ADOStoredProcInsertarPlanillaProvincial.ExecProc;
end;



procedure TModuloPlanillasProvinciales.EliminarPlanilla(aAnno: Integer; aProvincia: String);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= true;
  DataModulePlanillasProvinciales.ADOStoredProcEliminarPlanillaProvincial.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModulePlanillasProvinciales.ADOStoredProcEliminarPlanillaProvincial.Parameters.ParamByName('@vanno').Value:= aAnno;
  DataModulePlanillasProvinciales.ADOStoredProcEliminarPlanillaProvincial.Parameters.ParamByName('@vprovincia').Value:= aProvincia;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModule1.ADOStoredProcEliminarPlanilla.Open;
  DataModulePlanillasProvinciales.ADOStoredProcEliminarPlanillaProvincial.ExecProc;
end;



procedure TModuloPlanillasProvinciales.GenerarReporte(aplanilla: TPlanillaProvincial);
begin
  //Aun por programar

end;



procedure TModuloPlanillasProvinciales.MostrarPlanillasProvinciales(aProvincia: String);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= true;
  DataModulePlanillasProvinciales.ADOStoredProcSelectTodoPorProvincia.Active:= False;

  //Le pasamos el nombre de la provincia Camaguey al StoreProcedure.
  DataModulePlanillasProvinciales.ADOStoredProcSelectTodoPorProvincia.Parameters.ParamByName('@vprovincia').Value:= aProvincia;

  //Aqu� se hace la b�squeda en la BD
  DataModulePlanillasProvinciales.ADOStoredProcSelectTodoPorProvincia.Open;
  DataModulePlanillasProvinciales.ADOStoredProcSelectTodoPorProvincia.ExecProc;
end;


procedure TModuloPlanillasProvinciales.MostrarReporteAmpliadoProvincial(aAnno: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= true;
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumenAmpliadoProvincial.Active:= False;

  //Le pasamos el nombre de la provincia Camaguey al StoreProcedure.
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumenAmpliadoProvincial.Parameters.ParamByName('@vanno').Value:= aAnno;

  //Aqu� se hace la b�squeda en la BD
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumenAmpliadoProvincial.Open;
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumenAmpliadoProvincial.ExecProc;
end;



function TModuloPlanillasProvinciales.ExisteLaPlanilla(aAnno: Integer; aProvincia: String): Boolean;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= true;
  DataModulePlanillasProvinciales.ADOStoredProcExistePlanillaProvincial.Active:= False;

  //Le pasamos el a�o de la Planilla Provincial, y el nombre de la provincia, al StoredProc.
  DataModulePlanillasProvinciales.ADOStoredProcExistePlanillaProvincial.Parameters.ParamByName('@vanno').Value:= aAnno;
  DataModulePlanillasProvinciales.ADOStoredProcExistePlanillaProvincial.Parameters.ParamByName('@vprovincia').Value:= aProvincia;

  //Aqu� se hace la b�squeda en la BD
  DataModulePlanillasProvinciales.ADOStoredProcExistePlanillaProvincial.Open;
  DataModulePlanillasProvinciales.ADOStoredProcExistePlanillaProvincial.ExecProc;

  //Aqu� se verifica si se hall� alguna Planilla Provincial
  if (DataModulePlanillasProvinciales.DataSourceExistePlanillaProvincial.DataSet.RecordCount<>0)
    then
      Result:= True
        else
          Result:= False;
end;



function TModuloPlanillasProvinciales.ExisteAlMenosUnaPlanillaProvincial: Boolean;
begin
  //Verifico directamente sobre el DataSource si tiene al menos un resumen de planillas provinciales
  if (DataModulePlanillasProvinciales.DataSourceSelecTodo.DataSet.RecordCount<>0)
    then Result:= True
      else
        Result:= False;
end;


function TModuloPlanillasProvinciales.ExisteAlMenosUnResumenProvincial: Boolean;
begin
  //Verifico directamente sobre el DataSource si tiene al menos una planilla
  if (DataModulePlanillasProvinciales.DataSourceSelecResumen.DataSet.RecordCount<>0)
    then Result:= True
      else
        Result:= False;
end;



procedure TModuloPlanillasProvinciales.MostrarResumen(aAnno: String);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= true;
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumen.Active:= False;

  //Le pasamos el a�o al StoredProc, para que ejecute el Resumen
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumen.Parameters.ParamByName('@vanno').Value:= aAnno;

  //Aqu� se hace la b�squeda en la BD
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumen.Open;
  DataModulePlanillasProvinciales.ADOStoredProcSelecResumen.ExecProc;
end;



function TModuloPlanillasProvinciales.CantidadDePlanillas: Integer;
begin
  //Verifico directamente sobre el DataSource si tiene al menos una planilla
  if (DataModulePlanillasProvinciales.DataSourceSelecResumen.DataSet.RecordCount<>0)
    then Result:= DataModulePlanillasProvinciales.DataSourceSelecResumen.DataSet.RecordCount
      else
        Result:= 0;
end;



procedure TModuloPlanillasProvinciales.GenerarReportePlanillaProvincialPorAnnoYProvincia(aPlanilla: TPlanillaProvincial);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= true;
  DataModuleReportesPlanillasProvinciales.RvProjectSelecTodoPorProvincia.ExecuteReport('ProjectSelecTodoPorProvincia');
end;

end.
