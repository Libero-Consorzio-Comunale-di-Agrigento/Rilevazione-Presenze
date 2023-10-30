unit A020UCausPresenzeStorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStorico, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, A000UMessaggi,
  C180FunzioniGenerali, Vcl.ExtCtrls;

type
  TA020FCausPresStorico = class(TR004FGestStorico)
    lblCodice: TLabel;
    dedtCodice: TDBEdit;
    dedtDescCausale: TDBEdit;
    lblDescCausale: TLabel;
    dedtDescrizione: TDBEdit;
    lblDescrizione: TLabel;
    dchkNonAbilEliminaTimb: TDBCheckBox;
    dchkAnomCausNonAccop: TDBCheckBox;
    lblCausTimb: TLabel;
    edtCausTimb: TEdit;
    lblInclEsclOreNorm: TLabel;
    edtInclEsclOreNorm: TEdit;
    lblCausCompDebitoGG: TLabel;
    dcmbCausCompDebitoGG: TDBLookupComboBox;
    lblDetrazRiepprSeq: TLabel;
    dedtDetrazRiepprSeq: TDBEdit;
    grpIterAutStr: TGroupBox;
    lblIterAutStrArrotLiq: TLabel;
    dedtIterAutStrArrotLiq: TDBEdit;
    dchkIterAutStrArrotLiqFasce: TDBCheckBox;
    drgpConteggioTimbInterna: TDBRadioGroup;
    drgpIntersezioneTimbrature: TDBRadioGroup;
    dchkAutoCompletamentoUE: TDBCheckBox;
    dchkSeparaCausaliUE: TDBCheckBox;
    grpPausaMensa: TGroupBox;
    dchkTimbPM: TDBCheckBox;
    dchkTimbPMDetraz: TDBCheckBox;
    dchkTimbPMH: TDBCheckBox;
    dchkMaturaMensa: TDBCheckBox;
    dchkSpezzStraord: TDBCheckBox;
    dchkRiconoscimentoTurno: TDBCheckBox;
    grpCondizioneAbilitazione: TGroupBox;
    dedtCondizioneAbilitazione: TDBEdit;
    procedure TCancClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure dchkMaturaMensaClick(Sender: TObject);
    procedure drgpIntersezioneTimbratureChange(Sender: TObject);
    procedure dchkAutoCompletamentoUEClick(Sender: TObject);
  private
    { Private declarations }
    procedure ImpostaEnabledCampi;
  public
    // Periodo attuale, viene prevalorizzato prima dello show
    // e utilizzato prima del destroy per sincronizzare con il form chiamante
    A020StoricoDataLavoro:TDateTime;
  end;

var
  A020FCausPresStorico: TA020FCausPresStorico;

implementation

uses A020UCausPresenze,A020UCausPresenzeDtM1, A020UCausPresenzeStoricoDtM;

{$R *.dfm}

procedure TA020FCausPresStorico.ImpostaEnabledCampi;
begin
  drgpConteggioTimbInterna.Enabled:=drgpIntersezioneTimbrature.ItemIndex = 1;
  dchkSeparaCausaliUE.Enabled:=dchkAutoCompletamentoUE.Enabled and dchkAutoCompletamentoUE.Checked;
  dchkTimbPMDetraz.Enabled:=dchkMaturaMensa.Checked;
end;

procedure TA020FCausPresStorico.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TA020FCausPresStorico.dchkAutoCompletamentoUEClick(Sender: TObject);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TA020FCausPresStorico.dchkMaturaMensaClick(Sender: TObject);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TA020FCausPresStorico.drgpIntersezioneTimbratureChange(Sender: TObject);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TA020FCausPresStorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  A020StoricoDataLavoro:=DButton.DataSet.FieldByName('DECORRENZA').AsDateTime;
  inherited;
end;

procedure TA020FCausPresStorico.FormCreate(Sender: TObject);
begin
  inherited;
  dcmbCausCompDebitoGG.ListSource:=A020FCausPresenzeDtM1.A020MW.dsrT275lkpOreNorm;
  // Le descrizioni di questi campi sono definite nella form principale.
  // A questo punto il dataset è posizionato sul record di nostro interesse.
  edtCausTimb.Text:=A020FCausPresenze.DBRadioGroup1.Items[A020FCausPresenze.DBRadioGroup1.ItemIndex];
  edtInclEsclOreNorm.Text:=A020FCausPresenze.EOreNormali.Items[A020FCausPresenze.EOreNormali.ItemIndex];
end;

procedure TA020FCausPresStorico.FormShow(Sender: TObject);
var
  DataLavoroInizialeStr:String;
begin
  inherited;
  lblCausCompDebitoGG.Enabled:=A020FCausPresenzeStoricoDtM.A020FCausPresenzeStoricoMW.OreNormali = 'A';
  dcmbCausCompDebitoGG.Enabled:=A020FCausPresenzeStoricoDtM.A020FCausPresenzeStoricoMW.OreNormali = 'A';
  dchkAutoCompletamentoUE.Enabled:=R180In(A020FCausPresenzeStoricoDtM.A020FCausPresenzeStoricoMW.TipoConteggio,['A','E']);
  dchkSeparaCausaliUE.Enabled:=R180In(A020FCausPresenzeStoricoDtM.A020FCausPresenzeStoricoMW.TipoConteggio,['A','E']);
  dchkSpezzStraord.Enabled:=(A020FCausPresenzeStoricoDtM.A020FCausPresenzeStoricoMW.OreNormali = 'A') //Ore escluse dalle normali
                            and
                            (A020FCausPresenzeStoricoDtM.A020FCausPresenzeStoricoMW.CodInterno = 'A');//gruppo Straordinario

  DataLavoroInizialeStr:=DateToStr(A020StoricoDataLavoro);
  cmbDateDecorrenza.ItemIndex:=cmbDateDecorrenza.Items.IndexOf(DataLavoroInizialeStr);
  cmbDateDecorrenzaChange(nil);
end;

procedure TA020FCausPresStorico.TCancClick(Sender: TObject);
begin
  if DButton.DataSet.RecordCount < 2 then
  begin
    R180MessageBox(A000MSG_A020_MSG_NO_ELIMINA_STOR,ESCLAMA,Self.Caption);
    Exit;
  end;
  inherited;
end;

end.
