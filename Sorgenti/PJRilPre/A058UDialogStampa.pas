unit A058UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, C001StampaLib, DB, C180FunzioniGenerali, ExtCtrls, DateUtils,
  ComCtrls, C004UParamForm, Variants, Qrctrls, Printers, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione, A000UInterfaccia, A058UPianifTurni, R500Lin, Spin, Grids, DBGrids, Math,
  QRPrntr, A058UPianifTurniDtM1;

type
  TSquadre = record
    Squadra,DSquadra,Oper,
    S1,S2:String;
  end;

  TA058FDialogStampa = class(TForm)
    btnStampa: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    ETitolo: TEdit;
    Label2: TLabel;
    ENota: TEdit;
    Label3: TLabel;
    EDesc1: TEdit;
    Label4: TLabel;
    EDesc2: TEdit;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnAnteprima: TBitBtn;
    RG1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    PG1: TProgressBar;
    RG3: TRadioGroup;
    GroupBox1: TGroupBox;
    ChkTotTurno: TCheckBox;
    ChkDettaglioOrari: TCheckBox;
    ChkAssenze: TCheckBox;
    ChkSaldi: TCheckBox;
    ChkTotaleTurni: TCheckBox;
    edtNumGG: TSpinEdit;
    Label5: TLabel;
    chkSepColonne: TCheckBox;
    chkSepRighe: TCheckBox;
    SEdtFontSize: TSpinEdit;
    LblSizeFont: TLabel;
    Label6: TLabel;
    edtMargineSx: TSpinEdit;
    cmbOriPagina: TComboBox;
    lblOriPagina: TLabel;
    rgpRigheDip: TRadioGroup;
    chkTotOper: TCheckBox;
    chkLiquid: TCheckBox;
    chkTotGenTurni: TCheckBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RG3Click(Sender: TObject);
  private
    { Private declarations }
    AbilCont:Boolean;
    Squadre:array[1..31] of TSquadre;
    NumSquadre,PSquadra:Integer;
    SquadraOld:String;
    (*Al*)SalvaInizio,SalvaFine:Integer;
    LungCella:Byte;
    function GetSquadra(S:String):Integer;
    function Turni(GiornoIn:TGiorno):String;
    procedure CreaTabellaStampa;
    procedure CaricaTabellaStampa;
    procedure GetGiorni(Dip:Integer);
    procedure PutOrario(Ora:String);
    procedure PutAssenza(Ass:String);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
    procedure ScriviPiede(NDip:Integer);
  end;

var
  A058FDialogStampa: TA058FDialogStampa;

implementation

uses A058UTabellone, A058UGrigliaPianif;

{$R *.DFM}

procedure TA058FDialogStampa.FormCreate(Sender: TObject);
begin
  A058FTabellone:=TA058FTabellone.Create(nil);
  C001SettaQuickReport(A058FTabellone.QRep);
  AbilCont:=False;
end;

procedure TA058FDialogStampa.BitBtn3Click(Sender: TObject);
{Impostazione stampante}
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A058FTabellone.QRep);
end;

