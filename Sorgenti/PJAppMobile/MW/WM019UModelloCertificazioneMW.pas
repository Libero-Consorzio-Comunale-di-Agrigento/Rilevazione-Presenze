unit WM019UModelloCertificazioneMW;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, Data.DB, OracleData, Vcl.Controls, C180FunzioniGenerali, System.Math,
  A000UCostanti, A000USessione, MedpUnimPanelBase, MedpUnimLabel, Vcl.Graphics, WM019UCertificazioniMW, MedpUnimPanelCheckBox,
  MedpUnimPanelNumberEdit, MedpUnimPanel2Labels, MedpUnimPanelEdit, MedpUnimPanelDatePicker, MedpUnimPanelMemo, MedpUnimDatePicker, MedpUnimNumberEdit,
  Oracle, MedpUnimCheckBox, StrUtils, MedpUnimMemo, MedpUnimSelect, MedpUnimEdit, Generics.Collections, MedpUnimPanelSelect;

type
  TDatoEditabile = class(TObject)
    public
      Codice: String;
      Descrizione: String;
      Valore: String;
      Component: TComponent;
      Obbligatorio: Boolean;

      constructor Create(PCodice, PDescrizione, PValore: String; PComponent: TComponent; PObbligatorio: Boolean);
  end;

  //usa componenti UniGUI!!!
  TWM019FModelloCertificazioneMW = class(TWM000FDataModuleBaseDM, IWM019FModelloCertificazioneMW)
    selSG236SG237: TOracleDataSet;
    selSG235: TOracleDataSet;
    selQueryValore: TOracleQuery;
    selDatoLibero: TOracleDataSet;
    selSG231: TOracleDataSet;
    insSG231: TOracleQuery;
  private
    FPanelModello: TMedpUnimPanelBase;
    FListaDati: TObjectList<TDatoEditabile>;

    procedure InserisciDescrizioneModello(PDescrizione: String);
    procedure InserisciDescrizioneCategoria(PDescrizione: String);
    procedure InserisciTesto(PTesto: String);
    procedure InserisciMessaggio(PDescrizione, PMessaggio: String);
    procedure InserisciUrl(PDescrizione, PUrl: String);
    procedure InserisciCheckBox(PCodice, PDescrizione, PValore, PDefault: String; SolaLettura, Obbligatorio: Boolean);
    procedure InserisciMemo(PCodice, PDescrizione, PDefault: String; PLungMax: Integer; SolaLettura, Obbligatorio: Boolean);
    procedure InserisciEdit(PCodice, PDescrizione, PDefault: String; PLungMax: Integer; SolaLettura, Obbligatorio: Boolean);
    procedure InserisciNumberEdit(PCodice, PDescrizione: String; PDefault: String; PLungMax: Integer; SolaLettura, Obbligatorio: Boolean);
    procedure InserisciDatePicker(PCodice, PDescrizione: String; PDefault: String; SolaLettura, Obbligatorio: Boolean);
    procedure InserisciComboBox(PCodice, PDescrizione: String; PListaValori: TList<TPair<String, String>>; PElencoFisso: String; PLungMax: Integer; PDefault: String; SolaLettura, Obbligatorio: Boolean);
    procedure VariabiliQueryValore(PProgressivo: Integer; POperazione: String; DSSorg, DSDest:TOracleDataset);
    function RimuoviTagHTML(pStr: string): string;
    procedure Clear;
  public
    constructor Create(PSessioneIrisWin: TSessioneIrisWin; PPanelModello: TMedpUnimPanelBase); overload;
    destructor Destroy; override;

    //IWM019FModelloCertificazioneMW
    function AggiornaPanelModello(PId: Integer; PCodModello, POperazione: String; PProgressivo: Integer; DSRichieste: TOracleDataset; SolaLettura: Boolean): TResCtrl;
    function CtrlDatiModello: TResCtrl;
    function InserisciDatiModello(PIdRichiesta: Integer): TResCtrl;
    function AggiornaDatiModello(PIdRichiesta: Integer): TResCtrl;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TWM019FModelloCertificazioneMW }

constructor TWM019FModelloCertificazioneMW.Create(PSessioneIrisWin: TSessioneIrisWin; PPanelModello: TMedpUnimPanelBase);
begin
  if not Assigned(PPanelModello) then
    raise Exception.Create('E'' necessario inizializzare il modello con un panel valido');

  inherited Create(PSessioneIrisWin);
  FPanelModello:=PPanelModello;
  FListaDati:=nil;
end;

destructor TWM019FModelloCertificazioneMW.Destroy;
begin
  FreeAndNil(FListaDati);
  inherited;
end;

