unit WP686UCalcoloFondi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids,
  meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, WP686UCalcoloFondiDM,
  IWCompLabel, meIWLabel, Vcl.Menus, IWTMSCheckList, meTIWCheckListBox,
  meIWRadioGroup, meIWImageFile, medpIWImageButton, medpIWMessageDlg,
  A000UMessaggi, C180FunzioniGenerali, A000UInterfaccia, IWApplication;

type
  TWP686FCalcoloFondi = class(TWR100FBase)
    lblDecorrenzaDa: TmeIWLabel;
    lblDecorrenzaA: TmeIWLabel;
    edtDecorrenzaDa: TmeIWEdit;
    edtDecorrenzaA: TmeIWEdit;
    lblFondi: TmeIWLabel;
    lblDataMonit: TmeIWLabel;
    edtDataMonit: TmeIWEdit;
    lblStatoCedolini: TmeIWLabel;
    rgpStatoCedolini: TmeIWRadioGroup;
    lblModalitaCalcolo: TmeIWLabel;
    rgpModalitaCalcolo: TmeIWRadioGroup;
    btnEsegui: TmedpIWImageButton;
    clbFondi: TmeTIWCheckListBox;
    btnDate: TmeIWButton;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtDecorrenzaDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDecorrenzaAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnDateClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
  private
    { Private declarations }
    WP686FCalcoloFondiDM: TWP686FCalcoloFondiDM;
    ProgrFondo:Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ImpostaParametriElaborazione;
    procedure LanciaElaborazione;
    procedure AggiornaListaFondi;
    procedure ForzaSubmit();
  protected
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    function ElaborazioneTerminata:String; override;
  public
    { Public declarations }
    procedure evtRichiesta(Msg,Chiave:String);
  end;

implementation

{$R *.dfm}

procedure TWP686FCalcoloFondi.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  WP686FCalcoloFondiDM:=TWP686FCalcoloFondiDM.Create(Self);
  GetParametriFunzione;
  edtDataMonit.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  AggiornaListaFondi;
end;

procedure TWP686FCalcoloFondi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WP686FCalcoloFondiDM);
  inherited;
end;

procedure TWP686FCalcoloFondi.GetParametriFunzione;
begin
  edtDecorrenzaDa.Text:=C004DM.GetParametro('edtDecorrenzaDa','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004DM.GetParametro('edtDecorrenzaA','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TWP686FCalcoloFondi.PutParametriFunzione;
var Data: TDateTime;
begin
  C004DM.Cancella001;
  if TryStrToDate(edtDecorrenzaDa.Text,Data) then
    C004DM.PutParametro('edtDecorrenzaDa',edtDecorrenzaDa.Text);
  if TryStrToDate(edtDecorrenzaA.Text,Data) then
    C004DM.PutParametro('edtDecorrenzaA',edtDecorrenzaA.Text);

  try SessioneOracle.Commit; except end;
end;

procedure TWP686FCalcoloFondi.edtDecorrenzaDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  ForzaSubmit;
end;

procedure TWP686FCalcoloFondi.edtDecorrenzaAAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  ForzaSubmit;
end;

procedure TWP686FCalcoloFondi.btnDateClick(Sender: TObject);
begin
  AggiornaListaFondi;
end;

procedure TWP686FCalcoloFondi.btnEseguiClick(Sender: TObject);
begin
  ImpostaParametriElaborazione;
  WP686FCalcoloFondiDM.P686FCalcoloFondiMW.Inizializzazioni;
  WP686FCalcoloFondiDM.P686FCalcoloFondiMW.Controlli;
end;

procedure TWP686FCalcoloFondi.evtRichiesta(Msg,Chiave:String);
begin
  MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultRichiesta,Chiave);
  Abort;
end;

procedure TWP686FCalcoloFondi.ResultRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    LanciaElaborazione
  else
    MsgBox.ClearKeys;
end;

