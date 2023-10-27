unit WR208UGestTimbFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWApplication, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR100UBase,
  IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, IWDBStdCtrls, meIWDBEdit,
  IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWCompListbox,
  meIWDBLookupComboBox, medpIWMultiColumnComboBox, C180FunzioniGenerali,
  meIWRadioGroup,OracleData, IWAdvRadioGroup, meTIWAdvRadioGroup, A000UInterfaccia,
  A000UMessaggi, A000UCostanti, medpIWMessageDlg, R500Lin,DB,WR104UGestCartellino,
  A000UGestioneTimbraGiustMW;

type
  TWR208FGestTimbFM = class(TWR200FBaseFM)
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    lblData: TmeIWLabel;
    edtData: TmeIWEdit;
    lblDescData: TmeIWLabel;
    lblOra: TmeIWLabel;
    dedtOra: TmeIWDBEdit;
    drgpVerso: TmeIWDBRadioGroup;
    lblVerso: TmeIWLabel;
    lblRilevatore: TmeIWLabel;
    cmbRilevatore: TMedpIWMultiColumnComboBox;
    lblDescOrologio: TmeIWLabel;
    lblCausale: TmeIWLabel;
    cmbCausale: TMedpIWMultiColumnComboBox;
    rgpTipoCausale: TmeTIWAdvRadioGroup;
    lblDescCausale: TmeIWLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbRilevatoreAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure rgpTipoCausaleAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnConfermaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    DataOperazione: TDateTime;
    NumTimbratura: Integer;
    DatiModificati: Boolean;
    procedure caricaComboCausale;
    procedure ImpostaDescCausale;
    procedure ImpostaDescOrologio;
  public
    A000FGestioneTimbraGiustMW: TA000FGestioneTimbraGiustMW;
    function InserisciTimbratura(Data:TDateTime): Boolean; virtual;
    function ModificaTimbratura(Data:TDateTime; Num:Integer): Boolean; virtual;
    procedure Visualizza; virtual;
    procedure ReleaseOggetti; override;
  end;

implementation

{$R *.dfm}
procedure TWR208FGestTimbFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  DatiModificati:=False;
  with (Self.Parent as TWR104FGestCartellino) do
  begin
    dedtOra.DataSource:=DsrTimbrature;
    drgpVerso.DataSource:=DsrTimbrature;
    //Chiamata: 83085
    QRilevatori.Filtered:=True;
    QRilevatori.First;
    cmbRilevatore.Items.Clear;
    while not QRilevatori.Eof do
    begin
      cmbRilevatore.AddRow(QRilevatori.FieldByName('CODICE').AsString + ';' +  QRilevatori.FieldByName('DESCRIZIONE').AsString);
      QRilevatori.Next;
    end;
  end;
end;

procedure TWR208FGestTimbFM.Visualizza();
begin
  edtData.Text:=IntToStr(R180Giorno(DataOperazione));
  lblDescData.Caption:=FormatDateTime('mmmm yyyy',DataOperazione);
end;

function TWR208FGestTimbFM.InserisciTimbratura(Data:TDateTime): Boolean;
begin
  Result:=True;
  if Parametri.InserisciTimbrature <> 'S' then Result:=False;
  if A000FGestioneTimbraGiustMW.FNumTimbrature[R180Giorno(Data)] = MaxTimbrature then Result:=False;
  A000FGestioneTimbraGiustMW.StatoTimb:=stInserimento;
  btnConferma.OnAsyncClick:=btnConfermaAsyncClick;
  btnConferma.OnClick:=nil;
  DataOperazione:=Data;
  NumTimbratura:=A000FGestioneTimbraGiustMW.FNumTimbrature[R180Giorno(Data)] + 1;
  ImpostaDescOrologio;
  rgpTipoCausale.ItemIndex:=0;
  caricaComboCausale;
  cmbCausale.Text:='';
  ImpostaDescCausale;
  cmbRilevatore.Text:='';
  lblDescOrologio.Caption:='';
  with (Self.Parent as TWR104FGestCartellino) do
  begin
    dsrTimbrature.Dataset.Append;
  end;
end;