procedure TWM019FModelloCertificazioneMW.Clear;
var Item: TControl;
begin
  while FPanelModello.ControlCount > 0 do
  begin
    Item:=FPanelModello.controls[0];
    Item.Free;
  end;
  FreeAndNil(FListaDati);

  FListaDati:=TObjectList<TDatoEditabile>.Create(True);
end;

procedure TWM019FModelloCertificazioneMW.InserisciDescrizioneModello(PDescrizione: String);
var tempLabel: TMedpUnimLabel;
begin
  tempLabel:=TMedpUnimLabel.Create(FPanelModello);
  InsertComponent(tempLabel);
  with tempLabel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';

    JSInterface.JSCall('setHtml',[PDescrizione]);
    JSInterface.JSCall('setStyle',['width: 100%; font-weight: bold; font-size: 18px; margin: 5px 0px;']);
    JSInterface.JSCall('addCls',['x-text-center']);
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciDescrizioneCategoria(PDescrizione: String);
var tempLabel: TMedpUnimLabel;
begin
  tempLabel:=TMedpUnimLabel.Create(FPanelModello);
  InsertComponent(tempLabel);
  with tempLabel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';

    JSInterface.JSCall('setHtml',[PDescrizione]);
    JSInterface.JSCall('setStyle',['width: 100%; min-height: 20px; font-weight: bold; font-size: 15px; padding: 5px; border: 1px solid black; background-color: rgb(197, 213, 235);']);
    JSInterface.JSCall('addCls',['x-text-center']);
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciTesto(PTesto: String);
var tempLabel: TMedpUnimLabel;
begin
  tempLabel:=TMedpUnimLabel.Create(FPanelModello);
  InsertComponent(tempLabel);
  with tempLabel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';

    JSInterface.JSCall('setHtml',[PTesto]);
    JSInterface.JSCall('setStyle',['width: 100%; font-size: 14px; padding: 2px;']);
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciMessaggio(PDescrizione, PMessaggio: String);
var tempLabel: TMedpUnimLabel;
    LWidthDesc, LWidthMess: String;
