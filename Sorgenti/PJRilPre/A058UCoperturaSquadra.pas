unit A058UCoperturaSquadra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, A058UPianifTurniDtm1, C180FunzioniGenerali, DB, OracleData;

type
  TSquadre = record
    Squadra:String;
    Operatore:String;
  end;
  TColMatrice = record
    Col:array of string;
  end;

type
  TA058FCoperturaSquadra = class(TForm)
    SquadGriglia: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure SquadGrigliaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    Indice:integer;
    DataDa:TDateTime;
    VetSquadre:array of TSquadre;
    VetMatCol:array of TColMatrice;
    procedure GetSquadre;
    function GetNumSquadra(Sigla,Squad:String;Oper:String):Integer;
    function ControlloAss(Dip,Gio:Integer):Boolean;        
  public
    { Public declarations }
  end;

var A058FCoperturaSquadra: TA058FCoperturaSquadra;

procedure OpenA058CoperturaSquadra(IndiceVista:Integer;Data:TDateTime);

implementation

uses A058UPianifTurni;

{$R *.dfm}

procedure OpenA058CoperturaSquadra(IndiceVista:Integer;Data:TDateTime);
begin
  A058FCoperturaSquadra:=TA058FCoperturaSquadra.Create(nil);
  A058FCoperturaSquadra.Indice:=IndiceVista;
  A058FCoperturaSquadra.DataDa:=Data;
  try
    A058FCoperturaSquadra.ShowModal;
  finally
    FreeAndNil(A058FCoperturaSquadra);
  end;
end;

procedure TA058FCoperturaSquadra.FormShow(Sender: TObject);
var i,k,IndSigla,NumSquadra:Integer;
    Sigle:array of string;
begin
  Self.Caption:=StringReplace(Self.Caption,'dd/mm/yyyy',FormatDateTime('dd/mm/yyyy',DataDa),[rfReplaceAll]);
  SetLength(Sigle,0);
  SquadGriglia.ColCount:=1;
  GetSquadre;
  SquadGriglia.RowCount:=Length(VetSquadre) + 1;
  SetLength(VetMatCol,Length(VetSquadre));
  SquadGriglia.Cells[0,0]:='Squa(Oper)';
  for i:=Low(VetSquadre) to High(VetSquadre) do
  begin
    SetLength(VetMatCol[i].Col,0);
    SquadGriglia.Cells[0,i+1]:=VetSquadre[i].Squadra + '(' + VetSquadre[i].Operatore + ')';
    with A058FPianifTurniDtM1 do
    begin
      //Recupero i massimi e i minimi
      R180SetVariable(selT606,'PROGRESSIVO',-1); //Non individuale
      R180SetVariable(selT606,'COD_ORARIO','*'); //Tutti gli orari
      R180SetVariable(selT606,'COD_SQUADRA',VetSquadre[i].Squadra);
      R180SetVariable(selT606,'COD_TIPOOPE',VetSquadre[i].Operatore);
      selT606.Open;
      try
        FiltraT606(selT606,DataDa,'00001',A058PCKT080TURNO.CalcolaTipoGiorno(Vista[0].Prog,DataDa,'S'));
        if selT606.RecordCount = 0 then
          FiltraT606(selT606,DataDa,'00001',IntToStr(DayOfWeek(DataDa - 1)));
        if selT606.RecordCount = 0 then
          FiltraT606(selT606,DataDa,'00001','*');
        //Scorro le sigle turno per cui sono stati impostati i massimi e i minimi
        while not selT606.Eof do
        begin
          //Recupero l'indice della colonna della sigla
          IndSigla:=-1;
          for k:=Low(Sigle) to High(Sigle) do
            if Sigle[k] = selT606.FieldByName('SIGLA_TURNO').AsString then
            begin
              IndSigla:=k;
              Break;
            end;
          if IndSigla = -1 then
          begin
            SetLength(Sigle,Length(Sigle) + 1);
            IndSigla:=High(Sigle);
            Sigle[IndSigla]:=selT606.FieldByName('SIGLA_TURNO').AsString;
            SquadGriglia.ColCount:=SquadGriglia.ColCount + 1;
            SquadGriglia.Cells[IndSigla + 1,0]:='Turno ' + Sigle[IndSigla];
          end;
          SetLength(VetMatCol[i].Col,Length(Sigle));
          //Recupero i massimi e i minimi
          NumSquadra:=GetNumSquadra(selT606.FieldByName('SIGLA_TURNO').AsString,VetSquadre[i].Squadra,VetSquadre[i].Operatore);
          if (NumSquadra < selT606.FieldByName('MINIMO').AsInteger) or
             (NumSquadra > selT606.FieldByName('MASSIMO').AsInteger) then
            VetMatCol[i].Col[IndSigla]:='E';
          SquadGriglia.Cells[IndSigla + 1,i + 1]:='(' + IntToStr(selT606.FieldByName('MINIMO').AsInteger) + ' - ' + IntToStr(selT606.FieldByName('MASSIMO').AsInteger) + ') ' + IntToStr(NumSquadra);
          selT606.Next;
        end;
      finally
        selT606.Filtered:=False;
      end;
    end;
  end;
