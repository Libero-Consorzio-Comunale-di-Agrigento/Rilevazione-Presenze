unit WA081UTimbCaus;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, Menus, meIWImageFile, medpIWImageButton, IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit, IWAdvCheckGroup, meTIWAdvCheckGroup, IWCompLabel, meIWLabel, medpIWMultiColumnComboBox,
  A000UInterfaccia, A081UTimbCausMW, C180FunzioniGenerali, C190FunzioniGeneraliWeb, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} IWCompListbox, meIWComboBox, DB, DBClient, MConnect,
  A000UCostanti, ActiveX;

type
  TWA081FTimbCaus = class(TWR100FBase)
    lblListaCausali: TmeIWLabel;
    CgpListaCausali: TmeTIWAdvCheckGroup;
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    chkStampaDett: TmeIWCheckBox;
    chkSaltoRaggr: TmeIWCheckBox;
    btnGeneraPDF: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    chkTotData: TmeIWCheckBox;
    chkTotGenerale: TmeIWCheckBox;
    chkTotCaus: TmeIWCheckBox;
    chkTotRaggr: TmeIWCheckBox;
    chkSaltoCaus: TmeIWCheckBox;
    lblCampoRaggr: TmeIWLabel;
    cmbCampoRaggr: TmeIWComboBox;
    DCOMConnection: TDCOMConnection;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
  private
    A081MW: TA081FTimbCausMW;
    DaData,AData:TDateTime;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaborazioneServer; override;
    function CreateJSonString: String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA081FTimbCaus.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGestioneC700;
  A081MW:=TA081FTimbCausMW.Create(Self);

  DaData:=R180InizioMese(Parametri.DataLavoro);
  AData:=R180FineMese(Parametri.DataLavoro);
  edtDaData.Text:=DateToStr(DaData);
  edtAData.Text:=DateToStr(AData);

  CgpListaCausali.Items.Clear;
  with A081MW.Q305 do
  begin
    First;
    while not Eof do
    begin
      CgpListaCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  with A081MW.selI010 do
  begin
    First;
    while not Eof do
    begin
      cmbCampoRaggr.Items.add(FieldByName('NOME_LOGICO').AsString +'=' +
                                  FieldByName('NOME_CAMPO').AsString);
      Next;
    end;
    cmbCampoRaggr.ItemIndex:=0;
  end;

  GetParametriFunzione;
end;

procedure TWA081FTimbCaus.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA081FTimbCaus.btnGeneraPDFClick(Sender: TObject);
begin
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA081FTimbCaus.ElaborazioneServer;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA081(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
  end;
end;

function TWA081FTimbCaus.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaData,json);
    C190Comp2JsonString(edtAData,json);

    C190Comp2JsonString(chkTotGenerale,json);
    C190Comp2JsonString(chkTotRaggr,json);
    C190Comp2JsonString(chkTotCaus,json);
    C190Comp2JsonString(chkTotData,json);
    C190Comp2JsonString(chkStampaDett,json);
    C190Comp2JsonString(chkSaltoRaggr,json);
    C190Comp2JsonString(chkSaltoCaus,json);

    json.AddPair('CgpListaCausali',TJSONString.Create(C190GetCheckList(5,CgpListaCausali)));
    C190Comp2JsonString(cmbCampoRaggr,json,'dcmbCampoRaggr');

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA081FTimbCaus.Deselezionatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CgpListaCausali.Items.Count - 1 do
    CgpListaCausali.IsChecked[i]:=False;
  CgpListaCausali.AsyncUpdate;
end;

procedure TWA081FTimbCaus.GetParametriFunzione;
{Leggo i parametri della form}
var x, y, i,r:integer;
    e: boolean;
    svalore, snome, selemento:string;
