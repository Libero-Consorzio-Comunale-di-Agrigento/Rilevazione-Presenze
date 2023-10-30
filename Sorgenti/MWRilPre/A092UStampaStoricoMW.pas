unit A092UStampaStoricoMW;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, A000UInterfaccia, R005UDataModuleMW, DB, DBClient, OracleData, C006UStoriaDati;

type

  TParametriInterfaccia = record
    Progressivo: Integer;
    Nominativo: String;
    Matricola: String;
    DaData,AData:TDateTime;
    chkVariazioni:Boolean;
    IsApplicazionePaghe:Boolean;
    ListaAnagra: TStringList;
  end;

  TA092FStampaStoricoMW = class(TR005FDataModuleMW)
    Q010S: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    dsrTabellaStampa: TDataSource;
    Q430: TOracleDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    C006FStoriaDati: TC006FStoriaDati;
    FiltroDatiAnagrafe: String;
    FiltroDatiAnagrafeP430: String;
    procedure ScriviStorico(i:Integer; RS:RecStoria);
  public
    FParametriInterfaccia: TParametriInterfaccia;
    procedure Inizializza(IsApplicazionePaghe: Boolean);
    procedure CreaTabellaStampa(Index: String);
    procedure SetFiltriDatiAnagrafe;
    Procedure ElaborazioneElemento;
  end;

implementation

{$R *.dfm}

procedure TA092FStampaStoricoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  C006FStoriaDati:=TC006FStoriaDati.Create(Self);
  FParametriInterfaccia.ListaAnagra:=TStringList.Create;
end;

procedure TA092FStampaStoricoMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(C006FStoriaDati);
  FreeAndNil(FParametriInterfaccia.ListaAnagra);
  inherited;
end;

procedure TA092FStampaStoricoMW.Inizializza(IsApplicazionePaghe: Boolean);
begin
  //Q010S.SetVariable('TABELLE',IfThen(IsApplicazionePaghe,'''T430_STORICO'',''P430_ANAGRAFICO''','''T430_STORICO'''));
  Q010S.SetVariable('TABELLE',IfThen(Parametri.V430 = 'P430','''T430_STORICO'',''P430_ANAGRAFICO''','''T430_STORICO'''));
  Q010S.SetVariable('APPLICAZIONE',IfThen(IsApplicazionePaghe,'PAGHE','*'));
  Q010S.Open;
end;