function TWR208FGestTimbFM.ModificaTimbratura(Data:TDateTime; Num:Integer): Boolean;
var
  Timbratura: TTimbrature;
begin
  Result:=True;
  DataOperazione:=Data;
  NumTimbratura:=Num;
  Timbratura:=A000FGestioneTimbraGiustMW.FTimbrature[R180Giorno(DataOperazione),NumTimbratura];
  with (Self.Parent as TWR104FGestCartellino) do
  begin
    if not(DsrTimbrature.DataSet.Locate('Data;Ora;Verso;Flag',VarArrayOf([DataOperazione,Timbratura.Ora,Timbratura.Verso,Timbratura.Flag]),[])) then
    begin
      Result:=False;
      Exit;
    end;
  end;

  A000FGestioneTimbraGiustMW.StatoTimb:=stModifica;
  with (Self.Parent as TWR104FGestCartellino) do
    DsrTimbrature.DataSet.Edit;
  edtData.ReadOnly:=True;

  cmbRilevatore.Text:=Timbratura.Rilevatore;
  //Chiamata:84044 Utente: SanGiuliano_mi. il rilevatore della timbratura può non essere
  //presente sulla T361.Svuoto la combo del rilevatore
  if cmbRilevatore.ItemIndex = -1 then
    cmbRilevatore.Text:='';
  //Chiamata:84044 Utente: SanGiuliano_mi. FINE

  ImpostaDescOrologio;
  if rgpTipoCausale.visible then
  begin
    with (Self.Parent as TWR104FGestCartellino) do
    begin
      //Scelgo le causali di presenza o giustificazione a seconda della causale
      if QCausPres.Locate('Codice',Timbratura.Causale,[]) then
        rgpTipoCausale.ItemIndex:=0
      else
        if QCausGiust.Locate('Codice',Timbratura.Causale,[]) then
          rgpTipoCausale.ItemIndex:=1;
    end;
  end;
  caricaComboCausale;
  cmbCausale.Text:=Timbratura.Causale;
  ImpostaDescCausale;
end;

procedure TWR208FGestTimbFM.ReleaseOggetti;
begin
  //Chiamata: 83085
  try
    (Self.Parent as TWR104FGestCartellino).QRilevatori.Filtered:=False;
  except
  end;
  inherited;
end;

procedure TWR208FGestTimbFM.rgpTipoCausaleAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  cmbCausale.Text:='';
  lblDescCausale.Caption:='';
  caricaComboCausale;
end;

procedure TWR208FGestTimbFM.btnConfermaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  btnChiudiClick(Sender);
end;

procedure TWR208FGestTimbFM.caricaComboCausale;
var Ods:TOracleDataset;
begin
  cmbCausale.Items.Clear;
  with (Self.Parent as TWR104FGestCartellino) do
  begin
    if (rgpTipoCausale.Visible) and (rgpTipoCausale.ItemIndex = 0) then
      Ods:=QCausPres
    else
      Ods:=QCausGiust;
  end;

  Ods.First;
  while not Ods.Eof do
  begin
    cmbCausale.AddRow(Ods.FieldByName('CODICE').AsString + ';' + Ods.FieldByName('DESCRIZIONE').AsString);
    Ods.Next;
  end;
end;

procedure TWR208FGestTimbFM.ImpostaDescCausale;
begin
  lblDescCausale.Caption:='';
  if cmbCausale.ItemIndex <> -1 then
    lblDescCausale.Caption:=cmbCausale.Items[cmbCausale.ItemIndex].RowData[1];
end;

procedure TWR208FGestTimbFM.ImpostaDescOrologio;
begin
  lblDescOrologio.Caption:='';
  if cmbRilevatore.text <> '' then
  begin
    lblDescOrologio.Caption:=cmbRilevatore.Items[cmbRilevatore.ItemIndex].RowData[1];
  end;
end;

procedure TWR208FGestTimbFM.btnChiudiClick(Sender: TObject);
var
  anno,mese,giorno : Word;
  ConfermaDati: Boolean;
  LErrMsg: String;
