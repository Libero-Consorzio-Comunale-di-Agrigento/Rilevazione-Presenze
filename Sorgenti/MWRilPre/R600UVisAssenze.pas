unit R600UVisAssenze;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Math, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Buttons, Variants, C180FunzioniGenerali, Menus,
  A000UInterfaccia, Oracle, C004UParamForm, StrUtils;

type
  TR600FVisAssenze = class(TForm)
    Panel2: TPanel;
    LNome: TLabel;
    LMatricola: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    LCausale: TLabel;
    Label7: TLabel;
    lblPeriodoCumulo: TLabel;
    lblFamRif: TLabel;
    lblDataFamRif: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    StampaVideata1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label3: TLabel;
    lblNumeroFruizioni: TLabel;
    GroupBox1: TGroupBox;
    lblPartTime: TLabel;
    LFruizMinima: TLabel;
    lblFruizMinimaTitolo: TLabel;
    memoPartTime: TMemo;
    pnlLeft: TPanel;
    pnlTop: TPanel;
    Label2: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label10: TLabel;
    LDecurtazione: TLabel;
    LAbilAnagr: TLabel;
    LPartTime: TLabel;
    LCompSoloFerie: TLabel;
    LCompArrotondata: TLabel;
    LPeriodiRapporto: TLabel;
    LCompTotale: TLabel;
    pnlCumuloF: TPanel;
    lblDescFruizMMInteri: TLabel;
    lblFruizMMInteri: TLabel;
    lblDescMaxIndividuale: TLabel;
    lblMaxIndividuale: TLabel;
    lblDescFruizMMContinuativi: TLabel;
    lblFruizMMContinuativi: TLabel;
    pnlCompFinali: TPanel;
    LCompFinale: TLabel;
    Label12: TLabel;
    lblDescGGNoLavVuoti: TLabel;
    lblGGNoLavVuoti: TLabel;
    grdSintetica: TStringGrid;
    Grid1: TStringGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    btnAssCumulate: TBitBtn;
    btnPeriodiCumulati: TBitBtn;
    btnCambiaFineCumulo: TBitBtn;
    rgpTipoRiepilogo: TRadioGroup;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Grid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure grdSinteticaDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StampaVideata1Click(Sender: TObject);
    procedure rgpTipoRiepilogoClick(Sender: TObject);
    procedure btnCambiaFineCumuloClick(Sender: TObject);
    procedure btnAssCumulateClick(Sender: TObject);
    procedure btnPeriodiCumulatiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    HeightIni,hGroupBox1,hGrdSintetica:Integer;
    C004FParamFormR600VisAssenze: TC004FParamForm;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure VisualizzaComponenti;
  public
    SessioneOracleR600VisAssenze:TOracleSession;
    UnitaMisura: String;
    TCumulo: Char;
    SwitchFineCumulo: Boolean;
  end;

var
  R600FVisAssenze: TR600FVisAssenze;

implementation

uses R600UVisAssenzeCumulate;

{$R *.DFM}

procedure TR600FVisAssenze.FormCreate(Sender: TObject);
begin
  HeightIni:=Self.Height;//553
  hGroupBox1:=GroupBox1.Height;//195
  hGrdSintetica:=grdSintetica.Height;//64
  //18/07/2017 Danilo A.: NON SPOSTARE LE GRIGLIE A DESIGN PERCHE' ALTRIMENTI NON FUNZIONANO LE PROPRIETA' ALIGN A RUNTIME!!!!!
end;