procedure TA092FStampaStoricoMW.SetFiltriDatiAnagrafe;
var i:Integer;
begin
  FiltroDatiAnagrafe:='';
  FiltroDatiAnagrafeP430:='';
  with Q010S do
    for i:=0 to FParametriInterfaccia.ListaAnagra.Count - 1 do
    begin
      if VarToStr(Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'TABLE_NAME')) = 'T430_STORICO' then
      begin
        if FiltroDatiAnagrafe <> '' then
          FiltroDatiAnagrafe:=FiltroDatiAnagrafe + ',';
        FiltroDatiAnagrafe:=FiltroDatiAnagrafe + VarToStr(Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME'));
      end;
      if VarToStr(Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'TABLE_NAME')) = 'P430_ANAGRAFICO' then
      begin
        if FiltroDatiAnagrafeP430 <> '' then
          FiltroDatiAnagrafeP430:=FiltroDatiAnagrafeP430 + ',';
        FiltroDatiAnagrafeP430:=FiltroDatiAnagrafeP430 + VarToStr(Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME'));
      end;
    end;
end;

procedure TA092FStampaStoricoMW.ElaborazioneElemento;
var i,j,NV: integer;
begin
  C006FStoriaDati.GetStoriaDato(FParametriInterfaccia.Progressivo,FiltroDatiAnagrafe);

  for i:=0 to FParametriInterfaccia.ListaAnagra.Count - 1 do
  begin
    NV:=0;
    //Conto quanti movimenti ricadono all'interno del periodo richiesto
    for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
      if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(Q010S.Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME')) then
        if (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <=  FParametriInterfaccia.AData) and
           (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= FParametriInterfaccia.DaData) then
          inc(NV);
    //Caricamento dei dati nella tabella di stampa
    if (not FParametriInterfaccia.chkVariazioni) or (NV > 1)
    or (VarToStr(Q010S.Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME')) = 'INIZIO')
    or (VarToStr(Q010S.Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME')) = 'FINE') then
      for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
        if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(Q010S.Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME')) then
          if (((not FParametriInterfaccia.chkVariazioni) or (NV > 1)) and
             (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <= FParametriInterfaccia.AData) and
             (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= FParametriInterfaccia.DaData))
          or (FParametriInterfaccia.chkVariazioni and (NV <= 1) and
              (   (RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = 'FINE')
               or (RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = 'INIZIO')) and
              (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Valore <> '') and
              (StrToDate(RecStoria(C006FStoriaDati.StoriaDipendente[j]).Valore) <= FParametriInterfaccia.AData) and
              (StrToDate(RecStoria(C006FStoriaDati.StoriaDipendente[j]).Valore) >= FParametriInterfaccia.DaData)) then
            ScriviStorico(i,RecStoria(C006FStoriaDati.StoriaDipendente[j]));
  end;
//=============================
//SOLO SE APPLICATIVO = "PAGHE"
//=============================
  //if FParametriInterfaccia.IsApplicazionePaghe then
  if Parametri.V430 = 'P430' then
  begin
    C006FStoriaDati.GetStoriaDatoP430(FParametriInterfaccia.Progressivo,FiltroDatiAnagrafeP430);
    for i:=0 to FParametriInterfaccia.ListaAnagra.Count - 1 do
    begin
      NV:=0;
      //Conto quanti movimenti ricadono all'interno del periodo richiesto
      for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
        if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(Q010S.Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME')) then
          if (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <= FParametriInterfaccia.AData) and
             (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= FParametriInterfaccia.DaData) then
            inc(NV);
      //Caricamento dei dati nella tabella di stampa
      if (not FParametriInterfaccia.chkVariazioni) or (NV > 1) then
        for j:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
          if RecStoria(C006FStoriaDati.StoriaDipendente[j]).NomeCampo = VarToStr(Q010S.Lookup('NOME_LOGICO',FParametriInterfaccia.ListaAnagra[i],'COLUMN_NAME')) then
            if (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Decorrenza <= FParametriInterfaccia.AData) and
               (RecStoria(C006FStoriaDati.StoriaDipendente[j]).Fine >= FParametriInterfaccia.DaData) then
              ScriviStorico(i,RecStoria(C006FStoriaDati.StoriaDipendente[j]));
    end;
  end;
end;

procedure TA092FStampaStoricoMW.ScriviStorico(i:Integer; RS:RecStoria);
begin
  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Progressivo').Value:=FParametriInterfaccia.Progressivo;
  TabellaStampa.FieldByName('CognomeNome').Value:=FParametriInterfaccia.Nominativo;
  TabellaStampa.FieldByName('Matricola').Value:=FParametriInterfaccia.Matricola;
  TabellaStampa.FieldByName('SeqCampo').Value:=i;
  TabellaStampa.FieldByName('DataDecorrenza').AsString:=RS.DataDec;

  if RS.DataFine = '31/12/3999' then
    TabellaStampa.FieldByName('DataFine').Value:='Corrente'
  else
    TabellaStampa.FieldByName('DataFine').Value:=RS.DataFine;

  TabellaStampa.FieldByName('Campo').AsString:=RS.TipoDato;
  TabellaStampa.FieldByName('Dato').AsString:=RS.Valore;
  TabellaStampa.FieldByName('Descrizione').AsString:=RS.Descrizione;
  TabellaStampa.Post;
end;

procedure TA092FStampaStoricoMW.CreaTabellaStampa(Index: String);
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('CognomeNome',ftString,60,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftString,8,False);
  TabellaStampa.FieldDefs.Add('SeqCampo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('DataDecorrenza',ftDate,0,False);
  TabellaStampa.FieldDefs.Add('DataFine',ftString,10,False);
  TabellaStampa.FieldDefs.Add('Campo',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Dato',ftString,40,False);
  TabellaStampa.FieldDefs.Add('Descrizione',ftString,100,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primary',('CognomeNome;Progressivo;SeqCampo;DataDecorrenza'),[ixUnique]);
  TabellaStampa.IndexDefs.Add('IdxData',('CognomeNome;Progressivo;DataDecorrenza;SeqCampo'),[ixUnique]);
  TabellaStampa.CreateDataSet;

  TabellaStampa.FieldByName('Progressivo').Visible:=False;
  TabellaStampa.FieldByName('SeqCampo').Visible:=False;
  TabellaStampa.FieldByName('CognomeNome').DisplayLabel:='Nominativo';
  TabellaStampa.FieldByName('DataDecorrenza').DisplayLabel:='Decorrenza';
  TabellaStampa.FieldByName('DataFine').DisplayLabel:='Termine';
  TabellaStampa.FieldByName('Campo').DisplayLabel:='Dato';
  TabellaStampa.FieldByName('Dato').DisplayLabel:='Valore';
  TabellaStampa.FieldByName('Descrizione').DisplayLabel:='Descrizione';

  TabellaStampa.LogChanges:=False;
  TabellaStampa.IndexName:=Index;

end;

end.
