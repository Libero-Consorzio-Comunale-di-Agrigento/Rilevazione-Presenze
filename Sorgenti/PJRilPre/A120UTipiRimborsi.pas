unit A120UTipiRimborsi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGestTab, ActnList, ImgList, Db, Menus, ComCtrls, ToolWin, StdCtrls,
  ExtCtrls, DBCtrls, Mask, OracleData, Oracle, A000UCostanti, A000USessione,A000UInterfaccia,
  Variants, System.Actions, C013UCheckList, C180FunzioniGenerali;

type
  TA120FTIPIRIMBORSI = class(TR001FGestTab)
    Panel2: TPanel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtCodiceVociPaghe: TDBEdit;
    LblCodice: TLabel;
    LblDescrizione: TLabel;
    LblCodiceVociPaghe: TLabel;
    grpIndennitaSuppl: TGroupBox;
    LblCodiceVociPagheIndennitaSupplementare: TLabel;
    LblPercentualePerIndennitaSupplementare: TLabel;
    LblArrotondamentoPerIndennitaSupplementare: TLabel;
    dLblArrotondamentoPerIndennitaSupplementare: TDBText;
    dedtPercentualePerIndennitaSupplementare: TDBEdit;
    dedtCodiceVociPagheIndennitaSupplementare: TDBEdit;
    dcmbArrotondamentoPerIndennitaSupplementare: TDBLookupComboBox;
    dchkScaricoPaghe: TDBCheckBox;
    dchkEsistenza: TDBCheckBox;
    dchkScarico: TDBCheckBox;
    pmnTipiRimborsi: TPopupMenu;
    NuovoElemento1: TMenuItem;
    dchkAnticipo: TDBCheckBox;
    dcmbTipoRimb: TDBComboBox;
    lblTipoRimb: TLabel;
    grpIterWeb: TGroupBox;
    Label1: TLabel;
    dcmbTipoQuantita: TDBComboBox;
    Label2: TLabel;
    dedtPercAnticipo: TDBEdit;
    lblNoteFisse: TLabel;
    dedtNoteFisse: TDBEdit;
    dchkFlagMotivazione: TDBCheckBox;
    dchkFlagTarga: TDBCheckBox;
    Label3: TLabel;
    dchkFlagMezzoProprio: TDBCheckBox;
    dcmbCategRimborsi: TDBLookupComboBox;
    lblCategRimborsi: TLabel;
    dedtImportoMax: TDBEdit;
    lblImportoMax: TLabel;
    btnFasiCompetenza: TButton;
    dedtFasiCompetenza: TDBEdit;
    Label4: TLabel;
    procedure dcmbArrotondamentoPerIndennitaSupplementareKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dcmbTipoQuantitaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure dcmbTipoRimbClick(Sender: TObject);
    procedure btnFasiCompetenzaClick(Sender: TObject);
    procedure dchkFlagMezzoProprioClick(Sender: TObject);
    procedure dchkAnticipoClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
  private
    procedure IniDCmbCategRimborsi;
    function IsFasiCompetenzaModificabile: Boolean;
  end;

const
  D_TipoQuantita: array[0..3] of string = (
    {}  '',
    {I} 'Importo',
    {F} 'Flag',
    {Q} 'Quantità');
var
  A120FTIPIRIMBORSI: TA120FTIPIRIMBORSI;
  procedure OpenA120TipiRimborsi(Cod:String);

implementation

uses
  A120UTipiRimborsiDtM,
  P050UArrotondamenti, A149UCategRimborsi, C018UIterAutDM;

{$R *.DFM}

procedure OpenA120TipiRimborsi(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA120TipiRimborsi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA120FTipiRimborsi,A120FTIPIRIMBORSI);
  Application.CreateForm(TA120FTipiRimborsiDtm,A120FTIPIRIMBORSIDtm);
  A120FTIPIRIMBORSIDtm.M020.SearchRecord('CODICE',Cod,[srFromBeginning]);
  try
    Screen.Cursor:=crDefault;
    A120FTipiRimborsi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A120FTipiRimborsi.Free;
    A120FTipiRimborsiDtM.Free;
  end;
end;

procedure TA120FTIPIRIMBORSI.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A120FTipiRimborsiDtM.m020;
  dcmbArrotondamentoPerIndennitaSupplementare.ListSource:=A120FTIPIRIMBORSIDtm.A120FTipiRimborsiMW.DsrP050;
  inherited;
end;

procedure TA120FTIPIRIMBORSI.FormShow(Sender: TObject);
begin
  inherited;
  IniDCmbCategRimborsi;
  // popola tipi rimborso
  dcmbTipoRimb.Items.Add('');
  dcmbTipoRimb.Items.Add(M020TIPO_PASTO);
  dcmbTipoRimb.Items.Add(M020TIPO_MEZZO);
  dcmbTipoRimb.Items.Add(M020TIPO_PEDAGGIO);
end;

