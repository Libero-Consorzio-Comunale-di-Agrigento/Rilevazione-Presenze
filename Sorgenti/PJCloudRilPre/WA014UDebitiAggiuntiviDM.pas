unit WA014UDebitiAggiuntiviDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, medpIWMessageDlg,A000UMessaggi;

type
  TWA014FDebitiAggiuntiviDM = class(TWR302FGestTabellaDM)
    selTabellaAnno: TFloatField;
    selTabellaCodice: TStringField;
    selTabellaTipoPO: TStringField;
    selTabellaTipoDebito: TStringField;
    selTabellaOre1: TStringField;
    selTabellaOre2: TStringField;
    selTabellaOre3: TStringField;
    selTabellaOre4: TStringField;
    selTabellaOre5: TStringField;
    selTabellaOre6: TStringField;
    selTabellaOre7: TStringField;
    selTabellaOre8: TStringField;
    selTabellaOre9: TStringField;
    selTabellaOre10: TStringField;
    selTabellaOre11: TStringField;
    selTabellaOre12: TStringField;
    selTabellaD_Codice: TStringField;
    T060: TOracleDataSet;
    T060CODICE: TStringField;
    T060DESCRIZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
  end;

implementation

uses  WA014UDebitiAggiuntiviDettFM, WA014UDebitiAggiuntivi, WR100UBase;

{$R *.dfm}

procedure TWA014FDebitiAggiuntiviDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY ANNO,CODICE');
  NonAprireSelTabella:=True;
  inherited;
  T060.Open;
  selTabella.Open;
end;

procedure TWA014FDebitiAggiuntiviDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if TWA014FDebitiAggiuntiviDettFM(TWA014FDebitiAggiuntivi(Self.Owner).WDettaglioFM) <> nil then
    with TWA014FDebitiAggiuntiviDettFM(TWA014FDebitiAggiuntivi(Self.Owner).WDettaglioFM) do
    begin
      try
        OreMinutiValidate(dedtGennaio.Text);
        OreMinutiValidate(dedtFebbraio.Text);
        OreMinutiValidate(dedtMarzo.Text);
        OreMinutiValidate(dedtAprile.Text);
        OreMinutiValidate(dedtMaggio.Text);
        OreMinutiValidate(dedtGiugno.Text);
        OreMinutiValidate(dedtLuglio.Text);
        OreMinutiValidate(dedtAgosto.Text);
        OreMinutiValidate(dedtSettembre.Text);
        OreMinutiValidate(dedtOttobre.Text);
        OreMinutiValidate(dedtNovembre.Text);
        OreMinutiValidate(dedtDicembre.Text);
      except
        MsgBox.WebMessageDlg(A000MSG_ERR_ORA_NON_VALIDA,mtError,[mbOk],nil,'');
        Abort;
      end;
    end;
end;

end.
