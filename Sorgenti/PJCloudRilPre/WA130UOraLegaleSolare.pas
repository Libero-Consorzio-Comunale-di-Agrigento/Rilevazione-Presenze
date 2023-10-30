unit WA130UOraLegaleSolare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton,
  IWDBGrids, medpIWDBGrid, meIWRadioGroup, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,OracleData,
  medpIWMessageDlg, A000UInterfaccia, A000UMessaggi, A130UOraLegaleSolareMW, WC013UCheckListFM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, Menus;

type
  TWA130FOraLegaleSolare = class(TWR100FBase)
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    lblDaOre: TmeIWLabel;
    edtDaOre: TmeIWEdit;
    lblAOre: TmeIWLabel;
    edtAOre: TmeIWEdit;
    edtOrologi: TmeIWEdit;
    lblOrologi: TmeIWLabel;
    rgpPresMens: TmeIWRadioGroup;
    rgpLegsol: TmeIWRadioGroup;
    grdRisultati: TmedpIWDBGrid;
    btnVisualizza: TmedpIWImageButton;
    btnModifica: TmedpIWImageButton;
    btnOrologi: TmeIWButton;
    btnSalvaSuFile: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    actScaricaInExcelRisultati: TMenuItem;
    lblModificaRichiesta: TmeIWLabel;
    actScaricaInCSVRisultati: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnOrologiClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnModificaClick(Sender: TObject);
    procedure actScaricaInExcelRisultatiClick(Sender: TObject);
    procedure btnSalvaSuFileClick(Sender: TObject);
    procedure actScaricaInCSVRisultatiClick(Sender: TObject);
  private
    A130MW:TA130FOraLegaleSolareMW;
    WC013:TWC013FCheckListFM;
    dtsAppoggio:TOracleDataSet;
    procedure Visualizza(dtsTimb: TOracleDataSet);
    procedure ckOrologiResult(Sender: TObject; Result:Boolean);
    procedure Modifica(dtsTimb: TOracleDataSet);
    procedure ResultModifica(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultSalvaIntestazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure SettaVariabiliMW;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  end;


implementation

{$R *.dfm}

procedure TWA130FOraLegaleSolare.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=True;
  A130MW:=TA130FOraLegaleSolareMW.Create(Self);
  AttivaGestioneC700;
  grdRisultati.medpPaginazione:=True;
  grdRisultati.medpRighePagina:=12;
  edtDaData.Text:=DateToStr(Parametri.DataLavoro);
  edtAData.Text:=DateToStr(Parametri.DataLavoro);
  visualizza(A130MW.selT100);
end;

procedure TWA130FOraLegaleSolare.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TWC013FCheckListFM) and (AComponent = WC013) then
      WC013:=nil
    (*else if (AComponent is TWC015FSelEditGridFM) and (AComponent = WC015FSelEditGridFM) then
      WC015FSelEditGridFM:=nil
    *)
    ;
  end;
end;

procedure TWA130FOraLegaleSolare.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  if WC013 <> nil then
    FreeAndNil(WC013);
end;

procedure TWA130FOraLegaleSolare.actScaricaInCSVRisultatiClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdRisultati.ToCsv
  else
    inviaFile('Estrazione.xls',csvDownload);
end;

procedure TWA130FOraLegaleSolare.actScaricaInExcelRisultatiClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdRisultati.ToXlsx
  else
    inviaFile('Estrazione.xlsx',streamDownload);
end;

procedure TWA130FOraLegaleSolare.btnModificaClick(Sender: TObject);
begin
  if rgpPresMens.ItemIndex = 0 then
    Modifica(A130MW.selT100)
  else
    Modifica(A130MW.selT370);
end;

procedure TWA130FOraLegaleSolare.Modifica(dtsTimb:TOracleDataSet);
begin
  dtsAppoggio:=dtsTimb;
  MsgBox.WebMessageDlg(Format(A000MSG_A130_DLG_FMT_APPLICA_MODIFICHE,[edtDaData.Text,edtAData.Text,edtDaOre.Text,edtAOre.Text]),mtConfirmation,[mbYes,mbNo],ResultModifica,'');
end;

