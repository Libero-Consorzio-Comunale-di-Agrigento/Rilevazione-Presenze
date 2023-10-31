unit A157UCapitoliTrasferte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, OracleData,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids,
  C013UCheckList, C180FunzioniGenerali, C600USelAnagrafe, L001Call, R004UGestStorico,
  A000UInterfaccia, A000USessione, A157UCapitoliTrasferteDM, System.ImageList;

type
  TA157FCapitoliTrasferte = class(TR004FGestStorico)
    dGrdCapitoliTrasferta: TDBGrid;
    popmnuAccedi: TPopupMenu;
    Accedi1: TMenuItem;
    procedure dGrdCapitoliTrasfertaEditButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
  private
    { Private declarations }
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
  public
    { Public declarations }
  end;

var
  A157FCapitoliTrasferte: TA157FCapitoliTrasferte;

procedure OpenA157CapitoliTrasferta(Codice:String = '');

implementation

{$R *.dfm}

procedure OpenA157CapitoliTrasferta(Codice:String = '');
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA157CapitoliTrasferta') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  A157FCapitoliTrasferte:=TA157FCapitoliTrasferte.Create(nil);
  A157FCapitoliTrasferteDM:=TA157FCapitoliTrasferteDM.Create(nil);
  try
    Screen.Cursor:=crDefault;
    A157FCapitoliTrasferteDM.selM030.SearchRecord('CODICE',Codice,[srFromBeginning]);
    A157FCapitoliTrasferte.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A157FCapitoliTrasferte);
    FreeAndNil(A157FCapitoliTrasferteDM);
  end;
end;

procedure TA157FCapitoliTrasferte.Accedi1Click(Sender: TObject);
var Griglia:TInserisciDLL;
    i:integer;
    sFiltro:string;
begin
  inherited;
  with A157FCapitoliTrasferteDM.A157MW.selM011 do
  begin
    sFiltro:='';
    Griglia.NomeTabella:='M011_TIPOMISSIONE';
    Griglia.Titolo:='Tipi missione';
    Griglia.FiltroDizAllinea:='TIPI MISSIONE';
    for i:=0 to FieldCount -1 do
    begin
      Griglia.Display[i]:=Fields[i].DisplayLabel;
      Griglia.Size[i]:=Fields[i].DisplayWidth;
    end;
    //Imposto il filtro prima di aprire la tabella
    for i:=0 to High(Parametri.FiltroDizionario) do
      if Parametri.FiltroDizionario[i].Tabella = 'TIPOLOGIA TRASFERTA' then
      begin
        if Parametri.FiltroDizionario[i].Abilitato then
        begin
          if sFiltro <> '' then
            sFiltro:=sFiltro + ' OR ';
          sFiltro:=sFiltro + '(CODICE=''' + Parametri.FiltroDizionario[i].Codice + ''')';
        end
        else
        begin
          if sFiltro <> '' then
            sFiltro:=sFiltro + ' AND ';
          sFiltro:=sFiltro + '(CODICE<>''' + Parametri.FiltroDizionario[i].Codice + ''')';
        end
      end;
  end;
  Inserisci(Griglia,dgrdCapitoliTrasferta.SelectedField.AsString.Substring(0,5).Trim,sFiltro);
  A157FCapitoliTrasferteDM.A157MW.selM011.Refresh;
end;

procedure TA157FCapitoliTrasferte.dGrdCapitoliTrasfertaEditButtonClick(Sender: TObject);
var
  s:string;
  lstTM:TStringList;
begin
  inherited;
  if dGrdCapitoliTrasferta.SelectedField.FieldName = 'FILTRO_ANAGRAFE' then
  begin
    if not(dGrdCapitoliTrasferta.DataSource.DataSet.State in [dsInsert,dsEdit]) then
      exit;
    C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
    C600frmSelAnagrafe.C600DatiVisualizzati:='';
    C600frmSelAnagrafe.btnSelezioneClick(Sender);
    if C600frmSelAnagrafe.C600ModalResult = mrOK then
    begin
      s:=C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text.Trim;
      if pos('ORDER BY',UpperCase(s)) > 0 then
        s:=Copy(s,1,Pos('ORDER BY',s.ToUpper) - 1);
      dGrdCapitoliTrasferta.DataSource.DataSet.FieldByName('FILTRO_ANAGRAFE').AsString:=s;
    end;
  end;

  if dGrdCapitoliTrasferta.SelectedField.FieldName = 'TIPO_MISSIONE' then
  begin
    with TC013FCheckList.Create(nil) do
    try
      Caption:='Tipi missione';
      lstTM:=A157FCapitoliTrasferteDM.A157MW.GetLstTipiMissione;
      clbListaDati.Items.AddStrings(lstTM);
      lstTM.Free;
      R180PutCheckList(A157FCapitoliTrasferteDM.selM030.FieldByName('TIPO_MISSIONE').AsString,5,clbListaDati);
      clbListaDati.Enabled:=dGrdCapitoliTrasferta.DataSource.DataSet.State in [dsInsert,dsEdit];
      if ShowModal = mrOK then
        if dGrdCapitoliTrasferta.DataSource.DataSet.State in [dsInsert,dsEdit] then
          A157FCapitoliTrasferteDM.selM030.FieldByName('TIPO_MISSIONE').AsString:=R180GetCheckList(5,clbListaDati,',');
    finally
      Free;
    end;
  end;
end;

procedure TA157FCapitoliTrasferte.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA157FCapitoliTrasferte.FormShow(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe:=TC600frmSelAnagrafe.Create(Self);
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600Progressivo:=0;
end;

end.
