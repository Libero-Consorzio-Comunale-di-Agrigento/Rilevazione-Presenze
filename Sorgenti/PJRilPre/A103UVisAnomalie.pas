unit A103UVisAnomalie;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,Printers, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA103FVisAnomalie = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnStampa: TBitBtn;
    btnSetUpStampante: TBitBtn;
    BitBtn2: TBitBtn;
    BtnSalvaSuFile: TBitBtn;
    SaveDialog1: TSaveDialog;
    procedure btnSetUpStampanteClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure StampaMemo;
    procedure BtnSalvaSuFileClick(Sender: TObject);
  private
    { Private declarations }
    IntestazioneStampaInterna: String;
    F : TextFile;
    procedure SalvaSuFile(sPercorsoFileStraordinari:string);
  public
    { Public declarations }
    procedure SetIntestazioneStampa(IntestazioneStampa: String);
  end;

var
  A103FVisAnomalie: TA103FVisAnomalie;

implementation

uses A103UScaricoGiust;

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA103FVisAnomalie.StampaMemo;
var I : Integer;
begin
  Screen.Cursor := crHourGlass;
  AssignPrn(F);
  Rewrite(F);
  try
   Printer.Canvas.Font := Memo1.Font;
   writeln(F,IntestazioneStampaInterna);
   writeln(F,'');
   for I := 0 to Memo1.Lines.Count - 1 do
     writeln(F,Memo1.Lines[I])
  finally
    CloseFile(F);
  end;
  Screen.Cursor := crDefault;
end;

//------------------------------------------------------------------------------
procedure TA103FVisAnomalie.SetIntestazioneStampa(IntestazioneStampa: String);
begin
  IntestazioneStampaInterna:=IntestazioneStampa;
end;

procedure TA103FVisAnomalie.btnSetUpStampanteClick(Sender: TObject);
begin
  PrinterSetUpDialog1.Execute;
end;

//------------------------------------------------------------------------------
procedure TA103FVisAnomalie.btnStampaClick(Sender: TObject);
begin
  StampaMemo;
end;

procedure TA103FVisAnomalie.BtnSalvaSuFileClick(Sender: TObject);
var
  sDep:string;
begin
  SaveDialog1.Filter:='File di testo (*.txt)|*.txt|Tutti i file (*.*)|*.*';
  SaveDialog1.FileName:='Anomalie' + FormatDateTime('dd_mm_yyyy', Parametri.DataLavoro) + '.txt';
  if SaveDialog1.Execute then
  begin
    sDep:=SaveDialog1.FileName;
    if pos('.',sDep)=0 then
      sDep:=sDep+'.txt';
    SalvaSuFile(sDep);
  end;
end;

procedure TA103FVisAnomalie.SalvaSuFile(sPercorsoFileStraordinari:string);
var
  F: TextFile;
  i:integer;
begin
  //Cancello il file esistente
  IF FileExists(sPercorsoFileStraordinari) then
    if DeleteFile(sPercorsoFileStraordinari) = false then
      raise exception.create('Impossibile proseguire nel salvataggio del file.' + chr(13) + 'Verificare che il file ''' + sPercorsoFileStraordinari + ''' non sia in uso.');
  //Ricreo il file ...
  AssignFile(F, sPercorsoFileStraordinari);
  Rewrite(F);

  //Scrivo i record di tettaglio...
  try
    Printer.Canvas.Font:=Memo1.Font;
    for i:=0 to Memo1.Lines.Count - 1 do
      Writeln(F, Memo1.Lines[i]);
  finally
    CloseFile(F);
  end;

  Application.MessageBox(Pchar('La creazione del file è terminata con successo.'),PChar('Informazione'), MB_OK + MB_ICONINFORMATION);
end;

end.
