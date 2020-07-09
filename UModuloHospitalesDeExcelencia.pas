unit UModuloHospitalesDeExcelencia;

interface
uses
  Classes, DB, Dialogs,

  {Units echas por mi}
  UHospital, UCapacitador, UCurso, UTipoDeCurso,

  {DataModules echos por mi.}
  UDataModuleConexionGeneral, UDataModuleHospitalesDeExcelencia, UDataModulePlanillasDeExcelencia;

type
  TModuloHospitalesDeExcelencia = Class(TObject)

  //** Procedimientos del M�dulo de Hospitales de Excelencia **

  procedure MostrarPlanillasDeExcelenciaPorPeriodoYHospital(aPeriodo: Integer; aID_Hospital: Integer);
  procedure MostrarTodosLosHospitalesDeExcelenciaParaAdmin;
  procedure MostrarHospitalesPorProvincia(aProvincia: String);
  procedure MostrarCapacitadorPorHospitalDeExcelencia(aID_Hospital: Integer);
  procedure MostrarCapacPorID_HospitalParaAdmin(aID_Hospital: Integer);
  procedure MostrarHospitalDeExcelencia(aID_Hospital: Integer);
  procedure MostrarTiposDeCursos;
  procedure MostrarTiposDeCursosHabilitados;
  procedure MostrarTipoDeCursoPorID_TipoDeCurso(aID_TipoDeCurso: Integer);
  procedure MostrarCursosProgramadosPorID_Planilla(aID_Planilla: Integer);
  procedure MostrarCursosRealizadosPorID_Planilla(aID_Planilla: Integer);
  procedure MostrarCursosProgramadosTemporalesPorID_Planilla(aID_Planilla: Integer);
  procedure MostrarCursosRealizadosTemporalesPorID_Planilla(aID_Planilla: Integer);
  procedure MostrarGruposDeCorreos;
  procedure MostrarResumenDeExcelencia;

  function CantidadDeHospitalesPorProvincia: Integer;
  function CantidadDeHospitalesTotales: Integer;
  function CantidadDeTiposDeCursos: Integer;
  function CantidadDeCursosProgramados: Integer;
  function CantidadDeCursosRealizados: Integer;
  function CantidadDeCursosProgramadosTemporales: Integer;
  function CantidadDeCursosRealizadosTemporales: Integer;

  procedure CalcularMinYMaxID;
  procedure BuscarCorreosDeCapacitadorPorID_Hospital(aID_Hospital: Integer);

  Procedure CopiarCursosProgramadosPorID_Planilla(aID_Planilla: Integer);
  Procedure CopiarCursosRealizadosPorID_Planilla(aID_Planilla: Integer);

  function ExisteCapacitadorEnElHospital(aID_Hospital: Integer): Boolean;
  function ExisteAlMenosUnaPlanillaDeExcelencia: Boolean;
  function ExistePlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer): Boolean;
  function ExisteGruposDeCorreos: Boolean;
  function ExisteAlMenosUnResumenDeExcelencia: Boolean;

  procedure EliminarHospitalDeExcelencia(aID_Hospital: Integer);
  procedure EliminarCapacitador(aID_Hospital: Integer);
  procedure EliminarTipoDeCurso(aID_TipoDeCurso: Integer);
  procedure EliminarPlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer);
  procedure EliminarCursosProgramadosPorID_Planilla(aID_Planilla: Integer);
  procedure EliminarCursosRealizadosPorID_Planilla(aID_Planilla: Integer);
  procedure EliminarCursoProgramadoTemporalPorID_Curso(aID_Curso: Integer);
  procedure EliminarCursoRealizadoTemporalPorID_Curso(aID_Curso: Integer);
  procedure EliminarCursosProgramadosTemporalesPorID_Planilla(aID_Planilla: Integer);
  procedure EliminarCursosRealizadosTemporalesPorID_Planilla(aID_Planilla: Integer);
  procedure EliminarGruposDeCorreos;
  procedure EliminarResumenDeExcelencia;

  procedure ModificarHospitalDeExcelencia(aID_Hospital: Integer; aNuevoHospital: THospital);
  procedure ModificarCapacitador(aID_Hospital: Integer; aNuevoCapacitador: TCapacitador);
  procedure ModificarTipoDeCurso(aID_TipoDeCurso: Integer; aNuevoTipoDeCurso: TTipoDeCurso);
  procedure ModificarCursoProgramadoTemporal(aID_Curso: Integer; aNuevoCurso: TCurso);
  procedure ModificarCursoRealizadoTemporal(aID_Curso: Integer; aNuevoCurso: TCurso);
  procedure ModificarID_PlanillaEnCursosProgramadosTemporales(aViejoID_Planilla, aNuevoID_Planilla: Integer);
  procedure ModificarID_PlanillaEnCursosRealizadosTemporales(aViejoID_Planilla, aNuevoID_Planilla: Integer);

  procedure ModificarNulosEnBalancesDeExcelencia;

  procedure RellenarCursosProgramadosDesdeTemporales;
  procedure RellenarCursosRealizadosDesdeTemporales;
  procedure RellenarBalancesDeExcelenciaParte1(aAnno: String; aPeriodo: String);
  procedure RellenarBalancesDeExcelenciaParte2(aAnno: String; aPeriodo: String);

  procedure InsertarHospitalDeExcelencia(aHospital: THospital);
  procedure InsertarCapacitador(aCapacitador: TCapacitador);
  procedure InsertarTipoDeCurso(aTipoDeCurso: TTipoDeCurso);
  procedure InsertarEncabezamientoPlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer);
  procedure InsertarCursoProgramado(aCurso: TCurso);
  procedure InsertarCursoRealizado(aCurso: TCurso);
  procedure InsertarCursoProgramadoTemporal(aCurso: TCurso);
  procedure InsertarCursoRealizadoTemporal(aCurso: TCurso);
  procedure InsertarGrupoDeCorreos(aNombreGrupo: AnsiString; aCorreos: AnsiString);

  Procedure BuscarID_PlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer);

  private
    { Private declarations }

  public
    { Public declarations }