begin
  chkTotData.Checked:= C004DM.GetParametro('TOTDATA','N') = 'S';
  chkTotRaggr.Checked:= C004DM.GetParametro('TOTGRUPPO','N') = 'S';
  chkTotCaus.Checked:= C004DM.GetParametro('TOTCAUSALI','N') = 'S';
  chkSaltoCaus.Checked:= C004DM.GetParametro('SALTOPAGINACAUSALI','N') = 'S';
  chkSaltoRaggr.Checked:= C004DM.GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
  chkTotGenerale.Checked:= C004DM.GetParametro('TOTGENERALI','N') = 'S';
  chkStampaDett.Checked:= C004DM.GetParametro('DETTAGLIO','S') = 'S';
  cmbCampoRaggr.ItemIndex:=StrToInt(C004DM.GetParametro('CAMPORAGGRUPPA','0'));
  cmbCampoRaggr.ItemIndex:=StrToInt(ifThen(cmbCampoRaggr.ItemIndex>-1,IntToStr(cmbCampoRaggr.ItemIndex),'0'));
  // lettura causali selezionate
  x:=0; //contatore di paramento
  snome:='LISTACAUSALI';
  repeat
  // ciclo sui parametri LISTACAUSALI0,LISTACAUSALI1,ecc.
    svalore:=C004DM.GetParametro(snome+IntToStr(x),'');
    y:=0; // contatore di elementi nel parametro
    if svalore<>'' then
      begin
      repeat
      // ciclo sugli elementi nel parametro max 16 per parametro
        selemento:=Copy(svalore,(y*5)+1,5);
        if selemento<>'' then
          begin
          i:=0;
          e:=true;
          r:=CgpListaCausali.Items.Count;
          while (i<r) and (e) do
            begin
            if Copy(CgpListaCausali.Items[i],1,5)=selemento then
               begin
               CgpListaCausali.IsChecked[i]:=true;
               e:=false;
               end
            else
               if Copy(CgpListaCausali.Items[i],1,5)>selemento then
                  e:=false;
            inc(i);
            end;
          inc(y);
          end;
      until selemento ='';
      inc(x);
    end;
  until svalore ='';
end;

procedure TWA081FTimbCaus.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y,r:integer;
    svalore,snome:string;
begin
  C004DM.Cancella001;
  if chkTotData.Checked then
    C004DM.PutParametro('TOTDATA','S')
  else
    C004DM.PutParametro('TOTDATA','N');
  if chkTotRaggr.Checked then
    C004DM.PutParametro('TOTGRUPPO','S')
  else
    C004DM.PutParametro('TOTGRUPPO','N');
  if chkTotCaus.Checked then
    C004DM.PutParametro('TOTCAUSALI','S')
  else
    C004DM.PutParametro('TOTCAUSALI','N');
  if chkSaltoCaus.Checked then
    C004DM.PutParametro('SALTOPAGINACAUSALI','S')
  else
    C004DM.PutParametro('SALTOPAGINACAUSALI','N');
  if chkSaltoRaggr.Checked then
    C004DM.PutParametro('SALTOPAGINAGRUPPO','S')
  else
    C004DM.PutParametro('SALTOPAGINAGRUPPO','N');
  if chkTotGenerale.Checked then
    C004DM.PutParametro('TOTGENERALI','S')
  else
    C004DM.PutParametro('TOTGENERALI','N');
  if chkStampaDett.Checked then
    C004DM.PutParametro('DETTAGLIO','S')
  else
    C004DM.PutParametro('DETTAGLIO','N');
  C004DM.PutParametro('CAMPORAGGRUPPA',VarToStr(cmbCampoRaggr.ItemIndex));
  // salvo l'elenco delle causali selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTACAUSALI';
  r:=CgpListaCausali.Items.Count;
  For i:=1 to r do
  begin
   if CgpListaCausali.IsChecked[i-1] then
   begin
     svalore:=svalore+Copy(CgpListaCausali.Items[i-1],1,5);
     inc(y);
     if y=16 then
      begin
        C004DM.PutParametro(snome+IntToStr(x),svalore);
        inc(x);
        y:=0;
        svalore:='';
      end;
   end;
  end;
  C004DM.PutParametro(snome+IntToStr(x),svalore);
  try SessioneOracle.Commit; except end;
end;


procedure TWA081FTimbCaus.Selezionatutto1Click(Sender: TObject);
var
 i:Integer;
begin
  inherited;
  for i:=0 to CgpListaCausali.Items.Count - 1 do
    CgpListaCausali.IsChecked[i]:=True;
  CgpListaCausali.AsyncUpdate;
end;

procedure TWA081FTimbCaus.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CgpListaCausali.Items.Count - 1 do
    CgpListaCausali.IsChecked[i]:=not CgpListaCausali.IsChecked[i];
  CgpListaCausali.AsyncUpdate;
end;

end.