begin
  LWidthDesc:='50%';
  LWidthMess:='50%';

  if PDescrizione.Trim = '' then
    LWidthMess:='100%'
  else if PMessaggio.Trim = '' then
    LWidthDesc:='100%';

  if PDescrizione.Trim <> '' then
  begin
    tempLabel:=TMedpUnimLabel.Create(FPanelModello);
    InsertComponent(tempLabel);
    with tempLabel do
    begin
      SetSubComponent(True);
      CreateOrder:=FPanelModello.ControlCount+1;
      Parent:=FPanelModello;
      Name:='';

      JSInterface.JSCall('setHtml',[PDescrizione]);
      JSInterface.JSCall('setStyle',['width:' + LWidthDesc + '; font-size: 14px; padding: 2px;']);
    end;
  end;

  if PMessaggio.Trim <> '' then
  begin
    tempLabel:=TMedpUnimLabel.Create(FPanelModello);
    InsertComponent(tempLabel);
    with tempLabel do
    begin
      SetSubComponent(True);
      CreateOrder:=FPanelModello.ControlCount+1;
      Parent:=FPanelModello;
      Name:='';

      JSInterface.JSCall('setHtml',[PMessaggio]);
      JSInterface.JSCall('setStyle',['width: ' + LWidthMess + '; font-size: 14px; padding: 2px;']);
    end;
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciUrl(PDescrizione, PUrl: String);
var tempPanel: TMedpUnimPanel2Labels;
begin
  tempPanel:=TMedpUnimPanel2Labels.Create(FPanelModello);
  with tempPanel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';
    JSInterface.JSCall('setStyle',['width: 100%; height: auto;']);

    if PDescrizione.Trim <> '' then
    begin
      Label1.Caption:=PDescrizione;
      Label1.JSInterface.JSCall('setStyle',['justify-content: flex-start; font-size: 14px; padding: 2px;']);
      Label2.Caption:=PUrl;
      if PDescrizione.Trim.Length > 15 then
        Label2.JSInterface.JSCall('setStyle',['justify-content: flex-start; width: 65%; font-size: 14px; padding: 2px;'])
      else
        Label2.JSInterface.JSCall('setStyle',['justify-content: flex-start; width: 50%; font-size: 14px; padding: 2px;']);
    end
    else
    begin
      Label1.Caption:='';
      Label1.Flex:=0;
      Label1.JSInterface.JSCall('setStyle',['width: 0px;']);
      Label2.Caption:=PUrl;
      Label2.Flex:=0;
      Label2.JSInterface.JSCall('setStyle',['justify-content: flex-start; width: 100%; font-size: 14px; padding: 2px;']);
    end;
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciCheckBox(PCodice, PDescrizione, PValore, PDefault: String; SolaLettura, Obbligatorio: Boolean);
var tempPanel: TMedpUnimPanelCheckBox;
begin
  tempPanel:=TMedpUnimPanelCheckBox.Create(FPanelModello);
  with tempPanel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';
    JSInterface.JSCall('setStyle',['width: 100%; height: auto;']);
    CheckBox.CheckIcon.Checked:=PDefault = 'S';
    CheckBox.CheckIcon.ReadOnly:=SolaLettura;

    FListaDati.Add(TDatoEditabile.Create(PCodice, PDescrizione, PDefault, CheckBox, Obbligatorio));
    //solo obbligatorio + check
    if (PDescrizione.Trim = '(*)') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      CheckBox.CheckLabel.Caption:=PValore;
      CheckBox.JSInterface.JSCall('setStyle', ['padding: 2px; width: 90%;']);
    end
    // descrizione, check e valore
    else if (PDescrizione.Trim <> '') and (PValore.Trim <> '') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      CheckBox.CheckLabel.Caption:=PValore;
      CheckBox.JSInterface.JSCall('setStyle', ['padding: 2px; width: auto; max-width: 50%;'])
    end
    // solo descrizione e check, no valore
    else if (PDescrizione.Trim <> '') and (PValore.Trim = '') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.Flex:=0;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px; width: auto; max-width: 90%']);
      CheckBox.JSInterface.JSCall('setStyle', ['padding: 2px; width: 10%;']);
    end
    //solo check + valore
    else if (PDescrizione.Trim = '') and (PValore.Trim <> '') then
    begin
      CheckBox.CheckLabel.Caption:=PValore;
      CheckBox.JSInterface.JSCall('setStyle', ['padding: 2px; width: 100%;']);
    end
    //solo check
    else if (PDescrizione.Trim = '') and (PValore.Trim = '') then
    begin
      CheckBox.JSInterface.JSCall('setStyle', ['padding: 2px; width: 100%;']);
    end;
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciEdit(PCodice, PDescrizione, PDefault: String; PLungMax: Integer; SolaLettura, Obbligatorio: Boolean);
var tempPanel: TMedpUnimPanelEdit;
begin
  tempPanel:=TMedpUnimPanelEdit.Create(FPanelModello);
  with tempPanel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';
    JSInterface.JSCall('setStyle',['width: 100%; height: auto;']);
    Edit.MaxLength:=PLungMax;
    Edit.ReadOnly:=SolaLettura;

    FListaDati.Add(TDatoEditabile.Create(PCodice, PDescrizione, PDefault, Edit, Obbligatorio));

    if ((PDescrizione.Trim <> '') and (PDescrizione.Trim <> '(*)')) then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      Edit.Text:=PDefault;
      if (PDefault.Length <> -1) and (PDefault.Length < 5) and SolaLettura then
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 20%;'])
      else if PDescrizione.Trim.Length > 15 then
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 50%;'])
      else
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 65%;'])
    end
    else if (PDescrizione.Trim = '(*)') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      Edit.Text:=PDefault;
      if (PDefault.Length <> -1) and (PDefault.Length < 5) and SolaLettura then
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 20%; margin-right: 70%;'])
      else
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 90%;']);

    end
    else if (PDescrizione.Trim = '') then
    begin
      Edit.Text:=PDefault;
      if (PDefault.Length <> -1) and (PDefault.Length < 5) and SolaLettura then
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 20%; margin-right: 80%;'])
      else
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 100%;']);
    end;
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciNumberEdit(PCodice, PDescrizione: String; PDefault: String; PLungMax: Integer; SolaLettura, Obbligatorio: Boolean);
var tempPanel: TMedpUnimPanelNumberEdit;
begin
  tempPanel:=TMedpUnimPanelNumberEdit.Create(FPanelModello);
  with tempPanel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';
    JSInterface.JSCall('setStyle',['width: 100%; height: auto;']);
    Edit.Text:=PDefault;
    Edit.MaxLength:=PLungMax;
    Edit.ReadOnly:=SolaLettura;
    Edit.InputType:='digit';  //usato per differenziare da edit testuale libero

    FListaDati.Add(TDatoEditabile.Create(PCodice, PDescrizione, PDefault, Edit, Obbligatorio));

    if ((PDescrizione.Trim <> '') and (PDescrizione.Trim <> '(*)')) then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      if PDescrizione.Trim.Length > 15 then
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 50%;'])
      else
        Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 65%;'])
    end
    else if (PDescrizione.Trim = '(*)') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 90%;']);
    end
    else if (PDescrizione.Trim = '') then
    begin
      Edit.JSInterface.JSCall('setStyle', ['padding: 2px; width: 100%;']);
    end;
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciDatePicker(PCodice, PDescrizione: String; PDefault: String; SolaLettura, Obbligatorio: Boolean);
var tempPanel: TMedpUnimPanelDatePicker;
begin
  tempPanel:=TMedpUnimPanelDatePicker.Create(FPanelModello);
  with tempPanel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';
    JSInterface.JSCall('setStyle',['width: 100%; height: auto;']);
    DatePicker.Text:=PDefault;
    DatePicker.ReadOnly:=SolaLettura;

    FListaDati.Add(TDatoEditabile.Create(PCodice, PDescrizione, PDefault, DatePicker, Obbligatorio));

    if ((PDescrizione.Trim <> '') and (PDescrizione.Trim <> '(*)')) then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      if PDescrizione.Trim.Length > 15 then
        DatePicker.JSInterface.JSCall('setStyle', ['padding: 2px; width: 50%;'])
      else
        DatePicker.JSInterface.JSCall('setStyle', ['padding: 2px; width: 65%;'])
    end
    else if (PDescrizione.Trim = '(*)') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      DatePicker.JSInterface.JSCall('setStyle', ['padding: 2px; width: 90%;']);
    end
    else if (PDescrizione.Trim = '') then
    begin
      DatePicker.JSInterface.JSCall('setStyle', ['padding: 2px; width: 100%;']);
    end;
  end;