end;

implementation

uses SysUtils, ConvUtils;



  //** Procedimientos del M�dulo de Hospitales de Excelencia **

procedure TModuloHospitalesDeExcelencia.MostrarPlanillasDeExcelenciaPorPeriodoYHospital(aPeriodo: Integer; aID_Hospital: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecPlanillasDeExcelenciaPorPeriodoYHospital.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecPlanillasDeExcelenciaPorPeriodoYHospital.Parameters.ParamByName('@vperiodo').Value:= aPeriodo;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecPlanillasDeExcelenciaPorPeriodoYHospital.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecPlanillasDeExcelenciaPorPeriodoYHospital.Open;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecPlanillasDeExcelenciaPorPeriodoYHospital.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarTodosLosHospitalesDeExcelenciaParaAdmin;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTodosLosHospitalesParaAdmin.Active:= False;

  //No hay que pasarle par�metros a este StoreProcedure.

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTodosLosHospitalesParaAdmin.Open;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTodosLosHospitalesParaAdmin.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarHospitalesPorProvincia(aProvincia: String);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  if (aProvincia= 'TODAS')
    then
      begin
        DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTodosLosHospitales.Active:= False;

        //No hay que pasarle par�metros a este StoreProcedure.

        //Aqu� se hace la selecci�n en la BD
        DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTodosLosHospitales.Open;
        DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTodosLosHospitales.ExecProc;
      end
        else
          begin
            DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalesPorProvincia.Active:= False;

            //Le pasamos el par�metro al StoreProcedure.
            DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalesPorProvincia.Parameters.ParamByName('@vprovincia').Value:= aProvincia;

            //Aqu� se hace la selecci�n en la BD
            DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalesPorProvincia.Open;
            DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalesPorProvincia.ExecProc;
          end;
end;



function TModuloHospitalesDeExcelencia.CantidadDeHospitalesPorProvincia: Integer;
begin
  //Cuento la cantidad de Hospitales de Excelencia que existen para una provincia 
  if (DataModuleHospitalesDeExcelencia.DataSourceSelecHospitalesPorProvincia.DataSet.RecordCount <> 0)
    then
      Result:= DataModuleHospitalesDeExcelencia.DataSourceSelecHospitalesPorProvincia.DataSet.RecordCount
        else
          Result:= 0;
end;



function TModuloHospitalesDeExcelencia.CantidadDeHospitalesTotales: Integer;
begin
  //Cuento la cantidad de Hospitales de Excelencia que existen en total (todo el pa�s)
  if (DataModuleHospitalesDeExcelencia.DataSourceSelecTodosLosHospitalesParaAdmin.DataSet.RecordCount <> 0)
    then
      Result:= DataModuleHospitalesDeExcelencia.DataSourceSelecTodosLosHospitalesParaAdmin.DataSet.RecordCount
        else
          Result:= 0;
end;



function TModuloHospitalesDeExcelencia.CantidadDeCursosProgramados: Integer;
begin
  //Cuento la cantidad de Cursos Programados
  Result:= DataModuleHospitalesDeExcelencia.DataSourceSelecCursosProgramadosPorID_Planilla.DataSet.RecordCount;
end;



function TModuloHospitalesDeExcelencia.CantidadDeCursosRealizados: Integer;
begin
  //Cuento la cantidad de Cursos Realizados
  Result:= DataModuleHospitalesDeExcelencia.DataSourceSelecCursosRealizadosPorID_Planilla.DataSet.RecordCount;
end;



function TModuloHospitalesDeExcelencia.CantidadDeCursosProgramadosTemporales: Integer;
begin
  //Cuento la cantidad de Cursos Programados Temporales
  Result:= DataModuleHospitalesDeExcelencia.DataSourceSelecCursosProgramadosTemporalesPorID_Planilla.DataSet.RecordCount
end;



function TModuloHospitalesDeExcelencia.CantidadDeCursosRealizadosTemporales: Integer;
begin
  //Cuento la cantidad de Cursos Realizados Temporales
  Result:= DataModuleHospitalesDeExcelencia.DataSourceSelecCursosRealizadosTemporalesPorID_Planilla.DataSet.RecordCount
end;


procedure TModuloHospitalesDeExcelencia.CalcularMinYMaxID;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecMinYMaxID.Active:= False;

  //No hay que pasarle par�metros a este StoreProcedure.

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecMinYMaxID.Open; //<- S� se muestra esta l�nea pues se generan datos
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecMinYMaxID.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.BuscarCorreosDeCapacitadorPorID_Hospital(aID_Hospital: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcBuscarCorreosDeCapacitadorPorID_Hospital.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcBuscarCorreosDeCapacitadorPorID_Hospital.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcBuscarCorreosDeCapacitadorPorID_Hospital.Open;
  DataModuleHospitalesDeExcelencia.ADOStoredProcBuscarCorreosDeCapacitadorPorID_Hospital.ExecProc;
end;



function TModuloHospitalesDeExcelencia.ExisteCapacitadorEnElHospital(aID_Hospital: Integer): Boolean;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcExisteCapacitadorEnElHospital.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcExisteCapacitadorEnElHospital.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcExisteCapacitadorEnElHospital.Open;
  DataModuleHospitalesDeExcelencia.ADOStoredProcExisteCapacitadorEnElHospital.ExecProc;

  //Verificamos si encontr� algo
  if (DataModuleHospitalesDeExcelencia.DataSourceExisteCapacitadorEnElHospital.DataSet.RecordCount <> 0)
    then
      Result:= True
        else
          Result:= False;
end;



function TModuloHospitalesDeExcelencia.ExisteAlMenosUnaPlanillaDeExcelencia: Boolean;
begin
  //Verifico directamente sobre el DataSource si tiene al menos una Planilla de Excelencia
  if (DataModuleHospitalesDeExcelencia.DataSourceSelecPlanillasDeExcelenciaPorPeriodoYHospital.DataSet.RecordCount<>0)
    then Result:= True
      else
        Result:= False;
end;



procedure TModuloHospitalesDeExcelencia.MostrarCapacitadorPorHospitalDeExcelencia(aID_Hospital: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacitadorPorHospitalDeExcelencia.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacitadorPorHospitalDeExcelencia.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacitadorPorHospitalDeExcelencia.Open;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacitadorPorHospitalDeExcelencia.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarCapacPorID_HospitalParaAdmin(aID_Hospital: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacPorID_HospitalParaAdmin.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacPorID_HospitalParaAdmin.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacPorID_HospitalParaAdmin.Open;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCapacPorID_HospitalParaAdmin.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.EliminarHospitalDeExcelencia(aID_Hospital: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarHospitalDeExcelencia.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarHospitalDeExcelencia.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarHospitalDeExcelencia.Open; {No genera datos, por eso se omite}
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarHospitalDeExcelencia.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.EliminarCapacitador(aID_Hospital: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCapacitador.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCapacitador.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCapacitador.Open; {No genera datos, por eso se omite}
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCapacitador.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarHospitalDeExcelencia(aID_Hospital: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalDeExcelenciaPorID.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalDeExcelenciaPorID.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalDeExcelenciaPorID.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecHospitalDeExcelenciaPorID.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.ModificarHospitalDeExcelencia(aID_Hospital: Integer; aNuevoHospital: THospital);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarHospitalDeExcelencia.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarHospitalDeExcelencia.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarHospitalDeExcelencia.Parameters.ParamByName('@vNuevoNombre_Hospital').Value:= aNuevoHospital.NombreHospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarHospitalDeExcelencia.Parameters.ParamByName('@vNuevaDireccion_Hospital').Value:= aNuevoHospital.Direccion;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarHospitalDeExcelencia.Parameters.ParamByName('@vNueva_Provincia').Value:= aNuevoHospital.Provincia;

  //Aqu� se hace la modificaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcModificarHospitalDeExcelencia.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarHospitalDeExcelencia.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.ModificarCapacitador(aID_Hospital: Integer; aNuevoCapacitador: TCapacitador);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Parameters.ParamByName('@vNuevoNombre_Capacitador').Value:= aNuevoCapacitador.NombreCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Parameters.ParamByName('@vNuevoPrimer_Apellido_Capacitador').Value:= aNuevoCapacitador.PrimerApellidoCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Parameters.ParamByName('@vNuevoSegundo_Apellido_Capacitador').Value:= aNuevoCapacitador.SegundoApellidoCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Parameters.ParamByName('@vNuevoCorreo_Capacitador').Value:= aNuevoCapacitador.CorreosCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Parameters.ParamByName('@vNuevoNumeroCarne_Capacitador').Value:= aNuevoCapacitador.NumeroCarneCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Parameters.ParamByName('@vNuevoTelefono_Capacitador').Value:= aNuevoCapacitador.TelefonosCapacitador;

  //Aqu� se hace la modificaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCapacitador.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.InsertarHospitalDeExcelencia(aHospital: THospital);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarHospitalDeExcelencia.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarHospitalDeExcelencia.Parameters.ParamByName('@vNuevoNombre_Hospital').Value:= aHospital.NombreHospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarHospitalDeExcelencia.Parameters.ParamByName('@vNuevaDireccion_Hospital').Value:= aHospital.Direccion;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarHospitalDeExcelencia.Parameters.ParamByName('@vNueva_Provincia').Value:= aHospital.Provincia;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarHospitalDeExcelencia.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarHospitalDeExcelencia.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.InsertarCapacitador(aCapacitador: TCapacitador);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Parameters.ParamByName('@vNuevoNombre_Capacitador').Value:= aCapacitador.NombreCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Parameters.ParamByName('@vNuevoPrimer_Apellido_Capacitador').Value:= aCapacitador.PrimerApellidoCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Parameters.ParamByName('@vNuevoSegundo_Apellido_Capacitador').Value:= aCapacitador.SegundoApellidoCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Parameters.ParamByName('@vNuevoCorreo_Capacitador').Value:= aCapacitador.CorreosCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Parameters.ParamByName('@vNuevoNumeroCarne_Capacitador').Value:= aCapacitador.NumeroCarneCapacitador;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Parameters.ParamByName('@vNuevoTelefono_Capacitador').Value:= aCapacitador.TelefonosCapacitador;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCapacitador.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarTiposDeCursos;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTiposDeCursos.Active:= False;

  //No hay que pasarle par�metros al StoreProcedure.

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTiposDeCursos.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTiposDeCursos.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarTiposDeCursosHabilitados;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTiposDeCursosHabilitados.Active:= False;

  //No hay que pasarle par�metros al StoreProcedure.

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTiposDeCursosHabilitados.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTiposDeCursosHabilitados.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.EliminarTipoDeCurso(aID_TipoDeCurso: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarTipoDeCurso.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarTipoDeCurso.Parameters.ParamByName('@vid_TipoDeCurso').Value:= aID_TipoDeCurso;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarTipoDeCurso.Open; {No genera datos, por eso se omite}
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarTipoDeCurso.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.ModificarTipoDeCurso(aID_TipoDeCurso: Integer; aNuevoTipoDeCurso: TTipoDeCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarTipoDeCurso.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarTipoDeCurso.Parameters.ParamByName('@vid_TipoDeCurso').Value:= aID_TipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarTipoDeCurso.Parameters.ParamByName('@vNuevoNombre_TipoDeCurso').Value:= aNuevoTipoDeCurso.NombreTipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarTipoDeCurso.Parameters.ParamByName('@vNuevoEstado').Value:= aNuevoTipoDeCurso.Estado;
  
  //Aqu� se hace la modificaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcModificarTipoDeCurso.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarTipoDeCurso.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.InsertarTipoDeCurso(aTipoDeCurso: TTipoDeCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarTipoDeCurso.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarTipoDeCurso.Parameters.ParamByName('@vNombre_TipoDeCurso').Value:= aTipoDeCurso.NombreTipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarTipoDeCurso.Parameters.ParamByName('@vEstado').Value:= aTipoDeCurso.Estado;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarTipoDeCurso.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarTipoDeCurso.ExecProc;
end;



function TModuloHospitalesDeExcelencia.CantidadDeTiposDeCursos: Integer;
begin
  //Cuento la cantidad de Tipos de Cursos que existen en total
  if (DataModuleHospitalesDeExcelencia.DataSourceSelecTiposDeCursos.DataSet.RecordCount <> 0)
    then
      Result:= DataModuleHospitalesDeExcelencia.DataSourceSelecTiposDeCursos.DataSet.RecordCount
        else
          Result:= 0;
end;



procedure TModuloHospitalesDeExcelencia.MostrarTipoDeCursoPorID_TipoDeCurso(aID_TipoDeCurso: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTipoDeCursoPorID_TipoDeCurso.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTipoDeCursoPorID_TipoDeCurso.Parameters.ParamByName('@vid_TipoDeCurso').Value:= aID_TipoDeCurso;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTipoDeCursoPorID_TipoDeCurso.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecTipoDeCursoPorID_TipoDeCurso.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.InsertarEncabezamientoPlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarEncabezamientoPlanillaDeExcelencia.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarEncabezamientoPlanillaDeExcelencia.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarEncabezamientoPlanillaDeExcelencia.Parameters.ParamByName('@vAnno').Value:= aAnno;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarEncabezamientoPlanillaDeExcelencia.Parameters.ParamByName('@vPeriodo').Value:= aPeriodo;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarEncabezamientoPlanillaDeExcelencia.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarEncabezamientoPlanillaDeExcelencia.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.InsertarCursoProgramado(aCurso: TCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.Parameters.ParamByName('@vNombre_TipoDeCurso').Value:= aCurso.Nombre_TipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.Parameters.ParamByName('@vLugar').Value:= aCurso.Lugar;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.Parameters.ParamByName('@vFechaInicio').Value:= aCurso.FechaInicio;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.Parameters.ParamByName('@vCantidadParticipantes').Value:= aCurso.CantidadParticipantes;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.Parameters.ParamByName('@vid_Planilla').Value:= aCurso.ID_Planilla;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramado.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.InsertarCursoRealizado(aCurso: TCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.Parameters.ParamByName('@vNombre_TipoDeCurso').Value:= aCurso.Nombre_TipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.Parameters.ParamByName('@vLugar').Value:= aCurso.Lugar;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.Parameters.ParamByName('@vFechaInicio').Value:= aCurso.FechaInicio;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.Parameters.ParamByName('@vCantidadParticipantes').Value:= aCurso.CantidadParticipantes;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.Parameters.ParamByName('@vid_Planilla').Value:= aCurso.ID_Planilla;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizado.ExecProc;
end;


Procedure TModuloHospitalesDeExcelencia.BuscarID_PlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecID_PlanillaDeExcelencia.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecID_PlanillaDeExcelencia.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecID_PlanillaDeExcelencia.Parameters.ParamByName('@vAnno').Value:= aAnno;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecID_PlanillaDeExcelencia.Parameters.ParamByName('@vPeriodo').Value:= aPeriodo;

  //Aqu� se hace la inserci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecID_PlanillaDeExcelencia.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecID_PlanillaDeExcelencia.ExecProc;
end;



function TModuloHospitalesDeExcelencia.ExistePlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer): Boolean;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcExistePlanillaDeExcelencia.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcExistePlanillaDeExcelencia.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcExistePlanillaDeExcelencia.Parameters.ParamByName('@vAnno').Value:= aAnno;
  DataModuleHospitalesDeExcelencia.ADOStoredProcExistePlanillaDeExcelencia.Parameters.ParamByName('@vPeriodo').Value:= aPeriodo;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcExistePlanillaDeExcelencia.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcExistePlanillaDeExcelencia.ExecProc;

  //Verifico si se hall� la Planilla de Excelencia
  if (DataModuleHospitalesDeExcelencia.DataSourceExistePlanillaDeExcelencia.DataSet.RecordCount <> 0)
    then
      Result:= True
        else
          Result:= False;
end;


function TModuloHospitalesDeExcelencia.ExisteGruposDeCorreos: Boolean;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecGruposDeCorreos.Active:= False;

  //No hay que pasarle par�metros al StoreProcedure.

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecGruposDeCorreos.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecGruposDeCorreos.ExecProc;

  //Verifico si se hall� los grupos de correos en la BD
  if (DataModuleHospitalesDeExcelencia.DataSourceSelecGruposDeCorreos.DataSet.RecordCount <> 0)
    then
      Result:= True
        else
          Result:= False;
end;


function TModuloHospitalesDeExcelencia.ExisteAlMenosUnResumenDeExcelencia: Boolean;
begin
  //Verifico si se hall� al menos un Resumen de Excelencia en la BD
  if (DataModulePlanillasDeExcelencia.DataSourceSelecResumenDeExcelencia.DataSet.RecordCount <> 0)
    then
      Result:= True
        else
          Result:= False;
end;



procedure TModuloHospitalesDeExcelencia.MostrarCursosProgramadosPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosPorID_Planilla.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosPorID_Planilla.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarCursosRealizadosPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosPorID_Planilla.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosPorID_Planilla.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarCursosProgramadosTemporalesPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosTemporalesPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosTemporalesPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosTemporalesPorID_Planilla.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosProgramadosTemporalesPorID_Planilla.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.MostrarCursosRealizadosTemporalesPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosTemporalesPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosTemporalesPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosTemporalesPorID_Planilla.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecCursosRealizadosTemporalesPorID_Planilla.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.MostrarGruposDeCorreos;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecGruposDeCorreos.Active:= False;

  //No hay que pasarle par�metros al StoreProcedure.

  //Aqu� se hace la selecci�n en la BD
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecGruposDeCorreos.Open; {S� genera datos, por eso se muestra}
  DataModuleHospitalesDeExcelencia.ADOStoredProcSelecGruposDeCorreos.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.MostrarResumenDeExcelencia;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModulePlanillasDeExcelencia.ADOStoredProcSelecResumenDeExcelencia.Active:= False;

  //No se le pasan par�metros a los StoreProcedure.
  //DataModulePlanillasDeExcelencia.ADOStoredProcSelecResumenDeExcelenciaParte1.Parameters.ParamByName('@vanno').Value:= aAnno;
  //DataModulePlanillasDeExcelencia.ADOStoredProcSelecResumenDeExcelenciaParte1.Parameters.ParamByName('@vperiodo').Value:= aPeriodo;

  //Aqu� se hace la selecci�n en la BD
  DataModulePlanillasDeExcelencia.ADOStoredProcSelecResumenDeExcelencia.Open; {S� genera datos, por eso se muestra}
  DataModulePlanillasDeExcelencia.ADOStoredProcSelecResumenDeExcelencia.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.EliminarPlanillaDeExcelencia(aID_Hospital: Integer; aAnno: Integer; aPeriodo: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarPlanillaDeExcelencia.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarPlanillaDeExcelencia.Parameters.ParamByName('@vid_Hospital').Value:= aID_Hospital;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarPlanillaDeExcelencia.Parameters.ParamByName('@vAnno').Value:= aAnno;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarPlanillaDeExcelencia.Parameters.ParamByName('@vPeriodo').Value:= aPeriodo;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarPlanillaDeExcelencia.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarPlanillaDeExcelencia.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.EliminarCursosProgramadosPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosPorID_Planilla.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosPorID_Planilla.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.EliminarCursosRealizadosPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosPorID_Planilla.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosPorID_Planilla.ExecProc;
end;



Procedure TModuloHospitalesDeExcelencia.CopiarCursosProgramadosPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosProgramadosPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosProgramadosPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la copia en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosProgramadosPorID_Planilla.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosProgramadosPorID_Planilla.ExecProc;
end;



Procedure TModuloHospitalesDeExcelencia.CopiarCursosRealizadosPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosRealizadosPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosRealizadosPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la copia en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosRealizadosPorID_Planilla.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcCopiarCursosRealizadosPorID_Planilla.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.RellenarCursosProgramadosDesdeTemporales;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcRellenarCursosProgramadosDesdeTemporales.Active:= False;

  //No hay que pasarle pasamos par�metros al StoreProcedure.

  //Aqu� se hace el relleno en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcRellenarCursosProgramadosDesdeTemporales.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcRellenarCursosProgramadosDesdeTemporales.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.RellenarCursosRealizadosDesdeTemporales;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcRellenarCursosRealizadosDesdeTemporales.Active:= False;

  //No hay que pasarle pasamos par�metros al StoreProcedure.

  //Aqu� se hace el relleno en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcRellenarCursosRealizadosDesdeTemporales.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcRellenarCursosRealizadosDesdeTemporales.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.RellenarBalancesDeExcelenciaParte1(aAnno: String; aPeriodo: String);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte1.Active:= False;

  //Se le pasan los par�metros a los StoreProcedure.
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte1.Parameters.ParamByName('@vanno').Value:= aAnno;
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte1.Parameters.ParamByName('@vperiodo').Value:= aPeriodo;

  //Aqu� se hace la selecci�n en la BD
  //DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte1.Open; {No genera datos, por eso se oculta}
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte1.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.RellenarBalancesDeExcelenciaParte2(aAnno: String; aPeriodo: String);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte2.Active:= False;

  //Se le pasan los par�metros a los StoreProcedure.
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte2.Parameters.ParamByName('@vanno').Value:= aAnno;
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte2.Parameters.ParamByName('@vperiodo').Value:= aPeriodo;

  //Aqu� se hace la selecci�n en la BD
  //DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte2.Open; {No genera datos, por eso se oculta}
  DataModulePlanillasDeExcelencia.ADOStoredProcRellenarBalancesDeExcelenciaParte2.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.ModificarCursoProgramadoTemporal(aID_Curso: Integer; aNuevoCurso: TCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.Parameters.ParamByName('@vNombre_TipoDeCurso').Value:= aNuevoCurso.Nombre_TipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.Parameters.ParamByName('@vLugar').Value:= aNuevoCurso.Lugar;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.Parameters.ParamByName('@vFechaInicio').Value:= aNuevoCurso.FechaInicio;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.Parameters.ParamByName('@vCantidadParticipantes').Value:= aNuevoCurso.CantidadParticipantes;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.Parameters.ParamByName('@vid_Curso').Value:= aID_Curso;

  //Aqu� se hace la modificaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoProgramadoTemporal.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.ModificarCursoRealizadoTemporal(aID_Curso: Integer; aNuevoCurso: TCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.Parameters.ParamByName('@vNombre_TipoDeCurso').Value:= aNuevoCurso.Nombre_TipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.Parameters.ParamByName('@vLugar').Value:= aNuevoCurso.Lugar;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.Parameters.ParamByName('@vFechaInicio').Value:= aNuevoCurso.FechaInicio;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.Parameters.ParamByName('@vCantidadParticipantes').Value:= aNuevoCurso.CantidadParticipantes;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.Parameters.ParamByName('@vid_Curso').Value:= aID_Curso;

  //Aqu� se hace la modificaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarCursoRealizadoTemporal.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.ModificarID_PlanillaEnCursosProgramadosTemporales(aViejoID_Planilla, aNuevoID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosProgramadosTemporales.Parameters.ParamByName('@vViejoID_Planilla').Value:= aViejoID_Planilla;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosProgramadosTemporales.Parameters.ParamByName('@vNuevoID_Planilla').Value:= aNuevoID_Planilla;

  //Aqu� se hace la modificaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosProgramadosTemporales.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosProgramadosTemporales.ExecProc;  
end;



procedure TModuloHospitalesDeExcelencia.ModificarID_PlanillaEnCursosRealizadosTemporales(aViejoID_Planilla, aNuevoID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosRealizadosTemporales.Parameters.ParamByName('@vViejoID_Planilla').Value:= aViejoID_Planilla;
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosRealizadosTemporales.Parameters.ParamByName('@vNuevoID_Planilla').Value:= aNuevoID_Planilla;

  //Aqu� se hace la modificaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosRealizadosTemporales.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcModificarID_PlanillaEnCursosRealizadosTemporales.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.ModificarNulosEnBalancesDeExcelencia;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;

  //No hay que pasarle par�metros al StoreProcedure.

  //Aqu� se hacen las modificaciones en la BD
  //DataModulePlanillasDeExcelencia.ADOStoredProcModificarNulosEnBalancesProgramadosDeExcelencia.Open; //NO genera datos, por eso se oculta
  //DataModulePlanillasDeExcelencia.ADOStoredProcModificarNulosEnBalancesRealizadosDeExcelencia.Open; //NO genera datos, por eso se oculta
  DataModulePlanillasDeExcelencia.ADOStoredProcModificarNulosEnBalancesProgramadosDeExcelencia.ExecProc;
  DataModulePlanillasDeExcelencia.ADOStoredProcModificarNulosEnBalancesRealizadosDeExcelencia.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.InsertarCursoProgramadoTemporal(aCurso: TCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.Parameters.ParamByName('@vNombre_TipoDeCurso').Value:= aCurso.Nombre_TipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.Parameters.ParamByName('@vLugar').Value:= aCurso.Lugar;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.Parameters.ParamByName('@vFechaInicio').Value:= aCurso.FechaInicio;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.Parameters.ParamByName('@vCantidadParticipantes').Value:= aCurso.CantidadParticipantes;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.Parameters.ParamByName('@vid_Planilla').Value:= aCurso.ID_Planilla;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoProgramadoTemporal.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.InsertarCursoRealizadoTemporal(aCurso: TCurso);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.Parameters.ParamByName('@vNombre_TipoDeCurso').Value:= aCurso.Nombre_TipoDeCurso;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.Parameters.ParamByName('@vLugar').Value:= aCurso.Lugar;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.Parameters.ParamByName('@vFechaInicio').Value:= aCurso.FechaInicio;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.Parameters.ParamByName('@vCantidadParticipantes').Value:= aCurso.CantidadParticipantes;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.Parameters.ParamByName('@vid_Planilla').Value:= aCurso.ID_Planilla;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarCursoRealizadoTemporal.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.InsertarGrupoDeCorreos(aNombreGrupo: AnsiString; aCorreos: AnsiString);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarGrupoDeCorreos.Active:= False;

  //Le pasamos los par�metros al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarGrupoDeCorreos.Parameters.ParamByName('@vNombreGrupo').Value:= aNombreGrupo;
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarGrupoDeCorreos.Parameters.ParamByName('@vCorreos').Value:= aCorreos;

  //Aqu� se hace la inserci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarGrupoDeCorreos.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcInsertarGrupoDeCorreos.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.EliminarCursoProgramadoTemporalPorID_Curso(aID_Curso: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoProgramadoTemporalPorID_Curso.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoProgramadoTemporalPorID_Curso.Parameters.ParamByName('@vid_Curso').Value:= aID_Curso;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoProgramadoTemporalPorID_Curso.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoProgramadoTemporalPorID_Curso.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.EliminarCursoRealizadoTemporalPorID_Curso(aID_Curso: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoRealizadoTemporalPorID_Curso.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoRealizadoTemporalPorID_Curso.Parameters.ParamByName('@vid_Curso').Value:= aID_Curso;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoRealizadoTemporalPorID_Curso.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursoRealizadoTemporalPorID_Curso.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.EliminarCursosProgramadosTemporalesPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosTemporalesPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosTemporalesPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosTemporalesPorID_Planilla.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosProgramadosTemporalesPorID_Planilla.ExecProc;
end;



procedure TModuloHospitalesDeExcelencia.EliminarCursosRealizadosTemporalesPorID_Planilla(aID_Planilla: Integer);
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosTemporalesPorID_Planilla.Active:= False;

  //Le pasamos el par�metro al StoreProcedure.
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosTemporalesPorID_Planilla.Parameters.ParamByName('@vid_Planilla').Value:= aID_Planilla;

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosTemporalesPorID_Planilla.Open; //NO genera datos, por eso se oculta
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarCursosRealizadosTemporalesPorID_Planilla.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.EliminarGruposDeCorreos;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarGruposDeCorreos.Active:= False;

  //No hay que pasarle pasamos par�metros al StoreProcedure.

  //Aqu� se hace la eliminaci�n en la BD
  //DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarGruposDeCorreos.Open; {NO genera datos, por eso se oculta}
  DataModuleHospitalesDeExcelencia.ADOStoredProcEliminarGruposDeCorreos.ExecProc;
end;


procedure TModuloHospitalesDeExcelencia.EliminarResumenDeExcelencia;
begin
  //Se realiza la conexi�n con la BD
  DataModuleConexionGeneral.ADOConnectionGeneral.Connected:= True;
  DataModulePlanillasDeExcelencia.ADOStoredProcEliminarResumenDeExcelencia.Active:= False;

  //No hay que pasarle pasamos par�metros al StoreProcedure.

  //Aqu� se hace la eliminaci�n en la BD
  //DataModulePlanillasDeExcelencia.ADOStoredProcEliminarResumenDeExcelencia.Open; {NO genera datos, por eso se oculta}
  DataModulePlanillasDeExcelencia.ADOStoredProcEliminarResumenDeExcelencia.ExecProc;
end;



end.