procedure TR600FVisAssenze.FormShow(Sender: TObject);
begin
  SwitchFineCumulo:=False;

  with Grid1 do
  begin
    ColWidths[0]:=127;
    if UnitaMisura = 'G' then
      Cells[0,0]:='U.M.: Giorni'
    else
      Cells[0,0]:='U.M.: Ore';
    Cells[1,0]:='1°fascia';
    Cells[2,0]:='2°fascia';
    Cells[3,0]:='3°fascia';
    Cells[4,0]:='4°fascia';
    Cells[5,0]:='5°fascia';
    Cells[6,0]:='6°fascia';
    Cells[7,0]:='Totali';
    Cells[8,0]:='Totali(G)';
    Cells[0,1]:='Comp. precedente';
    Cells[0,2]:='Comp. corrente';
    Cells[0,3]:='Fruito precedente';
    Cells[0,4]:='Fruito corrente';
    Cells[0,5]:='Residuo precedente';   //Lorena 29/12/2005
    Cells[0,6]:='Residuo corrente';     //Lorena 29/12/2005
    Cells[0,7]:='Residuo totale';       //Lorena 29/12/2005
    Cells[0,8]:='Comp. parziali';
    Cells[0,9]:='Residuo parziale';
  end;
  with grdSintetica do
  begin
    Cells[1,0]:='Comp. prec.';
    Cells[2,0]:='Comp. corr.';
    Cells[3,0]:='Fruito prec.';
    Cells[4,0]:='Fruito corr.';
    Cells[5,0]:='Residuo prec.';
    Cells[6,0]:='Residuo corr.';
    Cells[7,0]:='Residuo tot.';
    if UnitaMisura = 'G' then
      Cells[0,1]:='Giorni'
    else
      Cells[0,1]:='Ore';
    Cells[1,1]:=Grid1.Cells[7,1];
    Cells[2,1]:=Grid1.Cells[7,2];
    Cells[3,1]:=Grid1.Cells[7,3];
    Cells[4,1]:=Grid1.Cells[7,4];
    Cells[5,1]:=Grid1.Cells[7,5];
    Cells[6,1]:=Grid1.Cells[7,6];
    Cells[7,1]:=Grid1.Cells[7,7];
    ColWidths[0]:=42;
    ColWidths[1]:=IfThen(Grid1.RowHeights[1] = 0,0,DefaultColWidth);
    ColWidths[2]:=IfThen(Grid1.RowHeights[2] = 0,0,DefaultColWidth);
    ColWidths[3]:=IfThen(Grid1.RowHeights[3] = 0,0,DefaultColWidth);
    ColWidths[4]:=IfThen(Grid1.RowHeights[4] = 0,0,DefaultColWidth);
    ColWidths[5]:=IfThen(Grid1.RowHeights[5] = 0,0,DefaultColWidth);
    ColWidths[6]:=IfThen(Grid1.RowHeights[6] = 0,0,DefaultColWidth);
    ColWidths[7]:=IfThen(Grid1.RowHeights[7] = 0,0,DefaultColWidth);
  end;

  C004FParamFormR600VisAssenze:=CreaC004(SessioneOracleR600VisAssenze,'R600',Parametri.ProgOper,False);
  GetParametriFunzione;
  VisualizzaComponenti;
end;

procedure TR600FVisAssenze.GetParametriFunzione;
begin
  rgpTipoRiepilogo.ItemIndex:=IfThen(C004FParamFormR600VisAssenze.GetParametro('rgpTipoRiepilogo','D') = 'S',0,1);
end;

procedure TR600FVisAssenze.PutParametriFunzione;
begin
  C004FParamFormR600VisAssenze.Cancella001;
  C004FParamFormR600VisAssenze.PutParametro('rgpTipoRiepilogo',IfThen(rgpTipoRiepilogo.ItemIndex = 0,'S','D'));
  try SessioneOracle.Commit; except end;
end;

procedure TR600FVisAssenze.Grid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var s: String;
begin
  if (ARow = 0) or (ACol = 0) or (ACol = 7) or (ACol = 8) then
  begin
    s:=Grid1.Cells[ACol,ARow];
    if (ACol = 0) or (ACol = 7) or (ACol = 8) then
      Grid1.Canvas.Font.Style:=[fsBold];//In debug la renderizzazione è pessima, ma nel progetto completo è OK
    if (ARow = 0) or (ACol = 0) then
      Grid1.Canvas.Font.Color:=clBlue;
    Grid1.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  end;
  //Se Fruito A.C. < Fruiz.Anno Minima allora coloro in blu la riga del Fruito A.C.
  if ARow = 4 then  //Riga Fruito A.C.
  begin
    if Pos('.',LFruizMinima.Caption) > 0 then  //Ore
    begin
      if R180OreMinutiExt(Grid1.Cells[7,4]) < R180OreMinutiExt(LFruizMinima.Caption) then
      begin
        s:=Grid1.Cells[ACol,ARow];
        Grid1.Canvas.Font.Color:=clBlue;
        Grid1.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
      end;
    end
    else  //Giorni
    begin
      if StrToFloatDef(Grid1.Cells[7,4],0) < StrToFloatDef(LFruizMinima.Caption,0) then
      begin
        s:=Grid1.Cells[ACol,ARow];
        Grid1.Canvas.Font.Color:=clBlue;
        Grid1.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
      end;
    end;
  end;
  //Se Negativo allora coloro in rosso la cella
  if Pos('-',Grid1.Cells[ACol,ARow]) > 0 then
  begin
    s:=Grid1.Cells[ACol,ARow];
    Grid1.Canvas.Font.Color:=clRed;
    Grid1.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  end;
