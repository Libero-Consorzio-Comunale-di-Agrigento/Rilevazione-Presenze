unit B002UAggiornamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, {DbTables,} ComCtrls, Grids, DBGrids, Menus, ExtCtrls,
  Buttons, Variants;

const NumMax = 20;

type
  TProva = class
    S:String;
    A1,A2:array[0..NumMax] of String;
  end;

  TB002FAggiornamento = class(TForm)
    Db1: TDatabase;
    Db2: TDatabase;
    QDest: TQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    PopupMenu1: TPopupMenu;
    Valoredidefault1: TMenuItem;
    Autoincrementante1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label10: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    ListBox3: TListBox;
    ListBox5: TListBox;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox3: TComboBox;
    Button2: TButton;
    Label1: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    ListBox2: TListBox;
    ListBox4: TListBox;
    Label7: TLabel;
    ComboBox4: TComboBox;
    Button3: TButton;
    Label2: TLabel;
    Label4: TLabel;
    ComboBox2: TComboBox;
    Button1: TButton;
    Label8: TLabel;
    TabSheet2: TTabSheet;
    Button4: TButton;
    TabSheet3: TTabSheet;
    QSorg: TQuery;
    TabSheet4: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button5: TButton;
    Q430: TQuery;
    Q030: TQuery;
    OperSQL: TQuery;
    T035: TTable;
    Label11: TLabel;
    Label12: TLabel;
    OpenSeq: TOpenDialog;
    Label13: TLabel;
    NomeFile: TEdit;
    Button6: TButton;
    BMappatura: TButton;
    BApri: TButton;
    BQueryDest: TButton;
    ListBox6: TListBox;
    PopupMenu2: TPopupMenu;
    MenuItem3: TMenuItem;
    Transcodifica1: TMenuItem;
    Invariato1: TMenuItem;
    ProgAnagra: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox3Exit(Sender: TObject);
    procedure ListBox3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox3DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Valoredidefault1Click(Sender: TObject);
    procedure Autoincrementante1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Q430FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Button6Click(Sender: TObject);
    procedure BMappaturaClick(Sender: TObject);
    procedure BApriClick(Sender: TObject);
    procedure Sostituzione1Click(Sender: TObject);
    procedure Transcodifica1Click(Sender: TObject);
    procedure Invariato1Click(Sender: TObject);
  private
    { Private declarations }
    Alias1,Alias2,Tabella1,Tabella2,RigaSeq:String;
    Campi,
    Anomalie,              //Elenco anomalie in scrittura su QDest
    WhereSorg:TStringList; //Filtro su QSorg (WHERE ...)
    Q430Decorrenza,Q430Fine,DecorrenzaK:TDateTime;
    Q430Progressivo:LongInt;
    PrimoEof:Boolean;  //Usato per Eof di file sequenziale
    TuttoStorico:(tsTutto,tsPrima,tsDopo); {tipo di filtro su archivio T430_Storico}
    RicercaAnagrafico:String;
    ValoriEsistenti:TStringList;
    function AppendEdit(Anagrafico:Boolean):boolean;
    function ValoreSorgente(i:Word; Campo:TField):String;
    function TrasformaValore(i:Word; Sorg:String):String;
    procedure AggiornaAnagrafe(Cont:Word);
    function RicercaStorico(Prog:LongInt):boolean;
    procedure StartSorgente;
    function FineSorg:Boolean;
    procedure NextSorg;
    procedure PulisciListBox6(P:Integer);
    procedure GetValoriEsistenti(Lista:TStringList);
    procedure PutValoriEsistenti(Lista:TStringList);
    procedure ApriAnagrafico(Prog:LongInt);
    procedure AggiornamentoStoriciSuccessivi(Data:TDateTime);
  public
    { Public declarations }
    KeySorg,KeyDest:TStringList;
    StoriciSuccessivi:Boolean;
  end;

var
  B002FAggiornamento: TB002FAggiornamento;
  FileTesto:TextFile;

implementation

uses B002USorgente, B002UDestinatario, B002UCampiChiave, B002UQuery,
  B002UMappatura, B002UDataStorici, B002UTranscodifica;

{$R *.DFM}

