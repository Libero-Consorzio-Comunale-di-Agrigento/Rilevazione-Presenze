unit WP652UINPDAPMMRegoleDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  P652UINPDAPMMRegoleMW, A000UInterfaccia, A000UCostanti;

type
  TWP652FINPDAPMMRegoleDM = class(TWR302FGestTabellaDM)
    selTabellaNOME_FLUSSO: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaPARTE: TStringField;
    selTabellaNUMERO: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO_RECORD: TStringField;
    selTabellaSEZIONE_FILE: TStringField;
    selTabellaNUMERO_FILE: TStringField;
    selTabellaFORMATO_FILE: TStringField;
    selTabellaLUNGHEZZA_FILE: TFloatField;
    selTabellaFORMATO_ANNOMESE: TStringField;
    selTabellaNUMERICO: TStringField;
    selTabellaCOD_ARROTONDAMENTO: TStringField;
    selTabellaFORMATO: TStringField;
    selTabellaOMETTI_VUOTO: TStringField;
    selTabellaTIPO_DATO: TStringField;
    selTabellaREGOLA_CALCOLO_AUTOMATICA: TStringField;
    selTabellaREGOLA_CALCOLO_MANUALE: TStringField;
    selTabellaREGOLA_MODIFICABILE: TStringField;
    selTabellaCOMMENTO: TStringField;
    selTabellaFL_NUMERO_TREDICESIMA: TStringField;
    selTabellaFL_NUMERO_TREDPREC: TStringField;
    selTabellaFL_NUMERO_ARRCORR: TStringField;
    selTabellaFL_NUMERO_ARRPREC: TStringField;
    selTabellaNOME_DATO: TStringField;
    selTabellaCODICI_CAUSALI: TStringField;
    selTabelladescFL_NUMERO_TREDICESIMA: TStringField;
    selTabelladescFL_NUMERO_TREDPREC: TStringField;
    selTabelladesc_FL_NUMERO_ARRCORR: TStringField;
    selTabelladesc_FL_NUMERO_ARRPREC: TStringField;
    selTabellaREGOLA_CALCOLO_ECCEZIONI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    P652FINPDAPMMRegoleMW: TP652FINPDAPMMRegoleMW;
  end;

implementation
uses WP652UINPDAPMMRegole, WP652UINPDAPMMRegoleDettFM;

{$R *.dfm}

procedure TWP652FINPDAPMMRegoleDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('NOMEFLUSSO',(Self.Owner as TWP652FINPDAPMMRegole).NomeFlusso);
  selTabella.SetVariable('ORDERBY','ORDER BY PARTE,NUMERO,DECORRENZA');
  inherited;
  P652FINPDAPMMRegoleMW:=TP652FINPDAPMMRegoleMW.Create(Self);
  P652FINPDAPMMRegoleMW.selP660_Funzioni:=selTabella;
  selTabella.FieldByName('descFL_NUMERO_TREDICESIMA').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;
  selTabella.FieldByName('descFL_NUMERO_TREDPREC').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;
  selTabella.FieldByName('desc_FL_NUMERO_ARRCORR').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;
  selTabella.FieldByName('desc_FL_NUMERO_ARRPREC').LookupDataSet:=P652FINPDAPMMRegoleMW.P660B;

  //Rimuovo campi per evitare che siano presentati nella WC04
  if (Self.Owner as TWP652FINPDAPMMRegole).NomeFlusso = FLUSSO_INPDAP then
  begin
    selTabella.FindField('descFL_NUMERO_TREDICESIMA').Free;
    selTabella.FindField('descFL_NUMERO_TREDPREC').Free;
    selTabella.FindField('desc_FL_NUMERO_ARRCORR').Free;
    selTabella.FindField('desc_FL_NUMERO_ARRPREC').Free;
    selTabella.FindField('FL_NUMERO_TREDICESIMA').Free;
    selTabella.FindField('FL_NUMERO_TREDPREC').Free;
    selTabella.FindField('FL_NUMERO_ARRCORR').Free;
    selTabella.FindField('FL_NUMERO_ARRPREC').Free;
  end;

  P652FINPDAPMMRegoleMW.ImpostaP660B(Parametri.DataLavoro,(Self.Owner as TWP652FINPDAPMMRegole).NomeFlusso,'');
  selTabella.Open;
end;

procedure TWP652FINPDAPMMRegoleDM.AfterScroll(DataSet: TDataSet);
begin
  P652FINPDAPMMRegoleMW.ImpostaP660B(selTabella.FieldByName('DECORRENZA').AsDateTime,(Self.Owner as TWP652FINPDAPMMRegole).NomeFlusso,selTabella.FieldByName('PARTE').AsString);
  if ((Self.Owner as TWP652FINPDAPMMRegole).WDettaglioFM as TWP652FINPDAPMMregoleDettFM) <> nil then
    if (selTabella.FieldByName('NOME_FLUSSO').AsString = 'FLUPER') and (selTabella.FieldByName('PARTE').AsString = 'A') and (selTabella.FieldByName('NUMERO').AsString = '005') then
      ((Self.Owner as TWP652FINPDAPMMRegole).WDettaglioFM as TWP652FINPDAPMMregoleDettFM).lblCausaliFluper.Caption:='T.Indet.'
    else
      ((Self.Owner as TWP652FINPDAPMMRegole).WDettaglioFM as TWP652FINPDAPMMregoleDettFM).lblCausaliFluper.Caption:='Causali';
  inherited;
end;

procedure TWP652FINPDAPMMRegoleDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P652FINPDAPMMRegoleMW);
  inherited;
end;

end.
