unit WP651URelazioniTabelle;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, A000UMessaggi, A000UCostanti, A000USessione, A000UInterfaccia,
  IWCompEdit, meIWEdit, StrUtils, Math, IWCompMemo, meIWMemo, IWCompListbox,
  meIWComboBox;

type
  TWP651FRelazioniTabelle = class(TWR102FGestTabella)
    memoControlli: TmeIWMemo;
    cmbTipologia: TmeIWComboBox;
    lblTipologia: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbTipologiaChange(Sender: TObject);
  private
    { Private declarations }
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  public
    { Public declarations }
    NomeFlusso: String;
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses WP651URelazioniTabelleBrowseFM, WP651URelazioniTabelleDM, WP651URelazioniTabelleDettFM;

procedure TWP651FRelazioniTabelle.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
end;

function TWP651FRelazioniTabelle.InizializzaAccesso: Boolean;
begin
  if not A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,nil) then
    raise Exception.Create(A000MSG_P651_ERR_NO_CDC);
  WR302DM:=TWP651FRelazioniTabelleDM.Create(Self);
  with (WR302DM as TWP651FRelazioniTabelleDM) do
  begin
    P651FRelazioniTabelleMW.TipoFlusso:=GetParam('TIPOFLUSSO');
    P651FRelazioniTabelleMW.NomeFlusso:=GetParam('FLUSSO');
    if P651FRelazioniTabelleMW.TipoFlusso = '' then
      P651FRelazioniTabelleMW.TipoFlusso:='FL'; //per test
    //impostazioni in base al TipoFlusso
    if P651FRelazioniTabelleMW.TipoFlusso = 'FL' then
      if InterfacciaWR102.LChiavePrimaria.IndexOf('COD_DATO2') >= 0 then
        InterfacciaWR102.LChiavePrimaria.Delete(InterfacciaWR102.LChiavePrimaria.IndexOf('COD_DATO2'));
    InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=P651FRelazioniTabelleMW.TipoFlusso <> 'FL';

    SetTag(IfThen(P651FRelazioniTabelleMW.TipoFlusso = 'FL',299,647));
    Self.HelpKeyword:=Format('%sP%s',[medpCodiceForm,IfThen(P651FRelazioniTabelleMW.TipoFlusso = 'FL','0','1')]);
    Self.Title:='(WP651) Relazioni tabelle ' + IfThen(P651FRelazioniTabelleMW.TipoFlusso = 'FL','FLUPER','conto annuale');
    MemoControlli.Visible:=P651FRelazioniTabelleMW.TipoFlusso <> 'FL';

    //ricerca del NomeFlusso e impostazione griglia
    P651FRelazioniTabelleMW.Inizio;
    cmbTipologia.Items.Clear;
    with P651FRelazioniTabelleMW.selFlussi do
      while not Eof do
      begin
        cmbTipologia.Items.Add(FieldByName('NOME_FLUSSO').AsString);
        Next;
      end;
    cmbTipologia.ItemIndex:=cmbTipologia.Items.IndexOf(P651FRelazioniTabelleMW.NomeFlusso);
    selTabella.FieldByName('COD_DATO1').DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C13_CdcPercentualizzati,1,1)) +
                                                                  LowerCase(Copy(Parametri.CampiRiferimento.C13_CdcPercentualizzati,2,length(Parametri.CampiRiferimento.C13_CdcPercentualizzati)));
    selTabella.FieldByName('COD_DATO2').DisplayLabel:=UpperCase(Copy(P651FRelazioniTabelleMW.NomeDato,1,1)) + LowerCase(Copy(P651FRelazioniTabelleMW.NomeDato,2));
  end;
  WBrowseFM:=TWP651FRelazioniTabelleBrowseFM.Create(Self);
  WBrowseFM.grdTabella.Summary:='Relazioni tabelle ' + IfThen((WR302DM as TWP651FRelazioniTabelleDM).P651FRelazioniTabelleMW.TipoFlusso = 'FL','FLUPER','conto annuale');
  WDettaglioFM:=TWP651FRelazioniTabelleDettFM.Create(Self);
  (WDettaglioFM as TWP651FRelazioniTabelleDettFM).lblDato1.Caption:=(WR302DM as TWP651FRelazioniTabelleDM).selTabella.FieldByName('COD_DATO1').DisplayLabel;
  (WDettaglioFM as TWP651FRelazioniTabelleDettFM).lblDato2.Caption:=(WR302DM as TWP651FRelazioniTabelleDM).selTabella.FieldByName('COD_DATO2').DisplayLabel;
  (WDettaglioFM as TWP651FRelazioniTabelleDettFM).lblPercentuale.Visible:=(WR302DM as TWP651FRelazioniTabelleDM).selTabella.FieldByName('PERCENTUALE').Visible;
  (WDettaglioFM as TWP651FRelazioniTabelleDettFM).dedtPercentuale.Visible:=(WR302DM as TWP651FRelazioniTabelleDM).selTabella.FieldByName('PERCENTUALE').Visible;
  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
  AggiornaToolBarStorico(False, False, False, False, False, False);
  (WR302DM as TWP651FRelazioniTabelleDM).Controlli;
  Result:=True;
end;

procedure TWP651FRelazioniTabelle.cmbTipologiaChange(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWP651FRelazioniTabelleDM) do
  begin
    P651FRelazioniTabelleMW.NomeFlusso:=cmbTipologia.Text;
    P651FRelazioniTabelleMW.Inizio;
    selTabella.FieldByName('COD_DATO2').DisplayLabel:=UpperCase(Copy(P651FRelazioniTabelleMW.NomeDato,1,1)) + LowerCase(Copy(P651FRelazioniTabelleMW.NomeDato,2));
    WBrowseFM.grdTabella.medpCreaColonne;
    (WDettaglioFM as TWP651FRelazioniTabelleDettFM).lblDato2.Caption:=(WR302DM as TWP651FRelazioniTabelleDM).selTabella.FieldByName('COD_DATO2').DisplayLabel;
    Controlli;
  end;
end;

procedure TWP651FRelazioniTabelle.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  if MemoControlli.Text <> '' then
    Conferma:=A000MSG_P651_DLG_EXIT_ANOMALIE;
end;

end.