procedure TA120FTIPIRIMBORSI.IniDCmbCategRimborsi;
begin
  dCmbCategRimborsi.DataSource:=DButton;
  dCmbCategRimborsi.DataField:='CATEG_RIMBORSO';
  dCmbCategRimborsi.KeyField:='CODICE';
  dCmbCategRimborsi.ListSource:=A120FTIPIRIMBORSIDTM.A120FTipiRimborsiMW.dsrM022;
  dCmbCategRimborsi.ListField:='DESCRIZIONE';
end;

procedure TA120FTIPIRIMBORSI.NuovoElemento1Click(Sender: TObject);
begin
  inherited;
  if pmnTipiRimborsi.PopupComponent = dcmbArrotondamentoPerIndennitaSupplementare then
  begin
    OpenP050FArrotondamenti(TDBLookupComboBox(pmnTipiRimborsi.PopupComponent).Field.AsString);
    A120FTIPIRIMBORSIDTM.A120FTipiRimborsiMW.selP050.Refresh;
  end
  else if pmnTipiRimborsi.PopupComponent = dcmbCategRimborsi then
  begin
    OpenA149CategRimborsi(TDBLookupComboBox(pmnTipiRimborsi.PopupComponent).Field.AsString);
    A120FTIPIRIMBORSIDTM.A120FTipiRimborsiMW.selM022.Refresh;
  end

end;

procedure TA120FTIPIRIMBORSI.btnFasiCompetenzaClick(Sender: TObject);
var
  C013:TC013FCheckList;
begin
  inherited;
  C013:=TC013FCheckList.Create(nil);
  try
    C013.clbListaDati.Items.Add(IntToStr(M140FASE_INIZIALE));
    C013.clbListaDati.Items.Add(IntToStr(M140FASE_RICHIESTA));
    C013.clbListaDati.Items.Add(IntToStr(M140FASE_AUTORIZZAZIONE));
    C013.clbListaDati.Items.Add(IntToStr(M140FASE_AGVIAGGIO));
    C013.clbListaDati.Items.Add(IntToStr(M140FASE_CASSA));
    C013.clbListaDati.Items.Add(IntToStr(M140FASE_RIMBORSI));
    C013.clbListaDati.Items.Add(IntToStr(M140FASE_CHIUSURA));
    R180PutCheckList(A120FTIPIRIMBORSIDTM.M020.FieldByName('FASI_COMPETENZA').AsString,5,C013.clbListaDati);
    if C013.ShowModal = mrOk then
    begin
      A120FTIPIRIMBORSIDTM.M020.FieldByName('FASI_COMPETENZA').AsString:=R180GetCheckList(5,C013.clbListaDati,',');
    end;
  finally
    FreeAndNil(C013);
  end;
end;

function TA120FTIPIRIMBORSI.IsFasiCompetenzaModificabile: Boolean;
begin
  Result:=(DButton.State <> dsBrowse) and
          ({(DButton.Dataset.FieldByName('FLAG_ANTICIPO').AsString = 'S')}dchkAnticipo.Checked or
           ((DButton.Dataset.FieldByName('TIPO').AsString = M020TIPO_MEZZO) and
            (DButton.Dataset.FieldByName('FLAG_MEZZO_PROPRIO').AsString = 'S')));
end;

procedure TA120FTIPIRIMBORSI.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btnFasiCompetenza.Enabled:=IsFasiCompetenzaModificabile;
end;

procedure TA120FTIPIRIMBORSI.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dcmbTipoRimb.Enabled:=DButton.State <> dsBrowse;
  dcmbTipoQuantita.Enabled:=DButton.State <> dsBrowse;
  dchkFlagMezzoProprio.Enabled:=(DButton.Dataset.FieldByName('TIPO').AsString = M020TIPO_MEZZO);
  btnFasiCompetenza.Enabled:=IsFasiCompetenzaModificabile;
end;

procedure TA120FTIPIRIMBORSI.dchkAnticipoClick(Sender: TObject);
begin
  inherited;
  //btnFasiCompetenza.Enabled:=IsFasiCompetenzaModificabile;
end;

procedure TA120FTIPIRIMBORSI.dchkFlagMezzoProprioClick(Sender: TObject);
begin
  inherited;
  //btnFasiCompetenza.Enabled:=IsFasiCompetenzaModificabile;
end;

procedure TA120FTIPIRIMBORSI.dcmbArrotondamentoPerIndennitaSupplementareKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA120FTIPIRIMBORSI.dcmbTipoQuantitaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  TDBComboBox(Control).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_TipoQuantita[Index]);
end;

procedure TA120FTIPIRIMBORSI.dcmbTipoRimbClick(Sender: TObject);
begin
  inherited;
  dchkFlagMezzoProprio.Enabled:=dcmbTipoRimb.Text = M020TIPO_MEZZO;
  if not dchkFlagMezzoProprio.Enabled then
    dchkFlagMezzoProprio.Checked:=False;
end;

end.
