unit A139UQuadroRiass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, C700USelezioneAnagrafe, StdCtrls, Buttons,
  ExtCtrls, C180FunzioniGenerali, DB, OracleData, Menus, ActnList, A004UGiustifAssPres,
  A000UInterfaccia;

type
  TCellAss = record
    Ass,VAss,Tipo,Dalle,Alle:String;
end;

type
  TCellServ =Record
    Servizio,ColoreServ,
    ColoreFont,Dalle,Alle:string;
end;

type
  TCellQuadro = record
    DataGG:TDateTime;
    Servizi:Array of TCellServ;
    Servizio,ColoreServ,
    ColoreFont,Dalle,Alle:string;
    VisParziale:Boolean;
    Assenze:array of TCellAss;
  end;

type
  TRowQuadro = record
    Prog:Integer;
    Nominativo:String;
    Giorni:array of TCellQuadro;
  end;

type
  TA139FQuadroRiass = class(TForm)
    GridQuadro: TAdvStringGrid;
    pnlCmd: TPanel;
    btnSelDip: TSpeedButton;
    lblMessaggio: TLabel;
    btnAnnulla: TSpeedButton;
    PopupMenu: TPopupMenu;
    inseriscipattuglia1: TMenuItem;
    ActionList1: TActionList;
    actInsPattuglia: TAction;
    actOpenA004: TAction;
    Giustificativi1: TMenuItem;
    actOpenA139VAss: TAction;
    actOpenA139VAss1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure GridQuadroGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GridQuadroDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnAnnullaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actInsPattugliaExecute(Sender: TObject);
    procedure actOpenA004Execute(Sender: TObject);
    procedure actOpenA139VAssExecute(Sender: TObject);
  private
    { Private declarations }
    Parola:String;
    NumGG:Integer;
    DataBase:TDateTime;
    procedure ShowGrid;
    procedure CaricaVista;
    procedure RefreshCellVista(Data:TDateTime;c,r:integer);
    function GetNumOre(Dalle,Alle:String):integer;
    function StampaServizi(IndProg,IndData:Integer):Integer;
  public
    { Public declarations }
    Vista:array of TRowQuadro;
  end;

var
  A139FQuadroRiass: TA139FQuadroRiass;

implementation

uses A139UPianifServizi, A139UPianifServiziDtm, A139UValidaAssenze;

{$R *.dfm}

function TA139FQuadroRiass.GetNumOre(Dalle,Alle:String):integer;
var MinDa,MinA:Integer;
begin
  MinDa:=R180OreMinutiExt(Dalle);
  MinA:=R180OreMinutiExt(Alle);
  if MinA > MinDa then
    Result:=MinA - MinDa
  else
  begin
    MinDa:=1440 - MinDa;
    Result:=MinDa + MinA;
  end;
end;

function TA139FQuadroRiass.StampaServizi(IndProg,IndData:Integer):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=0 to High(Vista[IndProg].Giorni[IndData].Servizi) do
    if 360 <= GetNumOre(Vista[IndProg].Giorni[IndData].Servizi[i].Dalle,Vista[IndProg].Giorni[IndData].Servizi[i].Alle) then
      inc(Result);
end;

procedure TA139FQuadroRiass.actInsPattugliaExecute(Sender: TObject);
var Mark:TBookMark;
    r,c:integer;
    Risultato:Boolean;
