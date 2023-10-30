unit WA115UIterAutorizzativiSelI96DetailFM;

interface

uses
  Data.DB,
  System.Actions,
  System.Classes,
  System.StrUtils,
  System.SysUtils,
  System.Variants,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Winapi.Messages,
  Winapi.Windows,
  A000UCostanti,
  A000UInterfaccia,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  IWBaseContainerLayout,
  IWBaseControl,
  IWBaseHTMLControl,
  IWBaseLayoutComponent,
  IWCompGrids,
  IWCompJQueryWidget,
  IWContainer,
  IWContainerLayout,
  IWControl,
  IWDBGrids,
  IWHTML40Container,
  IWHTMLContainer,
  IWRegion,
  IWTemplateProcessorHTML,
  IWVCLBaseContainer,
  IWVCLBaseControl,
  IWVCLComponent,
  WR100UBase,
  WR203UGestDetailFM,
  meIWGrid,
  meIWLabel,
  medpIWDBGrid,
  medpIWMessageDlg,
  medpIWMultiColumnComboBox;

type
  TWA115FIterAutorizzativiSelI96DetailFM = class(TWR203FGestDetailFM)
    Scriptdidefault1: TMenuItem;
    N1: TMenuItem;
    procedure actImpostaScriptDefaultExecute(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure ResultEvtScript(Sender: TObject; R: TmeIWModalResult; PChiave: String);
    procedure RicaricaTabella(DataSet: TDataSet);
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

const
  NOME_DETAIL: String = 'Livelli';
  CAMPI_COMBO: TArray<String> = ['LIVELLO','OBBLIGATORIO','AVVISO','DATI_MODIFICABILI','INVIO_EMAIL','ALLEGATI_OBBLIGATORI','ALLEGATI_VISIBILI'];
  CAMPI_DI_TESTO: TArray<String> = ['CONDIZ_AUTORIZZ_AUTOMATICA','SCRIPT_AUTORIZZ'];

implementation

{$R *.dfm}

uses
  WA115UIterAutorizzativi,
  WA115UIterAutorizzativiDM;

{ Pop-up custom }

procedure TWA115FIterAutorizzativiSelI96DetailFM.actImpostaScriptDefaultExecute(Sender: TObject);
var
  OldReadOnly: Boolean;
begin
  inherited;
  with (WR302DM as TWA115FIterAutorizzativiDM) do
  begin
    if (Self.Owner as TWR100FBase).SolaLettura then
    begin
      Exit;
    end;

    if selTabella.FieldByName('ITER').AsString <> ITER_SCIOPERI then
    begin
      MsgBox.MessageBox('Operazione non prevista per questo iter',INFORMA);
      Exit;
    end;

    if not MsgBox.KeyExists('CTRL_SCRIPT') then
    begin
      // se è già presente uno script personalizzato chiede conferma
      if (not selI096.FieldByName('SCRIPT_AUTORIZZ').IsNull) and
         (selI096.FieldByName('SCRIPT_AUTORIZZ').AsString.Trim <> ITER_SCIOPERI_DEFAULT_SCRIPT) then
      begin
        MsgBox.WebMessageDlg('Per questo livello è già impostato uno script di autorizzazione.'#13#10 +
                             'Si desidera sovrascrivere con lo script di default?',
                             mtConfirmation,[mbYes,mbNo],ResultEvtScript,'CTRL_SCRIPT');
        Exit;
      end;
    end;

    // imposta lo script di default
    OldReadOnly:=selI096.ReadOnly;
    if selI096.ReadOnly then
      selI096.ReadOnly:=False;
    selI096.Edit;
    selI096.FieldByName('SCRIPT_AUTORIZZ').AsString:=ITER_SCIOPERI_DEFAULT_SCRIPT;
    selI096.Post;
    selI096.ReadOnly:=OldReadOnly;

    // aggiorna grid
    grdTabella.medpCaricaCDS;
  end;
end;

procedure TWA115FIterAutorizzativiSelI96DetailFM.ResultEvtScript(Sender: TObject; R: TmeIWModalResult; PChiave: String);
begin
  if R = mrYes then
    actImpostaScriptDefaultExecute(Sender);
  MsgBox.ClearKeys;
end;

procedure TWA115FIterAutorizzativiSelI96DetailFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
var
  i:Integer;
begin
  inherited;
  grdTabella.medpPaginazione:=False;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.Summary:=NOME_DETAIL;
  grdTabella.Caption:=NOME_DETAIL;

  DataSet.AfterOpen:=RicaricaTabella;

  grdTabella.medpPreparaComponentiDefault;

  for i:=Low(CAMPI_COMBO) to High(CAMPI_COMBO) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_COMBO[i]).ReadOnly then
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna(CAMPI_COMBO[i]),0,DBG_MECMB,'1','1','null',IfThen(CAMPI_COMBO[i] = 'INVIO_EMAIL', 'N=disattivo, R=solo verso richiedente, A=solo verso autorizzatore, E=verso richiedente e autorizzatore', ''),IfThen(CAMPI_COMBO[i] = 'LIVELLO', '1', 'S'));
  end;

  for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_COMBO[i]).ReadOnly then
    begin
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_DI_TESTO[i],0,DBG_LBL,'50','','null','','S');
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_DI_TESTO[i],1,DBG_IMG,'','PUNTINI','','','D');
    end;
  end;

  grdTabella.medpCaricaCDS;
