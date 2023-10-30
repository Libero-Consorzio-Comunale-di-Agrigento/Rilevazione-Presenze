unit WA090UAssenzeAnno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompCheckbox, meIWCheckBox, Menus, IWAdvCheckGroup, meTIWAdvCheckGroup,
  A090UAssenzeAnnoMW, A000UInterfaccia, C180FunzioniGenerali, DB, DBClient, MConnect, C190FunzioniGeneraliWeb,
  A000UCostanti, ActiveX, StrUtils, IWAdvRadioGroup, IWDBAdvRadioGroup, meTIWAdvRadioGroup;

type
  TWA090FAssenzeAnno = class(TWR100FBase)
    btnGeneraPDF: TmedpIWImageButton;
    lblSelPeriodo: TmeIWLabel;
    lblDaAnno: TmeIWLabel;
    edtDaAnno: TmeIWEdit;
    lblDaMese: TmeIWLabel;
    edtDaMese: TmeIWEdit;
    edtAMese: TmeIWEdit;
    lblAMese: TmeIWLabel;
    lblOpzioniStampa: TmeIWLabel;
    chkSegnalazPresenza: TmeIWCheckBox;
    edtCaratteri: TmeIWEdit;
    lblCaratteri: TmeIWLabel;
    chkSecCausaleAss: TmeIWCheckBox;
    chkRigaValoriz: TmeIWCheckBox;
    chkTotIndiv: TmeIWCheckBox;
    chkSaltoPag: TmeIWCheckBox;
    chkStampaAllDip: TmeIWCheckBox;
    chkGGSett: TmeIWCheckBox;
    chkIntestazione: TmeIWCheckBox;
    chkData: TmeIWCheckBox;
    chkNumPagina: TmeIWCheckBox;
    chkAzienda: TmeIWCheckBox;
    lblTitolo: TmeIWLabel;
    edtTitolo: TmeIWEdit;
    CgpListaAnagr: TmeTIWAdvCheckGroup;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    lblListaAnagr: TmeIWLabel;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    lblListaCausali: TmeIWLabel;
    CgpListaCausali: TmeTIWAdvCheckGroup;
    DCOMConnection: TDCOMConnection;
    lblLogo: TmeIWLabel;
    lblLarghezza: TmeIWLabel;
    edtLogoLarghezza: TmeIWEdit;
    lblAltezza: TmeIWLabel;
    edtLogoAltezza: TmeIWEdit;
    chkRiepilogoCompetenze: TmeIWCheckBox;
    lblFirma: TmeIWLabel;
    edtFirma: TmeIWEdit;
    rgpRichiesteIrisWEB: TmeTIWAdvRadioGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Deselezionatutto2Click(Sender: TObject);
    procedure Invertiselezione2Click(Sender: TObject);
    procedure Selezionatutto2Click(Sender: TObject);
    procedure chkSegnalazPresenzaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkIntestazioneAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure edtLogoLarghezzaAsyncExit(Sender: TObject;
      EventParams: TStringList);
    procedure edtLogoAltezzaAsyncExit(Sender: TObject;
      EventParams: TStringList);
  private
    A090MW: TA090FAssenzeAnnoMW;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure Deselezionatutto(Sender: TmeTIWAdvCheckGroup);
    procedure Invertiselezione(Sender: TmeTIWAdvCheckGroup);
    procedure Selezionatutto(Sender: TmeTIWAdvCheckGroup);
    procedure ElaborazioneServer; override;
    function CreateJSonString: String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA090FAssenzeAnno.IWAppFormCreate(Sender: TObject);
var
  Year, Month, Day:Word;
begin
  inherited;
  AttivaGestioneC700;
  A090MW:=TA090FAssenzeAnnoMW.Create(Self);
  DecodeDate(Parametri.DataLavoro, Year, Month, Day);
  edtDaAnno.Text:=IntToStr(Year);
  edtDaMese.Text:=IntToStr(Month);
  edtAMese.Text:=IntToStr(Month);
  CgpListaAnagr.Items.Clear;
  with A090MW.selI010 do
  begin
    First;
    while not Eof do
    begin
      CgpListaAnagr.Items.Add(FieldByName('Nome_Logico').AsString);
      Next;
    end;
  end;

  CgpListaCausali.Items.Clear;
  with A090MW.Q265 do
    begin
      First;
      while not Eof do
      begin
        CgpListaCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
  GetParametriFunzione;
  chkSegnalazPresenzaAsyncClick(nil,nil);
  chkIntestazioneAsyncClick(nil,nil);
