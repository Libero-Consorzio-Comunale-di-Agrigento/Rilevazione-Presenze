unit WC013UCheckListFM;

interface

uses
  WR010UBase, WR200UBaseFM, A000UMessaggi, A000UInterfaccia,
  SysUtils, Classes, Controls, Forms,
  meIWButton, medpIWMessageDlg,
  IWAdvCheckGroup, meTIWAdvCheckGroup,
  meIWImageFile, Menus, IWCompExtCtrls, IWControl, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWCompButton, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion;

type
  TWC013ModalResultEvents = procedure(Sender: TObject; Result: Boolean) of object;

  TWC013FCheckListFM = class(TWR200FBaseFM)
    btnOk: TmeIWButton;
    btnAnnulla: TmeIWButton;
    ckList: TmeTIWAdvCheckGroup;
    imgDeselezionaTutto: TmeIWImageFile;
    imgInvertiSelezione: TmeIWImageFile;
    imgSelezionaTutto: TmeIWImageFile;
    pmnWC013Azioni: TPopupMenu;
    SelezionatuttoWC013: TMenuItem;
    DeselezionatuttoWC013: TMenuItem;
    InvertiselezioneWC013: TMenuItem;
    procedure btnClick(Sender: TObject);
    procedure imgSelezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgDeselezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgInvertiSelezioneAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure DeselezionatuttoWC013Click(Sender: TObject);
    procedure SelezionatuttoWC013Click(Sender: TObject);
    procedure InvertiselezioneWC013Click(Sender: TObject);
  public
    MinElem: Integer;
    MaxElem: Integer;
    ResultEvent: TWC013ModalResultEvents;
    procedure Visualizza(const MinElementi:Integer = 0;const MaxElementi:Integer = 0;const Titolo:String= 'Filtro dati');
    procedure ReleaseOggetti; override;
    procedure CaricaLista(lstItems, lstValues: TstringList); overload;
    procedure ImpostaValoriSelezionati(lstSelected:TStringList);
    function LeggiValoriSelezionati:TStringList;
    function LeggiValoriDeselezionati: TStringList;
  end;

implementation

{$R *.dfm}

procedure TWC013FCheckListFM.Visualizza(const MinElementi:Integer = 0;const MaxElementi:Integer = 0;const Titolo:String= 'Filtro dati');
begin
  MinElem:=MinElementi;
  MaxElem:=MaxElementi;
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,Self.Width + 35,-1,Self.Height + 35, Titolo,'#wc013_container',False,True);
end;

procedure TWC013FCheckListFM.btnClick(Sender: TObject);
var
  Result:Boolean;
  i, conta: Integer;
begin
  (Self.Parent as TWR010FBase).ActiveControl:=nil;

  if Sender = btnOk then
  begin
    Result:=True;
    conta:=0;
    for i:=0 to ckList.Items.Count - 1 do
    begin
      if ckList.IsChecked[i] then
      begin
        conta:=conta + 1;
        // verifica limite superiore
        if (MaxElem > 0) and (conta > MaxElem) then
        begin
          MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_TROPPI_ELEM_SEL,[IntToStr(MaxElem)]),mtWarning,[mbOK],nil,'');
          Exit;
        end;
      end;
    end;

    // verifica limite inferiore
    if conta < MinElem then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_POCHI_ELEM_SEL,[IntToStr(MinElem)]),mtWarning,[mbOK],nil,'');
      Exit;
    end;
  end
  else     //btnAnnulla
    Result:=False;

  try
    if Assigned(ResultEvent) then
    begin
      try
        ResultEvent(Self,Result);
      except
        on E: EAbort do;
        on E: Exception do
          raise;
      end;
    end;
  finally
    ReleaseOggetti;
    Free;
  end;
end;

procedure TWC013FCheckListFM.CaricaLista(lstItems, lstValues: TstringList);
var
  i: Integer;