begin
  with A139FPianifServiziDtm do
  begin
    r:=GridQuadro.Row;
    c:=GridQuadro.Col;

    selT430T502.Close;
    selT430T502.SetVariable('CAMPO1',ParametriPianServiziRaggr1);
    selT430T502.SetVariable('CAMPO2',ParametriPianServiziRaggr2);
    selT430T502.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
    selT430T502.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').Asinteger);
    selT430T502.SetVariable('PROGRESSIVO',Vista[GridQuadro.Row - 1].Prog);
    selT430T502.Open;
    Risultato:=False;
    //OpenTotAnag;
    OpenT502_2;
    if (selT430T502.RecordCount <= 0) then
    begin
      if ((selT500.FieldByName('COMANDATO').AsString = 'N') or (A139FPianifServizi.btnServiziComandati.Down))then
      begin
        selT502_2.Insert;
        selT502_2.FieldByName('PROGRESSIVO').AsInteger:=Vista[GridQuadro.Row - 1].Prog;
        selT502_2.FieldByName('DATA').AsDateTime:=selT500.FieldByName('DATA').AsDateTime;
        selT502_2.FieldByName('PATTUGLIA').AsInteger:=selT500.FieldByName('PATTUGLIA').AsInteger;
        selT502_2.Post;
        Risultato:=True;
      end;
    end
    else
    begin
      if selT502_2.SearchRecord('PROGRESSIVO;DATA;PATTUGLIA',VarArrayOf([selT430T502.FieldByName('PROGRESSIVO').AsVariant,
                                                                         selT430T502.FieldByName('DATA').AsVariant,
                                                                         selT430T502.FieldByName('PATTUGLIA').AsVariant])
                                                            ,[srFromBeginning]) then
      begin
        selT502_2.Edit;
        selT502_2.FieldByName('PROGRESSIVO').AsInteger:=Vista[GridQuadro.Row - 1].Prog;
        selT502_2.Post;
        Risultato:=True;
      end;
    end;

    if risultato then
    begin
      InsT502.Session.Commit;
      R180MessageBox('Anagrafica inserita correttamente.','INFORMA');
      RefreshCellVista(selT500.FieldByName('DATA').AsDateTime,Trunc(Trunc(selT500.FieldByName('DATA').AsDateTime) - DataBase),GridQuadro.Row-1);
      GridQuadro.Repaint;
      selT502.Close;
      selT502.Open;
      Mark:=selT500.GetBookmark;
      selT500.Refresh;
      A139FPianifServizi.GridServizi.Repaint;
      GridQuadro.FocusCell(c,r);
      selT500.GotoBookmark(Mark);
    end
    else
      R180MessageBox('Anagrafica non inserita.','ESCLAMA');
  end;
end;

procedure TA139FQuadroRiass.actOpenA004Execute(Sender: TObject);
begin
  with A139FPianifServizi do
  begin
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    try
      with A139FPianifServiziDtM do
        OpenA004GiustifAssPres(Vista[GridQuadro.Row - 1].Prog, GridQuadro.Cells[GridQuadro.Col,0],'','','','',0,False);
    finally
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
    end;
    ShowGrid;
    GridQuadro.RepaintCell(GridQuadro.Col,GridQuadro.Row);
  end;
end;

procedure TA139FQuadroRiass.actOpenA139VAssExecute(Sender: TObject);
var Str:String;
    i:integer;
begin
  Str:='';
  for i:=0 to High(Vista[GridQuadro.Row - 1].Giorni[GridQuadro.Col - 1].Assenze) do
    if Vista[GridQuadro.Row - 1].Giorni[GridQuadro.Col - 1].Assenze[i].VAss <> 'N' then
    begin
      if Str <> '' then
        Str:=Str + ',';
      Str:=Str + Vista[GridQuadro.Row - 1].Giorni[GridQuadro.Col - 1].Assenze[i].Ass;
    end;

  OpenA139ValidaAssenze(Vista[GridQuadro.Row - 1].Prog,
                        DataBase + GridQuadro.Col - 1,
                        DataBase + GridQuadro.Col - 1,
                        Str);
  CaricaVista;
  RefreshCellVista(DataBase + GridQuadro.Col - 1,GridQuadro.Col-1,GridQuadro.Row-1);
  GridQuadro.RepaintCell(GridQuadro.Col,GridQuadro.Row);
end;

procedure TA139FQuadroRiass.btnAnnullaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA139FQuadroRiass.FormCreate(Sender: TObject);
begin
  A139FPianifServizi.actShowQuadroRiass.Enabled:=False;
  Parola:='';
  DataBase:=StrToDate(A139FPianifServizi.edtDatada.Text) - 15;
end;

