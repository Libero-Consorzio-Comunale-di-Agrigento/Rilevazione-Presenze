unit A065UStampaBudget;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, Menus, DBCtrls, StdCtrls, Spin, ExtCtrls, Buttons, CheckLst, StrUtils,
  Oracle, OracleData, R450, A065UStampaBudgetMW,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  C001StampaLib, C004UParamForm, C180FunzioniGenerali,
  Mask, ComCtrls, QRPDFFilt;

type
  TA065FStampaBudget = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel1: TPanel;
    lblAnno: TLabel;
    lblDaMese: TLabel;
    lblAMese: TLabel;
    lblTipo: TLabel;
    lblDescTipo: TLabel;
    cmbDaMese: TComboBox;
    cmbAMese: TComboBox;
    sedtAnno: TSpinEdit;
    dcmbTipo: TDBLookupComboBox;
    Panel2: TPanel;
    chkDettaglioDipendenti: TCheckBox;
    chkSaltoPagina: TCheckBox;
    chkTotMese: TCheckBox;
    chkTotGruppo: TCheckBox;
    chkCostoInMoneta: TCheckBox;
    rgpTipoBudget: TRadioGroup;
    lblGruppi: TLabel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    clbGruppi: TCheckListBox;
    chkTotGenerale: TCheckBox;
    chkAggiornaFruito: TCheckBox;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    BitBtn1: TBitBtn;
    btnAnteprima: TBitBtn;
    BStampa: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure sedtAnnoChange(Sender: TObject);
    procedure cmbAMeseChange(Sender: TObject);
    procedure cmbDaMeseExit(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure chkDettaglioDipendentiClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BStampaClick(Sender: TObject);
  private
    { Private declarations }
    wCodGruppo,wTipo:String;
    wDecorrenza:TDateTime;
    procedure GetParametriFunzione;
    procedure GetParametriFunzione2;
    procedure PutParametriFunzione;
    procedure RicaricaClbGruppi;
    procedure AbilitaComponenti;
    procedure evtdsrAppDataChange;
    procedure CreaQueryStampa;
  public
    { Public declarations }
    A065MW: TA065FStampaBudgetMW;
    Anno, DaMese, AMese: Integer;
    DocumentoPDF,TipoModulo: string;
    procedure RicaricaListaGruppiSel;
  end;

var
  A065FStampaBudget: TA065FStampaBudget;

procedure OpenA065StampaBudget(CodGruppo,Tipo:String;Decorrenza:TDateTime);

implementation

{$R *.dfm}

uses A065UStampa;

procedure OpenA065StampaBudget(CodGruppo,Tipo:String;Decorrenza:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA065StampaBudget') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A065FStampaBudget:=TA065FStampaBudget.Create(nil);
  with A065FStampaBudget do
    try
      wCodGruppo:=CodGruppo;
      wTipo:=Tipo;
      wDecorrenza:=Decorrenza;
      Anno:=R180Anno(Decorrenza);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA065FStampaBudget.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A065MW:=TA065FStampaBudgetMW.Create(Self);
  A065MW.evtdsrAppDataChange:=evtdsrAppDataChange;
end;

procedure TA065FStampaBudget.FormShow(Sender: TObject);
var
  D,M,Y:Word;
  i:Integer;
begin
  A065FStampa:=TA065FStampa.Create(nil);
  A065FStampa.QRep.PrinterSettings.UseStandardPrinter:=(TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  dcmbTipo.DataSource:=A065MW.dsrApp;
  dcmbTipo.ListSource:=A065MW.dsrT275;
  CreaC004(SessioneOracle,'A065',Parametri.ProgOper);
  DecodeDate(Parametri.DataLavoro,Y,M,D);
  sedtAnno.Value:=IfThen(Anno = 0,StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro)),Anno);
  cmbDaMese.ItemIndex:=0;
  DaMese:=1;
  cmbAMese.ItemIndex:=M - 1;
  AMese:=M;
  chkCostoInMoneta.Visible:=Parametri.CampiRiferimento.C2_Livello <> '';
  if not chkCostoInMoneta.Visible then
    chkCostoInMoneta.Checked:=False;
  dcmbTipo.KeyValue:=A065MW.selT275.FieldByName('CODICE').AsString;
  lblDescTipo.Caption:=A065MW.selT275.FieldByName('DESCRIZIONE').AsString;
  GetParametriFunzione;
  if wTipo <> '' then
    dcmbTipo.KeyValue:=wTipo;
  //Recupero i gruppi abilitati all'utente corrente
  Screen.Cursor:=crHourGlass;
  A065MW.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
  A065MW.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue));
  Screen.Cursor:=crDefault;
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato, eventualmente selezionandoli
  RicaricaClbGruppi;
  //Seleziono i gruppi di clbGruppi in base al salvataggio precedente
  GetParametriFunzione2;
  //Allineo la lista dei gruppi selezionati in base al clbGruppi
  RicaricaListaGruppiSel;
  //Se sono richiamato dall'esterno...
  if wCodGruppo <> '' then
  begin
    //Cancello la lista dei gruppi selezionati
    for i:=0 to clbGruppi.Items.Count - 1 do
      clbGruppi.Checked[i]:=False;
    //Seleziono il gruppo richiamato
    if A065MW.selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([wCodGruppo,wTipo,wDecorrenza]),[srFromBeginning]) then
      clbGruppi.Checked[A065MW.selT713.RecNo - 1]:=True;
    //Allineo la lista dei gruppi selezionati in base al clbGruppi
    RicaricaListaGruppiSel;
  end;
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA065FStampaBudget.FormDestroy(Sender: TObject);
begin
  A065FStampa.Free;