end;

procedure TWA115FIterAutorizzativiSelI96DetailFM.RicaricaTabella(DataSet: TDataSet);
begin
  grdTabella.medpCaricaCDS; // Forzo il repaint della tabella dopo che la selI095 modifica il dataset
end;

procedure TWA115FIterAutorizzativiSelI96DetailFM.grdTabellaComponenti2DataSet(Row: Integer);
var
  i:Integer;
begin
  inherited;
  with TWA115FIterAutorizzativiDM(WR302DM).selI096 do
  begin
    for i:=Low(CAMPI_COMBO) to High(CAMPI_COMBO) do
    begin
      if (grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) <> nil) and (not grdTabella.medpDataSet.FieldByName(CAMPI_COMBO[i]).ReadOnly) then
        FieldByName(CAMPI_COMBO[i]).AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(CAMPI_COMBO[i]),0) as TMedpIWMultiColumnComboBox).Text;
    end;
    for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
    begin
      if grdTabella.medpCompCella(Row,CAMPI_DI_TESTO[i],0) <> nil then
        FieldByName(CAMPI_DI_TESTO[i]).AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(CAMPI_DI_TESTO[i]),0) as TmeIWLabel).Text);
    end;
  end;
end;

procedure TWA115FIterAutorizzativiSelI96DetailFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  c, i:Integer;
begin
  inherited;

  for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
  begin
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(CAMPI_DI_TESTO[i]),0) <> nil then
      TWA115FIterAutorizzativi(Self.Owner).CreaBtnTesto(grdTabella, TWA115FIterAutorizzativiDM(WR302DM).selI096, CAMPI_DI_TESTO[i],Row);
  end;

  for i:=Low(CAMPI_COMBO) to High(CAMPI_COMBO) do
  begin
    if (grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) is TMedpIWMultiColumnComboBox) and
      ((grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) as TMedpIWMultiColumnComboBox) <> nil) then
    begin
      with (grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) as TMedpIWMultiColumnComboBox) do
      begin
        if CAMPI_COMBO[i] = 'LIVELLO' then
        begin // 1 .. 9
          c:=1;
          while c < 10 do
          begin
            AddRow(IntToStr(c));
            Inc(c);
          end;
        end
        else if CAMPI_COMBO[i] = 'INVIO_EMAIL' then
        begin
          ColumnSeparator:=';';
          ColCount:=1;
          Items.Clear;
          AddRow('N');
          AddRow('A');
          AddRow('R');
          AddRow('E');
        end
        else
        begin // obbligatorio: combobox con valori [S | N]
          ColumnSeparator:=';';
          ColCount:=1;
          Items.Clear;
          AddRow('S');
          AddRow('N');
        end;
        Text:=grdTabella.medpValoreColonna(Row,CAMPI_COMBO[i]);
      end;
    end;
  end;
end;

end.
