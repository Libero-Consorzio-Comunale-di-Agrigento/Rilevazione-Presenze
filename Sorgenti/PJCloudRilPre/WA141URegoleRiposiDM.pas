unit WA141URegoleRiposiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData,
  A000UInterfaccia, WR302UGestTabellaDM, DBClient,
  A000UCostanti, A000USessione, medpIWMessageDlg,A000UMessaggi;

type
  TWA141FRegoleRiposiDM = class(TWR302FGestTabellaDM)
    selT265: TOracleDataSet;
    selT275: TOracleDataSet;
    selT275CODICE: TStringField;
    selT275DESCRIZIONE: TStringField;
    selT275ORENORMALI: TStringField;
    selInterfaccia: TOracleDataSet;
    dsrInterfaccia: TDataSource;
    QCausale1: TOracleDataSet;
    QCausale1T265CODICE: TStringField;
    QCausale1T265DESCRIZIONE: TStringField;
    QCausale1T265CODRAGGR: TStringField;
    DCausale1: TDataSource;
    DCausale2: TDataSource;
    QCausale2: TOracleDataSet;
    QCausale2T265CODICE: TStringField;
    QCausale2T265DESCRIZIONE: TStringField;
    QCausale2T265CODRAGGR: TStringField;
    QCausale3: TOracleDataSet;
    QCausale3T265CODICE: TStringField;
    QCausale3T265DESCRIZIONE: TStringField;
    QCausale3T265CODRAGGR: TStringField;
    DCausale3: TDataSource;
    DCausale4: TDataSource;
    QCausale4: TOracleDataSet;
    QCausale4T265CODICE: TStringField;
    QCausale4T265DESCRIZIONE: TStringField;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO_CAUSALE: TStringField;
    selTabellaRIPOSO_ORDINARIO: TStringField;
    selTabellaRIPOSO_COMPENSATIVO: TStringField;
    selTabellaRIPOSO_MESEPREC: TStringField;
    selTabellaCANCELLAZIONE_CAUSALE: TStringField;
    selTabellaPERSONALE_NON_TURNISTA: TStringField;
    selTabellaSMONTO_NOTTE: TStringField;
    selTabellaLIMITE_SALDO: TStringField;
    selTabellaGGNONLAV_CON_TIMBRATURE: TStringField;
    selTabellaSOLO_SE_NON_REPERIBILE: TStringField;
    selTabellaDOMENICA_GIUSTIFICATA: TStringField;
    selTabellaGGNONLAV_GIUSTIFICATO: TStringField;
    selTabellaGGCALEND_GIUSTIFICATO: TStringField;
    selTabellaCAUS_PRESENZA_TOLLERATE: TStringField;
    selTabellaCAUS_ASSENZA_NONTOLLERATE: TStringField;
    selTabellaGGFEST_GIUSTIFICATO: TStringField;
    selTabellaRIPOSO_LAVORATO: TStringField;
    DCausaleNeg: TDataSource;
    QCausaleNeg: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    selTabellaRIPOSO_COMPENSATIVO_SALDONEG: TStringField;
    selTabellaPRIORITA_FESTIVI: TStringField;
    selTabellaGIUST_NONELABORATI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    procedure CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
  end;

implementation

uses WR100UBase, WA141URegoleRiposi, WA141URegoleRiposiDettFM;

{$R *.dfm}

procedure TWA141FRegoleRiposiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
  selT265.Open;
  selT275.Open;
  QCausale1.Open;
  QCausale2.Open;
  QCausale3.Open;
  QCausale4.Open;
  QCausaleNeg.Open;
end;

procedure TWA141FRegoleRiposiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    if selTabella.FieldByName('RIPOSO_ORDINARIO').AsString = '' then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['causale di Riposo']),mtError,[mbOk],nil,'');
      Abort;
    end;
    // Controllo 'tipo giustificativo' con 'unità di misura inserimento' della causale
    if VarToStr(selT265.Lookup('CODICE',selTabella.FieldByName('RIPOSO_ORDINARIO').AsString,'UM_INSERIMENTO')) = 'N' then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A141_ERR_FMT_GIUST_NO_GIORN,[selTabella.FieldByName('RIPOSO_ORDINARIO').AsString]),mtError,[mbOk],nil,'');
      Abort;
    end;
    if VarToStr(selT265.Lookup('CODICE',selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString,'UM_INSERIMENTO')) = 'N' then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A141_ERR_FMT_GIUST_NO_GIORN,[selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString]),mtError,[mbOk],nil,'');
      Abort;
    end;

    if VarToStr(selT265.Lookup('CODICE',selTabella.FieldByName('RIPOSO_MESEPREC').AsString,'UM_INSERIMENTO')) = 'N' then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A141_ERR_FMT_GIUST_NO_GIORN,[selTabella.FieldByName('RIPOSO_MESEPREC').AsString]),mtError,[mbOk],nil,'');
      Abort;
    end;
    if (selTabella.FieldByName('TIPO_CAUSALE').AsString = 'R') and (VarToStr(selT265.Lookup('CODICE',selTabella.FieldByName('RIPOSO_ORDINARIO').AsString,'CODINTERNO')) <> 'H') then
    begin
      MsgBox.WebMessageDlg(A000MSG_A141_DLG_NO_RIPOSO,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_1');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    if (selTabella.FieldByName('TIPO_CAUSALE').AsString = 'R') and (Trim(selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString) <> '') and
       (VarToStr(selT265.Lookup('CODICE',selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString,'CODINTERNO')) <> 'H') and
       (VarToStr(selT265.Lookup('CODICE',selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString,'CODINTERNO')) <> 'E') then
    begin
      MsgBox.WebMessageDlg(A000MSG_A141_DLG_NO_RIPOSO_COMP,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_2');
      Abort;
    end;
  end;
end;

procedure TWA141FRegoleRiposiDM.CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

end.
