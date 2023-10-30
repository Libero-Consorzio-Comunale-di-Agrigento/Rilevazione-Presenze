unit WA126UBloccoRiepiloghiFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWAdvCheckGroup, meTIWAdvCheckGroup,
  WA126UBloccoRiepiloghiDM, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  WR100UBase, C180FunzioniGenerali, A000UInterfaccia,  A000UMessaggi,
  meIWImageFile, medpIWImageButton, IWCompExtCtrls, medpIWMessageDlg, Menus;

type
  TWA126FBloccoRiepiloghiFM = class(TWR200FBaseFM)
    cgpRiepiloghi: TmeTIWAdvCheckGroup;
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAdata: TmeIWEdit;
    imgBloccoRiepiloghi: TmedpIWImageButton;
    imgSbloccoRiepiloghi: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    SelezionaTutto1: TMenuItem;
    DeselezionaTutto1: TMenuItem;
    procedure imgBloccoRiepiloghiClick(Sender: TObject);
    procedure DeselezionaTutto1Click(Sender: TObject);
    procedure SelezionaTutto1Click(Sender: TObject);
  private
    SenderName: String;
    procedure GetParametriFunzione;
    procedure CaricaRiepiloghi(LstRiepiloghiSelezionati: TStringList);
    function CodiceRiepilogo(Item:String):String;
    function GetDataIniziale: TDateTime;
    function GetDataFinale: TDateTime;
    procedure SelezionaRiepiloghi(Val: Boolean);
    procedure ResultConfermaElaborazione(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    Blocco: Boolean;
    function GetRiepiloghiSelezionati: String;
    function GetLstRiepiloghiSelezionati: TStringList;
    procedure CaricaDatiIniziali;
    procedure PutParametriFunzione;
    property DataIniziale:TDateTime read GetDataIniziale;
    property DataFinale:TDateTime read GetDataFinale;
  end;

implementation

uses WA126UBloccoRiepiloghi;

{$R *.dfm}

{ TWA126FBloccoRiepiloghiFM }

procedure TWA126FBloccoRiepiloghiFM.CaricaDatiIniziali;
begin
  GetParametriFunzione;
end;

function TWA126FBloccoRiepiloghiFM.GetDataFinale: TDateTime;
var
  Data:TDateTime;
begin
  if TryStrToDate('01/'+ edtAData.Text,Data) then
    Result:=Data
  else
    Result:=DATE_NULL;
end;

function TWA126FBloccoRiepiloghiFM.GetDataIniziale: TDateTime;
var
  Data:TDateTime;
begin
  if TryStrToDate('01/'+ edtDaData.Text,Data) then
    Result:=Data
  else
    Result:=DATE_NULL;
end;

procedure TWA126FBloccoRiepiloghiFM.GetParametriFunzione;
var
  DaData,
  AData: TDateTime;
  LstRiepiloghiSelezionati:TStringList;
begin
  with (Self.Owner as TWA126FBloccoRiepiloghi),C004DM do
  begin
    if ParDataDa <> '' then //richiamo esterno
      DaData:=StrToDate(ParDataDa)
    else
      DaData:=StrToDate(GetParametro('DADATA',DateToStr(Parametri.DataLavoro)));
    if ParDataA <> '' then //richiamo esterno
      AData:=StrToDate(ParDataA)
    else
      AData:=StrToDate(GetParametro('ADATA',DateToStr(Parametri.DataLavoro)));
    edtDaData.Text:=FormatDateTime('mm/yyyy',DaData);
    edtAData.Text:=FormatDateTime('mm/yyyy',AData);

    LstRiepiloghiSelezionati:=TStringList.Create;
    LstRiepiloghiSelezionati.CommaText:=GetParametro('RIEPILOGHI','');
    CaricaRiepiloghi(LstRiepiloghiSelezionati);
    FreeAndNil(LstRiepiloghiSelezionati);
  end;
end;

function TWA126FBloccoRiepiloghiFM.GetRiepiloghiSelezionati: String;
var
  i: Integer;
  LstRiepiloghiSelezionati: TStringList;
begin
  LstRiepiloghiSelezionati:=TStringList.Create;
  for i:=0 to cgpRiepiloghi.Items.Count - 1 do
    if cgpRiepiloghi.IsChecked[i] then
      LstRiepiloghiSelezionati.add(CodiceRiepilogo(cgpRiepiloghi.Items[i]));
  Result:=LstRiepiloghiSelezionati.CommaText;
  FreeAndNil(LstRiepiloghiSelezionati);
end;

function TWA126FBloccoRiepiloghiFM.GetLstRiepiloghiSelezionati: TStringList;
var
  i: Integer;
begin
  Result:=TStringList.Create;
  for i:=0 to cgpRiepiloghi.Items.Count - 1 do
    if cgpRiepiloghi.IsChecked[i] then
      Result.add(CodiceRiepilogo(cgpRiepiloghi.Items[i]));
end;

procedure TWA126FBloccoRiepiloghiFM.imgBloccoRiepiloghiClick(Sender: TObject);
var
  DataI, DataF: TDateTime;
  Num: Real;
  sNum: String;
  Lst: TStringList;
begin
  inherited;
  if (Self.Owner as TWA126FBloccoRiepiloghi).grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  if not TryStrToDate('01/' + edtDaData.Text,DataI) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['inizio periodo']),mtError,[mbOk],nil,'');
    edtDaData.SetFocus;
    Exit;
  end;

  if not TryStrToDate('01/' + edtAData.Text,DataF) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['fine periodo']),mtError,[mbOk],nil,'');
    edtAData.SetFocus;
    Exit;
  end;

  if DataI > DataF then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    Exit;
  end;

  if GetRiepiloghiSelezionati = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_A126_ERR_NO_RIEPILOGO,mtError,[mbOk],nil,'');
    Exit;
  end;

  //Calcolo del numero di records da elaborare
  Lst:=GetLstRiepiloghiSelezionati;
  Num:=Lst.Count;
  FreeAndNil(Lst);

  with (Self.Owner as TWA126FBloccoRiepiloghi).grdC700 do
  begin
    if WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(DataI),R180FineMese(DataF)) then
      SelAnagrafe.Close;
    SelAnagrafe.Open;
    (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.DaData:=DataI;
    (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.AData:=DataF;
    SelAnagrafe.OnFilterRecord:=(WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.SelAnagrafeFilterRecord;
    SelAnagrafe.Filtered:=True;
    Num:=Num * SelAnagrafe.RecordCount;
    SNum:=Format('%n',[Num]);
    SNum:=Copy(SNum,1,Pos({$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,SNum) - 1);
    SelAnagrafe.OnFilterRecord:=nil;
  end;

  SenderName:=(Sender as TmedpIWImageButton).HTMLName;

  if Sender = imgBloccoRiepiloghi then
  begin
    Blocco:=True;
    MsgBox.WebMessageDlg(Format(A000MSG_A126_DLG_FMT_BLOCCO,[SNum]),mtConfirmation,[mbYes,mbNo],ResultConfermaElaborazione,'');
  end
  else
  begin
    Blocco:=False;
    MsgBox.WebMessageDlg(Format(A000MSG_A126_DLG_FMT_SBLOCCO,[SNum]),mtConfirmation,[mbYes,mbNo],ResultConfermaElaborazione,'');
  end;
end;

procedure TWA126FBloccoRiepiloghiFM.PutParametriFunzione;
var
  Data: TDateTime;
begin
  with (Self.Owner as TWR100FBase).C004DM do
  begin
    Cancella001;
    if TryStrToDate('01/' + edtDaData.Text,Data) then
      PutParametro('DADATA',DateToStr(Data));

    if TryStrToDate('01/' + edtAData.Text,Data) then
      PutParametro('ADATA',DateToStr(Data));

    PutParametro('RIEPILOGHI',GetRiepiloghiSelezionati);
    try SessioneOracle.Commit; except end;
  end;
end;

procedure TWA126FBloccoRiepiloghiFM.CaricaRiepiloghi(LstRiepiloghiSelezionati: TStringList);
var
  LstRiepilogo: TStringList;
  i, idx: Integer;
begin
 with (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW do
 begin
  LstRiepilogo:=getLstRiepiloghi;
  for i:=0 to LstRiepilogo.Count - 1 do
  begin
    idx:=cgpRiepiloghi.Items.Add(LstRiepilogo[i]);
    if LstRiepiloghiSelezionati.IndexOf(CodiceRiepilogo(LstRiepilogo[i])) >=0 then
      cgpRiepiloghi.IsChecked[idx]:=True;
  end;
  FreeAndNil(LstRiepilogo);
 end;
end;

function TWA126FBloccoRiepiloghiFM.CodiceRiepilogo(Item: String): String;
begin
  Result:=Trim(Copy(Item,1,5));
end;

procedure TWA126FBloccoRiepiloghiFM.DeselezionaTutto1Click(Sender: TObject);
begin
  inherited;
  SelezionaRiepiloghi(False);
end;

procedure TWA126FBloccoRiepiloghiFM.ResultConfermaElaborazione(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
   (Self.Owner as TWR100FBase).StartElaborazioneCiclo(SenderName);
end;

procedure TWA126FBloccoRiepiloghiFM.SelezionaRiepiloghi(Val: Boolean);
var
  i: Integer;
begin
  for i:=0 to cgpRiepiloghi.Items.Count - 1 do
    cgpRiepiloghi.IsChecked[i]:=Val;
end;

procedure TWA126FBloccoRiepiloghiFM.SelezionaTutto1Click(Sender: TObject);
begin
  inherited;
  SelezionaRiepiloghi(True);
end;

end.