begin
  ckList.Items.Clear;
  ckList.Values.Clear;

  ckList.Items.AddStrings(lstItems);
  ckList.Values.AddStrings(lstValues);
  for i:=0 to ckList.Items.Count do
   ckList.IsEnabled[i]:=True;
end;

procedure TWC013FCheckListFM.DeselezionatuttoWC013Click(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to ckList.Items.Count - 1 do
  begin
    // bugfix.ini
    if ckList.IsEnabled[i] then
    // bugfix.fine
      ckList.IsChecked[i]:=False;
  end;
  ckList.AsyncUpdate;
end;

procedure TWC013FCheckListFM.imgDeselezionaTuttoAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i:Integer;
begin
  for i:=0 to ckList.Items.Count - 1 do
  begin
    // bugfix.ini
    if ckList.IsEnabled[i] then
    // bugfix.fine
      ckList.IsChecked[i]:=False;
  end;
  ckList.AsyncUpdate;
end;

procedure TWC013FCheckListFM.imgInvertiSelezioneAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to ckList.Items.Count - 1 do
  begin
    // bugfix.ini
    if ckList.IsEnabled[i] then
    // bugfix.fine
      ckList.IsChecked[i]:=not ckList.IsChecked[i];
  end;
  ckList.AsyncUpdate;
end;

procedure TWC013FCheckListFM.imgSelezionaTuttoAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
 i:Integer;
begin
  for i:=0 to ckList.Items.Count - 1 do
  begin
    // bugfix.ini
    if ckList.IsEnabled[i] then
    // bugfix.fine
      ckList.IsChecked[i]:=True;
  end;
  ckList.AsyncUpdate;
end;

procedure TWC013FCheckListFM.ImpostaValoriSelezionati(lstSelected: TStringList);
var
  i, idx : Integer;
begin
  for i:=0 to ckList.Items.Count - 1 do
  begin
    // bugfix.ini
    if ckList.IsEnabled[i] then
    // bugfix.fine
      ckList.IsChecked[i]:=False;
  end;

  for i:=0 to lstSelected.Count - 1 do
  begin
    idx:=ckList.Values.IndexOf(lstSelected[i]);
    // bugfix.ini
    //if idx >= 0 then
    if (idx >= 0) and (ckList.IsEnabled[idx]) then
    // bugfix.fine
      ckList.IsChecked[idx]:=True;
  end;
end;

function TWC013FCheckListFM.LeggiValoriSelezionati: TStringList;
var
  i: Integer;
begin
  Result:=TStringList.Create;
  Result.StrictDelimiter:=True;
  for i:=0 to ckList.Items.Count - 1 do
  begin
    if ckList.IsChecked[i] then
      if ckList.Values[i] <> '' then  //necessario per elementi fittizi senza codice
        Result.add(ckList.Values[i]);
  end;
end;

function TWC013FCheckListFM.LeggiValoriDeselezionati: TStringList;
var
  i: Integer;
begin
  Result:=TStringList.Create;
  Result.StrictDelimiter:=True;
  for i:=0 to ckList.Items.Count - 1 do
  begin
    if not ckList.IsChecked[i] then
      if ckList.Values[i] <> '' then  //necessario per elementi fittizi senza codice
        Result.add(ckList.Values[i]);
  end;
end;

procedure TWC013FCheckListFM.InvertiselezioneWC013Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to ckList.Items.Count - 1 do
  begin
    // bugfix.ini
    if ckList.IsEnabled[i] then
    // bugfix.fine
      ckList.IsChecked[i]:=not ckList.IsChecked[i];
  end;
  ckList.AsyncUpdate;
end;

procedure TWC013FCheckListFM.ReleaseOggetti;
begin
  //
end;

procedure TWC013FCheckListFM.SelezionatuttoWC013Click(Sender: TObject);
var
 i:Integer;
begin
  inherited;
  for i:=0 to ckList.Items.Count - 1 do
  begin
    // bugfix.ini
    if ckList.IsEnabled[i] then
    // bugfix.fine
      ckList.IsChecked[i]:=True;
  end;
  ckList.AsyncUpdate;
end;

end.
