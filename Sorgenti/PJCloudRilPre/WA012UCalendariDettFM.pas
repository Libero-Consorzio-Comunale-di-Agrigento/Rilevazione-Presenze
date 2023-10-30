unit WA012UCalendariDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, meIWLabel,
  IWCompCheckbox, meIWDBCheckBox, Db,
  meIWEdit, IWDBGrids, medpIWDBGrid,
  WA012UVisualizzaCalendarioFM, medpIWMessageDlg, IWCompExtCtrls, IWCompGrids,
  IWCompJQueryWidget, meIWImageFile, A000UInterfaccia, A000UMessaggi,
  IWHTMLControls, meIWLink, medpIWImageButton;

type
  TWA012FCalendariDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    grdFestivita: TmedpIWDBGrid;
    lblFestivitaAggiuntive: TmeIWLabel;
    lblGiorniLavorativi: TmeIWLabel;
    dchkLunedi: TmeIWDBCheckBox;
    dchkMartedi: TmeIWDBCheckBox;
    dchkMercoledi: TmeIWDBCheckBox;
    dchkGiovedi: TmeIWDBCheckBox;
    dchkVenerdi: TmeIWDBCheckBox;
    dchkSabato: TmeIWDBCheckBox;
    dchkDomenica: TmeIWDBCheckBox;
    lblGenerazioneCalendari: TmeIWLabel;
    lblDa: TmeIWLabel;
    lblA: TmeIWLabel;
    edtDa: TmeIWEdit;
    edtA: TmeIWEdit;
    lblnumglav: TmeIWLabel;
    dedtNGGLav: TmeIWDBEdit;
    dchkIgnoraFestivita: TmeIWDBCheckBox;
    imbGeneraCalendario: TmedpIWImageButton;
    imbVisualizzaCalendario: TmedpIWImageButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdFestivitaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure imgVisualizzaCalendarioClick(Sender: TObject);
    procedure imgGeneraCalendarioClick(Sender: TObject);
  private
    WA012Visualizza:TWA012FVisualizzaCalendarioFM;
  public
    { Public declarations }
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
  end;

implementation

uses WA012UCalendariDM, WA012UCalendari, WR100UBase;

{$R *.dfm}

procedure TWA012FCalendariDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdFestivita.medpAttivaGrid(TWA012FCalendariDM(TWA012FCalendari(Self.Parent).WR302DM).selT013, False);
end;

procedure TWA012FCalendariDettFM.AbilitaComponenti;
begin
  with TWA012FCalendariDM(WR302DM) do
  begin
    grdFestivita.medpAttivaGrid(selT013,(selTabella.State in [dsInsert,dsEdit]));
    //Caratto 14/6/2012 disabilito generazione calendario in modifica. come in Iriswin
    imbGeneraCalendario.Enabled:=selTabella.State = dsBrowse;
    imbVisualizzaCalendario.Enabled:=True;
    edtDa.ReadOnly:=False;
    edtA.ReadOnly:=False;
    (*if (imbGeneraCalendario.Enabled) then
      imbGeneraCalendario.ImageFile.Filename:='img\btnGeneraCalendario.png'
    else
      imbGeneraCalendario.ImageFile.Filename:='img\btnGeneraCalendario_Disabled.png';

    imbGeneraCalendario.Enabled:=true;
    *)
  end;
end;

procedure TWA012FCalendariDettFM.DataSet2Componenti;
begin
  with TWA012FCalendariDM(WR302DM) do
  begin
    if not selT013.UpdatesPending then
    begin
      selT013.Close;
      selT013.SetVariable('CODICE',selTabella.FieldBYName('CODICE').AsString);
      selT013.Open;
    end;
    if grdFestivita.medpDataSet <> nil then
      grdFestivita.medpCaricaCDS;
  end;
end;

procedure TWA012FCalendariDettFM.imgGeneraCalendarioClick(Sender: TObject);
var DaGiorno,AGiorno:TDateTime;
begin
  if not TryStrToDate(edtDa.Text,DaGiorno) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Da']),mtError,[mbOk],nil,'');
    exit;
  end;
  if not TryStrToDate(edtA.Text,AGiorno) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['A']),mtError,[mbOk],nil,'');
    exit;
  end;
  if DaGiorno > AGiorno then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_PERIODO_NON_CORRETTO,['Da Data - A Data']),mtError,[mbOk],nil,'');
    exit;
  end;
  TWA012FCalendariDM(TWA012FCalendari(Self.Parent).WR302DM).GeneraCalendario(DaGiorno,AGiorno);
end;

procedure TWA012FCalendariDettFM.imgVisualizzaCalendarioClick(Sender: TObject);
var Anno,Mese,Giorno,AnnoL,MeseL,GiornoL,DiffAnni:Word;
    Range:boolean;
    DaGiorno,AGiorno:TDateTime;
begin
  with TWA012FCalendariDM(TWA012FCalendari(Self.Parent).WR302DM) do
  begin
    Range:=True;
    {Controllo se e' impostato un range valido}
    if not TryStrToDate(edtDa.Text,DaGiorno) then
    begin
      DaGiorno:=EncodeDate(1900,1,1);
      Range:=False;
    end;

    if not TryStrToDate(edtA.Text,AGiorno) then
    begin
      AGiorno:=EncodeDate(3999,12,31);
      Range:=False;
    end;

    if (Range) and (DaGiorno > AGiorno) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_PERIODO_NON_CORRETTO,['Da Data - A Data']),mtError,[mbOK],nil,'');
      Exit;
    end;

    Q011.Close;
    Q011.SetVariable('Codice',selTabella.FieldByName('Codice').AsString);
    Q011.SetVariable('Dal',DaGiorno);
    Q011.SetVariable('Al',AGiorno);
    Q011.Open;

    if Q011.RecordCount = 0 then
    begin
      MsgBox.WebMessageDlg(A000MSG_A012_ERR_NO_PERIODO,mtInformation,[mbOK],nil,'');
      exit;
    end;
    {Se le date sono errate parto dal primo record del calendario}
    Q011.First;
    DecodeDate(Q011['Data'],Anno,Mese,Giorno);
    Q011.Last;
    DecodeDate(Q011['Data'],AnnoL,MeseL,GiornoL);

    WA012Visualizza:=TWA012FVisualizzaCalendarioFM.CReate(Self.Parent);

    DiffAnni:=AnnoL-Anno;
    if DiffAnni = 0 then
      WA012Visualizza.NumMesi:=MeseL-Mese+1
    else
      WA012Visualizza.NumMesi:=12*(DiffAnni - 1) + MeseL + 13-Mese;
    WA012Visualizza.Anno:=Anno;
    WA012Visualizza.Mese:=Mese;
    WA012Visualizza.Visualizza(selTabellaDescrizione.AsString);
  end;
end;

procedure TWA012FCalendariDettFM.grdFestivitaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdFestivita.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdFestivita.medpCompGriglia) + 1) and (grdFestivita.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdFestivita.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

end.
