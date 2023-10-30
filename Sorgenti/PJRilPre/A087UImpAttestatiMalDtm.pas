unit A087UImpAttestatiMalDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, xmldom, DB, DBClient, XMLIntf,
  msxmldom, XMLDoc, OracleData, Oracle, A000UInterfaccia, C180FunzioniGenerali,
  A087UImpAttestatiMalMW, StrUtils, ExtCtrls;

type
  TA087FImpAttestatiMalDtm = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
  private
    function IsAnomalieChecked:Boolean;
    function IsValidChkEsenzione:Boolean;
    function GetPathFile:String;
    function IsInserimentoChecked: Boolean;
    procedure InizializzaProgressBar;
    procedure ProgressBarStepIt;
    procedure AbilCmbCausaleAll(Abilita: Boolean);
  public
    A087MW: TA087FImpAttestatiMalMW;
  end;

var
  A087FImpAttestatiMalDtm: TA087FImpAttestatiMalDtm;

implementation

uses A087UImpAttestatiMal;

{$R *.dfm}

procedure TA087FImpAttestatiMalDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A087MW:=TA087FImpAttestatiMalMW.Create(Self);
  with A087MW do
  begin
    evtAnomalieChecked:=IsAnomalieChecked;
    evtGetPathFile:=GetPathFile;
    evtIsValidChkEsenzione:=IsValidChkEsenzione;
    evtInitProgressBar:=InizializzaProgressBar;
    evtProgressBarStepIt:=ProgressBarStepIt;
    evtInserimentoChecked:=IsInserimentoChecked;
    evtAbilCmbCausaleAll:=AbilCmbCausaleAll;
    selT480.Open;
    selT265.Open;
    selT265_All.Open;
    cdsLookT265.CreateDataSet;
  end;
end;

procedure TA087FImpAttestatiMalDtm.AbilCmbCausaleAll(Abilita: Boolean);
begin
  A087FImpAttestatiMal.dbCmbCausale_All.Enabled:=Abilita;
end;

function TA087FImpAttestatiMalDtm.GetPathFile: String;
begin
  Result:=A087FImpAttestatiMal.edtPathFile.Text;
end;

function TA087FImpAttestatiMalDtm.IsAnomalieChecked: Boolean;
begin
  Result:=A087FImpAttestatiMal.chkAnomalie.Checked;
end;

function TA087FImpAttestatiMalDtm.IsValidChkEsenzione: Boolean;
begin
  Result:=A087FImpAttestatiMal.chkEsenzione.Enabled and A087FImpAttestatiMal.chkEsenzione.Checked;
end;

function TA087FImpAttestatiMalDtm.IsInserimentoChecked: Boolean;
begin
  Result:=A087FImpAttestatiMal.chkInserimento.Checked;
end;

procedure TA087FImpAttestatiMalDtm.InizializzaProgressBar;
begin
  A087FImpAttestatiMal.PrgBar1.Min:=0;
  A087FImpAttestatiMal.PrgBar1.Position:=0;
  A087FImpAttestatiMal.PrgBar1.Max:=High(A087MW.VetAttestato) + 1;
end;

procedure TA087FImpAttestatiMalDtm.ProgressBarStepIt;
begin
  A087FImpAttestatiMal.PrgBar1.StepIt;
end;

end.