end;

function TWM019FModelloCertificazioneMW.AggiornaDatiModello(PIdRichiesta: Integer): TResCtrl;
var i: Integer;
begin
  Result.Clear;
  try
    with selSG231 do
    begin
      Close;
      SetVariable('ID', PIdRichiesta);
      Filtered:=True;
      Open;
      for i:=0 to FListaDati.Count-1 do
      begin
        if (FListaDati[i].Valore = '') and (Locate('CODICE', FListaDati[i].Codice, [])) then
        begin
          Delete;
          Open;
        end
        else
        begin
          if Locate('CODICE', FListaDati[i].Codice, []) then
            Edit
          else
            Append;

          FieldByName('ID').AsInteger:=PIdRichiesta;
          FieldByName('CODICE').AsString:=FListaDati[i].Codice;
          FieldByName('VALORE').AsString:=FListaDati[i].Valore;
          Post;
        end;
      end;
      Result.Ok:=True;
    end;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciComboBox(PCodice, PDescrizione: String; PListaValori: TList<TPair<String, String>>; PElencoFisso: String; PLungMax: Integer; PDefault: String; SolaLettura, Obbligatorio: Boolean);
var tempPanel: TMedpUnimPanelSelect;
    i, LMaxLung: Integer;
begin
  LMaxLung:=-1;
  for i:=0 to PListaValori.Count-1 do
  begin
    if PListaValori[i].Value <> '' then
    begin
      LMaxLung:=-1;
      Break;
    end;
    if PListaValori[i].Key.Length > LMaxLung then
      LMaxLung:=PListaValori[i].Key.Length;
  end;

  tempPanel:=TMedpUnimPanelSelect.Create(FPanelModello);
  with tempPanel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';
    JSInterface.JSCall('setStyle',['width: 100%; height: auto;']);
    Select.JSInterface.JSCall('setMaxLength',[PLungMax.ToString]);

    FListaDati.Add(TDatoEditabile.Create(PCodice, PDescrizione, PDefault, Select, Obbligatorio));

    if (PDescrizione.Trim <> '') and (PDescrizione.Trim <> '(*)') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      if (LMaxLung <> -1) and (LMaxLung < 5)  then
        Select.JSInterface.JSCall('setStyle', ['padding: 2px; width: 20%;'])
      else
      begin
        if PDescrizione.Trim.Length > 15 then
          Select.JSInterface.JSCall('setStyle', ['padding: 2px; width: 50%;'])
        else
          Select.JSInterface.JSCall('setStyle', ['padding: 2px; width: 65%;'])
      end;
    end
    else if (PDescrizione.Trim = '(*)') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      if (LMaxLung <> -1) and (LMaxLung < 5) then
        Select.JSInterface.JSCall('setStyle', ['padding: 2px; width: 20%; margin-right: 70%;'])
      else
        Select.JSInterface.JSCall('setStyle', ['padding: 2px; width: 90%;']);
    end
    else if (PDescrizione.Trim = '') then
    begin
      if (LMaxLung <> -1) and (LMaxLung < 5) then
        Select.JSInterface.JSCall('setStyle', ['padding: 2px; width: 20%; margin-right: 80%;'])
      else
        Select.JSInterface.JSCall('setStyle', ['padding: 2px; width: 100%;']);
    end;

    if not (PElencoFisso = 'S') then
      Select.JSInterface.JSCall('setEditable', ['true']);

    //popolo la lista e gestisco anche il default
    Select.Popola(PListaValori, PDefault);
  end;
