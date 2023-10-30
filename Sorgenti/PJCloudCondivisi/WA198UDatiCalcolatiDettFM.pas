unit WA198UDatiCalcolatiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox, IWDBStdCtrls, meIWDBComboBox,
  WR102UGestTabella, WA198UDatiCalcolatiDM, IWCompLabel, meIWLabel, IWCompEdit,
  meIWDBEdit, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWCompMemo,
  meIWDBMemo, meIWListbox, meIWEdit, Data.DB, C180FunzioniGenerali, Vcl.Menus,
  WC010UMemoEditFM;

type
  TWA198FDatiCalcolatiDettFM = class(TWR205FDettTabellaFM)
    dcmbSerbatoi: TmeIWDBComboBox;
    lblSerbatoio: TmeIWLabel;
    dcmbStampa: TmeIWDBComboBox;
    lblStampa: TmeIWLabel;
    dedtNome: TmeIWDBEdit;
    lblNome: TmeIWLabel;
    lblFormato: TmeIWLabel;
    dmemEspressione: TmeIWDBMemo;
    lblEspressione: TmeIWLabel;
    lstDatiDisponibili: TmeIWListbox;
    drgpFormato: TmeIWDBRadioGroup;
    lstFunzioniDisponibili: TmeIWListbox;
    lblDatiDisponibili: TmeIWLabel;
    lblFunzioniDisponibili: TmeIWLabel;
    edtCaretPosition: TmeIWEdit;
    pmnDatiDisponibili: TPopupMenu;
    mnuOrdineAlfabetico: TMenuItem;
    pmnFunzioniDisponibili: TPopupMenu;
    mnuVisualizzaCodice: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dcmbSerbatoiAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure lstDatiDisponibiliDblClick(Sender: TObject);
    procedure lstFunzioniDisponibiliDblClick(Sender: TObject);
    procedure mnuOrdineAlfabeticoClick(Sender: TObject);
    procedure mnuVisualizzaCodiceClick(Sender: TObject);
  private
    procedure caricaLstDatiDisponibili;
    procedure addEspressione(val: String);
  public
    procedure Dataset2Componenti; override;
  end;

implementation

{$R *.dfm}

procedure TWA198FDatiCalcolatiDettFM.Dataset2Componenti;
begin
  inherited;
  caricaLstDatiDisponibili;
end;

procedure TWA198FDatiCalcolatiDettFM.dcmbSerbatoiAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  caricaLstDatiDisponibili;
end;

procedure TWA198FDatiCalcolatiDettFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
  sJs: string;
begin
  //Non usare la variabile WR302DM del frame perchè prima di inherited non ancora valorizzata.
  //Non spostare dopo inherited perchè richiama Dataset2Componenti e deve già essere stata caricata la combo
  with ((Self.Owner as TWR102FGestTabella).WR302DM as TWA198FDatiCalcolatiDM).R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(Serbatoi) do
      dcmbSerbatoi.Items.Add(IntToStr(Serbatoi[i].X) + ' - ' + Serbatoi[i].Nome + '=' + IntToStr(Serbatoi[i].X));
    selT910Codice.Open;
    while not selT910Codice.Eof do
    begin
      dcmbStampa.Items.Add(selT910Codice.FieldByName('CODICE').AsString);
      selT910Codice.Next;
    end;
    selT910Codice.Close;

    //Funzioni disponibili
    lstFunzioniDisponibili.Clear;
    lstFunzioniDisponibili.Items.Assign(lstFunzioniSQL);
    lstFunzioniDisponibili.ItemIndex:=0;
  end;
  inherited;
  sJs:='if ($("#' + dmemEspressione.HTMLName+ '").length > 0) {$("#' + edtCaretPosition.HTMLName + '").val($("#' + dmemEspressione.HTMLName+ '").caret().end + 1);}';
  lstDatiDisponibili.ScriptEvents.HookEvent('OnDblClick', sJs);
  lstFunzioniDisponibili.ScriptEvents.HookEvent('OnDblClick', sJs);
end;

procedure TWA198FDatiCalcolatiDettFM.addEspressione(val:String);
var
  RP,nCRLF: Integer;
  Tmp: String;