procedure TWP686FCalcoloFondi.ImpostaParametriElaborazione;
var i:Integer;
begin
  with WP686FCalcoloFondiDM.P686FCalcoloFondiMW.ParametriElaborazione do
  begin
    dDecorrenzaDa:=StrToDate(edtDecorrenzaDa.Text);
    dDecorrenzaA:=StrToDate(edtDecorrenzaA.Text);
    dDataMonit:=StrToDate(edtDataMonit.Text);
    iModalitaCalcolo:=rgpModalitaCalcolo.ItemIndex;
    iStatoCedolini:=rgpStatoCedolini.ItemIndex;
    lstFondi.Clear;
    for i:=0 to clbFondi.Items.Count - 1 do
      if clbFondi.Selected[i] then
        lstFondi.Add(Trim(Copy(clbFondi.Items[i],1,Pos('-',clbFondi.Items[i])-1)));
  end;
end;

procedure TWP686FCalcoloFondi.LanciaElaborazione;
begin
  WP686FCalcoloFondiDM.P686FCalcoloFondiMW.MsgErrore:='';
  ProgrFondo:=0;
  StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

function TWP686FCalcoloFondi.CurrentRecordElaborazione: Integer;
begin
  Result:=ProgrFondo + 1;
end;

function TWP686FCalcoloFondi.TotalRecordsElaborazione: Integer;
begin
  Result:= WP686FCalcoloFondiDM.P686FCalcoloFondiMW.ParametriElaborazione.lstFondi.Count;
end;

procedure TWP686FCalcoloFondi.ElaboraElemento;
begin
  inherited;
  with WP686FCalcoloFondiDM.P686FCalcoloFondiMW do
    try
      ElaboraFondo(ParametriElaborazione.lstFondi.Strings[ProgrFondo]);
    except
      on E:exception do
      begin
        SessioneOracle.Rollback;
        MsgErrore:='Elaborazione fallita:' + E.Message;
        raise exception.Create(MsgErrore);
      end;
    end;
end;

function TWP686FCalcoloFondi.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  if ProgrFondo < WP686FCalcoloFondiDM.P686FCalcoloFondiMW.ParametriElaborazione.lstFondi.Count - 1 then
  begin
    inc(ProgrFondo);
    Result:=True;
  end;
end;

function TWP686FCalcoloFondi.ElaborazioneTerminata: String;
begin
  Result:=A000MSG_MSG_ELAB_TERMINATA_OK;
end;

procedure TWP686FCalcoloFondi.AggiornaListaFondi;
begin
  with WP686FCalcoloFondiDM.P686FCalcoloFondiMW do
  begin
    if LetturaFondi(edtDecorrenzaDa.Text,edtDecorrenzaA.Text) then
    begin
      clbFondi.Items.Clear;
      while not selP684.Eof do
      begin
        clbFondi.Items.Add(selP684.FieldByName('COD_FONDO').AsString + ' - ' +
          selP684.FieldByName('DESCRIZIONE').AsString);
        clbFondi.Selected[clbFondi.Items.Count - 1]:=False;
        selP684.Next;
      end;
    end;
  end;
end;

procedure TWP686FCalcoloFondi.ForzaSubmit();
begin
  //Forzo un submit che richiama il click di un pulsante nascosto, così la maschera si riaggiorna
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnDate.HTMLName]));
end;

procedure TWP686FCalcoloFondi.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbFondi.Items.Count - 1 do
    clbFondi.Selected[i]:=True;
  clbFondi.AsyncUpdate;
end;

procedure TWP686FCalcoloFondi.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbFondi.Items.Count - 1 do
    clbFondi.Selected[i]:=False;
  clbFondi.AsyncUpdate;
end;

procedure TWP686FCalcoloFondi.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbFondi.Items.Count - 1 do
    clbFondi.Selected[i]:=not clbFondi.Selected[i];
  clbFondi.AsyncUpdate;
end;

end.
