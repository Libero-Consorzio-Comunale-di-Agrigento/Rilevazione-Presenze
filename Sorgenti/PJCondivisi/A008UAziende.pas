unit A008UAziende;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, Grids, DBGrids, checklst, ActnList, ImgList, ToolWin, Variants,
  A000UCostanti, A000UMessaggi, A000USessione, C180FunzioniGenerali, L021Call, C012UVisualizzaTesto,
  Oracle, OracleData, idSMTP, idMessage, System.Actions,
  C013UCheckList, A181UAziendeMW, System.ImageList, System.UITypes;

type
  TA008FAziende = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    dedtLungPassword: TDBEdit;
    dedtValidPassword: TDBEdit;
    Label8: TLabel;
    dedtValidUtente: TDBEdit;
    Label11: TLabel;
    Panel4: TPanel;
    Label13: TLabel;
    dedtPathAllClient: TDBEdit;
    btnPathAllClient: TButton;
    OpenDialog1: TOpenDialog;
    Label14: TLabel;
    dedtDominioDip: TDBEdit;
    Label15: TLabel;
    dedtDominioUsr: TDBEdit;
    dcmbDominioDipTipo: TDBComboBox;
    dcmbDominioUsrTipo: TDBComboBox;
    pnlTopGestModuli: TPanel;
    cmbFiltroGestModuli: TComboBox;
    lblFiltroGestModuli: TLabel;
    dedtValidCifre: TDBEdit;
    lblValidCifre: TLabel;
    dedtValidMaiuscole: TDBEdit;
    lblValidMaiuscole: TLabel;
    lblValidCarattSpeciali: TLabel;
    dedtValidCarattSpeciali: TDBEdit;
    GroupBox2: TGroupBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBCheckBox4: TDBCheckBox;
    lblGruppoBadge: TLabel;
    dedtGruppoBadge: TDBEdit;
    btnTestMail: TSpeedButton;
    grpRicAziendaAuto: TGroupBox;
    dchkLoginUsrAbilitato: TDBCheckBox;
    dchkLoginDipAbilitato: TDBCheckBox;
    tabRegistrazioneLog: TTabSheet;
    GroupBox3: TGroupBox;
    TabelleLog: TCheckListBox;
    DBCheckBox1: TDBCheckBox;
    pmnLogOperazioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    lblDominioLdapDN: TLabel;
    dedtDominioLdapDN: TDBEdit;
    lblSuffissoLDAP: TLabel;
    dedtSuffissoLDAP: TDBEdit;
    procedure btnPathAllClientClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure cmbCodiceIterDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cmbFiltroGestModuliChange(Sender: TObject);
    procedure btnTestMailClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure OnPmnLogOperazioniClick(Sender: TObject);
    procedure dcmbDominioTipoChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
  private
    //procedure PutElenco(S:String);
    function OpenSelezione:string; //Creazione e visualizzazione della maschera A008 o C013
    procedure CaricaCmbFiltroGestModuli;
    procedure AbilitaAzioni;
  public
    procedure EditaCampoMemo(var InDBGrid:TDBGrid;NomeCampo:String);
  end;

var
  A008FAziende: TA008FAziende;

implementation

uses
  A008UOperatoriDtM1, A008UListaGriglia, A000UInterfaccia;

{$R *.DFM}

function TA008FAziende.OpenSelezione:string;
var
  MyC013FCheckList:TC013FCheckList;
begin
  Result:=A008FOperatoriDtM1.A181MW.QI091.FieldByName('DATO').AsString;
  if Not A008FOperatoriDtM1.A181MW.I091DatiEnteItems.MultiSelect then
  begin
    //Gestione selezione singola
    A008FListaGriglia:=TA008FListaGriglia.Create(nil);
    try
      //Set caption della form
      A008FListaGriglia.Caption:=A008FOperatoriDtM1.A181MW.QI091D_Tipo.AsString;;
      //Passo i valori da visualizzare mediante string list
      A008FListaGriglia.Lista.Items:=A008FOperatoriDtM1.A181MW.I091DatiEnteItems.ListaSelezione;
      //posizionamento sul valore corretto
      A008FListaGriglia.Lista.ItemIndex:=A008FListaGriglia.Lista.Items.IndexOf(A008FOperatoriDtM1.A181MW.QI091.FieldByName('DATO').AsString);
      if A008FListaGriglia.ShowModal = mrOk then
      begin
        if A008FListaGriglia.Lista.ItemIndex >= 0 then
        begin
          // selezione singola
          Result:=A008FListaGriglia.Lista.Items[A008FListaGriglia.Lista.ItemIndex];
        end;
      end;
    finally
      FreeAndNil(A008FListaGriglia);
    end;
  end
  else
  begin
    //Gestione selezione multipla
    MyC013FCheckList:=TC013FCheckList.Create(nil);
    try
      //Set caption della form
      MyC013FCheckList.Caption:=A008FOperatoriDtM1.A181MW.QI091D_Tipo.AsString;;
      //Passo i valori da visualizzare mediante string list
      MyC013FCheckList.clbListaDati.Items:=A008FOperatoriDtM1.A181MW.I091DatiEnteItems.ListaSelezione;
      R180PutCheckList(A008FOperatoriDtM1.A181MW.QI091.FieldByName('DATO').AsString,
                       A008FOperatoriDtM1.A181MW.I091DatiEnteItems.DimCodice,
                       MyC013FCheckList.clbListaDati);
      if MyC013FCheckList.ShowModal = mrOK then
      begin
        Result:=R180GetCheckList(A008FOperatoriDtM1.A181MW.I091DatiEnteItems.DimCodice,
                                 MyC013FCheckList.clbListaDati,',');
      end;
    finally
      FreeAndNil(MyC013FCheckList);
    end;
  end;