procedure TA058FDialogStampa.btnStampaClick(Sender: TObject);
{Impostazioni di Stampa}
var i,j,xx,yy:Integer;
begin
  if RG1.ItemIndex = 0 then
    LungCella:=5
  else
    LungCella:=6;
  with A058FTabellone do
  begin
    LOrari.Clear;
    LAssenze.Clear;
    LTotTurni.Clear;
    for xx:=Low(TotaliTurni) to High(TotaliTurni) do
      for yy:=0 to 359 do
        TotaliTurni[xx,yy]:=0;
    QRMOrari.Lines.Clear;
    QRMAssenze.Lines.Clear;
    QRTitolo.Caption:=ETitolo.Text;
    QRNota.Caption:=ENota.Text;
    QRDesc1.Caption:=EDesc1.Text;
    QRDesc2.Caption:=EDesc2.Text;
    //InizializzaStampa;
    //Ciclo sul periodo in base agli x giorni da stampare  Lorena
    CreaTabellaStampa;
    A058FPianifTurniDtM1.OldInizio:=A058FPianifTurniDtm1.DataInizio;
    A058FPianifTurniDtM1.OldFine:=A058FPianifTurniDtm1.DataFine;
    Screen.Cursor:=crHourGlass;
    PG1.Position:=0;
    (*Al*)SalvaInizio:=0;
    (*Al*)SalvaFine:=edtNumGG.Value - 1;
    {Azzero la voce TotOraLiquid}
    with A058FPianifTurniDtM1 do
      for i:=Low(aTotaleTurni) to High(aTotaleTurni) do
      begin
        aTotaleTurni[i].TotOraLiquid:=0;
        aTotaleTurni[i].Rp502Turno1:=0;
        aTotaleTurni[i].Rp502Turno2:=0;
        aTotaleTurni[i].Rp502Turno3:=0;
        aTotaleTurni[i].Rp502Turno4:=0;
      end;

    PG1.Max:=Trunc((A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio) / edtNumGG.Value);
    repeat
      CaricaTabellaStampa;
      //SalvaInizio:=SalvaInizio + edtNumGG.Value;
      SalvaInizio:=SalvaFine + 1;
      SalvaFine:=SalvaFine + edtNumGG.Value;
      if R180Mese(A058FPianifTurniDtm1.DataInizio + SalvaInizio) <> R180Mese(A058FPianifTurniDtm1.DataInizio + SalvaFine) then
        SalvaFine:=Trunc(R180FineMese(A058FPianifTurniDtm1.DataInizio + SalvaInizio) - A058FPianifTurniDtm1.DataInizio);
      PG1.StepBy(1);
    until A058FPianifTurniDtm1.DataInizio + SalvaInizio > A058FPianifTurniDtm1.DataFine;

    if (RG3.ItemIndex = 1) and ChkTotTurno.Checked then
    begin
      with A058FPianifTurniDtM1 do
        for i:=0 to Min(edtNumGG.Value - 1,trunc(DataFine - DataInizio)) do
        begin
          T058Stampa.First;
          while Not T058Stampa.Eof do
          begin
            T058Stampa.Edit;
            T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno1;
            T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno2;
            T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno3;
            T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno4;
            T058Stampa.Post;
            T058Stampa.Next;
          end;
        end;
    end;

    A058FPianifTurniDtM1.T058Stampa.First;
    PG1.Position:=0;
    Screen.Cursor:=crDefault;
    if cmbOriPagina.ItemIndex = 0 then
      if edtNumGG.Value >= 15 then //Lorena
        QRep.Page.Orientation:=poLandScape
      else
        QRep.Page.Orientation:=poPortrait
    else if cmbOriPagina.ItemIndex = 1 then
      QRep.Page.Orientation:=poPortrait
    else
      QRep.Page.Orientation:=poLandScape;

    //PreviewAttiva:=Sender <> btnStampa;
    if Sender = btnStampa then
    begin
      QRep.Prepare;
      QRep.Print;
    end
    else if Sender = btnAnteprima then
      QRep.Preview;
    {distruggo gli oggetti della banda "piede5" con tag 99}
    DistruggiOggetti99(Piede5);
  end;
  with A058FPianifTurniDtm1 do
    for i:=0 to Vista.Count - 1 do
    begin
      with TDipendente(Vista[i]) do
      begin
        //Alberto 29/12/2005: aggiorno i totali turni individuali
        TotaleTurniMese.Turno1:=0;
        TotaleTurniMese.Turno2:=0;
        TotaleTurniMese.Turno3:=0;
        TotaleTurniMese.Turno4:=0;
        for j:=0 to Giorni.Count - 1 do
        begin
          if RG3.ItemIndex = 1 then
          begin
            TGiorno(Giorni[j]).T1:=TGiorno(GiorniOld[j]).T1;
            TGiorno(Giorni[j]).T2:=TGiorno(GiorniOld[j]).T2;
            TGiorno(Giorni[j]).T1EU:=TGiorno(GiorniOld[j]).T1EU;
            TGiorno(Giorni[j]).T2EU:=TGiorno(GiorniOld[j]).T2EU;
            TGiorno(Giorni[j]).Ora:=TGiorno(GiorniOld[j]).Ora;
            TGiorno(Giorni[j]).Ass1:=TGiorno(GiorniOld[j]).Ass1;
            TGiorno(Giorni[j]).SiglaT1:=TGiorno(GiorniOld[j]).SiglaT1;
            TGiorno(Giorni[j]).SiglaT2:=TGiorno(GiorniOld[j]).SiglaT2;
          end;
          //Alberto 29/12/2005: aggiorno i totali turni individuali
          TotaleTurniInd(i,j);
        end;
      end;
      DebitoDipendente(i,0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
    end;
  (*Al*)
  try
    A058FPianifTurniDtM1.T058Stampa.Close;
  except
  end;
end;

procedure TA058FDialogStampa.CreaTabellaStampa;
var
  i, j:Integer;
begin
  with A058FPianifTurniDtM1 do
  begin
    T058Stampa.Close;
    //Creo la tabella di appoggio T058Stampa
    with T058Stampa.FieldDefs do
    begin
      Clear;
      Add('Matricola',ftString,10,False);
      Add('DataInizio',ftDate);
      Add('DataFine',ftDate);
      Add('Squadra',ftString,5,False);
      Add('Operatore',ftString,5,False);
      Add('Nome',ftString,50,False);
      Add('Badge',ftInteger,0,False);
      Add('Progressivo',ftInteger,0,False);
      Add('DSquadra',ftString,40,False);
      Add('Partenza',ftInteger,0,False);
      //=================================
      //===Creazione campi giornalieri===
      //=================================
      for i:=0 to Min(edtNumGG.Value - 1,trunc(DataFine - DataInizio)) do
      begin
        Add('Orari' + IntToStr(i),ftString,5,False);
        Add('Turni' + IntToStr(i),ftString,10,False);
        Add('CodOrari' + IntToStr(i),ftString,5,False);
        Add('CodAssenze' + IntToStr(i),ftString,5,False);

        //Totali generali per squadra
        Add('TotGenTurno1_' + IntToStr(i),ftInteger,0,False);
        Add('TotGenTurno2_' + IntToStr(i),ftInteger,0,False);
        Add('TotGenTurno3_' + IntToStr(i),ftInteger,0,False);
        Add('TotGenTurno4_' + IntToStr(i),ftInteger,0,False);

        //Creo Totali copertura squadra suddivisi per
        //tipo operatore per tipo operatore
        for j:=Low(aTotaleTurni[i].TotOpe1) to High(aTotaleTurni[i].TotOpe1) do
          Add('TotGenTurno1_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe1[j].Operatore,ftInteger,0,False);
        for j:=Low(aTotaleTurni[i].TotOpe2) to High(aTotaleTurni[i].TotOpe2) do
          Add('TotGenTurno2_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe2[j].Operatore,ftInteger,0,False);
        for j:=Low(aTotaleTurni[i].TotOpe3) to High(aTotaleTurni[i].TotOpe3) do
          Add('TotGenTurno3_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe3[j].Operatore,ftInteger,0,False);
        for j:=Low(aTotaleTurni[i].TotOpe4) to High(aTotaleTurni[i].TotOpe4) do
          Add('TotGenTurno4_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe4[j].Operatore,ftInteger,0,False);

        {Aggiungere campi totali per operatore}
      end;
      //=================================
      Add('Debito',ftInteger,0,False);
      Add('Assegnato',ftInteger,0,False);
      Add('TotaleTurno1',ftInteger,0,False);
      Add('TotaleTurno2',ftInteger,0,False);
      Add('TotaleTurno3',ftInteger,0,False);
      Add('TotaleTurno4',ftInteger,0,False);
    end;
    with T058Stampa.IndexDefs do
    begin
      Clear;
      Add('TK','DataInizio;Squadra;Nome;Badge',[]);
      Add('PK','Squadra;Operatore;Nome;Badge',[]);
      Add('SK','Partenza;Nome;Badge',[]);
      Add('NK','Turni0;Nome;Badge',[])
    end;
    T058Stampa.CreateDataSet;
    T058Stampa.LogChanges:=False;
    if RadioGroup2.ItemIndex = 0 then
      T058Stampa.IndexName:='TK'//DataInizio;Squadra;Nome;Badge
    else if RadioGroup2.ItemIndex = 1 then
      T058Stampa.IndexName:='PK'//DataInizio;Squadra;Operatore;Nome
    else if RadioGroup2.ItemIndex = 2 then
      T058Stampa.IndexName:='SK';//DataInizio;Squadra;Partenza;Nome
    T058Stampa.Open;
  end;
end;

procedure TA058FDialogStampa.CaricaTabellaStampa;
var
  i,j,y,x,ggfine,Count:Integer;
  SigleSint:String;
begin
  with A058FPianifTurniDtM1,A058FPianifTurni do
  begin
    //Scorrimento dipendenti selezionati
    for i:=0 to Vista.Count - 1 do
    begin
      NumSquadre:=1;
      GetGiorni(i);
      for j:=1 to NumSquadre do
      begin
        T058Stampa.Append;
        (*Al*)T058Stampa.FieldByName('DataInizio').AsDateTime:=A058FPianifTurniDtm1.DataInizio + SalvaInizio;
        (*Al*)T058Stampa.FieldByName('DataFine').AsDateTime:=Min(A058FPianifTurniDtm1.DataInizio + SalvaFine,A058FPianifTurniDtm1.DataFine);
        T058Stampa.FieldByName('Matricola').AsString:=TDipendente(Vista[i]).Matricola;
        T058Stampa.FieldByName('Squadra').AsString:=Squadre[j].Squadra;
        T058Stampa.FieldByName('DSquadra').AsString:=Squadre[j].DSquadra;
        T058Stampa.FieldByName('Operatore').AsString:=Squadre[j].Oper;
        T058Stampa.FieldByName('Badge').AsInteger:=TDipendente(Vista[i]).Badge;
        T058Stampa.FieldByName('Nome').AsString:=TDipendente(Vista[i]).Cognome + ' ' + TDipendente(Vista[i]).Nome;
        T058Stampa.FieldByName('Progressivo').AsInteger:=TDipendente(Vista[i]).Prog;
        T058Stampa.FieldByName('Debito').AsInteger:=TDipendente(Vista[i]).Debito;
        T058Stampa.FieldByName('Assegnato').AsInteger:=TDipendente(Vista[i]).Assegnato;
        T058Stampa.FieldByName('TotaleTurno1').AsInteger:=TDipendente(Vista[i]).TotaleTurniMese.Turno1;
        T058Stampa.FieldByName('TotaleTurno2').AsInteger:=TDipendente(Vista[i]).TotaleTurniMese.Turno2;
        T058Stampa.FieldByName('TotaleTurno3').AsInteger:=TDipendente(Vista[i]).TotaleTurniMese.Turno3;
        T058Stampa.FieldByName('TotaleTurno4').AsInteger:=TDipendente(Vista[i]).TotaleTurniMese.Turno4;
        T058Stampa.FieldByName('Partenza').AsInteger:=TDipendente(Vista[i]).TurnoPartenza;
        with TDipendente(Vista[i]) do
        begin
          Count:=0;
    (*Al*)//for y:=0 to Giorni.Count - 1 do
    (*Al*)ggfine:=Min(SalvaFine,Giorni.Count - 1);
    (*Al*)for y:=SalvaInizio to ggfine do
          begin
            T058Stampa.FieldByName('CodOrari' + IntToStr(Count)).AsString:=TGiorno(Giorni[y]).Ora;
            T058Stampa.FieldByName('CodAssenze' + IntToStr(Count)).AsString:=TGiorno(Giorni[y]).Ass1;

            if RG3.ItemIndex = 0 then
            begin
              T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno1);
              T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno2);
              T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno3);
              T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno4);
            end;

            //Carico Totali copertura squadra suddivisi per
            //tipo operatore per tipo operatore
            for x:=Low(aTotaleTurni[y].TotOpe1) to High(aTotaleTurni[y].TotOpe1) do
              T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(Count) + '_'
                                     + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                     IntToStr(aTotaleTurni[y].TotOpe1[x].Totale);
            for x:=Low(aTotaleTurni[y].TotOpe2) to High(aTotaleTurni[y].TotOpe2) do
              T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(Count) + '_'
                                     + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                     IntToStr(aTotaleTurni[y].TotOpe2[x].Totale);
            for x:=Low(aTotaleTurni[y].TotOpe3) to High(aTotaleTurni[y].TotOpe3) do
              T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(Count) + '_'
                                     + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                     IntToStr(aTotaleTurni[y].TotOpe3[x].Totale);
            for x:=Low(aTotaleTurni[y].TotOpe4) to High(aTotaleTurni[y].TotOpe4) do
              T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(Count) + '_'
                                     + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                     IntToStr(aTotaleTurni[y].TotOpe4[x].Totale);

            {Valorizzazione dei campi totali operatore}
            T058Stampa.FieldByName('Orari' + IntToStr(Count)).AsString:=TGiorno(TDipendente(Vista[i]).Giorni[y]).Ora;

            //TURNO #1
            SigleSint:=TGiorno(TDipendente(Vista[i]).Giorni[y]).SiglaT1;
            if (SigleSint = '') and
               R180In(Trim(TGiorno(TDipendente(Vista[i]).Giorni[y]).T1),['A','--']) then
              SigleSint:='[' + Trim(TGiorno(TDipendente(Vista[i]).Giorni[y]).T1) + ']';
            //Se la stampa è predisposta per due righe dipendente rimuovo le parentesi
            if (rgpRigheDip.ItemIndex = 0) or (rgpRigheDip.ItemIndex = 1) then
            begin
              SigleSint:=StringReplace(SigleSint,']',')',[rfReplaceAll]);
              SigleSint:=StringReplace(SigleSint,'[','(',[rfReplaceAll]);
              SigleSint:=StringReplace(SigleSint,')',' ',[rfReplaceAll]);
              if TGiorno(TDipendente(Vista[i]).Giorni[y]).T1EU = '' then
                SigleSint:=StringReplace(SigleSint,'(',' ',[rfReplaceAll])
              else
                SigleSint:=StringReplace(SigleSint,'(','',[rfReplaceAll]);
            end;
            T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=SigleSint + TGiorno(TDipendente(Vista[i]).Giorni[y]).T1EU;

            //TURNO #2
            //Se la stampa è predisposta per due righe dipendente rimuovo le parentesi
            if TGiorno(TDipendente(Vista[i]).Giorni[y]).SiglaT2 <> '' then
            begin
              SigleSint:=TGiorno(TDipendente(Vista[i]).Giorni[y]).SiglaT2;
              if (SigleSint = '') and
                 R180In(Trim(TGiorno(TDipendente(Vista[i]).Giorni[y]).T2),['A','--']) then
                SigleSint:='[' + Trim(TGiorno(TDipendente(Vista[i]).Giorni[y]).T2) + ']';
              if (rgpRigheDip.ItemIndex = 0) or (rgpRigheDip.ItemIndex = 1) then
              begin
                SigleSint:=StringReplace(SigleSint,')',' ',[rfReplaceAll]);
                if TGiorno(TDipendente(Vista[i]).Giorni[y]).T2EU = '' then
                  SigleSint:=StringReplace(SigleSint,'(',' ',[rfReplaceAll])
                else
                  SigleSint:=StringReplace(SigleSint,'(','',[rfReplaceAll]);
              end;
              T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString + #13#10
              + SigleSint + TGiorno(TDipendente(Vista[i]).Giorni[y]).T2EU;
            end;

            if (A058FDialogStampa.ChkAssenze.Checked) and (RG1.ItemIndex = 1) and
               ((TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass1 + TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass2) <> '') then
              T058Stampa.FieldByName('Orari' + IntToStr(Count)).AsString:=TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass1 +
              ' ' + TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass2
            else if (A058FDialogStampa.ChkAssenze.Checked) and (RG1.ItemIndex = 0) and
               ((TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass1 + TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass2) <> '') then
              T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass1 +
              ' ' + TGiorno(TDipendente(Vista[i]).Giorni[y]).Ass2;
            inc(Count);
          end;
        end;
        T058Stampa.Post;
      end;
    end;
  end;
end;

procedure TA058FDialogStampa.GetGiorni(Dip:Integer);
var
  i,j,xx,NumTurno1,NumTurno2:Integer;
  T:String;
  DataCorr:TDateTime;
  A,M,G:Word;
  Giorno:TGiorno;
begin
  for xx:=Low(Squadre) to High(Squadre) do
  begin
    Squadre[xx].DSquadra:='';
    Squadre[xx].Oper:='';
    Squadre[xx].S1:='';
    Squadre[xx].S2:='';
    Squadre[xx].Squadra:='';
  end;
  NumSquadre:=0;
  SquadraOld:='';
  (*Al*)//DataCorr:=A058FPianifTurni.DataInizio;
  (*Al*)DataCorr:=A058FPianifTurniDtm1.DataInizio + SalvaInizio;
  with TDipendente(A058FPianifTurniDtm1.Vista[Dip]) do
  begin
    //Alberto 29/12/2005: aggiorno i totali turni individuali
    TotaleTurniMese.Turno1:=0;
    TotaleTurniMese.Turno2:=0;
    TotaleTurniMese.Turno3:=0;
    TotaleTurniMese.Turno4:=0;
    (*Al*)//for i:=0 to Giorni.Count - 1 do
    (*Al*)for i:=SalvaInizio to Min(SalvaFine,Giorni.Count - 1) do
    begin
      if SquadraOld <> TGiorno(Giorni[i]).Squadra then
      begin
        SquadraOld:=TGiorno(Giorni[i]).Squadra;
        PSquadra:=GetSquadra(SquadraOld);
        if PSquadra = 0 then
        begin
          inc(NumSquadre);
          PSquadra:=NumSquadre;
          Squadre[PSquadra].S1:=R180DimLung('',(i - SalvaInizio) * LungCella);
          Squadre[PSquadra].S2:=R180DimLung('',(i - SalvaInizio) * LungCella);
        end;
        Squadre[PSquadra].Squadra:=TGiorno(Giorni[i]).Squadra;
        Squadre[PSquadra].DSquadra:=TGiorno(Giorni[i]).DSquadra;
        Squadre[PSquadra].Oper:=TGiorno(Giorni[i]).Oper;
      end;
      if NumSquadre = 0 then
      begin
        SquadraOld:=TGiorno(Giorni[i]).Squadra;
        inc(NumSquadre);
        PSquadra:=NumSquadre;
        Squadre[PSquadra].Squadra:=TGiorno(Giorni[i]).Squadra;
        Squadre[PSquadra].DSquadra:=TGiorno(Giorni[i]).DSquadra;
        Squadre[PSquadra].Oper:=TGiorno(Giorni[i]).Oper;
      end;
      if RG3.ItemIndex = 1 then
      //Utilizzo i dati ritornati dai conteggi anzichè quelli pianificati
      begin
        DecodeDate(DataCorr,A,M,G);
        (*Alberto (Pescara)*)
        A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.Progressivo:=0;
        A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.Data:=0;
        A058FPianifTurniDtM1.R502ProDtM.Conteggi('Cartolina',Prog,DataCorr);

        {Aggiorno contatore totale liquidabile}
        inc(A058FPianifTurniDtM1.aTotaleTurni[i].TotOraLiquid,R180SommaArray(A058FPianifTurniDtM1.R502ProDtM.tminstrgio));
        {-- CALCOLO TOTALE TURNI DA CONTEGGI GIORNALIERI(Stampa consuntiva) --}
        with A058FPianifTurniDtM1 do
          if (R502ProDtM.blocca = 0) then
          begin
            NumTurno1:=-1;
            NumTurno2:=-1;
            if R502ProDtM.r_turno1 >= 0 then
              NumTurno1:=R502ProDtM.ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,R502ProDtM.r_turno1];
            if R502ProDtM.r_turno2 >= 0 then
              NumTurno2:=R502ProDtM.ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,R502ProDtM.r_turno2];
            if (NumTurno1 = 1) or (NumTurno2 = 1) then
              inc(aTotaleTurni[i].Rp502Turno1);
            if (NumTurno1 = 2) or (NumTurno2 = 2)  then
              inc(aTotaleTurni[i].Rp502Turno2);
            if (NumTurno1 = 3) or (NumTurno2 = 3)  then
              inc(aTotaleTurni[i].Rp502Turno3);
            if (NumTurno1 = 4) or (NumTurno2 = 4)  then
              inc(aTotaleTurni[i].Rp502Turno4);
          end;

        TGiorno(GiorniOld[i]).T1:=TGiorno(Giorni[i]).T1;
        TGiorno(GiorniOld[i]).T2:=TGiorno(Giorni[i]).T2;
        TGiorno(GiorniOld[i]).T1EU:=TGiorno(Giorni[i]).T1EU;
        TGiorno(GiorniOld[i]).T2EU:=TGiorno(Giorni[i]).T2EU;
        TGiorno(GiorniOld[i]).Ora:=TGiorno(Giorni[i]).Ora;
        TGiorno(GiorniOld[i]).Ass1:=TGiorno(Giorni[i]).Ass1;
        TGiorno(GiorniOld[i]).SiglaT1:=TGiorno(Giorni[i]).SiglaT1;
        TGiorno(GiorniOld[i]).SiglaT2:=TGiorno(Giorni[i]).SiglaT2;

        if (A058FPianifTurniDtM1.R502ProDtM.Blocca <> 0) or (A058FPianifTurniDtM1.R502ProDtM.dipinser = 'no') then
        begin
          TGiorno(Giorni[i]).T1:='';
          TGiorno(Giorni[i]).T2:='';
          TGiorno(Giorni[i]).T1EU:='';
          TGiorno(Giorni[i]).T2EU:='';
          TGiorno(Giorni[i]).Ora:='';
          TGiorno(Giorni[i]).Ass1:='';
          TGiorno(Giorni[i]).SiglaT1:='';
          TGiorno(Giorni[i]).SiglaT2:='';
        end
        else
        begin
          //1° Turno
          TGiorno(Giorni[i]).T1:='';
          if A058FPianifTurniDtM1.R502ProDtM.r_turno1 > 0 then
            TGiorno(Giorni[i]).T1:=IntToStr(A058FPianifTurniDtM1.R502ProDtM.r_turno1)
          else
            TGiorno(Giorni[i]).T1:='';
          //2° Turno
          TGiorno(Giorni[i]).T2:='';
          if A058FPianifTurniDtM1.R502ProDtM.r_turno2 > 0 then
            TGiorno(Giorni[i]).T2:=IntToStr(A058FPianifTurniDtM1.R502ProDtM.r_turno2)
          else
            if A058FPianifTurniDtM1.R502ProDtM.c_turni2 = 0 then
              TGiorno(Giorni[i]).T2:='';
          //Orario
          TGiorno(Giorni[i]).Ora:=A058FPianifTurniDtM1.R502ProDtM.c_orario;
          //Assenza
          TGiorno(Giorni[i]).Ass1:='';
          if A058FPianifTurniDtM1.R502ProDtM.n_giusgga > 0 then
            TGiorno(Giorni[i]).Ass1:=A058FPianifTurniDtM1.R502ProDtM.tgius_ggass[1].tcausggass;

          Giorno:=TGiorno(Giorni[i]);
          A058FPianifTurniDtm1.GetDatiTurno(Giorno);
          TGiorno(Giorni[i]).SiglaT1:=Giorno.SiglaT1;
          TGiorno(Giorni[i]).SiglaT2:=Giorno.SiglaT2;
        end;
        //Alberto (Pescara)
        TGiorno(Giorni[i]).Debito:=A058FPianifTurniDtM1.R502ProDtM.debitocl;
        TGiorno(Giorni[i]).Assegnato:=0;//A058FPianifTurniDtM1.R502ProDtM.debitogg;
        with A058FPianifTurniDtM1.R502ProDtM do
        begin
          if PianificazioneEsterna.l08_turno1 > 0 then
            inc(TGiorno(Giorni[i]).Assegnato,
                ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,PianificazioneEsterna.l08_turno1]);
          if PianificazioneEsterna.l08_turno2 > 0 then
            inc(TGiorno(Giorni[i]).Assegnato,
                ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,PianificazioneEsterna.l08_turno2]);
          if TGiorno(Giorni[i]).Assegnato = 0 then
            TGiorno(Giorni[i]).Assegnato:=debitogg;
        end;
      end
      //Alberto (Pescara)
      else if (not A058FPianifTurniDtm1.ConteggiaDebito) and (ChkSaldi.Checked) then
      begin
        A058FPianifTurniDtm1.ConteggiaDebito:=True;
        A058FPianifTurniDtM1.ConteggiGiornalieri(DataCorr,Dip,i);
        A058FPianifTurniDtm1.ConteggiaDebito:=False;
      end;
      //Leggo la sigla dei turni
      Giorno:=TGiorno(GiorniOld[i]);
      A058FPianifTurniDtm1.GetDatiTurno(Giorno);
      TGiorno(GiorniOld[i]).SiglaT1:=Giorno.SiglaT1;
      TGiorno(GiorniOld[i]).SiglaT2:=Giorno.SiglaT2;
      TGiorno(GiorniOld[i]).NumTurno1:=Giorno.NumTurno1;
      //Fine lettura sigla dei turni
      //Se assenza e stampa ridotta scrivo il codice assenza al posto del turno
      if (TGiorno(Giorni[i]).Ass1 <> '') and (RG1.ItemIndex = 0) then
        Squadre[PSquadra].S1:=Squadre[PSquadra].S1 + R180DimLung(TGiorno(Giorni[i]).Ass1,LungCella)
      else
        //Leggo la descrizione turni dall'orario
      begin
        T:=Turni(TGiorno(Giorni[i]));
        if (Trim(T) = '') and (RG1.ItemIndex = 0) then
          T:=R180DimLung(TGiorno(Giorni[i]).Ora,LungCella);
        Squadre[PSquadra].S1:=Squadre[PSquadra].S1 + T;
      end;
      if TGiorno(Giorni[i]).Ass1 = '' then
      begin
        if RG1.ItemIndex = 1 then
          //Scrivo codice orario
          Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung(TGiorno(Giorni[i]).Ora,LungCella)
        else
          Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung('',LungCella);
      end
      else
        //Scrivo codice assenza
      begin
        if RG1.ItemIndex = 1 then
          Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung(TGiorno(Giorni[i]).Ass1,LungCella)
        else
          Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + '      ';
      end;
      for j:=1 to NumSquadre do
        if j <> PSquadra then
        begin
          Squadre[j].S1:=Squadre[j].S1 + R180DimLung('',LungCella);
          Squadre[j].S2:=Squadre[j].S2 + R180DimLung('',LungCella);
        end;
      //Alberto 29/12/2005: aggiornamento totali turni individuali per il periodo in stampa
      A058FPianifTurniDtm1.TotaleTurniInd(Dip,i);
      DataCorr:=DataCorr + 1;
    end;
  end;
  A058FPianifTurniDtm1.DebitoDipendente(Dip,SalvaInizio,Min(SalvaFine,TDipendente(A058FPianifTurniDtm1.Vista[Dip]).Giorni.Count - 1));
