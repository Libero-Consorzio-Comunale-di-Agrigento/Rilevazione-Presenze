unit WA126UBloccoRiepiloghiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A126UBloccoRiepiloghiMW,A000UInterfaccia;

type
  TWA126FBloccoRiepiloghiDM = class(TWR302FGestTabellaDM)
    selTabellaMATRICOLA: TStringField;
    selTabellaNOME: TStringField;
    selTabellaRIEPILOGO: TStringField;
    selTabellaD_RIEPILOGO: TStringField;
    selTabellaDADATA: TStringField;
    selTabellaADATA: TStringField;
    selTabellaPROGRESSIVO: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selTabellaCalcFields(DataSet: TDataSet);
  public
    A126FBloccoRiepiloghiMW: TA126FBloccoRiepiloghiMW;
    function ImpostaSelTabella(Riepiloghi:String;DaData,AData:TDateTime;DipendentiSelezionati:Boolean):Boolean ;
  end;

implementation

{$R *.dfm}

procedure TWA126FBloccoRiepiloghiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  (*
  Imposto valori default solo perchè SelTabella deve essere aperto
  prima della creazione del pannello di browse.
  Dopo aver creato tutti i pannelli, imposto con i valori corretti
  *)
  ImpostaSelTabella('',Now,Now,False);

  A126FBloccoRiepiloghiMW:=TA126FBloccoRiepiloghiMW.Create(Self);
  A126FBloccoRiepiloghiMW.SelT180_Funzioni:=SelTabella;
end;

procedure TWA126FBloccoRiepiloghiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A126FBloccoRiepiloghiMW);
  inherited;
end;

procedure TWA126FBloccoRiepiloghiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  A126FBloccoRiepiloghiMW.CalcFieldsT180;
end;

procedure TWA126FBloccoRiepiloghiDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A126FBloccoRiepiloghiMW.FilterT180;
end;

//Imposta variabili nel dataset. Se vi sono state modifiche restituisce True
function TWA126FBloccoRiepiloghiDM.ImpostaSelTabella(Riepiloghi:String;DaData,AData:TDateTime;DipendentiSelezionati:Boolean):Boolean;
var
  RiepiloghiApici: String;
  SaveFiltered: Boolean;
begin
  Result:=False;

  if Riepiloghi = '' then
    RiepiloghiApici:='''*'''
  else
    RiepiloghiApici:='''' + StringReplace(Riepiloghi,',',''',''',[rfReplaceAll]) + '''';
  with selTabella do
  begin
    if VarToStr(GetVariable('RIEPILOGO')) <> RiepiloghiApici then
    begin
      Close;
      Result:=True;
    end;

    if GetVariable('DATA1') <> DaData then
    begin
      Close;
      Result:=True;
    end;
    if GetVariable('DATA2') <> AData then
    begin
      Close;
      Result:=True;
    end;

    SetVariable('RIEPILOGO',RiepiloghiApici);
    SetVariable('DATA1',DaData);
    SetVariable('DATA2',AData);
    SaveFiltered:=Filtered;
    Filtered:=DipendentiSelezionati;
    if SaveFiltered <> Filtered then
      Result:=True;
    Open;
  end;
end;

end.