begin
  with WR302DM do
  begin
    if selTabella.State in [dsEdit, dsInsert] then
    begin
      RP:=StrToIntDef(edtCaretPosition.Text,0);
      Tmp:=dmemEspressione.Text;
      //devo contare i ritorni a capo perchè contati come 1 carattere ma nella propietà text sono 2 (#13#10)
      nCRLF:=R180NumOccorrenzeString(#13#10,Copy(Tmp,0,RP));
      Insert(val,Tmp,RP + nCRLF);
      selTabella.FieldByName('ESPRESSIONE').AsString:=Tmp;
    end;
  end;
end;

procedure TWA198FDatiCalcolatiDettFM.lstDatiDisponibiliDblClick(
  Sender: TObject);
begin
  addEspressione(Identificatore(lstDatiDisponibili.SelectedValue));
end;

procedure TWA198FDatiCalcolatiDettFM.lstFunzioniDisponibiliDblClick(
  Sender: TObject);
begin
  inherited;
  addEspressione(lstFunzioniDisponibili.SelectedValue);
end;

procedure TWA198FDatiCalcolatiDettFM.mnuOrdineAlfabeticoClick(Sender: TObject);
begin
  inherited;
  mnuOrdineAlfabetico.Checked:=not mnuOrdineAlfabetico.Checked;
  lstDatiDisponibili.Sorted:=mnuOrdineAlfabetico.Checked;
  if not lstDatiDisponibili.Sorted then
    caricaLstDatiDisponibili;
end;

procedure TWA198FDatiCalcolatiDettFM.mnuVisualizzaCodiceClick(Sender: TObject);
var
  WC010FMemoEditFM: TWC010FMemoEditFM;
  lst: TStringList;
begin
  inherited;
  try
    lst:=((Self.Owner as TWR102FGestTabella).WR302DM as TWA198FDatiCalcolatiDM).R003FGeneratoreStampeMW.getCodiceFunzione(lstFunzioniDisponibili.SelectedValue);

    if lst.Count > 0 then
    begin
      WC010FMemoEditFM:=TWC010FMemoEditFM.Create(Self.Parent);
      WC010FMemoEditFM.memValore.Lines.Clear;
      WC010FMemoEditFM.memValore.Lines.Assign(lst);
      WC010FMemoEditFM.Width:=600;
      WC010FMemoEditFM.Height:=350;
      WC010FMemoEditFM.Visualizza('Function ' +  lstFunzioniDisponibili.SelectedValue);
    end;
  finally
    FreeAndNil(lst)
  end;

end;

procedure TWA198FDatiCalcolatiDettFM.caricaLstDatiDisponibili;
var
  P,i: Integer;
  IdSerbatoio: String;
  idxSerbatoio: Integer;
begin
  with ((Self.Owner as TWR102FGestTabella).WR302DM as TWA198FDatiCalcolatiDM) do
  begin
    lstDatiDisponibili.Items.Clear;

    IdSerbatoio:=selTabella.FieldByName('ID_SERBATOIO').AsString;
    if IdSerbatoio = '' then
      Exit;
    idxSerbatoio:=-1;
    for i:=Low(R003FGeneratoreStampeMW.Serbatoi) to High(R003FGeneratoreStampeMW.Serbatoi) do
      if R003FGeneratoreStampeMW.Serbatoi[i].X = StrToInt(IdSerbatoio) then
      begin
        idxSerbatoio:=i;
        break;
      end;

    lstDatiDisponibili.Items.Clear;
    if idxSerbatoio >= 0 then
      lstDatiDisponibili.Items.Assign(R003FGeneratoreStampeMW.Serbatoi[idxSerbatoio].lst);

    for i:=lstDatiDisponibili.Items.Count - 1 downto 0 do
    begin
      //il Middleware non carica i dati calcolati. Lasciato per sicurezza
      P:=R003FGeneratoreStampeMW.GetDato(lstDatiDisponibili.Items[i],False);
      if R003FGeneratoreStampeMW.Dati[P].Calcolato then
        lstDatiDisponibili.Items.Delete(i);
    end;
    lstDatiDisponibili.Sorted:=mnuOrdineAlfabetico.Checked;
    if lstDatiDisponibili.Items.Count > 0 then
      lstDatiDisponibili.ItemIndex:=0;
  end;
end;

end.