end;

procedure TWA090FAssenzeAnno.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA090FAssenzeAnno.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y,r:integer;
    svalore,snome:string;
begin
  C004DM.Cancella001;
  if chkTotIndiv.Checked then
    C004DM.PutParametro('TOTINDIVIDUALI','S')
  else
    C004DM.PutParametro('TOTINDIVIDUALI','N');
  C004DM.PutParametro('RIEPCOMPETENZE',IfThen(chkRiepilogoCompetenze.Checked,'S','N'));
  if chkSegnalazPresenza.Checked then
    C004DM.PutParametro('PRESENZE','S')
  else
    C004DM.PutParametro('PRESENZE','N');
  if chkRigaValoriz.Checked then
    C004DM.PutParametro('VALORIZZA','S')
  else
    C004DM.PutParametro('VALORIZZA','N');
  if chkSecCausaleAss.Checked then
    C004DM.PutParametro('CAUSALE2','S')
  else
    C004DM.PutParametro('CAUSALE2','N');
  if chkSaltoPag.Checked then
    C004DM.PutParametro('SALTOPAGINA','S')
  else
    C004DM.PutParametro('SALTOPAGINA','N');
  if chkStampaAllDip.Checked then
    C004DM.PutParametro(UpperCase(chkStampaAllDip.Name),'S')
  else
    C004DM.PutParametro(UpperCase(chkStampaAllDip.Name),'N');
  if chkGGSett.Checked then
    C004DM.PutParametro(UpperCase(chkGGSett.Name),'S')
  else
    C004DM.PutParametro(UpperCase(chkGGSett.Name),'N');
  C004DM.PutParametro(UpperCase(rgpRichiesteIrisWEB.Name),rgpRichiesteIrisWEB.ItemIndex.ToString);
  C004DM.PutParametro('CARATTERI',edtCaratteri.Text);
  if chkIntestazione.Checked then
    C004DM.PutParametro('INTESTAZIONE','S')
  else
    C004DM.PutParametro('INTESTAZIONE','N');
  if chkData.Checked then
    C004DM.PutParametro('DATASTAMPA','S')
  else
    C004DM.PutParametro('DATASTAMPA','N');
  if chkNumPagina.Checked then
    C004DM.PutParametro('NUMPAGINA','S')
  else
    C004DM.PutParametro('NUMPAGINA','N');
  if chkAzienda.Checked then
    C004DM.PutParametro('AZIENDA','S')
  else
    C004DM.PutParametro('AZIENDA','N');
  C004DM.PutParametro('TITOLO',edtTitolo.Text);
  C004DM.PutParametro('FIRMA',edtFirma.Text);
  C004DM.PutParametro('edtLogoLarghezza',edtLogoLarghezza.Text);
  C004DM.PutParametro('edtLogoAltezza',edtLogoAltezza.Text);

  // salvo l'elenco dei campi di anagrafe selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTAANAGRA';
  r:=CgpListaAnagr.Items.Count;
  For i:=1 to r do
    begin
    if CgpListaAnagr.IsChecked[i-1] then
       begin
       svalore:=svalore+Format('%-20s',[CgpListaAnagr.Items[i-1]]);
       inc(y);
       if y=4 then
          begin
          C004DM.PutParametro(snome+IntToStr(x),svalore);
          inc(x);
          y:=0;
          svalore:='';
          end;
       end;
    end;
  C004DM.PutParametro(snome+IntToStr(x),svalore);
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

procedure TWA090FAssenzeAnno.GetParametriFunzione;
{Leggo i parametri della form}
var x,y,i,r,posiz,k:integer;
    e:boolean;
    svalore,snome,selemento:string;