end;

procedure TWM019FModelloCertificazioneMW.InserisciMemo(PCodice, PDescrizione, PDefault: String; PLungMax: Integer; SolaLettura, Obbligatorio: Boolean);
var tempPanel: TMedpUnimPanelMemo;
begin
  tempPanel:=TMedpUnimPanelMemo.Create(FPanelModello);
  with tempPanel do
  begin
    SetSubComponent(True);
    CreateOrder:=FPanelModello.ControlCount+1;
    Parent:=FPanelModello;
    Name:='';
    JSInterface.JSCall('setStyle',['width: 100%; height: auto;']);
    Memo.Memo.ReadOnly:=SolaLettura;

    if ((PDescrizione.Trim <> '') and (PDescrizione.Trim <> '(*)')) then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      Memo.Memo.Text:=PDefault;
      if PDescrizione.Trim.Length > 15 then
        Memo.JSInterface.JSCall('setStyle', ['padding: 2px; width: 50%;'])
      else
        Memo.JSInterface.JSCall('setStyle', ['padding: 2px; width: 65%;'])
    end
    else if (PDescrizione.Trim = '(*)') then
    begin
      PanelLabel.Caption:=PDescrizione;
      PanelLabel.JSInterface.JSCall('setStyle', ['padding: 2px;']);
      Memo.Memo.Text:=PDefault;
      Memo.JSInterface.JSCall('setStyle', ['padding: 2px; width: 90%;']);
    end
    else if (PDescrizione.Trim = '') then
    begin
      Memo.Memo.Text:=PDefault;
      Memo.JSInterface.JSCall('setStyle', ['padding: 2px; width: 100%;']);
    end;
  end;
end;

function TWM019FModelloCertificazioneMW.AggiornaPanelModello(PId: Integer; PCodModello, POperazione: String; PProgressivo: Integer; DSRichieste: TOracleDataset; SolaLettura: Boolean): TResCtrl;
var
  Codice, Descrizione, Categoria, DescCategoria, CategoriaPrec, Valori, DatoAnagrafico, QueryValore, ElencoFisso, ValoreDefault: String;
  TestoSQLQueryValore, Tabella, TabCodice, TabStorico, S, ValoreInserito: String;
  Obbligatorio, Elenco, ElencoTabellare: Boolean;
  DSValori: TOracleDataSet;
  rDato, Righe, LungMax: Integer;
  LFormato: Char;
  //DatoPers: TDatoPersonalizzato;
  LListaDatiCombo: TList<TPair<String, String>>;
