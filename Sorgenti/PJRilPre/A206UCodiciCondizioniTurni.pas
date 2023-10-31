unit A206UCodiciCondizioniTurni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids, C600USelAnagrafe, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Samples.Spin, Vcl.Mask, Vcl.ExtCtrls, A000USessione, OracleData;

type
  TA206FCodiciCondizioniTurni = class(TR001FGestTab)
    Panel2: TPanel;
    lblTipo: TLabel;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    dcmbValoreTipo: TDBLookupComboBox;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dgrdCodiciCondizioni: TDBGrid;
    lblSquadra: TLabel;
    lblAbilita: TLabel;
    lblObbliga: TLabel;
    lblTipoOperatore: TLabel;
    lblOrario: TLabel;
    lblSiglaTurno: TLabel;
    lblGiorno: TLabel;
    lblMinimo: TLabel;
    lblOttimale: TLabel;
    lblMassimo: TLabel;
    lblValore: TLabel;
    dchkGenerale: TDBCheckBox;
    dchkIndividuale: TDBCheckBox;
    dchkSqA: TDBCheckBox;
    dchkOpA: TDBCheckBox;
    dchkOrA: TDBCheckBox;
    dchkSgA: TDBCheckBox;
    dchkGgA: TDBCheckBox;
    dchkMnA: TDBCheckBox;
    dchkMnO: TDBCheckBox;
    dchkOtA: TDBCheckBox;
    dchkOtO: TDBCheckBox;
    dchkMxA: TDBCheckBox;
    dchkMxO: TDBCheckBox;
    dchkVrA: TDBCheckBox;
    dchkVrO: TDBCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A206FCodiciCondizioniTurni: TA206FCodiciCondizioniTurni;

procedure OpenA206FCodiciCondizioniTurni(CodSquadra:String);

implementation

{$R *.dfm}

uses
  A206UCondizioniTurniDM;

procedure OpenA206FCodiciCondizioniTurni(CodSquadra:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=True;
  Application.CreateForm(TA206FCodiciCondizioniTurni, A206FCodiciCondizioniTurni);
  try
    Screen.Cursor:=crDefault;
    A206FCodiciCondizioniTurni.dcmbValoreTipo.ListSource:=A206FCondizioniTurniDM.A206MW.dsrTipoVal;
    A206FCodiciCondizioniTurni.DButton.DataSet:=A206FCondizioniTurniDM.A206MW.selT605a;
    //Si posiziona sul codice scelto
    A206FCondizioniTurniDM.A206MW.selT605a.SearchRecord('CODICE',CodSquadra,[srFromBeginning]);
    A206FCodiciCondizioniTurni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A206FCodiciCondizioniTurni.Free;
    //Toglie eventuali filtri e si riposiziona sul codice originale
    A206FCondizioniTurniDM.A206MW.selT605a.Filtered:=False;
    A206FCondizioniTurniDM.A206MW.selT605a.SearchRecord('CODICE',CodSquadra,[srFromBeginning]);
  end;
end;

end.