begin
  posiz:=0;
  chkTotIndiv.Checked:=C004DM.GetParametro('TOTINDIVIDUALI','N') = 'S';
  chkRiepilogoCompetenze.Checked:=C004DM.GetParametro('RIEPCOMPETENZE','N') = 'S';
  chkSegnalazPresenza.Checked:=C004DM.GetParametro('PRESENZE','N') = 'S';
  chkRigaValoriz.Checked:=C004DM.GetParametro('VALORIZZA','N') = 'S';
  chkSecCausaleAss.Checked:=C004DM.GetParametro('CAUSALE2','N') = 'S';
  chkSaltoPag.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
  chkGGSett.Checked:=C004DM.GetParametro(UpperCase(chkGGSett.Name),'N') = 'S';
  rgpRichiesteIrisWEB.ItemIndex:=C004DM.GetParametro(UpperCase(rgpRichiesteIrisWEB.Name),'0').ToInteger;
  chkStampaAllDip.Checked:=C004DM.GetParametro(UpperCase(chkStampaAllDip.Name),'S') = 'S';
  edtCaratteri.Text:=C004DM.GetParametro('CARATTERI','***');
  chkIntestazione.Checked:=C004DM.GetParametro('INTESTAZIONE','S') = 'S';
  chkData.Checked:=C004DM.GetParametro('DATASTAMPA','S') = 'S';
  chkNumPagina.Checked:=C004DM.GetParametro('NUMPAGINA','S') = 'S';
  chkAzienda.Checked:=C004DM.GetParametro('AZIENDA','S') = 'S';
  edtTitolo.Text:=C004DM.GetParametro('TITOLO','Stampa situazione assenze dal <DAL> al <AL>');
  edtFirma.Text:=C004DM.GetParametro('FIRMA','');
  if edtTitolo.Text = '' then
    edtTitolo.Text:='Stampa situazione assenze dal <DAL> al <AL>';
  edtLogoLarghezza.Text:=C004DM.GetParametro('edtLogoLarghezza','0');
  edtLogoAltezza.Text:=C004DM.GetParametro('edtLogoAltezza','0');
  // lettura campi selezionati
  x:=0; //contatore di paramento
  snome:='LISTAANAGRA';
  repeat
  // ciclo sui parametri LISTAANAGRA0,LISTAANAGRA1,ecc.
    svalore:=C004DM.GetParametro(snome+IntToStr(x),'');
    y:=0; // contatore di elementi nel parametro
    if svalore<>'' then
      begin
      repeat
      // ciclo sugli elementi nel parametro max 4 per parametro
        selemento:=Trim(Copy(svalore,(y*20)+1,20));
        if selemento<>'' then
          begin
          i:=0;
          e:=true;
          r:=CgpListaAnagr.Items.Count;
          while (i<r) and (e) do
            begin
            if CgpListaAnagr.Items[i]=selemento then
               begin
               // ricostruisce l'ordinamento corretto
               if posiz<>i then
                 CgpListaAnagr.Items.Move(i,posiz);
               CgpListaAnagr.IsChecked[posiz]:=true;
               e:=false;
               inc(posiz);
               end;
            inc(i);
            end;
          inc(y);
          end;
      until selemento ='';
      inc(x);
    end;
  until svalore ='';
  // lettura causali selezionate
  x:=0; //contatore di paramento
  snome:='LISTACAUSALI';
  repeat
  // ciclo sui parametri LISTACAUSALI0,LISTACAUSALI1,ecc.
    svalore:=C004DM.GetParametro(snome+IntToStr(x),'');
    y:=0; // contatore di elementi nel parametro
    if svalore <> '' then
    begin
      repeat
      // ciclo sugli elementi nel parametro max 16 per parametro
        selemento:=Trim(Copy(svalore,(y*5)+1,5));
        k:=R180IndexOf(CgpListaCausali.Items,selemento,5);
        if k >= 0 then
          CgpListaCausali.IsChecked[k]:=True;
        inc(y);
      until selemento = '';
      inc(x);
    end;
  until Trim(svalore) = '';
end;

procedure TWA090FAssenzeAnno.Selezionatutto1Click(Sender: TObject);
begin
  Selezionatutto(CgpListaAnagr);
end;

procedure TWA090FAssenzeAnno.Invertiselezione1Click(Sender: TObject);
begin
  Invertiselezione(CgpListaAnagr);
end;

procedure TWA090FAssenzeAnno.Deselezionatutto1Click(Sender: TObject);
begin
  Deselezionatutto(CgpListaAnagr);
end;

procedure TWA090FAssenzeAnno.Selezionatutto2Click(Sender: TObject);
begin
  Selezionatutto(CgpListaCausali);
end;

procedure TWA090FAssenzeAnno.Invertiselezione2Click(Sender: TObject);
begin
  Invertiselezione(CgpListaCausali);
