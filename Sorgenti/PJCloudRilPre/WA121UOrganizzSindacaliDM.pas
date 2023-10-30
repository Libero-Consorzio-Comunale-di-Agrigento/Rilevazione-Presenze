unit WA121UOrganizzSindacaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB, meIWCheckBox,
  OracleData, A121URecapitiSindacaliMW;

type
  TWA121FOrganizzSindacaliDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaCOD_MINISTERIALE: TStringField;
    selTabellaFILTRO: TStringField;
    selTabellaRAGGRUPPAMENTO: TStringField;
    selTabellaSINDACATI_RAGGRUPPATI: TStringField;
    selTabellaRSU: TStringField;
    selTabellaVOCEPAGHE: TStringField;
    selTabellaCAUSALE_COMPETENZE: TStringField;
    selTabellaCAUSALE_COMPETENZE_NO: TStringField;
    selTabellaCOD_REGIONALE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaRSUValidate(Sender: TField);
    procedure selTabellaCODICEValidate(Sender: TField);
    procedure selTabellaRAGGRUPPAMENTOValidate(Sender: TField);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    procedure relazionaTabelleFiglie;Override;
    procedure VisColOrg;
    procedure AggiornaVariabiliMW;
  public
    A121MW: TA121FRecapitiSindacaliMW;
  end;


implementation

uses WA121UOrganizzSindacali, WA121UOrganizzSindacaliDettFM;

{$R *.dfm}

procedure TWA121FOrganizzSindacaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY','ORDER BY CODICE, DECORRENZA');
  NonAprireSelTabella:=True;
  inherited;
  A121MW:=TA121FRecapitiSindacaliMW.Create(Self);
  A121MW.selT240:=SelTabella;
  VisColOrg;
  A121MW.AggiornaVariabiliMW:=AggiornaVariabiliMW;
  SelTabella.Open;
end;

procedure TWA121FOrganizzSindacaliDM.relazionaTabelleFiglie;
begin
  inherited;
  A121MW.selT241.Close;
  A121MW.selT241.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  A121MW.selT241.Open;
  A121MW.selT242.Close;
  A121MW.selT242.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  A121MW.selT242.Open;
end;

procedure TWA121FOrganizzSindacaliDM.VisColOrg;
begin
  with A121MW do
  begin
    selT245.FieldByName('FRUIZIONE_PERMESSI').Visible:=False;
    selT245.FieldByName('PARTECIPAZIONE_RICHIESTA').Visible:=False;
    selT245.FieldByName('RETRIBUITO').Visible:=False;
    selT245.FieldByName('STATUTARIO').Visible:=False;
    selT245.FieldByName('ABBATTE_COMPETENZE_ORG').Visible:=False;
    selT245.FieldByName('D_FRUIZIONE_PERMESSI').Visible:=True;
    selT245.FieldByName('D_PARTECIPAZIONE_RICHIESTA').Visible:=True;
    selT245.FieldByName('D_RETRIBUITO').Visible:=True;
    selT245.FieldByName('D_STATUTARIO').Visible:=True;
    selT245.FieldByName('D_ABBATTE_COMPETENZE_ORG').Visible:=True;
    selT245.Open;
  end;
end;

procedure TWA121FOrganizzSindacaliDM.AggiornaVariabiliMW;
begin
  with (Self.Owner as TWA121FOrganizzSindacali) do
  begin
    A121MW.RqStoriciPrec:=chkStoriciPrec.Checked;
    A121MW.RqStoriciSucc:=chkStoriciSucc.Checked;
  end;
end;

procedure TWA121FOrganizzSindacaliDM.selTabellaCODICEValidate(Sender: TField);
begin
  inherited;
  A121MW.FieldCODICEValidate;
end;

procedure TWA121FOrganizzSindacaliDM.selTabellaRAGGRUPPAMENTOValidate(Sender: TField);
begin
  inherited;
  A121MW.FieldRAGGRUPPAMENTOValidate;
end;

procedure TWA121FOrganizzSindacaliDM.selTabellaRSUValidate(Sender: TField);
begin
  inherited;
  A121MW.FieldRSUValidate;
end;

procedure TWA121FOrganizzSindacaliDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (Self.Owner as TWA121FOrganizzSindacali).WDettaglioFM <> nil then
    with ((Self.Owner as TWA121FOrganizzSindacali).WDettaglioFM as TWA121FOrganizzSindacaliDettFM)  do
    begin
      if SelTabella.FieldByName('RAGGRUPPAMENTO').AsString = 'S' then
        edtSindacati.Text:=''
      else
        with A121MW.selRaggruppatoIn do
        begin
          Close;
          SetVariable('CODICE',SelTabella.FieldByName('CODICE').AsString);
          SetVariable('DECORRENZA',SelTabella.FieldByName('DECORRENZA').AsDateTime);
          Open;
          First;
          edtSindacati.Text:='';
          while not Eof do
          begin
            if Pos(FieldByName('CODICE').AsString,edtSindacati.Text) <= 0 then
            begin
              if edtSindacati.Text <> '' then
                edtSindacati.Text:=edtSindacati.Text + ',';
              edtSindacati.Text:=edtSindacati.Text + FieldByName('CODICE').AsString;
            end;
            Next;
          end;
        end;
      //TODO chkRaggruppamentoClick(nil);
    end;
  A121MW.AfterScroll;
end;

procedure TWA121FOrganizzSindacaliDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  A121MW.BeforePost;
end;

procedure TWA121FOrganizzSindacaliDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  (* TODO!!!!!
  if (selTabella.Active) and ((Self.Owner as TWA121FOrganizzSindacali).WDettaglioFM <> nil) then
  begin
    with ((Self.Owner as TWA121FOrganizzSindacali).WDettaglioFM as TWA121FOrganizzSindacaliDettFM)  do
    begin
      CompetenzeNavBar.AbilitaToolBar(selTabella.State = dsBrowse);
      chkRaggruppamentoClick(nil);
    end;
    if (Self.Owner as TWA121FOrganizzSindacali).OrganismiNavBar <> nil then
      (Self.Owner as TWA121FOrganizzSindacali).OrganismiNavBar.AbilitaToolBar(selTabella.State = dsBrowse);
  end;
  *)
end;

end.