procedure TB002FAggiornamento.FormCreate(Sender: TObject);
begin
 {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat:='dd/mm/yyyy';  
 Session.GetAliasNames(ComboBox1.Items);
 ComboBox2.Items.Assign(ComboBox1.Items);
 Alias1:='';
 Alias2:='';
 Tabella1:='';
 Tabella2:='';
 Campi:=TStringList.Create;
 Anomalie:=TStringList.Create;
 KeyDest:=TStringList.Create;
 KeySorg:=TStringList.Create;
 WhereSorg:=TStringList.Create;
 TabSheet1.TabVisible:=False;
 TabSheet2.TabVisible:=False;
 TabSheet3.TabVisible:=False;
 PageControl1.ActivePage:=TabSheet4;
 DecorrenzaK:=Date;
end;

procedure TB002FAggiornamento.BitBtn1Click(Sender: TObject);
{Scelta dati sorgenti}
begin
  if Sender = BitBtn1 then
    begin
    TabSheet1.TabVisible:=True;
    TabSheet2.TabVisible:=False;
    TabSheet3.TabVisible:=False;
    PageControl1.ActivePage:=TabSheet1;
    end;
  if Sender = BitBtn2 then
    begin
    TabSheet1.TabVisible:=False;
    TabSheet2.TabVisible:=True;
    TabSheet3.TabVisible:=False;
    PageControl1.ActivePage:=TabSheet2;
    end;
  if Sender = BitBtn3 then
    begin
    TabSheet1.TabVisible:=False;
    TabSheet2.TabVisible:=False;
    TabSheet3.TabVisible:=True;
    PageControl1.ActivePage:=TabSheet3;
    end;
  if PageControl1.ActivePage <> TabSheet3 then
    ListBox1.Parent:=PageControl1.ActivePage;
  ListBox3.Parent:=PageControl1.ActivePage;
  ListBox5.Parent:=PageControl1.ActivePage;
  Button4.Visible:=PageControl1.Activepage <> TabSheet3;
  BQueryDest.Visible:=PageControl1.Activepage = TabSheet3;
end;

procedure TB002FAggiornamento.ComboBox1Exit(Sender: TObject);
{Apro i database richiesti fornendo l'elenco delle tabelle}
begin
  if Sender = ComboBox1 then
    begin
    if Alias1 = ComboBox1.Text then exit;
    Alias1:=ComboBox1.Text;
    Db1.Close;
    Db1.AliasName:=ComboBox1.Text;
    ComboBox3.Items.Clear;
    try
      Db1.Open;
    except
      Alias1:='';
      raise Exception.Create('Alias inesistente! troppo difficile usare la lista?');
    end;
    Label3.Caption:=Session.GetAliasDriverName(Db1.AliasName);
    Session.GetTableNames('Db1','*.*',False,False,ComboBox3.Items);
    end;
  if Sender = ComboBox2 then
    begin
    if Alias2 = ComboBox2.Text then exit;
    Alias2:=ComboBox2.Text;
    Db2.Close;
    Db2.AliasName:=ComboBox2.Text;
    ComboBox4.Items.Clear;
    try
      Db2.Open;
    except
      Alias2:='';
      raise Exception.Create('Alias inesistente! troppo difficile usare la lista?');
    end;
    Label4.Caption:=Session.GetAliasDriverName(Db2.AliasName);
    Session.GetTableNames('Db2','*.*',False,False,ComboBox4.Items);
    end;
end;

procedure TB002FAggiornamento.ComboBox3Exit(Sender: TObject);
{Lettura della struttura della tabella e visualizzazione campi}
var i:Integer;
begin
  if Sender = ComboBox3 then
    begin
    if ComboBox3.Text = Tabella1 then exit;
    Tabella1:=ComboBox3.Text;
    ListBox1.Items.Clear;
    ListBox3.Items.Clear;
    ListBox5.Items.Clear;
    WhereSorg.Clear;
    ProgAnagra.Close;
    with QSorg do
      begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + ComboBox3.Text);
      FieldDefs.Update;
      for i:=0 to FieldDefs.Count - 1 do
        ListBox1.Items.Add(FieldDefs[i].Name);
      end;
    end;
  if Sender = ComboBox4 then
    begin
    if ComboBox4.Text = Tabella2 then exit;
    Tabella2:=ComboBox4.Text;
    //Se scelgo T030 o T430 devo aprirli entrambi per aggiornare l'anagrafico
    if (Tabella2 = 'T030_ANAGRAFICO') or (Tabella2 = 'T430_STORICO') then
      begin
      ComboBox4.ItemIndex:=ComboBox4.Items.IndexOf('T030_ANAGRAFICO');
      Tabella2:=ComboBox4.Text;
      end;
    ListBox2.Items.Clear;
    ListBox4.Items.Clear;
    PulisciListBox6(-1);
    ListBox6.Items.Clear;
    with QDest do
      begin
      Close;
      SQL.Clear;
      if Tabella2 = 'T030_ANAGRAFICO' then
        begin
        if Label4.Caption = 'ORACLE' then
          begin
          SQL.Add('SELECT * FROM T030_ANAGRAFICO T030, T430_STORICO T430 WHERE T030.PROGRESSIVO = T430.PROGRESSIVO');
          RicercaAnagrafico:='SELECT T030.PROGRESSIVO FROM T030_ANAGRAFICO T030, T430_STORICO T430 WHERE T030.PROGRESSIVO = T430.PROGRESSIVO AND ';
          with OperSQL do
            begin
            SQL.Clear;
            SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = ''MM/DD/YYYY''');
            ExecSql;
            end;
         end
        else
          begin
          SQL.Add('SELECT * FROM T030_ANAGRAFICO T030 INNER JOIN T430_STORICO T430 ON T030.PROGRESSIVO = T430.PROGRESSIVO');
          RicercaAnagrafico:='SELECT T030.PROGRESSIVO FROM T030_ANAGRAFICO T030 INNER JOIN T430_STORICO T430 ON T030.PROGRESSIVO = T430.PROGRESSIVO WHERE ';
          end;
        QDest.RequestLive:=False;
        end
      else
        begin
        SQL.Add('SELECT * FROM ' + ComboBox4.Text);
        QDest.RequestLive:=True;
        end;
      FieldDefs.Update;
      for i:=0 to FieldDefs.Count - 1 do
        ListBox2.Items.Add(FieldDefs[i].Name);
      end;
    end;
  with B002FCampiChiave do
    begin
    ListBox1.Items.Clear;
    ListBox2.Items.Clear;
    ListBox5.Items.Clear;
    end;
  KeySorg.Clear;
  KeyDest.Clear;
  B002FCampiChiave.ListBox1.Items.Assign(ListBox1.Items);
  B002FCampiChiave.ListBox5.Items.Assign(ListBox2.Items);
end;

procedure TB002FAggiornamento.ListBox3DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
{Accettazione o meno di un campo sulla list box con il drag & drop}
begin
  if Sender = ListBox3 then
    begin
    Accept:=Source = ListBox1;
    if not Accept then exit;
    Accept:=ListBox1.ItemIndex > -1;
    if not Accept then exit;
    end
  else
    begin
    Accept:=Source = ListBox2;
    if not Accept then exit;
    Accept:=ListBox2.ItemIndex > -1;
    if not Accept then exit;
    Accept:=ListBox4.Items.IndexOf(ListBox2.Items[ListBox2.ItemIndex]) = -1;
    if not Accept then exit;
    end;
end;

procedure TB002FAggiornamento.ListBox3DragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Rilascio di un campo nella list box di selezione}
var Punto:TPoint;
    i:Integer;
begin
  Punto.X:=X;
  Punto.Y:=Y;
  if Sender = ListBox3 then
    begin
    i:=ListBox3.ItemAtPos(Punto,False);
    if i = -1 then
      begin
      ListBox3.Items.Add(ListBox1.Items[ListBox1.Itemindex]);
      ListBox5.Items.Add('CAMPO DB');
      end
    else
      begin
      ListBox3.Items.Insert(i,ListBox1.Items[ListBox1.Itemindex]);
      ListBox5.Items.Insert(i,'CAMPO DB');
      end;
    end
  else
    begin
    i:=ListBox4.ItemAtPos(Punto,False);
    if i = -1 then
      begin
      ListBox4.Items.Add(ListBox1.Items[ListBox2.Itemindex]);
      ListBox6.Items.Add('');
      end
    else
      begin
      ListBox4.Items.Insert(i,ListBox2.Items[ListBox2.Itemindex]);
      ListBox6.Items.Insert(i,'');
      end;
    end
end;

procedure TB002FAggiornamento.ListBox3DblClick(Sender: TObject);
{Cancellazione di un campo selezionato con doppio click}
begin
  if Sender = ListBox3 then
    begin
    if ListBox3.ItemIndex > -1 then
      begin
      ListBox5.Items.Delete(ListBox3.ItemIndex);
      ListBox3.Items.Delete(ListBox3.ItemIndex);
      end;
    end
  else
    begin
    if ListBox4.ItemIndex > -1 then
      begin
      PulisciListBox6(ListBox4.ItemIndex);
      ListBox6.Items.Delete(ListBox4.ItemIndex);
      ListBox4.Items.Delete(ListBox4.ItemIndex);
      end;
    end;
end;

procedure TB002FAggiornamento.Button2Click(Sender: TObject);
{visualizzazione tabella sorgente}
begin
  QSorg.Close;
  QSorg.Open;
  Form1.Show;
end;

procedure TB002FAggiornamento.Button3Click(Sender: TObject);
{Visualizzazione tabella destinazione}
begin
  QDest.Close;   
  QDest.Open;
  Form2.Show;
end;

procedure TB002FAggiornamento.ListBox1DblClick(Sender: TObject);
{Copio l'intero contenuto delle list box complete nelle list box di selezione}
var i:Integer;
begin
  if Sender = ListBox1 then
    begin
    for i:=0 to ListBox1.Items.Count -1 do
      if ListBox3.Items.IndexOf(ListBox1.Items[i]) = -1 then
        begin
        ListBox3.Items.Add(ListBox1.Items[i]);
        ListBox5.items.Add('CAMPO DB');
        end;
    end
  else
    begin
    for i:=0 to ListBox2.Items.Count -1 do
      if ListBox4.Items.IndexOf(ListBox2.Items[i]) = -1 then
        begin
        ListBox4.Items.Add(ListBox2.Items[i]);
        ListBox6.Items.Add('');
        end;
    end
end;

procedure TB002FAggiornamento.Valoredidefault1Click(Sender: TObject);
{Inserisco un valore di default}
var Valore:String;
begin
  Valore:='';
  if InputQuery('VALORE DI DEFAULT','Valore:',Valore) then
    if ListBox3.Itemindex = -1 then
      begin
      ListBox3.Items.Add(Valore);
      ListBox5.Items.Add('DEFAULT');
      end
    else
      begin
      ListBox5.Items.Insert(ListBox3.ItemIndex,'DEFAULT');
      ListBox3.Items.Insert(ListBox3.ItemIndex,Valore);
      end;
end;

procedure TB002FAggiornamento.Autoincrementante1Click(Sender: TObject);
var Valore:String;
begin
  Valore:='0';
  if InputQuery('VALORE AUTOINCREMENTANTE','Numero di partenza:',Valore) then
    if ListBox3.Itemindex = -1 then
      begin
      ListBox3.Items.Add(IntToStr(StrToIntDef(Valore,0)));
      ListBox5.Items.Add('AUTOINC');
      end
    else
      begin
      ListBox5.Items.Insert(ListBox3.ItemIndex,'AUTOINC');
      ListBox3.Items.Insert(ListBox3.ItemIndex,IntToStr(StrToIntDef(Valore,0)));
      end;
end;

procedure TB002FAggiornamento.Button4Click(Sender: TObject);
{Impostazione campi chiave per modifica di record esistenti}
begin
  B002FCampiChiave.ShowModal;
end;

procedure TB002FAggiornamento.Button5Click(Sender: TObject);
{Immissione della parte WHERE della SELECT per la tabella sorgente}
var i:Integer;
    QueryApp:TQuery;
begin
  if Sender = Button5 then
    //Query su sorgente
    with B002FQuery do
      begin
      Caption:='Filtro Tabella ' + ComboBox3.Text;
      QueryApp:=QSorg;
      end
  else
    //Query su destinatario
    with B002FQuery do
      begin
      Caption:='Filtro Tabella ' + ComboBox4.Text;
      QueryApp:=QDest;
      end;
  with B002FQuery do
    begin
    Memo1.Lines.Assign(WhereSorg);
    ShowModal;
    for i:=Memo1.Lines.Count - 1 downto 0 do
      if Trim(Memo1.Lines[i]) = '' then
        Memo1.Lines.Delete(i);
    WhereSorg.Assign(Memo1.Lines);
    if WhereSorg.Count > 0 then
      begin
      QueryApp.Close;
      //Elimino l'eventuale WHERE già esistente
      for i:=QueryApp.SQL.Count - 1 downto  1 do
        QueryApp.SQL.Delete(i);
      if Tabella2 = 'T030_ANAGRAFICO' then
        begin
        if Label4.Caption = 'ORACLE' then
          QueryApp.SQL.Add('AND')
        else
          QueryApp.SQL.Add('WHERE');
        end
      else
        QueryApp.SQL.Add('WHERE');
      for i:=0 to WhereSorg.Count - 1 do
        QueryApp.SQL.Add(WhereSorg[i]);
      //Provo ad aprire la query per verificarne la correttezza
      try
        QueryApp.Open;
      except
        ShowMessage('Filtro non valido!');
        WhereSorg.Clear;
        for i:=QueryApp.SQL.Count - 1 downto  1 do
          QueryApp.SQL.Delete(i);
      end;
      end;
    end;
end;

//--------------------- Gestione Aggiornamento Generico---------------------//
procedure TB002FAggiornamento.Button1Click(Sender: TObject);
{Copia dei dati da una tabella all'altra}
var i,Cont:Word;
begin
  Anomalie.Clear;
  if Form1.Visible then Form1.Close;
  if Form2.Visible then Form2.Close;
  Cont:=ListBox3.Items.Count;
  if Cont > ListBox4.Items.Count then
    Cont:=ListBox4.Items.Count;
  if Cont = 0 then exit;
  QDest.DisableControls;
  QDest.Close;
  QDest.Open;
  QDest.First;
  StartSorgente;
  Label11.Caption:='0';
  Label11.RePaint;
  if PageControl1.ActivePage = TabSheet1 then
    begin
    Label12.Caption:='di ' + IntToStr(QSorg.RecordCount);
    Label12.RePaint;
    end
  else
    begin
    Label12.Caption:='';
    Label12.RePaint;
    end;
  if Tabella2 = 'T030_ANAGRAFICO' then
    begin
    try
      Q030.Prepare;
      Q430.Prepare;
      AggiornaAnagrafe(Cont);
    finally
      Q030.Close;
      Q430.Close;
      Q030.UnPrepare;
      Q430.UnPrepare;
      QSorg.EnableControls;
      QDest.EnableControls;
    end;
    exit;
    end;
  try
  while not FineSorg do
    begin
    //Vado in Append o Edit a seconda dei campi chiave
    Label11.Caption:=IntToStr(StrToInt(Label11.Caption) + 1);
    Label11.RePaint;
    if AppendEdit(False) then
      QDest.Edit
    else
      QDest.Append;
    for i:=0 to Cont  - 1 do
      try
        if ListBox5.Items[i] = 'AUTOINC' then
          //Campo autoincrementante:setto Value
          begin
          QDest.FieldByName(ListBox4.Items[i]).Value:=StrToInt(ValoreSorgente(i,QDest.FieldByName(ListBox4.Items[i])));
          ListBox3.Items[i]:=IntToStr(StrToInt(ListBox3.Items[i]) + 1);
          end
        else
          //Campo di file o valore di default:setto AsString
          QDest.FieldByName(ListBox4.Items[i]).AsString:=ValoreSorgente(i,QDest.FieldByName(ListBox4.Items[i]));
      except
      end;
    try
      QDest.Post
    except
      on E:Exception do
        begin
        Anomalie.Add(E.Message);
        QDest.Cancel;
        end;
    end;
    NextSorg;
    end;
  finally
    QSorg.EnableControls;
    QDest.EnableControls;
  end;
end;

procedure TB002FAggiornamento.StartSorgente;
{Inizializza la tabella o il file seq. per la lettura}
begin
  if PageControl1.ActivePage = TabSheet1 then
    //Tabella di database
    begin
    QSorg.DisableControls;
    QSorg.Close;
    QSorg.Open;
    QSorg.First;
    end
  else
    if PageControl1.ActivePage = TabSheet2 then
      //File seq.
      begin
      PrimoEof:=False;
      Reset(FileTesto);
      repeat
        Readln(FileTesto,RigaSeq);
      until (Eof(FileTesto)) or (Trim(RigaSeq) <> '');
      end;
  //Se valori di default non devo fare nulla
end;

function TB002FAggiornamento.FineSorg:boolean;
{testo la fine della tabella o del file seq.}
begin
  if PageControl1.ActivePage = TabSheet1 then
    Result:=QSorg.Eof
  else
    if PageControl1.ActivePage = TabSheet2 then
      begin
      Result:=Eof(FileTesto) and PrimoEof;
      if Eof(FileTesto) then PrimoEof:=True;
      end
    else
      //Valori di default
      Result:=QDest.Eof;
end;

procedure TB002FAggiornamento.NextSorg;
{Leggo il record o riga successiva}
begin
  if PageControl1.ActivePage = TabSheet1 then
    QSorg.Next
  else
    if PageControl1.ActivePage = TabSheet2 then
      begin
      if not Eof(FileTesto) then
        repeat
          Readln(FileTesto,RigaSeq);
        until Eof(FileTesto) or (Trim(RigaSeq) <> '');  
      end
    else
      //Valori di default
      QDest.Next;
end;

function TB002FAggiornamento.AppendEdit(Anagrafico:Boolean):Boolean;
{Riconosco se esiste il record in base alla chiave per andare in modifica
o inserimento}
var Campi:String;
    Valori:Variant;
    i,P,L,R:Integer;
begin
  if PageControl1.ActivePage = TabSheet3 then
    //Se aggiorno da valori di default sono sempre in modifica
    begin
    Result:=True;
    //Se modifico l'anagrafico estraggo il progressivo corrspondente su ProgAnagra
    if Anagrafico then
      with ProgAnagra do
        begin
        Close;
        SQL.Clear;
        SQL.Add(RicercaAnagrafico);
        SQL.Add('T030.PROGRESSIVO = ' + QDest.FieldByName('PROGRESSIVO').AsString);
        Open;
        end;
    exit;
    end;
  if KeySorg.Count = 0 then
    begin
    Result:=False;
    exit;
    end;
  Campi:='';
  Valori:=VarArrayCreate([0,KeySorg.Count - 1],VarVariant);
  for i:=0 to KeySorg.Count -1 do
    begin
    if i > 0 then Campi:=Campi + ';';
    Campi:=Campi + KeyDest[i];
    if PageControl1.ActivePage = TabSheet1 then
      Valori[i]:=QSorg.FieldByName(KeySorg[i]).AsString
    else
      begin
      //Numero elemento nella StringGrid Mappatura
      R:=ListBox1.Items.IndexOf(KeySorg[i]);
      //Posizione di partenza valore richiesto
      P:=StrToInt(B002FMappatura.StringGrid1.Cells[1,R + 1]);
      //Lunghezza valore richiesto
      L:=StrToInt(B002FMappatura.StringGrid1.Cells[2,R + 1]);
      Valori[i]:=Copy(RigaSeq,P,L);
      end;
    end;
  if Anagrafico then
    //Costruisco la Select sui campi chiave (+ veloce)
    with ProgAnagra do
      begin
      Close;
      SQL.Clear;
      SQL.Add(RicercaAnagrafico);
      for i:=0 to KeySorg.Count - 1 do
        begin
        SQL.Add(KeyDest[i] + ' = ''' + Valori[i] + '''');
        if i < KeySorg.Count - 1 then
          SQL.Add('AND');
        end;
      SQL.Add('ORDER BY T030.PROGRESSIVO');
      Open;
      Result:=RecordCount > 0;
      end
  else
    //Locate tradizionale
    begin
    if KeySorg.Count > 1 then
      Result:=QDest.Locate(Campi,Valori,[])
    else
      Result:=QDest.Locate(Campi,VarToStr(Valori[0]),[]);
    end;
end;

function TB002FAggiornamento.ValoreSorgente(i:Word; Campo:TField):String;
{Ritorna il valore richiesto a seconda che provenga da Tabella, da File seq.,
da valore di Default o Autoincrementante}
var P,L,R:Word;
begin
  if (ListBox5.Items[i] = 'DEFAULT') or (ListBox5.Items[i] = 'AUTOINC') then
    //Risultato immediato; il campo autoinc. viene incrementato dal chiamante
    begin
    Result:=TrasformaValore(i,ListBox3.Items[i]);
    exit;
    end;
  if (ListBox5.Items[i] = 'INVAR') then
    //Risultato immediato; nessuna modifica
    begin
    Result:=TrasformaValore(i,Campo.AsString);
    exit;
    end;
  if (ListBox5.Items[i] = 'CAMPO DB') then
    begin
    if PageControl1.ActivePage = TabSheet1 then
      //Campo di tabella di database
      Result:=TrasformaValore(i,QSorg.FieldByName(ListBox3.Items[i]).AsString)
    else
      if PageControl1.ActivePage = TabSheet2 then
        //Da file sequenziale
        begin
        //Numero elemento nella StringGrid Mappatura
        R:=ListBox1.Items.IndexOf(ListBox3.Items[i]);
        //Posizione di partenza valore richiesto
        P:=StrToInt(B002FMappatura.StringGrid1.Cells[1,R + 1]);
        //Lunghezza valore richiesto
        L:=StrToInt(B002FMappatura.StringGrid1.Cells[2,R + 1]);
        Result:=TrasformaValore(i,Copy(RigaSeq,P,L));
        end;
    end;
end;


function TB002FAggiornamento.TrasformaValore(i:Word; Sorg:String):String;
{Trasforma il valore precedentemente ottenuto}
var S,S1,S2,M:String;
    P:Word;
begin
  Sorg:=TrimLeft(TrimRight(Sorg));
  Result:=Sorg;
  //Sostituzione di una sottostringa
  if ListBox6.Items[i] = 'SOSTIT' then
    begin
    M:=TProva(ListBox6.Items.Objects[i]).S;
    P:=Pos('%',M);
    S:=Copy(M,1,P - 1);
    S1:=Copy(M,P + 1,Length(M));
    S2:=Sorg;
    P:=Pos(S,S2);
    if P > 0 then
      begin
      Delete(S2,P,Length(S));
      Insert(S1,S2,P);
      Result:=S2;
      end;
    Result:=S2;
    exit;
    end;
  //TransCodifica
  if ListBox6.Items[i] = 'CODIF' then
    begin
    for P:=0 to NumMax do
      begin
      if TProva(ListBox6.Items.Objects[i]).A1[P] = #0 then Break;
      if TProva(ListBox6.Items.Objects[i]).A1[P] = Sorg then
        begin
        Result:=TProva(ListBox6.Items.Objects[i]).A2[P];
        Break;
        end;
      end;
    exit;
    end;
end;

//----------------- Gestione aggiornamento Anagrafico e Storico ------------//
procedure TB002FAggiornamento.AggiornaAnagrafe(Cont:Word);
{Aggiornamento anagrafe + storico}
var Prog:LongInt;
    i:Integer;
    Trovato:Boolean;
    CampiT030,CampiT430:TStringList;
    QueryApp:TQuery;
    A,M,G:Word;
begin
  CampiT030:=TStringList.Create;
  CampiT430:=TStringList.Create;
  ValoriEsistenti:=TStringList.Create;
  //Progressivo anagrafico
  T035.Open;
  if T035.FieldByName('PROGRESSIVO').IsNull then
    Prog:=0
  else
    Prog:=T035.FieldByName('PROGRESSIVO').AsInteger;
  try
  if B002FDataStorici.ShowModal = mrOk then
    DecorrenzaK:=StrToDate(B002FDataStorici.Edit1.Text)
  else
    Abort;
  //Aggiornamento archivi anagrafici
  while not FineSorg do
    begin
    Label11.Caption:=IntToStr(StrToInt(Label11.Caption) + 1);
    Label11.RePaint;
    Trovato:=AppendEdit(True);
    if not Trovato then
      //Se devo inserire un nuovo dipendente
      begin
      //Inserisco i dati anagrafici
      if Db2.InTransaction then Db2.RollBack;
      Db2.StartTransaction;
      ApriAnagrafico(0);
      Q030.Append;
      Q430.Append;
      Q430.FieldByName('DataDecorrenza').AsDateTime:=DecorrenzaK;
      Q430.FieldByName('DataFine').AsDateTime:=StrToDate('31/12/3999');
      for i:=0 to Cont - 1 do
        try
          //Salto il progressivo in quanto automatico
          if (ListBox4.Items[i] = 'PROGRESSIVO') or (ListBox4.Items[i] = 'PROGRESSIVO_1') then Continue;
          if Q030.FindField(ListBox4.Items[i]) <> nil then
            QueryApp:=Q030
          else
            QueryApp:=Q430;
          if ListBox5.Items[i] = 'AUTOINC' then
            //Campo autoincrementante:setto Value
            begin
            QueryApp.FieldByName(ListBox4.Items[i]).Value:=StrToInt(ValoreSorgente(i,QueryApp.FieldByName(ListBox4.Items[i])));
            ListBox3.Items[i]:=IntToStr(StrToInt(ListBox3.Items[i]) + 1);
            end
          else
          //Campo di file o valore di default:setto AsString
          QueryApp.FieldByName(ListBox4.Items[i]).AsString:=ValoreSorgente(i,QueryApp.FieldByName(ListBox4.Items[i]));
        except
        end;
      //Porto la data di decorrenza al primo del mese
      DecodeDate(Q430.FieldByName('DATADECORRENZA').AsDateTime,A,M,G);
      Q430.FieldByName('DATADECORRENZA').AsDateTime:=EncodeDate(A,M,1);
      //Scrivo il progressivo
      Inc(Prog);
      Q030.FieldByName('PROGRESSIVO').AsInteger:=Prog;
      Q430.FieldByName('PROGRESSIVO').AsInteger:=Prog;
      //Scrivo Q030 e Q430
      try
        Q030.Post;
        Q430.Post;
        Db2.Commit;
      except
        on E:EDBEngineError do
          begin
          Dec(Prog);
          Anomalie.Add(E.Message);
          try
            Q030.Cancel;
          except
          end;
          try
            Q430.Cancel;
          except
          end;
          Db2.RollBack;
          end;
      end;
      end
    else
      //Sono già posizionato su un dipendente
      begin
      ApriAnagrafico(ProgAnagra.FieldByName('PROGRESSIVO').AsInteger);
      //Va in Edit o Append a seconda che esista il movimento storico impostando
      //Progressivo, DataDecorrenza e DataFine e aggiornando eventualmente i movim.storici vicini
      if not RicercaStorico(ProgAnagra.FieldByName('PROGRESSIVO').AsInteger) then
        begin
        NextSorg;
        Continue;
        end;
      if Db2.InTransaction then Db2.RollBack;
      Db2.StartTransaction;
      Q030.Edit;
      for i:=0 to Cont  - 1 do
        try
          //Salto il progressivo,data decorr. e data fine in quanto già impostati
          if (ListBox4.Items[i] = 'PROGRESSIVO') or (ListBox4.Items[i] = 'PROGRESSIVO_1') then Continue;
          if (ListBox4.Items[i] = 'DATADECORRENZA') or (ListBox4.Items[i] = 'DATAFINE') then Continue;
          if Q030.FindField(ListBox4.Items[i]) <> nil then
            QueryApp:=Q030
          else
            QueryApp:=Q430;
          if ListBox5.Items[i] = 'AUTOINC' then
            //Campo autoincrementante:setto Value
            begin
            QueryApp.FieldByName(ListBox4.Items[i]).Value:=StrToInt(ValoreSorgente(i,QueryApp.FieldByName(ListBox4.Items[i])));
            ListBox3.Items[i]:=IntToStr(StrToInt(ListBox3.Items[i]) + 1);
            end
          else
          //Campo di file o valore di default:setto AsString
          QueryApp.FieldByName(ListBox4.Items[i]).AsString:=ValoreSorgente(i,QueryApp.FieldByName(ListBox4.Items[i]));
        except
        end;
      //Richiesta di aggiornamento storici successivi
      if (ValoriEsistenti.Count > 0) and (Q430.Modified) and (StoriciSuccessivi) then
          AggiornamentoStoriciSuccessivi(Q430.FieldByName('DataDecorrenza').AsDateTime);
      //Scrivo Q030 e Q430
      try
        Q030.Post;
        Q430.Post;
        Db2.Commit;
      except
        on E:Exception do
          begin
          Anomalie.Add(E.Message);
          try
            Q030.Cancel;
          except
          end;
          try
            Q430.Cancel;
          except
          end;
          Db2.RollBack;
          end;
      end;
      end;
    NextSorg;
    end;
  finally
    CampiT030.Free;
    CampiT430.Free;
    ValoriEsistenti.Free;
    T035.Edit;
    T035.FieldByName('PROGRESSIVO').AsInteger:=Prog;
    T035.Post;
    T035.Close;
  end;
end;

procedure TB002FAggiornamento.ApriAnagrafico(Prog:LongInt);
begin
  Q030.Close;
  Q430.Close;
  Q030.ParamByName('Progressivo').AsInteger:=Prog;
  Q430.ParamByName('Progressivo').AsInteger:=Prog;
  Q030.Open;
  Q430.Open;
end;

function TB002FAggiornamento.RicercaStorico(Prog:LongInt):boolean;
{Ricerca i dati storici in base alla data di decorrenza}
var i:Integer;
    A,M,G:Word;
    Prec,Succ:Boolean;
begin
  Result:=True;
  Q430Progressivo:=Prog;
  ValoriEsistenti.Clear;
  if B002FDataStorici.RGStorici.ItemIndex = 0 then
    //Ricerco il movimento storico corrente
    if Q430.Locate('PROGRESSIVO;DATAFINE',VarArrayOf([Prog,'31/12/3999']),[]) then
      begin
      Q430.Edit;
      exit;
      end
    else
      begin
      Result:=False;
      exit;
      end;
  //Scelgo la data di decorrenza
  i:=ListBox4.Items.IndexOf('DATADECORRENZA');
  if i = -1 then
    Q430Decorrenza:=DecorrenzaK
  else
    try
      if ListBox5.Items[i] = 'AUTOINC' then
       //Campo autoincrementante numerico
        begin
        Q430Decorrenza:=StrToInt(ValoreSorgente(i,Q430.FieldByName('DataDecorrenza')));
        ListBox3.Items[i]:=IntToStr(StrToInt(ListBox3.Items[i]) + 1);
        end
      else
        //Campo di file o valore di default
        Q430Decorrenza:=StrToDate(ValoreSorgente(i,Q430.FieldByName('DataDecorrenza')));
    except
      Q430Decorrenza:=DecorrenzaK;
    end;
  DecodeDate(Q430Decorrenza,A,M,G);
  //Q430Decorrenza:=EncodeDate(A,M,1);
  if B002FDataStorici.RGStorici.ItemIndex = 1 then
    //Modifica di movimento storico con data specificata
    begin
    TuttoStorico:=tsPrima;
    if Q430.FindFirst then
      begin
      GetValoriEsistenti(ValoriEsistenti);
      Q430.Edit;
      end
    else
      Result:=false;
    exit;
    end;
  if Q430.Locate('PROGRESSIVO;DATADECORRENZA',VarArrayOf([Prog,Q430Decorrenza]),[]) then
    begin
    GetValoriEsistenti(ValoriEsistenti);
    Q430.Edit;
    exit;
    end;
  //Se inserisco un nuovo movimento storico devo incastrarlo fra quelli esistenti
  Prec:=False;
  Succ:=False;
  with Q430 do
    begin
    TuttoStorico:=tsPrima;
    if FindFirst then
      begin
      //Se si sovrappone a una storicizzazione già esistente
      //aggiorno la data fine di quest'ultima
      Prec:=True;
      GetValoriEsistenti(ValoriEsistenti);
      Edit;
      FieldByName('DataFine').AsDateTime:=Q430Decorrenza - 1;
      Post;
      end;
    TuttoStorico:=tsDopo;
    //Se ci sono delle storicizzazioni posteriori imposto la data
    //di fine alla data di decorrenza successiva - 1
    if FindFirst then
      begin
      if not Prec then
        begin
        Succ:=True;
        GetValoriEsistenti(ValoriEsistenti);
        end;
      Q430Fine:=FieldByName('DataDecorrenza').AsDateTime - 1;
      end
    else
      Q430Fine:=StrToDateTime('31/12/3999');
    Q430.Append;
    if (Succ) or (Prec) then
      PutValoriEsistenti(ValoriEsistenti);
    Q430.FieldByName('Progressivo').AsInteger:=Prog;
    Q430.FieldByName('DataDecorrenza').AsDateTime:=Q430Decorrenza;
    Q430.FieldByName('DataFine').AsDateTime:=Q430Fine;
    end;
end;

procedure TB002FAggiornamento.GetValoriEsistenti(Lista:TStringList);
{Leggo i valori di T430 in una StringList}
var i:Integer;
begin
  Lista.Clear;
  for i:=0 to Q430.FieldCount - 1 do
    Lista.Add(Q430.Fields[i].AsString);
end;

procedure TB002FAggiornamento.PutValoriEsistenti(Lista:TStringList);
{Scrivo i valori registrati precedentemente nella StringLIst su T430}
var i:Integer;
begin
  for i:=0 to Q430.FieldCount - 1 do
    if i <= Lista.Count - 1 then
      Q430.Fields[i].AsString:=Lista[i];
end;

procedure TB002FAggiornamento.AggiornamentoStoriciSuccessivi(Data:TDateTime);
{Aggiorno gli storici successivo con l'istruzione SQL UPDATE...}
var i:Integer;
    U:String;
    V:String;
begin
  U:='';
  for i:=0 to Q430.FieldDefs.Count - 1 do
    begin
    if (UpperCase(Q430.FieldDefs[i].Name) = 'DATADECORRENZA') or (UpperCase(Q430.FieldDefs[i].Name) = 'DATAFINE') then Continue;
    if Q430.FieldByName(Q430.FieldDefs[i].Name).AsString <> ValoriEsistenti[i] then
      begin
      if U <> '' then U:=U + ',';
      if Q430.FieldDefs[i].DataType = ftDateTime then
        V:=FormatDateTime('mm/dd/yyyy',Q430.FieldByName(Q430.FieldDefs[i].Name).AsDateTime)
      else
        V:=Q430.FieldByName(Q430.FieldDefs[i].Name).AsString;
      U:=U + Q430.FieldDefs[i].Name + '='''  + V + '''';
      end;
    end;
  if U = '' then exit;
  with OperSQL do
    begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE T430_Storico SET');
    SQL.Add(U);
    SQL.Add(Format('WHERE PROGRESSIVO = %s AND DATADECORRENZA > ''%s''',[Q430.FieldByName('Progressivo').AsString,FormatDateTime('mm/dd/yyyy',Data)]));
    ExecSQL;
    SQL.Clear;
    SQL.Add('COMMIT');
    ExecSQL;
    end;