end;

procedure TR600FVisAssenze.grdSinteticaDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var s: String;
begin
  if (ARow = 0) or (ACol = 0) then
  begin
    s:=grdSintetica.Cells[ACol,ARow];
    grdSintetica.Canvas.Font.Color:=clBlue;
    grdSintetica.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  end;
  //Se Fruito A.C. < Fruiz.Anno Minima allora coloro in blu la cella del Fruito A.C.
  if (ARow = 1) and (ACol = 4) then  //Cella Fruito A.C.
  begin
    if Pos('.',LFruizMinima.Caption) > 0 then  //Ore
    begin
      if R180OreMinutiExt(grdSintetica.Cells[4,1]) < R180OreMinutiExt(LFruizMinima.Caption) then
      begin
        s:=grdSintetica.Cells[ACol,ARow];
        grdSintetica.Canvas.Font.Color:=clBlue;
        grdSintetica.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
      end;
    end
    else  //Giorni
    begin
      if StrToFloatDef(grdSintetica.Cells[4,1],0) < StrToFloatDef(LFruizMinima.Caption,0) then
      begin
        s:=grdSintetica.Cells[ACol,ARow];
        grdSintetica.Canvas.Font.Color:=clBlue;
        grdSintetica.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
      end;
    end;
  end;
  //Se Negativo allora coloro in rosso la cella
  if Pos('-',grdSintetica.Cells[ACol,ARow]) > 0 then
  begin
    s:=grdSintetica.Cells[ACol,ARow];
    grdSintetica.Canvas.Font.Color:=clRed;
    grdSintetica.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  end;
end;

procedure TR600FVisAssenze.StampaVideata1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Self.Print;
end;

procedure TR600FVisAssenze.rgpTipoRiepilogoClick(Sender: TObject);
begin
  VisualizzaComponenti;
end;

procedure TR600FVisAssenze.btnCambiaFineCumuloClick(Sender: TObject);
begin
  SwitchFineCumulo:=True;
  Close;
end;

procedure TR600FVisAssenze.btnAssCumulateClick(Sender: TObject);
begin
  R600FVisAssenzeCumulate.Show;
end;

procedure TR600FVisAssenze.btnPeriodiCumulatiClick(Sender: TObject);
begin
  R600FVisPeriodiCumulati.Show;
end;

procedure TR600FVisAssenze.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  FreeAndNil(C004FParamFormR600VisAssenze);
end;

procedure TR600FVisAssenze.VisualizzaComponenti;
begin
  pnlCumuloF.Visible:=TCumulo = 'F';
  GroupBox1.Visible:=rgpTipoRiepilogo.ItemIndex <> 0;
  Grid1.Visible:=rgpTipoRiepilogo.ItemIndex <> 0;
  grdSintetica.Visible:=rgpTipoRiepilogo.ItemIndex = 0;
  Self.Height:=HeightIni - IfThen(rgpTipoRiepilogo.ItemIndex = 0,
                                  hGroupBox1 + Grid1.Height - hGrdSintetica,
                                  IfThen(pnlCumuloF.Visible,0,pnlCumuloF.Height));
  if rgpTipoRiepilogo.ItemIndex = 0 then
  begin
    GroupBox1.Align:=alNone;
    Grid1.Align:=alNone;
    grdSintetica.Align:=alClient;
    ActiveControl:=grdSintetica;
  end
  else
  begin
    grdSintetica.Align:=alNone;
    Grid1.Align:=alBottom;
    GroupBox1.Align:=alClient;
    ActiveControl:=Grid1;
  end;
  //Dopo il ridimensionamento della form mantengo il posizionamento centrale rispetto allo schermo
  //La proprietà Position non può essere impostata a runtime, altrimenti crea problemi
  //Il valore poScreenCenter punta a WorkAreaWidth e WorkAreaHeight (cioè le dimensioni dello schermo al netto della barra delle applicazioni)
  //Il valore poDesktopCenter punta a Width(/DesktopWidth) e Height(/DesktopHeight) (cioè le dimensioni effettive dello schermo)
  Self.Left:=(Screen.Width - Self.Width) div 2;
  Self.Top:=(Screen.Height - Self.Height) div 2;
end;

end.
