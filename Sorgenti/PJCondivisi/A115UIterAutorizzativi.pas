unit A115UIterAutorizzativi;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  System.StrUtils,
  Vcl.ImgList,
  Data.DB,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Oracle,
  OracleData,
  OracleMonitor,
  R001UGESTTAB,
  C012UVisualizzaTesto,
  C180FunzioniGenerali,
  A115UIterCondizValidita,
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  A000UMessaggi,
  ToolbarFiglio;

type
  TA115FIterAutorizzativi = class(TR001FGestTab)
    Splitter1:TSplitter;
    Splitter2:TSplitter;
    DgrdselI096:TDBGrid;
    Panel5:TPanel;
    DgrdselI095:TDBGrid;
    DgrdselI093:TDBGrid;
    pmnLivelli: TPopupMenu;
    mnuImpostaScriptDefault: TMenuItem;
    actImpostaScriptDefault: TAction;
    frmToolbarSelI096: TfrmToolbarFiglio;
    Panel2: TPanel;
    Panel3: TPanel;
    frmToolbarSelI095: TfrmToolbarFiglio;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dgrdselI095EditButtonClick(Sender: TObject);
    procedure dgrdselI093EditButtonClick(Sender: TObject);
    procedure dgrdselI096ColEnter(Sender: TObject);
    procedure dgrdselI096EditButtonClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure actImpostaScriptDefaultExecute(Sender: TObject);
    procedure pmnLivelliPopup(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
  private

  public
    procedure EditaCampoMemo(var InDBGrid:TDBGrid;NomeCampo:String);
  end;

var
  A115FIterAutorizzativi:TA115FIterAutorizzativi;

procedure OpenA115IterAutorizzativi(Azienda:String = '');

implementation

{$R *.dfm}

uses A115UIterAutorizzativiDM;

procedure OpenA115IterAutorizzativi(Azienda:String = '');
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA115IterAutorizzativi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA115FIterAutorizzativi,A115FIterAutorizzativi);
  Application.CreateForm(TA115FIterAutorizzativiDM,A115FIterAutorizzativiDM);
  if Azienda = '' then
    Azienda:=Parametri.Azienda;
  try
    A115FIterAutorizzativiDM.InizializzaDataModulo(Azienda);
    A115FIterAutorizzativi.ShowModal;
  finally
    Screen.Cursor:=crDefault;
    SolaLettura:=SolaLetturaOriginale;
    A115FIterAutorizzativi.Free;
    A115FIterAutorizzativiDM.Free;
  end;
end;

{ Finestra }
procedure TA115FIterAutorizzativi.FormActivate(Sender: TObject);
begin
  Caption:=Caption + IfThen(SolaLettura, ' (Sola lettura)');
  Panel5.Caption:=Format(Panel5.Caption, [A115FIterAutorizzativiDM.A115MW.AziendaCorrente]);
  DButton.DataSet:=A115FIterAutorizzativiDM.selI093;
  inherited;
end;

procedure TA115FIterAutorizzativi.FormShow(Sender: TObject);
begin

  with A115FIterAutorizzativiDM do
  begin

    { Toolbar sel95 }

    frmToolbarSelI095.TFDButton:=dsrI095;
    frmToolbarSelI095.TFDBGrid:=dgrdselI095;
    frmToolbarSelI095.TFReadOnly:=SolaLettura;
    frmToolbarSelI095.TFSolaLettura:=SolaLettura;
    frmToolbarSelI095.TlbarFiglio.HandleNeeded;
    dsrI095.OnStateChange:=frmToolbarSelI095.DButtonStateChange;
    frmToolbarSelI095.AbilitaAzioniTF(nil);

    { Toolbar sel96 }

    frmToolbarSelI096.TFDButton:=dsrI096;
    frmToolbarSelI096.TFDBGrid:=dgrdselI096;
    frmToolbarSelI096.TFReadOnly:=SolaLettura;
    frmToolbarSelI096.TFSolaLettura:=SolaLettura;
    frmToolbarSelI096.TlbarFiglio.HandleNeeded;
    dsrI096.OnStateChange:=frmToolbarSelI096.DButtonStateChange;
    frmToolbarSelI096.AbilitaAzioniTF(nil);

  end;