end;

procedure TB002FAggiornamento.Q430FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
{Filtro archivio storico}
begin
  case TuttoStorico of
    tsPrima:Accept:=(Q430.FieldByName('Progressivo').AsInteger = Q430Progressivo) and
                    (Q430.FieldByName('DataDecorrenza').AsDateTime <= Q430Decorrenza) and
                    (Q430.FieldByName('DataFine').AsDateTime >= Q430Decorrenza);
    tsDopo: Accept:=(Q430.FieldByName('Progressivo').AsInteger = Q430Progressivo) and
                    (Q430.FieldByName('DataDecorrenza').AsDateTime > Q430Decorrenza);
    tsTutto:Accept:=True;
  end;
end;

//--------------------- Gestione File sequenziale ---------------------//
procedure TB002FAggiornamento.Button6Click(Sender: TObject);
begin
  if not OpenSeq.Execute then exit;
  NomeFile.Text:=OpenSeq.FileName;
  BApriClick(Sender);
end;

procedure TB002FAggiornamento.BApriClick(Sender: TObject);
{Apro il file specificato}
var S:String;
    i,j:Word;
begin
  if Trim(NomeFile.Text) = '' then exit;
  try
    CloseFile(FileTesto);
  except
  end;
  AssignFile(FileTesto,NomeFile.Text);
  Reset(FileTesto);
  with B002FMappatura do
    begin
    MemoFile.Lines.Clear;
    for i:=0 to StringGrid1.ColCount - 1 do
      for j:=1 to StringGrid1.RowCount - 1 do
        StringGrid1.Cells[i,j]:='';
    StringGrid1.RowCount:=2;
    end;
  if not eof(FileTesto) then
    begin
    Readln(FileTesto,S);
    B002FMappatura.MemoFile.Lines.Add(S);
    end;