const DATI_PERS_MAXLENGTH = 2000;
begin
  Result.Clear;
  try
    with selSG235 do
    begin
      Close;
      SetVariable('COD_MODELLO', PCodModello);
      Open;

      if RecordCount = 0 then
      begin
        Result.Messaggio:=Format('Modello con codice %s non trovato', [PCodModello]);
        Exit;
      end;
    end;

    Clear;

    InserisciDescrizioneModello(selSG235.FieldByName('DESCRIZIONE').AsString.Trim.Replace(sLineBreak, '<br>'));

    CategoriaPrec:='';

    if POperazione <> 'I' then
    begin
      with selSG231 do
      begin
        Close;
        SetVariable('ID', PId);
        Open;
      end;
    end;

    with selSG236SG237 do
    begin
      Close;
      SetVariable('ID',selSG235.FieldByName('ID').AsInteger);
      Open;

      while not Eof do
      begin
        Codice:=FieldByName('COD_DATO').AsString;
        Descrizione:=StringReplace(FieldByName('DESC_DATO').AsString, '<br>', ' ', [rfReplaceAll, rfIgnoreCase]);
        Categoria:=FieldByName('COD_CAT').AsString;
        DescCategoria:=FieldByName('DESC_CAT').AsString;
        // dati personalizzati
        DSValori:=nil;
        ValoreInserito:='';

        // gestione rottura di categoria
        if Categoria <> CategoriaPrec then
          //gestire inserimenti label descrizione categoria
          InserisciDescrizioneCategoria(DescCategoria.Trim.Replace(sLineBreak, '<br>'));

        // informazioni sul dato
        Valori:=StringReplace(FieldByName('VALORI').AsString, '<br>', ' ', [rfReplaceAll, rfIgnoreCase]);
        Obbligatorio:=FieldByName('OBBLIGATORIO').AsString = 'S';
        Righe:=FieldByName('RIGHE').AsInteger;
        LFormato:=R180CarattereDef(FieldByName('FORMATO').AsString);
        LungMax:=IfThen(FieldByName('LUNG_MAX').AsInteger = 0, DATI_PERS_MAXLENGTH, FieldByName('LUNG_MAX').AsInteger);
        DatoAnagrafico:=FieldByName('DATO_ANAGRAFICO').AsString;
        QueryValore:=FieldByName('QUERY_VALORE').AsString;
        ElencoFisso:=FieldByName('ELENCO_FISSO').AsString;
        ValoreDefault:=FieldByName('VALORE_DEFAULT').AsString;

        if POperazione <> 'I' then
        begin
          if selSG231.Locate('CODICE', Codice, []) then
            ValoreInserito:=selSG231.FieldByName('VALORE').AsString;
        end;

        Elenco:=(QueryValore <> '') or (DatoAnagrafico <> '') or (Valori <> '');    //indica se il dato è selezionabile da elenco oppure no

        // cerca di capire se il dato è tabellare (codice + descrizione) o meno
        ElencoTabellare:=False;
        if QueryValore <> '' then
        begin
          // elenco valori estratto da interrogazione di servizio
          selQueryValore.SetVariable('NOME',QueryValore);
          try
            selQueryValore.Execute;
            TestoSQLQueryValore:=selQueryValore.FieldAsString(0);
          except
            TestoSQLQueryValore:='';
          end;

          if TestoSQLQueryValore <> '' then
          begin
            // crea e imposta proprietà dataset
            DSValori:=TOracleDataSet.Create(Self);
            DSValori.Session:=SessioneOracle;
            DSValori.ReadBuffer:=50;
            DSValori.ReadOnly:=True;

            // imposta testo e variabili sql
            DSValori.Close;
            DSValori.SQL.Text:=TestoSQLQueryValore;
            // gestione variabili
            DSValori.ClearVariables;
            DSValori.DeleteVariables;

            VariabiliQueryValore(PProgressivo, POperazione, DSRichieste, DSValori);

            try
              DSValori.Open;
              ElencoTabellare:=DSValori.FieldCount > 1;
            except
              raise Exception.Create(Format('Impossibile determinare i valori del dato %s: l''interrogazione di servizio "%s" contiene errori!',
                                                                                  [FieldByName('DESCRIZIONE').AsString,QueryValore]));
            end;
          end;
        end
        else if DatoAnagrafico <> '' then
        begin
          // elenco valori estratto da dato personalizzato anagrafico
          A000GetTabella(DatoAnagrafico,Tabella,TabCodice,TabStorico);
          ElencoTabellare:=(Tabella <> '') and (Tabella.ToUpper <> 'T430_STORICO');
        end;

        if LFormato = 'T' then
          InserisciTesto(IfThen(Obbligatorio,'(*) ') + Descrizione)
        else if LFormato = 'U' then
          InserisciUrl(IfThen(Obbligatorio,'(*) ') + Descrizione, '<a href="' + copy(Valori,Valori.IndexOf(',')+2, Valori.Length-Valori.IndexOf(',')) + '" target="_blank">' + copy(Valori,0, Valori.IndexOf(',')) + '</a>')
        else if LFormato = 'M' then
          InserisciMessaggio(IfThen(Obbligatorio,'(*) ') + Descrizione, Valori)
        else if LFormato = 'C' then
          InserisciCheckBox(Codice, IfThen(Obbligatorio,'(*) ') + Descrizione, Valori, IfThen(POperazione = 'I', ValoreDefault, ValoreInserito), SolaLettura, Obbligatorio)
        else if LFormato = 'N' then
          InserisciNumberEdit(Codice, IfThen(Obbligatorio, '(*) ') + Descrizione, IfThen(POperazione = 'I', '', ValoreInserito), LungMax, SolaLettura, Obbligatorio)
        else if LFormato = 'D' then
          InserisciDatePicker(Codice, IfThen(Obbligatorio, '(*) ') + Descrizione, IfThen(POperazione = 'I', '', ValoreInserito), SolaLettura, Obbligatorio)
        else if LFormato = 'S' then
        begin
          if Elenco then //Combo??
          begin
            LListaDatiCombo:=TList<TPair<String, String>>.Create;
            try
              if QueryValore <> '' then
              begin
                // gestione query valore
                if TestoSQLQueryValore = '' then
                begin

                end
                else
                begin
                  // popola multicolumn con valori
                  // nota: il dataset è già stato aperto per determinare se il dato è tabellare
                  if (DSValori <> nil) and (DSValori.Active) then
                  begin
                    // popolamento combobox
                    DSValori.First;
                    while not DSValori.Eof do
                    begin
                      if ElencoTabellare then
                        LListaDatiCombo.Add(TPair<String, String>.Create(DSValori.Fields[0].AsString, DSValori.Fields[1].AsString))
                      else
                        LListaDatiCombo.Add(TPair<String, String>.Create(DSValori.Fields[0].AsString, ''));

                      DSValori.Next;
                    end;
                  end;
                end;
              end
              else if DatoAnagrafico <> '' then
              begin
                // dato anagrafico

                // se è indicato il dato anagrafico estrae l'elenco di valori in base a questo
                if A000LookupTabella(DatoAnagrafico, selDatoLibero) then
                begin
                  // popola multicolumn con valori
                  if selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
                    selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Now));

                  selDatoLibero.Open;
                  selDatoLibero.First;
                  // ciclo di popolamento della combo
                  while not selDatoLibero.Eof do
                  begin
                    if ElencoTabellare then
                      LListaDatiCombo.Add(TPair<String, String>.Create(selDatoLibero.FieldByName('CODICE').AsString, selDatoLibero.FieldByName('DESCRIZIONE').AsString))
                    else
                      LListaDatiCombo.Add(TPair<String, String>.Create(selDatoLibero.FieldByName('CODICE').AsString, ''));

                    selDatoLibero.Next;
                  end;
                  selDatoLibero.Close;
                end;
              end
              else
              begin
                // elenco di valori fissi
                // popola multicolumn con valori
                for S in Valori.Split([',']) do
                  LListaDatiCombo.Add(TPair<String, String>.Create(S, ''));
              end;

              // se è presente un solo elemento nella combobox, questa viene eliminata
              // e sostituita da un edit
              if (LListaDatiCombo.Count = 1) or SolaLettura then
                //se ho un solo elemento, considero quello come valore di default!
                InserisciEdit(Codice, IfThen(Obbligatorio,'(*) ') + Descrizione, IfThen(POperazione = 'I', LListaDatiCombo[0].Key, ValoreInserito), LungMax, SolaLettura, Obbligatorio)
              else
                InserisciComboBox(Codice, IfThen(Obbligatorio,'(*) ') + Descrizione, LListaDatiCombo, ElencoFisso, LungMax, IfThen(POperazione = 'I', ValoreDefault, ValoreInserito), SolaLettura, Obbligatorio);
            finally
              FreeAndNil(LListaDatiCombo);
            end;
          end
          else
          begin
            // dato personalizzato: edit / memo
            if Righe = 1 then
              // 1 riga: crea un edit
              InserisciEdit(Codice, IfThen(Obbligatorio,'(*) ') + Descrizione, IfThen(POperazione = 'I', ValoreDefault, ValoreInserito), LungMax, SolaLettura, Obbligatorio)
            else
              // n>1 righe: crea un memo
              InserisciMemo(Codice, IfThen(Obbligatorio,'(*) ') + Descrizione, IfThen(POperazione = 'I', ValoreDefault, ValoreInserito), LungMax, SolaLettura, Obbligatorio);
          end;
        end;

        // salva categoria precedente
        CategoriaPrec:=Categoria;
        Next;
      end;
    end;
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWM019FModelloCertificazioneMW.InserisciDatiModello(PIdRichiesta: Integer): TResCtrl;
var i: Integer;
begin
  Result.Clear;
  try
    with insSG231 do
    begin
      for i:=0 to FListaDati.Count-1 do
      begin
        if FListaDati[i].Valore <> '' then
        begin
          SetVariable('ID', PIdRichiesta);
          SetVariable('CODICE', FListaDati[i].Codice);
          SetVariable('VALORE', FListaDati[i].Valore);
          Execute;
        end;
      end;
      Result.Ok:=True;
    end;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWM019FModelloCertificazioneMW.CtrlDatiModello: TResCtrl;