end;

procedure TA115FIterAutorizzativi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  actCancella.Enabled:=False;
  TCanc.Enabled:=False;
  actInserisci.Enabled:=False;
  TInser.Enabled:=False;
end;

{ Bottoni e azioni }

procedure TA115FIterAutorizzativi.dgrdselI093EditButtonClick(Sender: TObject);
begin
  inherited;
  with A115FIterAutorizzativiDM do
  begin
    if dgrdselI093.SelectedField <> nil then
    begin
      if dgrdselI093.SelectedField.FieldName = 'C_CHKDATI_ITER_AUT' then
      begin
        A115FIterCondizValidita:=TA115FIterCondizValidita.Create(Self);

        A115FIterAutorizzativiDM.A115MW.selI094.ReadOnly:=not (A115FIterAutorizzativiDM.A115MW.selI093.State in [dsInsert,dsEdit]);

        try
          A115FIterCondizValidita.Caption:=dgrdselI093.SelectedField.DisplayLabel;
          A115FIterCondizValidita.dsrGenerale.DataSet:=A115MW.selI094;
          A115FIterCondizValidita.ShowModal;
        finally
          FreeAndNil(A115FIterCondizValidita);
        end;
      end
      else
        EditaCampoMemo(dgrdselI093,dgrdselI093.SelectedField.FieldName);
    end;
  end;
end;

procedure TA115FIterAutorizzativi.dgrdselI095EditButtonClick(Sender: TObject);
begin
  inherited;
  if dgrdselI095.SelectedField <> nil then
  begin
   if dgrdselI095.SelectedField.FieldName = 'C_VALIDITA_ITER_AUT' then
    begin
      A115FIterCondizValidita:=TA115FIterCondizValidita.Create(Self);

      A115FIterAutorizzativiDM.A115MW.selI097.ReadOnly:=not (A115FIterAutorizzativiDM.A115MW.selI095.State in [dsInsert,dsEdit]);

      try
        A115FIterCondizValidita.Caption:=dgrdselI095.SelectedField.DisplayLabel;
        A115FIterCondizValidita.dsrGenerale.DataSet:=A115FIterAutorizzativiDM.A115MW.selI097;
        A115FIterCondizValidita.ShowModal;
      finally
        FreeAndNil(A115FIterCondizValidita);
      end;
    end
    else
      EditaCampoMemo(dgrdselI095,dgrdselI095.SelectedField.FieldName);
  end;
end;

procedure TA115FIterAutorizzativi.dgrdselI096ColEnter(Sender: TObject);
begin
  inherited;
  dgrdselI096.ShowHint:=True;
  if dgrdselI096.SelectedField.FieldName = 'INVIO_EMAIL' then
    dgrdselI096.Hint:='N=disattivo, R=solo verso richiedente, A=solo verso autorizzatore, E=verso richiedente e autorizzatore'
  else
    dgrdselI096.ShowHint:=False;
end;

procedure TA115FIterAutorizzativi.dgrdselI096EditButtonClick(Sender: TObject);
begin
  inherited;
  EditaCampoMemo(dgrdselI096,dgrdselI096.SelectedField.FieldName);
end;

procedure TA115FIterAutorizzativi.actImpostaScriptDefaultExecute(Sender: TObject);
var
  OldReadOnly: Boolean;
begin
  inherited;
  with A115FIterAutorizzativiDM do
  begin
    // se � gi� presente uno script personalizzato chiede conferma
    if (not selI096.FieldByName('SCRIPT_AUTORIZZ').IsNull) and
       (selI096.FieldByName('SCRIPT_AUTORIZZ').AsString.Trim <> ITER_SCIOPERI_DEFAULT_SCRIPT) then
    begin
      if R180MessageBox('Per questo livello � gi� impostato uno script di autorizzazione.'#13#10 +
                        'Si desidera sovrascrivere con lo script di default?',DOMANDA) = mrNo then
        Exit;
    end;

    // imposta lo script di default
    OldReadOnly:=selI096.ReadOnly;
    if selI096.ReadOnly then
      selI096.ReadOnly:=False;
    selI096.Edit;
    selI096.FieldByName('SCRIPT_AUTORIZZ').AsString:=ITER_SCIOPERI_DEFAULT_SCRIPT;
    selI096.Post;
    selI096.ReadOnly:=OldReadOnly;
  end;