end;

function TA058FCoperturaSquadra.ControlloAss(Dip,Gio:Integer):Boolean;
var Ret:Boolean;
begin
  Ret:=False;
  if (A058FPianifTurniDtm1.Vista[Dip].Giorni[Gio].Ass1 <> '') or
     (A058FPianifTurniDtm1.Vista[Dip].Giorni[Gio].Ass2 <> '') then
    Ret:=True;
  Result:=Ret;
end;

function TA058FCoperturaSquadra.GetNumSquadra(Sigla,Squad:String;Oper:String):Integer;
//Calcola il numero dei dipendenti presenti in un turno, in una squadra e in un
//determinato giorno(se Oper è valorizzato fa un ulteriore distinzione per operatore)
var IndGio,i,Ret:Integer;
    TempSquad,TempSigla1,TempSigla2:String;
  //Se riconosce la presenza di più operatori all'interno della vista
  //ritorna true
  function PiuOperatori:Boolean;
  var Ind:Integer;
      Operatore:String;
  begin
    Result:=False;
    with A058FPianifTurniDtm1 do
    begin
      Operatore:=Vista[0].Giorni[IndGio].Oper;
      for Ind:=0 to Vista.Count - 1 do
        if Vista[Ind].Giorni[IndGio].Oper <> Operatore then
        begin
          Result:=True;
          Break;
        end;
    end;
  end;
begin
  IndGio:=Indice;
  Ret:=0;
  Oper:=Trim(Oper);
  with A058FPianifTurniDtm1 do
  begin
    for i:=0 to Vista.Count - 1 do
    begin
      TempSigla1:='NULL';
      if (Vista[i].Giorni[IndGio].T1EU <> 'U') then
        TempSigla1:=Vista[i].Giorni[IndGio].SiglaT1;

      TempSigla2:='NULL';
      if Vista[i].Giorni[IndGio].NumTurno2 <> '' then
        if (Vista[i].Giorni[IndGio].T2EU <> 'U') then
          TempSigla2:=Vista[i].Giorni[IndGio].SiglaT2;
                                                       
      TempSquad:=Vista[i].Giorni[IndGio].Squadra;
      if (Squad = TempSquad) and (('(' + Sigla + ')' = TempSigla1) or ('(' + Sigla + ')' = TempSigla2)) and
         (Vista[i].Giorni[IndGio].Flag <> 'NT') and
         not ControlloAss(i,IndGio) then
        if (Oper = Vista[i].Giorni[IndGio].Oper) or not PiuOperatori then
          Inc(Ret);
    end;
  end;
  Result:=Ret;
end;

procedure TA058FCoperturaSquadra.GetSquadre;
//Prende squadre e operatori del giorno designato
//NB:Prima di richiamarla ripulire il vettore "VetSquadre" = "SetLength(VetSquadre,0)"
var
  IndGio,i,j,k:Integer;
  TempSquadra,TempOper:String;
  Trovato:Boolean;
begin
  IndGio:=Indice;
  for i:=0 to A058FPianifTurniDtM1.Vista.Count - 1 do
  begin
    //Ricerca di valori già esistenti
    TempSquadra:=A058FPianifTurniDtM1.Vista[i].Giorni[IndGio].Squadra;
    TempOper:=A058FPianifTurniDtM1.Vista[i].Giorni[IndGio].Oper;
    if TempSquadra <> '' then
    begin
      //Ricerca di valori già esistenti
      Trovato:=False;
      for k:=Low(VetSquadre) to High(VetSquadre) do
        if (VetSquadre[k].Squadra = TempSquadra) and (VetSquadre[k].Operatore = TempOper) then
          Trovato:=True;
      if not(Trovato) then
      begin
        SetLength(VetSquadre,Length(VetSquadre) + 1);
        j:=High(VetSquadre);
        //Carico Squadra e Operatore
        VetSquadre[j].Squadra:=TempSquadra;
        VetSquadre[j].Operatore:=TempOper;
      end;
    end;
  end;
end;

procedure TA058FCoperturaSquadra.SquadGrigliaDrawCell(Sender: TObject; ACol,
 ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (SquadGriglia.Cells[ACol,ARow] <> '') and
     (ARow > 0) and (ACol > 0) then
  begin
    if ACol <= Length(VetMatCol[ARow - 1].Col) then //Alcuni VetMatCol[x].Col potrebbero non essere allineati al totale delle colonne della griglia
      if VetMatCol[ARow - 1].Col[ACol - 1] = 'E' then
        SquadGriglia.Canvas.Brush.Color:=clRed;
    SquadGriglia.Canvas.FillRect(Rect);
    SquadGriglia.Canvas.TextOut(Rect.Left + 2,Rect.Top + 2,SquadGriglia.Cells[ACol,ARow]);
  end;
end;

end.