end;

function TA058FDialogStampa.GetSquadra(S:String):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to NumSquadre do
    if Squadre[i].Squadra = S then
    begin
      Result:=i;
      Break;
    end;
end;

function TA058FDialogStampa.Turni(GiornoIn:TGiorno):String;
{Restituisco la stringa dei 2 turni}
var Giorno:TGiorno;
    T1,T2:String;
begin
  T1:=Trim(GiornoIn.T1);
  if GiornoIn.T1EU = 'U' then
    T1:= '-8';
  T2:=Trim(GiornoIn.T2);
  Result:=Copy('      ',1,LungCella);
  if T1 = '0' then
  begin
    Result:=Copy('Rp    ',1,LungCella);
    exit;
  end;
  if T1 = '-8' then
  //Smonto notte
  begin
    Result:=Copy('Sn    ',1,LungCella);
    exit;
  end;
  Giorno:=TGiorno.Create;
  Giorno.T1:=T1;
  Giorno.T2:=T2;
  Giorno.Ora:=Trim(GiornoIn.Ora);
  A058FPianifTurniDtm1.GetDatiTurno(Giorno);
  Result:=R180DimLung(Giorno.SiglaT1,3);
  if Giorno.T2 <> '' then
    Result:=Result + R180DimLung(Giorno.SiglaT2,3)
  else
    Result:=R180DimLung(Result,LungCella);
  Giorno.Free;