var i,j: Integer;
    Check: TMedpUnimCheckBox;
    Edit: TMedpUnimEdit;
    Memo: TMedpUnimMemo;
    Select: TMedpUnimSelect;
    DatePicker: TMedpUnimDatePicker;
    NumEdit: TMedpUnimNumberEdit;
begin
  Result.Clear;

  for i:=0 to FListaDati.Count-1 do
  begin
    if FListaDati[i].Component is TMedpUnimCheckBox then
    begin
      Check:=FListaDati[i].Component as TMedpUnimCheckBox;

      if FListaDati[i].Obbligatorio and not Check.CheckIcon.Checked then
      begin
        Result.Messaggio:=Format('E'' necessario accettare la condizione ' + CRLF + '"%s"!',[RimuoviTagHTML(FListaDati[i].Descrizione)]);
        Exit;
      end
      else
        FListaDati[i].Valore:=IfThen(Check.CheckIcon.Checked, 'S', 'N');
    end
    else if FListaDati[i].Component is TMedpUnimEdit then
    begin
      Edit:=FListaDati[i].Component as TMedpUnimEdit;

      if FListaDati[i].Obbligatorio and (Trim(Edit.Text) = '') then
      begin
        Result.Messaggio:=Format('L''indicazione del dato ' + CRLF + '"%s"! è obbligatoria!',[RimuoviTagHTML(FListaDati[i].Descrizione)]);
        Exit;
      end
      else if Edit.InputType = 'digit' then //caso input solo numerico
      begin
        for j:=1 to Length(Edit.Text) do
        begin
          if (Edit.Text[j] < '0') or (Edit.Text[j] > '9') then
          begin
            Result.Messaggio:=Format('Il dato ' + CRLF + '"%s"! può contenere soltanto caratteri numerici',[RimuoviTagHTML(FListaDati[i].Descrizione)]);
            Exit;;
          end;
        end;
      end;

      FListaDati[i].Valore:=Trim(Edit.Text);
    end
    else if FListaDati[i].Component is TMedpUnimMemo then
    begin
      Memo:=FListaDati[i].Component as TMedpUnimMemo;

      if FListaDati[i].Obbligatorio and (Trim(Memo.Memo.Text) = '') then
      begin
        Result.Messaggio:=Format('L''indicazione del dato ' + CRLF + '"%s"! è obbligatoria!',[RimuoviTagHTML(FListaDati[i].Descrizione)]);
        Exit;
      end
      else
        FListaDati[i].Valore:=Trim(Memo.Memo.Text);
    end
    else if FListaDati[i].Component is TMedpUnimSelect then
    begin
      Select:=FListaDati[i].Component as TMedpUnimSelect;

      if FListaDati[i].Obbligatorio and (Select.ItemIndex = -1) then
      begin
        Result.Messaggio:=Format('E'' necessario selezionare un valore per il dato ' + CRLF + '"%s"!',[RimuoviTagHTML(FListaDati[i].Descrizione)]);
        Exit;
      end
      else
      begin
        if Select.ItemIndex = -1 then
          FListaDati[i].Valore:=''
        else
          FListaDati[i].Valore:=Select.ListaCodici[Select.ItemIndex];
      end;
    end
    else if FListaDati[i].Component is TMedpUnimDatePicker then
    begin
      DatePicker:=FListaDati[i].Component as TMedpUnimDatePicker;

      if FListaDati[i].Obbligatorio and (DatePicker.Text = '') then
      begin
        Result.Messaggio:=Format('L''indicazione del dato ' + CRLF + '"%s"! è obbligatoria!',[RimuoviTagHTML(FListaDati[i].Descrizione)]);
        Exit;
      end
      else
        FListaDati[i].Valore:=DatePicker.Text;
    end;
  end;

  Result.Ok:=True;
