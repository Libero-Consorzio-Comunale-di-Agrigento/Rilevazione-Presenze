unit P651URelazioniTabelle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, DBCtrls, Buttons, ExtCtrls, ComCtrls, ActnList,
  A000UCostanti, A000USessione, A000UInterfaccia, OracleData, StrUtils, Math,
  C180FunzioniGenerali, R004UGestStorico, Variants, DBGrids, Grids,
  ImgList, ToolWin, Mask, A000UMessaggi, System.Actions, OracleMonitor;

type
  TP651FRelazioniTabelle = class(TR004FGestStorico)
    dgrdRelazioni: TDBGrid;
    actCopiaSuAltriDip: TAction;
    Panel1: TPanel;
    lblTipologia: TLabel;
    cmbTipologia: TDBLookupComboBox;
    Splitter1: TSplitter;
    MemoControlli: TMemo;
    procedure FormShow(Sender: TObject);
    procedure cmbTipologiaCloseUp(Sender: TObject);
    procedure cmbTipologiaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P651FRelazioniTabelle: TP651FRelazioniTabelle;

procedure OpenP651RelazioniTabelle(TipoFlusso,Flusso:String);

implementation

uses P651URelazioniTabelleDtM;

{$R *.DFM}

procedure OpenP651RelazioniTabelle(TipoFlusso,Flusso:String);
begin
  if not A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,nil) then
    raise Exception.Create(A000MSG_P651_ERR_NO_CDC);
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP651RelazioniTabelle' + TipoFlusso) of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  P651FRelazioniTabelle:=TP651FRelazioniTabelle.Create(nil);
  P651FRelazioniTabelleDtM:=TP651FRelazioniTabelleDtM.Create(nil);
  P651FRelazioniTabelleDtM.P651FRelazioniTabelleMW.TipoFlusso:=TipoFlusso;
  P651FRelazioniTabelleDtM.P651FRelazioniTabelleMW.NomeFlusso:=Flusso;
  try
    Screen.Cursor:=crDefault;
    P651FRelazioniTabelle.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P651FRelazioniTabelle.Free;
    P651FRelazioniTabelleDtM.Free;
  end;
end;

procedure TP651FRelazioniTabelle.FormShow(Sender: TObject);
begin
  inherited;
  with P651FRelazioniTabelleDtM do
  begin
    if P651FRelazioniTabelleMW.TipoFlusso = '' then
      P651FRelazioniTabelleMW.TipoFlusso:='CA'; //per test
    //impostazioni in base al TipoFlusso
    if P651FRelazioniTabelleMW.TipoFlusso = 'FL' then
      if InterfacciaR004.LChiavePrimaria.IndexOf('COD_DATO2') >= 0 then
        InterfacciaR004.LChiavePrimaria.Delete(InterfacciaR004.LChiavePrimaria.IndexOf('COD_DATO2'));
    InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=P651FRelazioniTabelleMW.TipoFlusso <> 'FL';
    MemoControlli.Visible:=P651FRelazioniTabelleMW.TipoFlusso <> 'FL';
    Splitter1.Visible:=P651FRelazioniTabelleMW.TipoFlusso <> 'FL';
    P651FRelazioniTabelle.HelpContext:=IfThen(P651FRelazioniTabelleMW.TipoFlusso = 'FL',3651000,3651100);
    P651FRelazioniTabelle.Caption:='<P651> Relazioni tabelle ' + IfThen(P651FRelazioniTabelleMW.TipoFlusso = 'FL','FLUPER','conto annuale');
    //ricerca del NomeFlusso e impostazione griglia
    DButton.DataSet:=selI037;
    P651FRelazioniTabelleMW.Inizio;
    cmbTipologia.KeyValue:=P651FRelazioniTabelleMW.NomeFlusso;
    dgrdRelazioni.Columns[1].Visible:=P651FRelazioniTabelleMW.selI037.FieldByName('DECORRENZA_FINE').Visible;
    dgrdRelazioni.Columns[2].PickList.Clear;
    dgrdRelazioni.Columns[2].PickList.AddStrings(P651FRelazioniTabelleMW.lstDati1);
    dgrdRelazioni.Columns[2].Title.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C13_CdcPercentualizzati,1,1)) +
                                                                  LowerCase(Copy(Parametri.CampiRiferimento.C13_CdcPercentualizzati,2,length(Parametri.CampiRiferimento.C13_CdcPercentualizzati)));
    dgrdRelazioni.Columns[4].PickList.Clear;
    dgrdRelazioni.Columns[4].PickList.AddStrings(P651FRelazioniTabelleMW.lstDati2);
    dgrdRelazioni.Columns[4].Title.Caption:=UpperCase(Copy(P651FRelazioniTabelleMW.NomeDato,1,1)) + LowerCase(Copy(P651FRelazioniTabelleMW.NomeDato,2));
    dgrdRelazioni.Columns[6].Visible:=P651FRelazioniTabelleMW.selI037.FieldByName('PERCENTUALE').Visible;
    Controlli;
  end;
end;

procedure TP651FRelazioniTabelle.cmbTipologiaCloseUp(Sender: TObject);
begin
  inherited;
  with P651FRelazioniTabelleDtM do
  begin
    P651FRelazioniTabelleMW.NomeFlusso:=cmbTipologia.Text;
    P651FRelazioniTabelleMW.Inizio;
    dgrdRelazioni.Columns[4].PickList.Clear;
    dgrdRelazioni.Columns[4].PickList.AddStrings(P651FRelazioniTabelleMW.lstDati2);
    dgrdRelazioni.Columns[4].Title.Caption:=UpperCase(Copy(P651FRelazioniTabelleMW.NomeDato,1,1)) + LowerCase(Copy(P651FRelazioniTabelleMW.NomeDato,2));
    Controlli;
  end;
end;

procedure TP651FRelazioniTabelle.cmbTipologiaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbTipologiaCloseUp(nil);
end;

procedure TP651FRelazioniTabelle.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

procedure TP651FRelazioniTabelle.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if MemoControlli.Text <> '' then
    if R180MessageBox(A000MSG_P651_DLG_EXIT_ANOMALIE,DOMANDA) <> mrYes then
      Action:=caNone;
end;

end.
