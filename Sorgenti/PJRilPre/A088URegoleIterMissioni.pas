unit A088URegoleIterMissioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, DB, ComCtrls,
  DBCtrls, DBGrids,
  A000UCostanti, A000USessione, A000UInterfaccia, OracleData, Grids, ImgList, Menus, ToolWin;

type
  TA088FRegoleIterMissioni = class(TR001FGestTab)
    dgrdRegoleIter: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure CaricaListe;
  public
  end;

var
  A088FRegoleIterMissioni: TA088FRegoleIterMissioni;

procedure OpenA088RegoleIterMissioni(const Regola: String);

implementation

uses A088URegoleIterMissioniDtM;

{$R *.dfm}

procedure OpenA088RegoleIterMissioni(const Regola: String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA088RegoleIterMissioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A088FRegoleIterMissioni:=TA088FRegoleIterMissioni.Create(nil);
  with A088FRegoleIterMissioni do
  try
    A088FRegoleIterMissioniDtM:=TA088FRegoleIterMissioniDtM.Create(nil);
    A088FRegoleIterMissioniDtM.selM012.SearchRecord('REGOLA',Regola,[srFromBeginning]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A088FRegoleIterMissioniDtM.Free;
    Free;
  end;
end;

procedure TA088FRegoleIterMissioni.CaricaListe;
var
  RegoleList, TipiList: TStringList;
  RegolePickList, TipiPickList: String;
begin
  // elenco delle regole missione (distinct da M010 del codice)
  with A088FRegoleIterMissioniDtM.selM010 do
  begin
    Open;
    RegoleList:=TStringList.Create;
    try
      while not Eof do
      begin
        if RegoleList.IndexOf(FieldByName('CODICE').AsString) < 0 then
          RegoleList.Add(FieldByName('CODICE').AsString);
        Next;
      end;
      RegolePickList:=RegoleList.CommaText;
    finally
      FreeAndNil(RegoleList);
    end;
  end;
  dgrdRegoleIter.Columns.Items[0].PickList.CommaText:=RegolePickList;

  // estero e ispettiva (valori S/N)
  dgrdRegoleIter.Columns.Items[1].PickList.CommaText:='S,N';
  dgrdRegoleIter.Columns.Items[2].PickList.CommaText:='S,N';

  // elenco dei tipi missione da associare (M011)
  with A088FRegoleIterMissioniDtM.selM011 do
  begin
    Open;
    TipiList:=TStringList.Create;
    try
      while not Eof do
      begin
        if TipiList.IndexOf(FieldByName('CODICE').AsString) < 0 then
          TipiList.Add(FieldByName('CODICE').AsString);
        Next;
      end;
      TipiPickList:=TipiList.CommaText;
    finally
      FreeAndNil(TipiList);
    end;
  end;
  dgrdRegoleIter.Columns.Items[3].PickList.CommaText:=TipiPickList;
end;

procedure TA088FRegoleIterMissioni.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A088FRegoleIterMissioniDtM.selM012;
  inherited;
  CaricaListe;
end;

procedure TA088FRegoleIterMissioni.FormDestroy(Sender: TObject);
begin
  // se debug distrugge datamodulo (evita memory leak)
  if DebugHook <> 0 then
    A088FRegoleIterMissioniDtM.Free;
  inherited;
end;


end.