end;

procedure TA058FDialogStampa.ScriviPiede(NDip:Integer);
{Scrivo la descrizione degli orari e delle assenze sul piè di pagina}
var i:Integer;
  S:TStringList;
begin
  S:=TStringList.Create;
  with A058FPianifTurniDtM1.T058Stampa do
  begin
    if ChkSaldi.Checked then
    begin
      A058FTabellone.QrLblDebito.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Debito').AsInteger)]);
      A058FTabellone.QRLblAssegnato.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Assegnato').AsInteger)]);
      A058FTabellone.QRLblScostamento.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Assegnato').AsInteger - FieldByName('Debito').AsInteger)]);
    end;
    if ChkTotaleTurni.Checked then
    begin
      A058FTabellone.QrLblTotTurno1.Caption:='1°T ' + Format('%3s',[IntToStr(FieldByName('TotaleTurno1').AsInteger)]);
      A058FTabellone.QrLblTotTurno2.Caption:='2°T ' + Format('%3s',[IntToStr(FieldByName('TotaleTurno2').AsInteger)]);
      A058FTabellone.QrLblTotTurno3.Caption:='3°T ' + Format('%3s',[IntToStr(FieldByName('TotaleTurno3').AsInteger)]);
      A058FTabellone.QrLblTotTurno4.Caption:='4°T ' + Format('%3s',[IntToStr(FieldByName('TotaleTurno4').AsInteger)]);
    end;
    if (ChkTotaleTurni.Checked and (rgpRigheDip.ItemIndex = 0)) then
    begin
      A058FTabellone.QrLblTotTurno1.Caption:=IntToStr(FieldByName('TotaleTurno1').AsInteger);
      A058FTabellone.QrLblTotTurno1.Caption:=A058FTabellone.QrLblTotTurno1.Caption + '  ' + IntToStr(FieldByName('TotaleTurno2').AsInteger);
      A058FTabellone.QrLblTotTurno1.Caption:=A058FTabellone.QrLblTotTurno1.Caption + '  ' + IntToStr(FieldByName('TotaleTurno3').AsInteger);
      if rgpRigheDip.ItemIndex = 2  then
        A058FTabellone.QrLblTotTurno1.Caption:=A058FTabellone.QrLblTotTurno1.Caption + '  ' + IntToStr(FieldByName('TotaleTurno4').AsInteger);
    end;
    if ChkSaldi.Checked and (rgpRigheDip.ItemIndex = 0) then
       A058FTabellone.QrLblTotTurno2.Caption:=R180MinutiOre(FieldByName('Debito').AsInteger) + '\' + R180MinutiOre(FieldByName('Assegnato').AsInteger);
     with A058FPianifTurniDtM1 do
      for i:=0 to T058Stampa.FieldCount - 1 do
      begin
        if Pos('CodOrari',T058Stampa.Fields[i].FieldName) > 0  then
          PutOrario(T058Stampa.Fields[i].AsString);

        if Pos('CodAssenze',T058Stampa.Fields[i].FieldName) > 0  then
          PutAssenza(T058Stampa.Fields[i].AsString);
      end;
  end;
  FreeAndNil(S);