procedure TWA130FOraLegaleSolare.ResultModifica(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
var data: TDateTime;
begin
//applica le modifiche dell'anteprima
  if Res = mrYes then
  begin
    SettaVariabiliMW;
    A130MW.dtsTimb:=dtsAppoggio;
    A130MW.ModificaOra;
    btnModifica.Enabled:=False;
    MsgBox.WebMessageDlg(A000MSG_MSG_MODIFICA_COMPLETATA,mtInformation,[mbOk],nil,'');
    Visualizza(dtsAppoggio);
  end;
end;

procedure TWA130FOraLegaleSolare.btnOrologiClick(Sender: TObject);
begin
 inherited;
  WC013:=TWC013FCheckListFM.Create(Self);
  with A130MW do
  begin
    if rgpPresMens.ItemIndex = 0 then
      selT361.SetVariable('TOROLOGIO','P')
    else
      selT361.SetVariable('TOROLOGIO','M');
    selT361.Open;
    while not selT361.Eof do
    begin
      WC013.ckList.Items.Add(Format('%-5s %s',[selT361.FieldByName('CODICE').AsString,selT361.FieldByName('DESCRIZIONE').AsString]));
      WC013.ckList.Values.Add(Trim(selT361.FieldByName('CODICE').AsString));
      selT361.Next;
    end;
    WC013.ResultEvent:=ckOrologiResult;
    C190PutCheckList(edtOrologi.Text,30,WC013.ckList);
    WC013.Visualizza;
    selT361.Close;
  end;
end;

procedure TWA130FOraLegaleSolare.btnSalvaSuFileClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_A130_DLG_SALVA_INTESTAZIONE,mtConfirmation,[mbYes,mbNo],ResultSalvaIntestazione,'');
end;

procedure TWA130FOraLegaleSolare.ResultSalvaIntestazione(Sender: TObject;Res: TmeIWModalResult; KeyID: String);
var Intestazione:Boolean;
begin
  Intestazione:=False;
  if Res = mrYes then
    Intestazione:=True;
  //Viene richiamata la funzione InviaFileGenerato perchè in questo caso, avendo un WebMessageDlg a monte,
  //è necessario eliminare nuovamente IWLoker e sbloccare quindi la videata.
  StreamGenerato:=A130MW.CreaTestoFile(Intestazione);
  NomeFileGenerato:='Estrazione.txt';
  InviaFileGenerato;
end;

procedure TWA130FOraLegaleSolare.btnVisualizzaClick(Sender: TObject);
begin
  if rgpPresMens.ItemIndex = 0 then
    visualizza(A130MW.selT100)
  else
    visualizza(A130MW.selT370);
end;

procedure TWA130FOraLegaleSolare.ckOrologiResult(Sender: TObject; Result: Boolean);
begin
  if Result then
    edtOrologi.Text:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA130FOraLegaleSolare.grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True);
end;

procedure TWA130FOraLegaleSolare.Visualizza(dtsTimb:TOracleDataSet);
begin
  if (edtDaData.Text <> '') and (edtAData.Text <> '') and (edtDaOre.Text <> '') and (edtAOre.Text <> '') then
  begin
    SettaVariabiliMW;
    A130MW.dtsTimb:=dtsTimb;
    A130MW.dtsTimb.ClearVariables;
    grdC700.WC700FM.C700MergeSelAnagrafe(A130MW.dtsTimb,False);
    grdC700.WC700FM.C700MergeSettaPeriodo(A130MW.dtsTimb,StrToDate(edtDaData.Text),StrToDate(edtAData.Text));
    A130MW.SelezionaTimbrature;
    if A130MW.dtsTimb.RecordCount > 0 then
    begin
      btnModifica.Enabled:=True and (not SolaLettura);
      btnSalvaSuFile.Enabled:=True;
    end;
    grdRisultati.medpAttivaGrid(dtsTimb,False,False,False);
  end;
end;

procedure TWA130FOraLegaleSolare.SettaVariabiliMW;
begin
  with A130MW do
  begin
    DataDa:=StrToDate(edtDaData.Text);
    DataA:=StrToDate(edtAData.Text);
    OraDa:=edtDaOre.Text;
    OraA:=edtAOre.Text;
    OrologiTimbratura:=edtOrologi.Text;
    IndiceTimbratura:=rgpPresMens.ItemIndex;
    IndiceOra:=rgpLegSol.ItemIndex;
  end;
end;

procedure TWA130FOraLegaleSolare.WC700AperturaSelezione(Sender: TObject);
var
  D: TDateTime;
begin
  inherited;
  if TryStrToDate(edtDaData.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtAData.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

end.