end;

procedure TA065FStampaBudget.GetParametriFunzione;
{Leggo i parametri della form}
begin
  dcmbTipo.KeyValue:=C004FParamForm.GetParametro('dcmbTipo','#LIQ#');
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkDettaglioDipendenti.Checked:=C004FParamForm.GetParametro('DIPENDENTI','N') = 'S';
  chkTotMese.Checked:=C004FParamForm.GetParametro('TOTMESE','N') = 'S';
  chkCostoInMoneta.Checked:=C004FParamForm.GetParametro('COSTO','N') = 'S';
  chkTotGruppo.Checked:=C004FParamForm.GetParametro('TOTREPARTO','N') = 'S';
  chkTotGenerale.Checked:=C004FParamForm.GetParametro('TOTGENERALE','N') = 'S';
  rgpTipoBudget.ItemIndex:=StrToInt(C004FParamForm.GetParametro('rgpTipoBudget','0'));
end;

procedure TA065FStampaBudget.GetParametriFunzione2;
{Leggo i parametri della form}
var x,y,i:integer;
    e: boolean;
    sValore,sNome,sElemento:string;
begin
  //lettura gruppi-tipi-mesi selezionati
  x:=0; //contatore di paramento
  sNome:='clbGruppi';
  repeat
    //ciclo sui parametri clbGruppi0,clbGruppi1,ecc.
    sValore:=C004FParamForm.GetParametro(sNome + IntToStr(x),'');
    y:=0; //contatore di elementi nel parametro
    if sValore <> '' then
    begin
      repeat
        //ciclo sugli elementi nel parametro
        sElemento:=Copy(sValore,(y * 22) + 1,22);
        if sElemento <> '' then
        begin
          i:=0;
          e:=true;
          while (i < clbGruppi.Items.Count) and (e) do
          begin
            if Copy(clbGruppi.Items[i],1,22) = sElemento then
            begin
              clbGruppi.Checked[i]:=true;
              e:=false;
            end
            else if Copy(clbGruppi.Items[i],1,22) > sElemento then
              e:=false;
            inc(i);
          end;
          inc(y);
        end;
      until sElemento = '';
      inc(x);
    end;
  until sValore = '';
end;