end;

procedure TA058FDialogStampa.PutOrario(Ora:String);
{Scrivo la descrizione degli orari nel riepilogo}
var S,ST:String;
    i:Integer;
begin
  with A058FPianifTurniDtM1 do
    if (A058FTabellone.LOrari.IndexOf(Ora) = -1) and (Q020.Locate('Codice',Ora,[])) then
    begin
      A058FTabellone.LOrari.Add(Ora);
      S:=R180DimLung(Q020.FieldByName('Codice').AsString,6) + R180DimLung(Q020.FieldByName('Descrizione').AsString,41);
      A058FTabellone.QRMOrari.Lines.Add(S);
      i:=A058FTabellone.QRMOrari.Lines.Count - 1;
      Q020Turni.Close;
      Q020Turni.SetVariable('COD',Q020.FieldByName('Codice').AsString);
      Q020Turni.SetVariable('DATA',Q020.FieldByName('DECORRENZA').AsDateTime);
      Q020Turni.Open;
      while not Q020Turni.Eof do
      begin
        if Q020Turni.FieldByName('SIGLATURNI').AsString='' then
          ST:='[' + Q020Turni.FieldByName('NumTurno').AsString + ']'
        else
          ST:='(' + Q020Turni.FieldByName('SIGLATURNI').AsString + ')';
        S:='  ' + ST + ' = ' + Q020Turni.FieldByName('Entrata').AsString + ' - ' + Q020Turni.FieldByName('Uscita').AsString;
        A058FTabellone.QRLblTemp.Caption:=A058FTabellone.QRMOrari.Lines[i] + S;
        if A058FTabellone.QRMOrari.Left + A058FTabellone.QRLblTemp.Width >= (A058FTabellone.Piede2.Width - 50) then
        begin
          //Creo una nuova riga...
          A058FTabellone.QRMOrari.Lines.Add(R180DimLung(Q020.FieldByName('Codice').AsString,6) + R180DimLung(Q020.FieldByName('Descrizione').AsString,41));
          i:=A058FTabellone.QRMOrari.Lines.Count - 1;
        end;
        A058FTabellone.QRMOrari.Lines[i]:=A058FTabellone.QRMOrari.Lines[i] + S;
        A058FTabellone.QRLblTemp.Caption:='';
        Q020Turni.Next;
      end;
    end;