begin
  //sender: btnchiudi, btnConferma o nullo se scatenato da submit di edtOra
  if Sender = btnChiudi then
    ConfermaDati:=False
  else
    ConfermaDati:=True;

  A000FGestioneTimbraGiustMW.EU:=#0;
  with (Self.Parent as TWR104FGestCartellino) do
  begin
    if not ConfermaDati then
    begin
      DsrTimbrature.DataSet.Cancel;
    end
    else //btnConferma
    begin
      if DsrTimbrature.DataSet.FieldByName('Ora').IsNull then
      begin
        //MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Ora']),mtError,[mbOk],nil,'');
        GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Ora']));
        Exit;
      end;

      if A000FGestioneTimbraGiustMW.StatoTimb = stInserimento then
      begin
        try
          DecodeDate(DataOperazione,anno,mese,giorno);
          giorno:=StrToInt(edtData.Text);
          DataOperazione:=EncodeDate(anno,mese,giorno);
        except
          //MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
          GGetWebApplicationThreadVar.ShowMessage(A000MSG_ERR_DATA_ERRATA);
          Exit;
        end;
        try
          A000FGestioneTimbraGiustMW.EseguiInserisciTimbratura(DataOperazione);
        except
          on E: Exception do
          begin
            if Pos('ORA-00001:',E.Message) > 0 then
              LErrMsg:=A000TraduzioneStringhe(A000MSG_ERR_TIMB_DUPLICATA)
            else
              LErrMsg:=E.Message;
            GGetWebApplicationThreadVar.ShowMessage(LErrMsg);
            Exit;
          end;
        end;
        DatiModificati:=True;
        //se non ho raggiunto il limite timbrature consento altro inserimento senza uscire
        if A000FGestioneTimbraGiustMW.FNumTimbrature[giorno] < MaxTimbrature then
        begin
          A000FGestioneTimbraGiustMW.EU:=DsrTimbrature.DataSet.FieldByName('Verso').AsString[1];
          DsrTimbrature.DataSet.Append;
          //mantengo orologio impostato
          with (Self.Parent as TWR104FGestCartellino) do
          begin
            DsrTimbrature.DataSet.FieldByName('RILEVATORE').asString:=cmbRilevatore.Text;
          end;
          //svuoto causale
          cmbCausale.Text:='';
          lblDescCausale.Caption:='';
          dedtOra.SetFocus;
          Exit;
        end;
      end
      else //modifica
      begin
        giorno:=R180Giorno(DataOperazione);
        if not A000FGestioneTimbraGiustMW.TimbraturaModificata(giorno, NumTimbratura) then
        begin
          DsrTimbrature.DataSet.Cancel;
        end
        else
        begin
          DatiModificati:=True;
          A000FGestioneTimbraGiustMW.EseguiModificaTimbratura(DataOperazione,giorno, NumTimbratura);
        end;
      end;
    end;

    //in caso di inserimento il frame non viene chiuso.
    //potrei inserire n timbrature e poi fare chiudi. testo la variabile e non il pulsante premuto
    if DatiModificati then
    begin
      if DsrTimbrature.DataSet.State in [dsEdit,dsInsert] then DsrTimbrature.DataSet.Cancel;
      DsrTimbrature.DataSet.Close;
      DsrTimbrature.DataSet.Open;
      CaricaGrid;
    end;

    //Riesame del 15/10/2013 su ativita WA023
    grdCartellino.Visible:=True;
  end;
  ReleaseOggetti;
  Free;
end;

procedure TWR208FGestTimbFM.cmbCausaleAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with (Self.Parent as TWR104FGestCartellino) do
    DsrTimbrature.DataSet.FieldByName('CAUSALE').asString:=cmbCausale.Text;
  ImpostaDescCausale;
end;

procedure TWR208FGestTimbFM.cmbRilevatoreAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (Self.Parent as TWR104FGestCartellino) do
    DsrTimbrature.DataSet.FieldByName('RILEVATORE').asString:=cmbRilevatore.Text;
  if cmbRilevatore.Text <> '' then
    lblDescOrologio.Caption:=cmbRilevatore.Items[cmbRilevatore.ItemIndex].RowData[1]
  else
    lblDescOrologio.Caption:='';
end;

end.