end;

procedure TWM019FModelloCertificazioneMW.VariabiliQueryValore(PProgressivo: Integer; POperazione: String; DSSorg, DSDest:TOracleDataset);
var lstVariabili:TStringList;
    i:Integer;
begin
  lstVariabili:=FindVariables(DSDest.SQL.Text, False);
  try
    for i:=0 to lstVariabili.Count - 1 do
    begin
      if DSSorg.FindField(lstVariabili[i]) = nil then
        Continue;
      if DSSorg.FindField(lstVariabili[i]) is TDateTimeField then
        DSDest.DeclareVariable(lstVariabili[i],otDate)
      else if DSSorg.FindField(lstVariabili[i]) is TIntegerField then
        DSDest.DeclareVariable(lstVariabili[i],otInteger)
      else
        DSDest.DeclareVariable(lstVariabili[i],otString);

      if POperazione = 'I' then
      begin
        if lstVariabili[i].ToUpper = 'PROGRESSIVO' then
          DSDest.SetVariable(lstVariabili[i], PProgressivo)
      end
      else
        DSDest.SetVariable(lstVariabili[i], DSSorg.FieldByName(lstVariabili[i]).Value);
    end;
  finally
    FreeAndNil(lstVariabili);
  end;
end;

function TWM019FModelloCertificazioneMW.RimuoviTagHTML(pStr: string): string;
var inizio, fine: integer;
begin
  inizio:=pStr.IndexOf('<');
  fine:=pStr.IndexOf('>');
  while (inizio > 0) and (fine > 0) do
  begin
    pStr:=Copy(pStr,0, inizio) + Copy(pStr, fine+2, pStr.Length-fine-1);
    inizio:=pStr.IndexOf('<');
    fine:=pStr.IndexOf('>');
  end;
  Result:=pStr;
end;

{ TDatoEditabile }

constructor TDatoEditabile.Create(PCodice, PDescrizione, PValore: String; PComponent: TComponent; PObbligatorio: Boolean);
begin
  Codice:=PCodice;
  Descrizione:=PDescrizione;
  Valore:=PValore;
  Component:=PComponent;
  Obbligatorio:=PObbligatorio;
end;

end.