procedure TA065FStampaBudget.PutParametriFunzione;
{Scrivo i parametri della form}
var i,x,y:integer;
    sValore,sNome:string;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('dcmbTipo',VarToStr(dcmbTipo.KeyValue));
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004FParamForm.PutParametro('DIPENDENTI',IfThen(chkDettaglioDipendenti.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTMESE',IfThen(chkTotMese.Checked,'S','N'));
  C004FParamForm.PutParametro('COSTO',IfThen(chkCostoInMoneta.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTREPARTO',IfThen(chkTotGruppo.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTGENERALE',IfThen(chkTotGenerale.Checked,'S','N'));
  C004FParamForm.PutParametro('rgpTipoBudget',IntToStr(rgpTipoBudget.ItemIndex));
  //salvo l'elenco dei gruppi-tipi-mesi selezionati
  x:=0; //contatore parametri gruppi-tipi-decorrenze
  y:=0; //contatore elementi per parametro
  sValore:='';
  sNome:='clbGruppi';
  for i:=1 to clbGruppi.Items.Count do
    if clbGruppi.Checked[i-1] then
    begin
       sValore:=sValore + Copy(clbGruppi.Items[i-1],1,22);
       inc(y);
       if y = 90 then
       begin
          C004FParamForm.PutParametro(sNome + IntToStr(x),sValore);
          inc(x);
          y:=0;
          sValore:='';
       end;
    end;
  C004FParamForm.PutParametro(sNome + IntToStr(x),sValore);
  try SessioneOracle.Commit; except end;
end;

procedure TA065FStampaBudget.RicaricaListaGruppiSel;
var i:Integer;
begin
  A065MW.ListaGruppiSel.Clear;
  for i:=0 to clbGruppi.Items.Count - 1 do
    if clbGruppi.Checked[i] then
      A065MW.ListaGruppiSel.Add(clbGruppi.Items[i]);
end;

procedure TA065FStampaBudget.RicaricaClbGruppi;
var i:Integer;
begin
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato
  clbGruppi.Items.Clear;
  for i:=0 to A065MW.ListaGruppi.Count - 1 do
    clbGruppi.Items.Add(A065MW.ListaGruppi[i]);
  //Seleziono i gruppi in clbGruppi
  for i:=0 to clbGruppi.Items.Count - 1 do
    clbGruppi.Checked[i]:=A065MW.ListaGruppiSel.IndexOf(clbGruppi.Items[i]) >= 0;
end;

procedure TA065FStampaBudget.AbilitaComponenti;
begin
  cmbDaMese.Enabled:=(dcmbTipo.KeyValue <> '#ECC#');
  chkAggiornaFruito.Enabled:=not SolaLettura;
  if not chkAggiornaFruito.Enabled then
    chkAggiornaFruito.Checked:=False;
  chkAggiornaFruito.Caption:='Aggiornamento del fruito' + IfThen(dcmbTipo.KeyValue = '#ECC#',' e riporto del residuo');
  if not chkDettaglioDipendenti.Enabled then
    chkDettaglioDipendenti.Checked:=False;
  chkTotMese.Enabled:=(cmbDaMese.ItemIndex <> cmbAMese.ItemIndex) and chkDettaglioDipendenti.Checked;
  if not chkTotMese.Enabled then
    chkTotMese.Checked:=False;
  chkCostoInMoneta.Enabled:=(dcmbTipo.KeyValue = '#LIQ#') and chkDettaglioDipendenti.Checked;
  if not chkCostoInMoneta.Enabled then
    chkCostoInMoneta.Checked:=False;
end;

procedure TA065FStampaBudget.sedtAnnoChange(Sender: TObject);
var
  Data:TDateTime;
begin
  if Length(sedtAnno.Text) = 4 then
    try
      Data:=StrToDate('01/01/' + sedtAnno.Text);
      Anno:=sedtAnno.Value;
      RicaricaListaGruppiSel;
      A065MW.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
      A065MW.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue));
      RicaricaClbGruppi;
    except
      sedtAnno.SetFocus;
    end
  else
    sedtAnno.SetFocus;
end;

procedure TA065FStampaBudget.cmbAMeseChange(Sender: TObject);
begin
  DaMese:=cmbDaMese.ItemIndex + 1;
  AMese:=cmbAMese.ItemIndex + 1;
  if cmbDaMese.ItemIndex > cmbAMese.ItemIndex then
  begin
    ShowMessage(A000MSG_A065_ERR_PERIODO);
    (Sender as TComboBox).SetFocus;
    exit;
  end;
  RicaricaListaGruppiSel;
  A065MW.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
  A065MW.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue));
  RicaricaClbGruppi;
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.cmbDaMeseExit(Sender: TObject);
begin
  if cmbDaMese.ItemIndex > cmbAMese.ItemIndex then
  begin
    ShowMessage(A000MSG_A065_ERR_PERIODO);
    (Sender as TComboBox).SetFocus;
  end;
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with TCheckListBox(PopupMenu1.PopupComponent) do
    for i:=0 to Items.Count - 1 do
       Checked[i]:=True;
end;

procedure TA065FStampaBudget.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with TCheckListBox(PopupMenu1.PopupComponent) do
    for i:=0 to Items.Count - 1 do
       Checked[i]:=False;
end;

procedure TA065FStampaBudget.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  with TCheckListBox(PopupMenu1.PopupComponent) do
    for i:=0 to Items.Count - 1 do
       Checked[i]:=not Checked[i];
end;

procedure TA065FStampaBudget.chkDettaglioDipendentiClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.BitBtn1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A065FStampa.QRep);
end;