end;

procedure TA058FDialogStampa.PutAssenza(Ass:String);
{Scrivo la descrizione delle assenze nel riepilogo}
var P:Integer;
    S:String;
begin
  with A058FPianifTurniDtM1.Q265 do
    if (A058FTabellone.LAssenze.IndexOf(Ass) = -1) and (Locate('Codice',Ass,[])) then
    begin
      A058FTabellone.LAssenze.Add(Ass);
      S:=R180DimLung(FieldByName('Codice').AsString,6) + R180DimLung(FieldByName('Descrizione').AsString,41);
      P:=A058FTabellone.QRMAssenze.Lines.Count;
      if P = 0 then
        A058FTabellone.QRMAssenze.Lines.Add(S)
      else
        if Length(A058FTabellone.QRMAssenze.Lines[P - 1]) > 50 then
          A058FTabellone.QRMAssenze.Lines.Add(S)
        else
          A058FTabellone.QRMAssenze.Lines[P - 1]:=A058FTabellone.QRMAssenze.Lines[P - 1] + S;
    end;
end;

procedure TA058FDialogStampa.FormDestroy(Sender: TObject);
begin
  A058FTabellone.Release;
end;

procedure TA058FDialogStampa.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A058B',Parametri.ProgOper);
  GetParametriFunzione;
  C004FParamForm.Free;
  RG3Click(Self);
  edtNumGG.MaxValue:=DaysBetween(A058FPianifTurniDtm1.DataFine,A058FPianifTurniDtm1.DataInizio)+1;
  if edtNumGG.Value > edtNumGG.MaxValue then
    edtNumGG.Value:=edtNumGG.MaxValue;