end;

procedure TA008FAziende.PageControl1Change(Sender: TObject);
begin
  AbilitaAzioni;
end;

procedure TA008FAziende.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=TabSheet1;
  dedtValidCarattSpeciali.Hint:='Caratteri speciali considerati: ' + NEW_SPECIAL_CHAR;
  lblValidCarattSpeciali.Hint:='Caratteri speciali considerati: ' + NEW_SPECIAL_CHAR;
  //tabIterAutorizzativi.TabVisible:=ITER_ATTIVO = 'S';
end;

procedure TA008FAziende.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A008FOperatoriDtM1.QI090;
  inherited;
end;

procedure TA008FAziende.DBGrid1EditButtonClick(Sender: TObject);
var
  S:String;
begin
  if DButton.State <> dsEdit then
    exit;
  if A008FOperatoriDtM1.A181MW.QI091.State = dsEdit then
    A008FOperatoriDtM1.A181MW.QI091.Cancel;

  A008FOperatoriDtM1.A181MW.PutElenco(A008FOperatoriDtM1.A181MW.QI091Tipo.AsString);
  S:=OpenSelezione;
  if not S.IsEmpty then
  begin
    A008FOperatoriDtM1.A181MW.QI091.Edit;
    A008FOperatoriDtM1.A181MW.QI091.FieldByName('DATO').AsString:=S;
    A008FOperatoriDtM1.A181MW.QI091.Post;
  end;
end;

//procedure TA008FAziende.PutElenco(S:String); spostata su middleware 26/05/2017

procedure TA008FAziende.CaricaCmbFiltroGestModuli;
var i:Integer;
begin
  cmbFiltroGestModuli.Items.Clear;
  cmbFiltroGestModuli.Items.Add('');
  for i:=Low(DatiEnte) to High(DatiEnte) do
    if cmbFiltroGestModuli.Items.IndexOf(DatiEnte[i].Gruppo) < 0 then
      cmbFiltroGestModuli.Items.Add(DatiEnte[i].Gruppo);
  if cmbFiltroGestModuli.Items.IndexOf(A008FOperatoriDtM1.A181MW.NON_ASSEGNATO) < 0 then
    cmbFiltroGestModuli.Items.Add(A008FOperatoriDtM1.A181MW.NON_ASSEGNATO);
  cmbFiltroGestModuli.Sorted:=True;
end;