end;

procedure TB002FAggiornamento.BMappaturaClick(Sender: TObject);
{Richiamo la finestra di mappatura}
var i:Integer;
begin
  if Trim(NomeFile.Text) = '' then exit;
  with B002FMappatura do
    begin
    ShowModal;
    ListBox1.Items.Clear;
    for i:=1 to StringGrid1.RowCount - 1 do
      ListBox1.Items.Add(StringGrid1.Cells[0,i]);
    for i:=ListBox3.Items.Count - 1 downto 0 do
      if (ListBox5.Items[i] = 'CAMPO DB') and (ListBox1.Items.IndexOf(ListBox3.Items[i]) = -1) then
        begin
        ListBox3.Items.Delete(i);
        ListBox5.Items.Delete(i);
        end;
    end;
end;

procedure TB002FAggiornamento.FormDestroy(Sender: TObject);
begin
  Campi.Free;
  Anomalie.Free;
  KeyDest.Free;
  KeySorg.Free;
  WhereSorg.Free;
end;

procedure TB002FAggiornamento.Sostituzione1Click(Sender: TObject);
{Richiesta della maschera di sistituzione: s1%s2
 la sottostringa s1 viene sostituita con s2}
var Valore:String;
    i:Integer;
begin
  Valore:='';
  i:=ListBox4.Itemindex;
  if i = -1 then exit;
  if InputQuery('SOSTITUZIONE','Introdurre nella forma Orig%Sost:',Valore) then
    begin
    ListBox6.Items[i]:='SOSTIT';
    if ListBox6.Items.Objects[i] <> nil then
      begin
      ListBox6.Items.Objects[i].Free;
      ListBox6.Items.Objects[i]:=nil;
      end;
    ListBox6.Items.Objects[i]:=TProva.Create;
    TProva(ListBox6.Items.Objects[i]).S:=Valore;
    end;