end;

procedure TWA090FAssenzeAnno.Deselezionatutto2Click(Sender: TObject);
begin
  Deselezionatutto(CgpListaCausali);
end;

procedure TWA090FAssenzeAnno.edtLogoAltezzaAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  try
    edtLogoAltezza.Text:=IntToStr(StrToInt(edtLogoAltezza.Text));
  except
    edtLogoAltezza.Text:=C004DM.GetParametro('edtLogoAltezza','0');
  end;
end;

procedure TWA090FAssenzeAnno.edtLogoLarghezzaAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  try
    edtLogoLarghezza.Text:=IntToStr(StrToInt(edtLogoLarghezza.Text));
  except
    edtLogoLarghezza.Text:=C004DM.GetParametro('edtLogoLarghezza','0');
  end;
end;

procedure TWA090FAssenzeAnno.Selezionatutto(Sender: TmeTIWAdvCheckGroup);
var
 i:Integer;
begin
  inherited;
  for i:=0 to Sender.Items.Count - 1 do
    Sender.IsChecked[i]:=True;
  Sender.AsyncUpdate;
end;

procedure TWA090FAssenzeAnno.Invertiselezione(Sender: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to Sender.Items.Count - 1 do
    Sender.IsChecked[i]:=not Sender.IsChecked[i];
  Sender.AsyncUpdate;
end;

procedure TWA090FAssenzeAnno.btnGeneraPDFClick(Sender: TObject);
begin
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA090FAssenzeAnno.ElaborazioneServer;
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
    DCOMConnection.AppServer.PrintA090(grdC700.selAnagrafe.SubstitutedSQL,
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

function TWA090FAssenzeAnno.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaAnno,json);
    C190Comp2JsonString(edtDaMese,json);
    C190Comp2JsonString(edtAMese,json);
    C190Comp2JsonString(edtTitolo,json);
    C190Comp2JsonString(edtFirma,json);
    C190Comp2JsonString(edtCaratteri,json);
    C190Comp2JsonString(edtLogoLarghezza,json);
    C190Comp2JsonString(edtLogoAltezza,json);

    C190Comp2JsonString(chkSegnalazPresenza,json);
    C190Comp2JsonString(chkSecCausaleAss,json);
    C190Comp2JsonString(chkRigaValoriz,json);
    C190Comp2JsonString(chkTotIndiv,json);
    C190Comp2JsonString(chkRiepilogoCompetenze,json);
    C190Comp2JsonString(chkSaltoPag,json);
    C190Comp2JsonString(chkStampaAllDip,json);
    C190Comp2JsonString(chkGGSett,json);
    C190Comp2JsonString(rgpRichiesteIrisWEB,json);
    C190Comp2JsonString(chkIntestazione,json);
    C190Comp2JsonString(chkData,json);
    C190Comp2JsonString(chkNumPagina,json);
    C190Comp2JsonString(chkAzienda,json);

    json.AddPair('CgpListaAnagr',TJSONString.Create(C190GetCheckList(50,CgpListaAnagr)));
    json.AddPair('CgpListaCausali',TJSONString.Create(C190GetCheckList(5,CgpListaCausali)));

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA090FAssenzeAnno.chkIntestazioneAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkData.Enabled:=chkIntestazione.Checked;
  chkAzienda.Enabled:=chkIntestazione.Checked;
  chkNumPagina.Enabled:=chkIntestazione.Checked;
  lblTitolo.Enabled:=chkIntestazione.Checked;
  edtTitolo.Enabled:=chkIntestazione.Checked;
  lblLarghezza.Enabled:=chkIntestazione.Checked;
  edtLogoLarghezza.Enabled:=chkIntestazione.Checked;
  lblAltezza.Enabled:=chkIntestazione.Checked;
  edtLogoAltezza.Enabled:=chkIntestazione.Checked;
end;

procedure TWA090FAssenzeAnno.chkSegnalazPresenzaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  edtCaratteri.Enabled:=chkSegnalazPresenza.Checked;
  lblCaratteri.Enabled:=chkSegnalazPresenza.Checked;
end;

procedure TWA090FAssenzeAnno.Deselezionatutto(Sender: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to Sender.Items.Count - 1 do
    Sender.IsChecked[i]:=False;
  Sender.AsyncUpdate;
end;

end.