end;

procedure TA115FIterAutorizzativi.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT I093.AZIENDA, I093.ITER, I093.REVOCABILE, I093.MAIL_OGGETTO_DIP, I093.MAIL_CORPO_DIP, I093.MAIL_OGGETTO_RESP, ');
  QueryStampa.Add('I093.MAIL_CORPO_RESP, I093.EXPR_PERIODO_VISUAL, I093.MAIL_OGGETTO_OTTIMIZZATA, I093.MAIL_CORPO_OTTIMIZZATA, I093.MSG_NOTIFICA ');
  QueryStampa.Add('FROM MONDOEDP.I093_BASE_ITER_AUT I093 ');
  QueryStampa.Add(Format('WHERE I093.AZIENDA = ''%s'' ', [A115FIterAutorizzativiDM.A115MW.AziendaCorrente]));

  NomiCampiR001.Clear;
  NomiCampiR001.Add('I093.AZIENDA');
  NomiCampiR001.Add('I093.ITER');
  NomiCampiR001.Add('I093.REVOCABILE');
  NomiCampiR001.Add('I093.MAIL_OGGETTO_DIP');
  NomiCampiR001.Add('I093.MAIL_CORPO_DIP');
  NomiCampiR001.Add('I093.MAIL_OGGETTO_RESP');
  NomiCampiR001.Add('I093.MAIL_CORPO_RESP');
  NomiCampiR001.Add('I093.EXPR_PERIODO_VISUAL');
  NomiCampiR001.Add('I093.MAIL_OGGETTO_OTTIMIZZATA');
  NomiCampiR001.Add('I093.MAIL_CORPO_OTTIMIZZATA');
  NomiCampiR001.Add('I093.MSG_NOTIFICA');
  inherited;
end;

{ Pop-up }
procedure TA115FIterAutorizzativi.pmnLivelliPopup(Sender: TObject);
begin
  inherited;
  actImpostaScriptDefault.Visible:=(A115FIterAutorizzativiDM.selI093.FieldByName('ITER').AsString = ITER_SCIOPERI) and
                                   (not SolaLettura);
end;

{ Altro }

procedure TA115FIterAutorizzativi.EditaCampoMemo(var InDBGrid:TDBGrid;NomeCampo:String);
var
  Str:TStringList;
  SolaLettura:Boolean;
  CaptionC012:String;
  BottoniC012:TMsgDlgButtons;
begin
  if InDBGrid.SelectedField.FieldName = NomeCampo then
  begin
    Str:=TStringList.Create;
    try
      SolaLettura:=TOracleDataSet(InDBGrid.DataSource.DataSet).ReadOnly or
                   InDBGrid.SelectedField.ReadOnly; // bugfix
      CaptionC012:=InDBGrid.SelectedField.DisplayLabel;
      BottoniC012:=[mbOK,mbCancel];
      if SolaLettura then
      begin
        CaptionC012:=InDBGrid.SelectedField.DisplayLabel + ' (Sola lettura)';
        BottoniC012:=[mbCancel];
      end;
      Str.Text:=InDBGrid.DataSource.DataSet.FieldByName(NomeCampo).AsString;
      OpenC012VisualizzaTesto(CaptionC012,'',Str,'',BottoniC012);
      if not SolaLettura then
      begin
        InDBGrid.DataSource.DataSet.Edit;
        InDBGrid.DataSource.DataSet.FieldByName(NomeCampo).AsString:=Trim(Str.Text);
        InDBGrid.DataSource.DataSet.Post
      end;
    finally
      FreeAndNil(Str);
    end;
  end;
end;

end.