procedure TA065FStampaBudget.BStampaClick(Sender: TObject);
begin
  RicaricaListaGruppiSel;
  ProgressBar1.Position:=0;
  Screen.Cursor:=crHourGlass;
  A065MW.cdsStampa.EmptyDataSet;
  CreaQueryStampa;
  Screen.Cursor:=crDefault;
  with A065FStampa do
  begin
    Anno:=A065FStampaBudget.Anno;
    DaMese:=A065FStampaBudget.DaMese;
    AMese:=A065FStampaBudget.AMese;
    LEnte.Caption:=Parametri.DAzienda;
    LTitolo.Caption:='Budget straordinario mensile dell''anno ' + sedtAnno.Text;
    bndTestGruppi.ForceNewPage:=chkSaltoPagina.Checked;
    lblTitoloMonetizzazione.Enabled:=chkCostoInMoneta.Checked;
    bndTestDipendenti.Enabled:=chkDettaglioDipendenti.Checked;
    lblTitoloFascia15Dip.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTitoloFascia30Dip.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTitoloFascia50Dip.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTitoloMonetizzazioneDip.Enabled:=chkCostoInMoneta.Checked;
    bndDettDipendenti.Enabled:=chkDettaglioDipendenti.Checked;
    lblF15.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblF30.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblF50.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblSoldi.Enabled:=chkCostoInMoneta.Checked;
    bndTotMesi.Enabled:=chkTotMese.Checked;
    lblTotF15.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTotF30.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTotF50.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTotSoldiMese.Enabled:=chkCostoInMoneta.Checked;
    bndTotGruppi.Enabled:=chkTotGruppo.Checked;
    bndTotGruppi.Frame.DrawTop:=chkTotGruppo.Checked;
    lblTotSoldiGruppo.Enabled:=chkCostoInMoneta.Checked;
    bndTotGenerale.ForceNewPage:=chkSaltoPagina.Checked;
    bndTotGenerale.Enabled:=chkTotGenerale.Checked;
    lblTitoloMonetizzazioneGenerale.Enabled:=chkCostoInMoneta.Checked;
    lblTotSoldiGenerale.Enabled:=chkCostoInMoneta.Checked;
    if dcmbTipo.KeyValue = '#ECC#' then
      R450DtM:=TR450DtM1.Create(nil);
    QRep.DataSet.First;
    if (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
    begin
      QRep.ShowProgress:=False;
      QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    end
    else if Sender = btnAnteprima then
      QRep.Preview
    else
      QRep.Print;
    if dcmbTipo.KeyValue = '#ECC#' then
      FreeAndNil(R450DtM);
  end;
  ProgressBar1.Position:=0;
end;

procedure TA065FStampaBudget.CreaQueryStampa;
var i,n,RigaMese,MesiPeriodo,OreDiff,OreDiffEcc:Integer;
    CodGruppo,Tipo,OreMese:String;
    Decorrenza,Data,DataMin,DataMax:TDateTime;
    AggOre:Boolean;
begin
  n:=0;
  with clbGruppi do
    for i:=0 to Count - 1 do
      if Checked[i] then
        inc(n);
  if n = 0 then
  begin
    Screen.Cursor:=crDefault;
    raise exception.create(A000MSG_A065_NO_GRUPPI);
  end;
  ProgressBar1.Max:=n;
  with clbGruppi do
    for i:=0 to Count - 1 do
    begin
      if Checked[i] then
      begin
        ProgressBar1.StepBy(1);
        //Prelevo i dati della chiave
        CodGruppo:=Trim(Copy(Items[i],1,10));
        Tipo:=Trim(Copy(Items[i],12,5));
        Decorrenza:=EncodeDate(StrToInt(Trim(Copy(Items[i],24,4))),StrToInt(Trim(Copy(Items[i],18,2))),1);
        with A065MW do
          if selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([CodGruppo,Tipo,Decorrenza]),[srFromBeginning]) then
            with selT714 do
            begin
              if chkAggiornaFruito.Checked then
              begin
                //Calcolo del fruito
                DataMin:=EncodeDate(sedtAnno.Value,DaMese,1);
                DataMax:=EncodeDate(sedtAnno.Value,AMese,1);
                Data:=DataMin;
                while Data <= DataMax do
                begin
                  A029FBudgetDtM1.AggiornaFruitoBudget(Data,
                                                       Tipo,
                                                       CodGruppo,
                                                       selT713.FieldByName('FILTRO_ANAGRAFE').AsString,
                                                       'O',
                                                       False);
                  Data:=R180FineMese(Data) + 1;
                end;
                //Riporto del residuo
                if Tipo = '#ECC#' then
                begin
                  DataMax:=EncodeDate(sedtAnno.Value,12,1);
                  Data:=DataMin;
                  while Data <= DataMax do
                  begin
                    OreDiff:=0;
                    Close;
                    SetVariable('CODGRUPPO',CodGruppo);
                    SetVariable('TIPO',Tipo);
                    SetVariable('DECORRENZA',Decorrenza);
                    SetVariable('MESEDA',R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime));
                    SetVariable('MESEA',R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
                    Open;
                    while not Eof do
                    begin
                      if (EncodeDate(sedtAnno.Value,selT714.FieldByName('MESE').AsInteger,1) = Data)
                      and (RecNo <> RecordCount) then
                      begin
                        AggOre:=R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString) <> 0;
                        OreDiff:=R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString);
                        OreDiffEcc:=0;
                      end
                      else if (EncodeDate(sedtAnno.Value,FieldByName('MESE').AsInteger,1) > Data) then
                      begin
                        if RecNo = RecordCount then
                          OreDiffEcc:=OreDiff
                        else
                          OreDiffEcc:=(OreDiff div (R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime) - R180Mese(Data))) * (FieldByName('MESE').AsInteger - R180Mese(Data));
                        updT714.SetVariable('CODGRUPPO',CodGruppo);
                        updT714.SetVariable('TIPO',Tipo);
                        updT714.SetVariable('DECORRENZA',Decorrenza);
                        updT714.SetVariable('MESE',FieldByName('MESE').AsInteger);
                        updT714.SetVariable('ORE',IfThen(AggOre,QuotedStr(R180MinutiOre(OreDiffEcc)),'ORE'));
                        updT714.SetVariable('IMPORTO','IMPORTO');
                        updT714.Execute;
                      end;
                      Next;
                    end;
                    Data:=R180FineMese(Data) + 1;
                  end;
                end;
                SessioneOracle.Commit;
              end;
              MesiPeriodo:=R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime) - R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime) + 1;
              Close;
              SetVariable('CODGRUPPO',CodGruppo);
              SetVariable('TIPO',Tipo);
              SetVariable('DECORRENZA',Decorrenza);
              SetVariable('MESEDA',DaMese);
              SetVariable('MESEA',AMese);
              Open;
              while not Eof do
              begin
                cdsStampa.Append;
                cdsStampa.FieldByName('CODGRUPPO').AsString:=FieldByName('CODGRUPPO').AsString;
                cdsStampa.FieldByName('DECORRENZA').AsString:=FieldByName('DECORRENZA').AsString;
                cdsStampa.FieldByName('MESE').AsString:=FieldByName('MESE').AsString;
                if rgpTipoBudget.ItemIndex = 0 then
                  cdsStampa.FieldByName('ORE').AsString:=FieldByName('ORE').AsString
                else
                begin
                  RigaMese:=FieldByName('MESE').AsInteger - R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime) + 1;
                  OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) div MesiPeriodo);
                  if RigaMese = MesiPeriodo then
                  begin
                    if FieldByName('TIPO').AsString = '#ECC#' then
                      OreMese:=selT713.FieldByName('ORE').AsString
                    else
                      OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - (R180OreMinutiExt(OreMese) * (MesiPeriodo - 1)));
                  end
                  else if selT714.FieldByName('TIPO').AsString = '#ECC#' then
                    OreMese:=R180MinutiOre(R180OreMinutiExt(OreMese) * RigaMese);
                  cdsStampa.FieldByName('ORE').AsString:=OreMese;
                end;
                cdsStampa.FieldByName('ORE_FRUITO').AsString:=FieldByName('ORE_FRUITO').AsString;
                cdsStampa.FieldByName('ORE_RESIDUO').AsString:=R180MinutiOre(R180OreMinutiExt(cdsStampa.FieldByName('ORE').AsString) - R180OreMinutiExt(cdsStampa.FieldByName('ORE_FRUITO').AsString));
                cdsStampa.Post;
                Next;
              end;
            end;
      end;
    end;
end;

procedure TA065FStampaBudget.evtdsrAppDataChange;
begin
  if A065MW.selT275.Active then
    lblDescTipo.Caption:=A065MW.selT275.FieldByName('DESCRIZIONE').AsString;
  if (VarToStr(dcmbTipo.KeyValue) = '#ECC#') and (cmbDaMese.ItemIndex <> 0) then
  begin
    cmbDaMese.ItemIndex:=0;
    cmbAMeseChange(nil);
  end;
  RicaricaListaGruppiSel;
  A065MW.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue));
  RicaricaClbGruppi;
  AbilitaComponenti;
end;

end.