end;

procedure TA058FDialogStampa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CreaC004(SessioneOracle,'A058B',Parametri.ProgOper);
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA058FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
var
  Aus:String;
begin
  with A058FDialogStampa do
  begin
    ETitolo.Text:=C004FParamForm.GetParametro('TITOLO','Tabellone Turni');
    ENota.Text:=C004FParamForm.GetParametro('NOTA','NOTA: Ogni richiesta di variazione dovrà essere trasmessa a questo ufficio');
    EDesc1.Text:=C004FParamForm.GetParametro('DESCRIZIONE1','L''UFFICIO DEL PERSONALE');
    EDesc2.Text:=C004FParamForm.GetParametro('DESCRIZIONE2','IL DIRETTORE SANITARIO');
    RG1.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSTAMPA','0'));
    RadioGroup2.ItemIndex:=StrToInt(C004FParamForm.GetParametro('ORDINAMENTO','0'));
    RG3.ItemIndex:=StrToInt(C004FParamForm.GetParametro('PREVENTIVACONSUNTIVA','0'));
    ChkTotTurno.Checked:=C004FParamForm.GetParametro('TOTTURNO','N')='S';
    ChkDettaglioOrari.Checked:=C004FParamForm.GetParametro('DETTORARI','N')='S';
    ChkAssenze.Checked:=C004FParamForm.GetParametro('ASSENZE','N')='S';
    ChkSaldi.Checked:=C004FParamForm.GetParametro('SALDI','N')='S';
    ChkSepColonne.Checked:=C004FParamForm.GetParametro('SEPARATORE_COLONNE','S')='S';
    ChkSepRighe.Checked:=C004FParamForm.GetParametro('SEPARATORE_RIGHE','S')='S';
    ChkTotOper.Checked:=C004FParamForm.GetParametro(UpperCase(chkTotOper.Name),'N') = 'S';
    chkLiquid.Checked:=C004FParamForm.GetParametro(UpperCase(chkLiquid.Name),'N') = 'S';
    chkTotGenTurni.Checked:=C004FParamForm.GetParametro(UpperCase(chkTotGenTurni.Name),'N') = 'S';
    cmbOriPagina.ItemIndex:=StrToInt(C004FParamForm.GetParametro(UpperCase(cmbOriPagina.Name),'0'));
    Aus:=C004FParamForm.GetParametro('NUMERO_GIORNI','1');
    if (StrToInt(Aus) >= 28) and (StrToInt(Aus) <= 31) and (R180Anno(A058FPianifTurniDtm1.DataInizio) = R180Anno(A058FPianifTurniDtm1.DataFine)) and
       (R180Mese(A058FPianifTurniDtm1.DataInizio) = R180Mese(A058FPianifTurniDtm1.DataFine)) then
      Aus:=IntToStr(R180GiorniMese(A058FPianifTurniDtm1.DataInizio));
    edtNumGG.Text:=Aus;
    ChkTotaleTurni.Checked:=C004FParamForm.GetParametro('TOTALE_TURNI_MESE','S')='S';
    SEdtFontSize.Text:=C004FParamForm.GetParametro(UpperCase(SEdtFontSize.Name),'8');
    rgpRigheDip.ItemIndex:=StrToInt(C004FParamForm.GetParametro(UpperCase(rgpRigheDip.Name),'1'));
    edtMargineSx.Value:=StrToInt(C004FParamForm.GetParametro(UpperCase(edtMargineSx.Name),'5'));
  end;