procedure TA139FQuadroRiass.FormShow(Sender: TObject);
begin
  A139FPianifServiziDtm.OpenTotAnag;
  CaricaVista;
  ShowGrid;
  GridQuadro.AutoSizeColumns(True,1);
  GridQuadro.AutoSizeRows(True,1);
end;

procedure TA139FQuadroRiass.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Self);
end;

procedure TA139FQuadroRiass.FormDestroy(Sender: TObject);
begin
  A139FPianifServizi.actShowQuadroRiass.Enabled:=True;
end;

procedure TA139FQuadroRiass.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var i:Integer;
begin
  if Key = 114 then
  begin
    Parola:=InputBox('Ricarca nome','',Parola);
    if Parola <> '' then
    begin
      if GridQuadro.Row+1 = GridQuadro.RowCount then
        GridQuadro.Row:=1;
      for i:=GridQuadro.Row+1 to GridQuadro.RowCount - 1 do
        if Pos(Parola,StringReplace(GridQuadro.Cells[0,i],#$D#$A,' ',[rfReplaceAll])) > 0 then
          Break;
      if i <= GridQuadro.RowCount - 1 then
        GridQuadro.FocusCell(GridQuadro.Col,i);
    end;
  end;
  if (ssCtrl in Shift) and (Key = 79) then
    actInsPattuglia.Execute;
end;

procedure TA139FQuadroRiass.RefreshCellVista(Data:TDateTime;c,r:integer);
var k:Integer;
begin
  with A139FPianifServiziDtm do
  begin
    selT040GetAss.Close;
    selT040GetAss.SetVariable('PROGRESSIVO',Vista[r].Prog);
    selT040GetAss.SetVariable('DATADA',Data);
    selT040GetAss.SetVariable('DATAA',Data);
    selT040GetAss.Open;
    selT502QuadroRiass.Close;
    selT502QuadroRiass.SetVariable('DATADA',Data);
    selT502QuadroRiass.SetVariable('DATAA',Data);
    selT502QuadroRiass.SetVariable('PROGRESSIVO',Vista[r].Prog);
    selT502QuadroRiass.Open;

    Vista[r].Giorni[c].Servizio:=selT502QuadroRiass.FieldByName('SERVIZIO').AsString;
    if selT040GetAss.SearchRecord('DATA',Data,[srFromBeginning]) then
    begin
      SetLength(Vista[r].Giorni[c].Assenze,0);
      repeat
        SetLength(Vista[r].Giorni[c].Assenze,High(Vista[r].Giorni[c].Assenze)+2);
        Vista[r].Giorni[c].Assenze[High(Vista[r].Giorni[c].Assenze)].Dalle:=copy(selT040GetAss.FieldByName('DAORE').AsString,12,10);
        Vista[r].Giorni[c].Assenze[High(Vista[r].Giorni[c].Assenze)].Alle:=copy(selT040GetAss.FieldByName('AORE').AsString,12,10);
        Vista[r].Giorni[c].Assenze[High(Vista[r].Giorni[c].Assenze)].Tipo:=selT040GetAss.FieldByName('TIPOGIUST').AsString;
        Vista[r].Giorni[c].Assenze[High(Vista[r].Giorni[c].Assenze)].Ass:=selT040GetAss.FieldByName('CAUSALE').AsString;
        Vista[r].Giorni[c].Assenze[High(Vista[r].Giorni[c].Assenze)].VAss:=selT040GetAss.FieldByName('VALIDAZIONE').AsString;
      until not selT040GetAss.SearchRecord('DATA',Data,[]);
    end;
    SetLength(Vista[r].Giorni[c].Servizi,0);
    if selT502QuadroRiass.SearchRecord('DATA',Data,[srFromBeginning]) then
      repeat
        SetLength(Vista[r].Giorni[c].Servizi,High(Vista[r].Giorni[c].Servizi)+2);
        Vista[r].Giorni[c].Servizi[High(Vista[r].Giorni[c].Servizi)].Servizio:=selT502QuadroRiass.FieldByName('SERVIZIO').AsString;
        Vista[r].Giorni[c].Servizi[High(Vista[r].Giorni[c].Servizi)].ColoreServ:=selT502QuadroRiass.FieldByName('COLORE').AsString;
        Vista[r].Giorni[c].Servizi[High(Vista[r].Giorni[c].Servizi)].ColoreFont:=selT502QuadroRiass.FieldByName('COLOREFONT').AsString;
        Vista[r].Giorni[c].Servizi[High(Vista[r].Giorni[c].Servizi)].Dalle:=selT502QuadroRiass.FieldByName('DALLE').AsString;
        Vista[r].Giorni[c].Servizi[High(Vista[r].Giorni[c].Servizi)].Alle:=selT502QuadroRiass.FieldByName('ALLE').AsString;
        if 360 > GetNumOre(Vista[r].Giorni[c].Servizi[High(Vista[r].Giorni[c].Servizi)].Dalle,Vista[r].Giorni[c].Servizi[High(Vista[r].Giorni[c].Servizi)].Alle) then
          Vista[r].Giorni[c].VisParziale:=True;
      until not selT502QuadroRiass.SearchRecord('DATA',Data,[]);
    Vista[r].Giorni[c].ColoreServ:=selT502QuadroRiass.FieldByName('COLORE').AsString;
    Vista[r].Giorni[c].ColoreFont:=selT502QuadroRiass.FieldByName('COLOREFONT').AsString;
    Vista[r].Giorni[c].Dalle:=selT502QuadroRiass.FieldByName('DALLE').AsString;
    Vista[r].Giorni[c].Alle:=selT502QuadroRiass.FieldByName('ALLE').AsString;
    if High(Vista[r].Giorni[c].Servizi) >= 0 then
    begin
      GridQuadro.Cells[c+1,r+1]:='';
      for k:=0 to High(Vista[r].Giorni[c].Servizi) do
        if 360 <= GetNumOre(Vista[r].Giorni[c].Servizi[k].Dalle,Vista[r].Giorni[c].Servizi[k].Alle) then
        begin
          if GridQuadro.Cells[c+1,r+1] <> '' then
            GridQuadro.Cells[c+1,r+1]:=GridQuadro.Cells[c+1,r+1] + #13#10;
          GridQuadro.Cells[c+1,r+1]:=GridQuadro.Cells[c+1,r+1] + Vista[r].Giorni[c].Servizi[k].Servizio + '(';
          GridQuadro.Cells[c+1,r+1]:=GridQuadro.Cells[c+1,r+1] + Vista[r].Giorni[c].Servizi[k].Dalle + ')';
        end;
    end;
    GridQuadro.Repaint;
  end;
end;

procedure TA139FQuadroRiass.CaricaVista;
var i,j:integer;
    DataScorr:TDateTime;
begin
  Screen.Cursor:=crHourGlass;
  try
    NumGG:=Trunc(StrToDate(A139FPianifServizi.edtDataa.Text) - StrToDate(A139FPianifServizi.edtDatada.Text)) + 30;
    i:=0;
    SetLength(Vista,C700SelAnagrafe.RecordCount);
    C700SelAnagrafe.First;
    while Not C700SelAnagrafe.Eof do
    begin
      Vista[i].Prog:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      Vista[i].Nominativo:=C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + C700SelAnagrafe.FieldByName('NOME').AsString;
      with A139FPianifServiziDtm do
      begin
        selT040GetAss.Close;
        selT040GetAss.SetVariable('PROGRESSIVO',Vista[i].Prog);
        selT040GetAss.SetVariable('DATADA',StrToDate(A139FPianifServizi.edtDatada.Text)-15);
        selT040GetAss.SetVariable('DATAA',StrToDate(A139FPianifServizi.edtDataa.Text)+15);
        selT040GetAss.Open;
        selT502QuadroRiass.Close;
        selT502QuadroRiass.SetVariable('DATADA',StrToDate(A139FPianifServizi.edtDatada.Text)-15);
        selT502QuadroRiass.SetVariable('DATAA',StrToDate(A139FPianifServizi.edtDataa.Text)+15);
        selT502QuadroRiass.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selT502QuadroRiass.Open;
        SetLength(Vista[i].Giorni,NumGG);
        for j:=0 to NumGG - 1 do
        begin
          Vista[i].Giorni[j].VisParziale:=False;
          DataScorr:=StrToDate(A139FPianifServizi.edtDatada.Text) - 15 + j;
          SetLength(Vista[i].Giorni[j].Assenze,0);
          if selT040GetAss.SearchRecord('DATA',DataScorr,[srFromBeginning]) then
            repeat
              SetLength(Vista[i].Giorni[j].Assenze,High(Vista[i].Giorni[j].Assenze)+2);
              Vista[i].Giorni[j].Assenze[High(Vista[i].Giorni[j].Assenze)].Dalle:=FormatDateTime('hh.mm',selT040GetAss.FieldByName('DAORE').AsDateTime);
              Vista[i].Giorni[j].Assenze[High(Vista[i].Giorni[j].Assenze)].Alle:=FormatDateTime('hh.mm',selT040GetAss.FieldByName('AORE').AsDateTime);
              Vista[i].Giorni[j].Assenze[High(Vista[i].Giorni[j].Assenze)].Tipo:=selT040GetAss.FieldByName('TIPOGIUST').AsString;
              Vista[i].Giorni[j].Assenze[High(Vista[i].Giorni[j].Assenze)].Ass:=selT040GetAss.FieldByName('CAUSALE').AsString;
              Vista[i].Giorni[j].Assenze[High(Vista[i].Giorni[j].Assenze)].VAss:=selT040GetAss.FieldByName('VALIDAZIONE').AsString;
            until not selT040GetAss.SearchRecord('DATA',DataScorr,[]);
          Vista[i].Giorni[j].Servizio:='';
          Vista[i].Giorni[j].ColoreServ:='';
          Vista[i].Giorni[j].ColoreFont:='';
          Vista[i].Giorni[j].DataGG:=DataScorr;
          SetLength(Vista[i].Giorni[j].Servizi,0);
          if selT502QuadroRiass.SearchRecord('DATA',DataScorr,[srFromBeginning]) then
            repeat
              SetLength(Vista[i].Giorni[j].Servizi,High(Vista[i].Giorni[j].Servizi)+2);
              Vista[i].Giorni[j].Servizi[High(Vista[i].Giorni[j].Servizi)].Servizio:=selT502QuadroRiass.FieldByName('SERVIZIO').AsString;
              Vista[i].Giorni[j].Servizi[High(Vista[i].Giorni[j].Servizi)].ColoreServ:=selT502QuadroRiass.FieldByName('COLORE').AsString;
              Vista[i].Giorni[j].Servizi[High(Vista[i].Giorni[j].Servizi)].ColoreFont:=selT502QuadroRiass.FieldByName('COLOREFONT').AsString;
              Vista[i].Giorni[j].Servizi[High(Vista[i].Giorni[j].Servizi)].Dalle:=selT502QuadroRiass.FieldByName('DALLE').AsString;
              Vista[i].Giorni[j].Servizi[High(Vista[i].Giorni[j].Servizi)].Alle:=selT502QuadroRiass.FieldByName('ALLE').AsString;
              if 360 > GetNumOre(Vista[i].Giorni[j].Servizi[High(Vista[i].Giorni[j].Servizi)].Dalle,Vista[i].Giorni[j].Servizi[High(Vista[i].Giorni[j].Servizi)].Alle) then
                Vista[i].Giorni[j].VisParziale:=True;
            until not selT502QuadroRiass.SearchRecord('DATA',DataScorr,[]);
          //Application.ProcessMessages;
        end;
      end;
      inc(i);
      C700SelAnagrafe.Next;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA139FQuadroRiass.ShowGrid;
var i,j,k:integer;
    Str,TStr:String;
begin
  Screen.Cursor:=crHourGlass;
  try
    GridQuadro.Clear;
    GridQuadro.RowCount:=High(Vista) + 2;
    GridQuadro.ColCount:=High(Vista[0].Giorni) + 1;
    i:=0;
    C700SelAnagrafe.First;
    while Not C700SelAnagrafe.Eof do
    begin
      with A139FPianifServiziDtm do
      begin
        selTotAnag.SearchRecord('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,[]);
        GridQuadro.Cells[0,i+1]:=C700SelAnagrafe.FieldByName('COGNOME').AsString + #13#10 + C700SelAnagrafe.FieldByName('NOME').AsString + #13#10;
        GridQuadro.Cells[0,i+1]:=GridQuadro.Cells[0,i+1] + C700SelAnagrafe.FieldByName('MATRICOLA').AsString;
        if Not(selTotAnag.FieldByName('T430V_GIORNALIERO').IsNull and selTotAnag.FieldByName('T430V_FESTIVO').IsNull) then
        GridQuadro.Cells[0,i+1]:=GridQuadro.Cells[0,i+1] + '(' + selTotAnag.FieldByName('T430V_GIORNALIERO').AsString + selTotAnag.FieldByName('T430V_FESTIVO').AsString + ')';
      end;
      for j:=0 to High(Vista[0].Giorni)-1 do
      begin
        //Stampa del servizio
        if High(Vista[i].Giorni[j].Servizi) >= 0 then
        begin
          GridQuadro.Cells[j+1,i+1]:='';
          for k:=0 to High(Vista[i].Giorni[j].Servizi) do
            if 360 <= GetNumOre(Vista[i].Giorni[j].Servizi[k].Dalle,Vista[i].Giorni[j].Servizi[k].Alle) then
            begin
              if GridQuadro.Cells[j+1,i+1] <> '' then
                GridQuadro.Cells[j+1,i+1]:=GridQuadro.Cells[j+1,i+1] + #13#10;
              GridQuadro.Cells[j+1,i+1]:=GridQuadro.Cells[j+1,i+1] + Vista[i].Giorni[j].Servizi[k].Servizio + '(';
              GridQuadro.Cells[j+1,i+1]:=GridQuadro.Cells[j+1,i+1] + Vista[i].Giorni[j].Servizi[k].Dalle + ')';
            end;
        end;
        //Stampa delle assenze
        if High(Vista[i].Giorni[j].Assenze) >= 0 then
        begin
          if (High(Vista[i].Giorni[j].Servizi) >= 0) and
             (GridQuadro.Cells[j+1,i+1] <> '') then
            Str:=#13#10
          else
            Str:='';
          for k:=0 to High(Vista[i].Giorni[j].Assenze) do
          begin
            if (Vista[i].Giorni[j].Assenze[k].Tipo = 'I') or
               (Vista[i].Giorni[j].Assenze[k].Tipo = 'M') then
            begin
              if Length(Str) > 0 then
                Str:=Str + #13#10;
              Str:=Str + Vista[i].Giorni[j].Assenze[k].Ass;
              if Vista[i].Giorni[j].Assenze[k].Tipo = 'I' then
                Str:=Str + '(I)'
              else if Vista[i].Giorni[j].Assenze[k].Tipo = 'M' then
                Str:=Str + '(M)'
              else if Vista[i].Giorni[j].Assenze[K].Tipo = 'N' then
                Str:=Str + '(' + Vista[i].Giorni[j].Assenze[k].Dalle + ')'
              else if Vista[i].Giorni[j].Assenze[K].Tipo = 'D' then
                Str:=Str + '(' + Vista[i].Giorni[j].Assenze[k].Dalle +
                           ' - ' + Vista[i].Giorni[j].Assenze[k].Alle + ')';
            end;
          end;
          GridQuadro.Cells[j+1,i+1]:=GridQuadro.Cells[j+1,i+1] + Str;
        end;
      end;
      C700SelAnagrafe.Next;
      inc(i);
    end;
    for j:=0 to High(Vista[0].Giorni)-1 do
    begin
      GridQuadro.Cells[j+1,0]:=FormatDateTime('dd/mm/yy',DataBase + j);
      TStr:=copy(A139FPianifServiziDtm.GetTipoGiornoServizio(DataBase + j),2,1);
      if TStr <> '' then
        GridQuadro.Cells[j+1,0]:=GridQuadro.Cells[j+1,0] + '-' + TStr;
    end;
    GridQuadro.AutoSizeRows(True,1);
    GridQuadro.AutoSizeColumns(True,1);    
    try
    //Mi posiziono sulla colonna centrale della griglia
      GridQuadro.FocusCell((GridQuadro.ColCount div 2) + 1,1);
    except
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA139FQuadroRiass.GridQuadroDrawCell(Sender: TObject; ACol, ARow: Integer;
Rect: TRect; State: TGridDrawState);
var i,HCell,RL,RB,NumServ:integer;
    Str:String;
    PRect:TRect;
begin
  PRect:=Rect;
  HCell:=GridQuadro.Canvas.TextHeight('A') + 1;
  if (ARow > 0) and (ACol > 0) and
     (High(Vista[ARow - 1].Giorni[ACol - 1].Assenze) >= 0) then
  begin
    NumServ:=StampaServizi(ARow - 1,ACol -1);//Numero di servizi maggiori di 6 ore
    if (Length(Vista[ARow - 1].Giorni[ACol - 1].Servizi) >= 1) and (NumServ > 0) then
      Rect.Top:=Rect.Top + HCell*(NumServ+1);
    Rect.Bottom:=Rect.Top + HCell + 1;
    for i:=0 to High(Vista[ARow - 1].Giorni[ACol - 1].Assenze) do
    begin
      if (Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Tipo = 'I') or
         (Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Tipo = 'M') then
      begin
        Str:=Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Ass;
        if Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Tipo = 'I' then
          Str:=Str + '(I)'
        else if Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Tipo = 'M' then
          Str:=Str + '(M)'
        else if Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Tipo = 'N' then
          Str:=Str + '(' + Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Dalle + ')'
        else if Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Tipo = 'D' then
          Str:=Str + '(' + Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Dalle +
                     ' - ' + Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Alle + ')';

        if Vista[ARow - 1].Giorni[ACol - 1].Assenze[i].Vass = 'S' then
          GridQuadro.Canvas.Brush.Color:=clAqua
        else
          GridQuadro.Canvas.Brush.Color:=clRed;
        if i = 0 then
          GridQuadro.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,Str)
        else
          GridQuadro.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,Str);
        Rect.Top:=Rect.Bottom;
        Rect.Bottom:=Rect.Top + HCell;
      end;
    end;
  end;
  Rect:=PRect;
  if (ARow > 0) and (ACol > 0) and Vista[ARow - 1].Giorni[ACol - 1].VisParziale then
  begin
    Rect.Left:=Rect.Right - 10;
    Rect.Bottom:=Rect.Top + 10;
    GridQuadro.Canvas.Brush.Color:=clBlue;
    GridQuadro.Canvas.FillRect(Rect);
  end;
end;

procedure TA139FQuadroRiass.GridQuadroGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var i:Integer;
    ColoraCella:Boolean;
begin
  if (ARow > 0) and (ACol > 0) and (High(Vista[ARow - 1].Giorni[ACol - 1].Servizi) >= 0) then
  begin
    ColoraCella:=False;
    for i:=0 to High(Vista[ARow - 1].Giorni[ACol - 1].Servizi) do
      if 360 <= GetNumOre(Vista[ARow - 1].Giorni[ACol - 1].Servizi[i].Dalle,Vista[ARow - 1].Giorni[ACol - 1].Servizi[i].Alle) then
      begin
        ColoraCella:=True;
        break;
      end;
    if ColoraCella then
    begin
      ABrush.Color:=StringToColor(Vista[ARow - 1].Giorni[ACol - 1].Servizi[0].ColoreServ);
      AFont.Color:=StringToColor(Vista[ARow - 1].Giorni[ACol - 1].Servizi[0].ColoreFont);
    end;
  end;
  with A139FPianifServizi do
    if (ARow = 0) then
      if Pos('Festivo',getTipoGiorno(DataBase+ACol-1)) > 0  then
        AFont.Color:=clRed;
end;

end.