end;

procedure TB002FAggiornamento.PulisciListBox6(P:Integer);
{Pulisco gli oggetti TProva della ListBox6}
var i:Integer;
    procedure PulisciOggetto(K:Integer);
    begin
    if ListBox6.Items.Objects[K] <> nil then
      begin
      ListBox6.Items.Objects[K].Free;
      ListBox6.Items.Objects[K]:=nil;
      end;
    end;
begin
  if P = -1 then
    begin
    for i:=0 to ListBox6.Items.Count - 1 do
      PulisciOggetto(i);
    end
  else
    PulisciOggetto(P);
end;

procedure TB002FAggiornamento.Transcodifica1Click(Sender: TObject);
{Richiesta dei codici di transcodifica}
var i,j:Integer;
begin
  i:=ListBox4.Itemindex;
  if i = -1 then exit;
  with B002FTranscodifica do
    begin
    if ShowModal = mrOK then
      begin
      ListBox6.Items[i]:='CODIF';
      if ListBox6.Items.Objects[i] <> nil then
        begin
        ListBox6.Items.Objects[i].Free;
        ListBox6.Items.Objects[i]:=nil;
        end;
      ListBox6.Items.Objects[i]:=TProva.Create;
      FillChar(TProva(ListBox6.Items.Objects[i]).A1,SizeOf(TProva(ListBox6.Items.Objects[i]).A1),#0);
      FillChar(TProva(ListBox6.Items.Objects[i]).A2,SizeOf(TProva(ListBox6.Items.Objects[i]).A2),#0);
      for j:=0 to Memo1.Lines.Count - 1 do
        begin
        if j > NumMax then Break;
        if j > (Memo2.Lines.Count - 1) then Break;
        if (Trim(Memo1.Lines[j]) = '') and (Trim(Memo2.Lines[j]) = '') then Break;
        TProva(ListBox6.Items.Objects[i]).A1[j]:=Memo1.Lines[j];
        TProva(ListBox6.Items.Objects[i]).A2[j]:=Memo2.Lines[j];
        end;
      end;
    end;
end;

procedure TB002FAggiornamento.Invariato1Click(Sender: TObject);
{Dato sorgente invariato: letto dalla tabella destinataria:
 utile per sostituzioni}
begin
  if ListBox3.Itemindex = -1 then
    begin
    ListBox3.Items.Add('');
    ListBox5.Items.Add('INVAR');
    end
  else
    begin
    ListBox5.Items.Insert(ListBox3.ItemIndex,'INVAR');
    ListBox3.Items.Insert(ListBox3.ItemIndex,'');
    end;
end;

end.