procedure TA008FAziende.AbilitaAzioni;
begin
  actCancella.Enabled:=(DButton.State = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
  TCanc.Enabled:=(DButton.State  = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
  actInserisci.Enabled:=(DButton.State  = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
  TInser.Enabled:=(DButton.State  = dsBrowse) and not(SolaLettura) and (PageControl1.ActivePageIndex = 0);
end;

procedure TA008FAziende.TCancClick(Sender: TObject);
var iAzienda,dsAzienda:String;
begin
  if PageControl1.ActivePageIndex > 0 then
    Exit;
  dsAzienda:=A008FOperatoriDtM1.QI090.FieldByName('AZIENDA').AsString;
  if (dsAzienda <> 'AZIN') then
  begin
    if Parametri.Azienda <> dsAzienda then
    begin
      iAzienda:=Dialogs.InputBox('Cancellazione azienda ' + dsAzienda,
                                 Format(A000MSG_A008_DLG_FMT_CANC_AZ_PROMPT,[dsAzienda]),
                                 '');
      if iAzienda = dsAzienda then
      begin
        if Dialogs.MessageDlg(Format(A000MSG_A008_MSG_FMT_CANC_AZ_AVVISO,[dsAzienda]),
                              mtWarning,[mbYes,mbNo],0) = mrYes then
          inherited
        else
          raise Exception.Create(Format(A000MSG_A008_ERR_FMT_CANC_AZIENDA,[dsAzienda]));
      end
      else
        raise Exception.Create(Format(A000MSG_A008_ERR_FMT_CANC_AZIENDA,[dsAzienda]));
    end
    else
      raise Exception.Create(A000MSG_A008_ERR_NO_CANC_AZIENDA_CORR);
  end
  else
    raise Exception.Create(A000MSG_A008_ERR_NO_CANC_AZIN);
end;

procedure TA008FAziende.TGommaClick(Sender: TObject);
var StatoPrec:Boolean;
begin
  StatoPrec:=A008FOperatoriDtm1.A181MW.QI091.FieldByName('DATO').ReadOnly;
  A008FOperatoriDtm1.A181MW.QI091.FieldByName('DATO').ReadOnly:=False;
  inherited;
  A008FOperatoriDtm1.A181MW.QI091.FieldByName('DATO').ReadOnly:=StatoPrec;
end;

procedure TA008FAziende.TModifClick(Sender: TObject);
begin
  inherited;
  with A008FOperatoriDtM1 do
  begin
    A181MW.A181MW_QI091AfterScroll(A181MW.QI091);
  end;
end;

procedure TA008FAziende.DBCheckBox1Click(Sender: TObject);
begin
  TabelleLog.Enabled:=(DButton.State in [dsEdit,dsInsert]) and DbCheckBox1.Checked;
end;

procedure TA008FAziende.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = nil then
  begin
    dcmbDominioTipoChange(nil);
  end;
end;

procedure TA008FAziende.DButtonStateChange(Sender: TObject);
begin
  inherited;
  TabelleLog.Enabled:=(DButton.State in [dsEdit,dsInsert]) and DbCheckBox1.Checked;
  btnPathAllClient.Enabled:=DButton.State in [dsEdit,dsInsert];
  //cmbFiltroGestModuli.Enabled:=DButton.State = dsBrowse;
  A008FOperatoriDtM1.QI090.FieldByName('AZIENDA').ReadOnly:=not (DButton.State in [dsInsert]);
  AbilitaAzioni;
end;

procedure TA008FAziende.EditaCampoMemo(var InDBGrid:TDBGrid;NomeCampo:String);
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

procedure TA008FAziende.dcmbDominioTipoChange(Sender: TObject);
begin
  inherited;
  lblDominioLdapDN.Enabled:=R180In('LDAP',[dcmbDominioDipTipo.Text,dcmbDominioUsrTipo.Text]);
  dedtDominioLdapDN.Enabled:=lblDominioLdapDN.Enabled;
end;

procedure TA008FAziende.FormShow(Sender: TObject);
begin
  with A008FOperatoriDtM1 do
  begin
    QI090.AfterScroll:=QI090AfterScroll;
    QI090AfterScroll(QI090);
  end;
  CaricaCmbFiltroGestModuli;
end;

procedure TA008FAziende.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Action in [caHide,caFree] then
    A008FOperatoriDtM1.QI090.AfterScroll:=nil;
end;

procedure TA008FAziende.OnPmnLogOperazioniClick(Sender: TObject);
var
  i:Integer;
begin
  if DButton.State in [dsInsert,dsEdit] then
  begin
  for i:=0 to TabelleLog.Items.Count - 1 do
    if Sender = Selezionatutto1 then
      TabelleLog.Checked[i]:=True
    else if Sender = Annullatutto1 then
      TabelleLog.Checked[i]:=False
    else if Sender = Invertiselezione1 then
      TabelleLog.Checked[i]:=not TabelleLog.Checked[i];
  end;
end;

procedure TA008FAziende.btnPathAllClientClick(Sender: TObject);
begin
  inherited;
  if OpenDialog1.Execute then
    A008FOperatoriDtM1.QI090.FieldByName('PATHALLCLIENT').AsString:=R180GetFilePath(OpenDialog1.FileName);
end;

procedure TA008FAziende.btnTestMailClick(Sender: TObject);
var
  MyAddress:String;
begin
  inherited;
  MyAddress:='';
  if InputQuery('Indirizzo E-Mail','',MyAddress) then
    A008FOperatoriDtM1.A181MW.SendEMail(MyAddress);
end;

procedure TA008FAziende.cmbCodiceIterDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  if Index = 0 then
    (Control as TComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,'Tutti')
  else
    (Control as TComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A000IterAutorizzativi[Index - 1].Desc);
end;

procedure TA008FAziende.cmbFiltroGestModuliChange(Sender: TObject);
begin
  inherited;
  with A008FOperatoriDtM1 do
  begin
    A181MW.GruppoFiltroI091:=cmbFiltroGestModuli.Text;
    A181MW.QI091.Filtered:=True;
  end;
end;

end.