end;
//------------------------------------------------------------------------------
procedure TA058FDialogStampa.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  with A058FDialogStampa do
  begin
    C004FParamForm.PutParametro(UpperCase(rgpRigheDip.Name),IntToStr(rgpRigheDip.ItemIndex));
    C004FParamForm.PutParametro(UpperCase(edtMargineSx.Name),IntToStr(edtMargineSx.Value));
    C004FParamForm.PutParametro(UpperCase(SEdtFontSize.Name),SEdtFontSize.Text);
    C004FParamForm.PutParametro('TITOLO',Copy(ETitolo.text,1,80));
    C004FParamForm.PutParametro('NOTA',Copy(ENota.text,1,80));
    C004FParamForm.PutParametro('DESCRIZIONE1',Copy(EDesc1.text,1,80));
    C004FParamForm.PutParametro('DESCRIZIONE2',Copy(EDesc2.text,1,80));
    C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(RG1.ItemIndex));
    C004FParamForm.PutParametro('ORDINAMENTO',IntToStr(RadioGroup2.ItemIndex));
    C004FParamForm.PutParametro('PREVENTIVACONSUNTIVA',IntToStr(RG3.ItemIndex));
    C004FParamForm.PutParametro(UpperCase(cmbOriPagina.Name),IntToStr(cmbOriPagina.ItemIndex));
    if ChkTotTurno.Checked then
      C004FParamForm.PutParametro('TOTTURNO','S')
    else
      C004FParamForm.PutParametro('TOTTURNO','N');
    if ChkDettaglioOrari.Checked then
      C004FParamForm.PutParametro('DETTORARI','S')
    else
      C004FParamForm.PutParametro('DETTORARI','N');
    if ChkAssenze.Checked then
      C004FParamForm.PutParametro('ASSENZE','S')
    else
      C004FParamForm.PutParametro('ASSENZE','N');
    if ChkSaldi.Checked then
      C004FParamForm.PutParametro('SALDI','S')
    else
      C004FParamForm.PutParametro('SALDI','N');
    if ChkSepColonne.Checked then
      C004FParamForm.PutParametro('SEPARATORE_COLONNE','S')
    else
      C004FParamForm.PutParametro('SEPARATORE_COLONNE','N');
    if chkLiquid.Checked then
      C004FParamForm.PutParametro(UpperCase(chkLiquid.Name),'S')
    else
      C004FParamForm.PutParametro(UpperCase(chkLiquid.Name),'N');
    if chkTotGenTurni.Checked then
      C004FParamForm.PutParametro(UpperCase(chkTotGenTurni.Name),'S')
    else
      C004FParamForm.PutParametro(UpperCase(chkTotGenTurni.Name),'N');
    if chkTotOper.Checked then
      C004FParamForm.PutParametro(UpperCase(chkTotOper.Name),'S')
    else
      C004FParamForm.PutParametro(UpperCase(chkTotOper.Name),'N');
    if ChkSepRighe.Checked then
      C004FParamForm.PutParametro('SEPARATORE_RIGHE','S')
    else
      C004FParamForm.PutParametro('SEPARATORE_RIGHE','N');
    C004FParamForm.PutParametro('NUMERO_GIORNI',edtNumGG.Text);
    if ChkTotaleTurni.Checked then
      C004FParamForm.PutParametro('TOTALE_TURNI_MESE','S')
    else
      C004FParamForm.PutParametro('TOTALE_TURNI_MESE','N');
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TA058FDialogStampa.RG3Click(Sender: TObject);
begin
  chkLiquid.Enabled:=RG3.ItemIndex = 1;
  chkTotOper.Enabled:=RG3.ItemIndex = 0;
  if Not chkLiquid.Enabled then
    chkLiquid.Checked:=False;
end;

end.
