unit B023UCifraturaCedoliniDtM;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Dialogs, Vcl.Forms,
  R004UGestStoricoDTM, Data.DB, OracleData, StrUtils,
  A000UCostanti,A000UMessaggi,A000UInterfaccia, RegistrazioneLog, C180FunzioniGenerali,B023UCifraturaCedoliniBase;

type
  TB023TipoAzione = (b023ActEncrypt, b023ActDecrypt);
  TB023TipoDocumento = (b023Cedolino, b023CU);

  TB023FCifraturaCedoliniDtM = class(TR004FGestStoricoDtM)
    selP500Ced: TOracleDataSet;
    selP500CU: TOracleDataSet;
  private
    FPresenzaAnomalie:Boolean;
    FOperazioneAnnullata:Boolean;
    function CheckPercorso(Path:String; var ElencoFilePdf:TStrings):Boolean;
    function GetNomeFileNoExt(NomeFile:String):String;
  public
    CallerForm:TB023FCifraturaCedoliniBase;
    InterrompiElaborazione:Boolean;
    property PresenzaAnomalie:Boolean read FPresenzaAnomalie;
    property OperazioneAnnullata:Boolean read FOperazioneAnnullata;
    function GetPathCedolini(Mese,Anno:Integer):String;
    function GetPathCU(Anno:Integer):String;
    procedure Esegui(Path:String; Passphrase:String=''; HashAlg:String = HASHTYPE_Sha256; Azione:TB023TipoAzione=b023ActEncrypt;
                     Sostituisci:Boolean=true);
  end;

const
  B023_SUFFISSO_FILE_CIFRATO='_cifrato';
  B023_SUFFISSO_FILE_DECIFRATO='_decifrato';
  B023_SUFFISSO_PATH_CU='CU_';
var
  B023FCifraturaCedoliniDtM: TB023FCifraturaCedoliniDtM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

(* Ritorna true se il percorso indicato contiene solo file pdf, false altrimenti.
   Controlla inoltre che il percorso sia valido, in caso contrario solleva
   un'eccezione.
*)
function TB023FCifraturaCedoliniDtM.CheckPercorso(Path:String; var ElencoFilePdf:TStrings):Boolean;
var
  SearchRecord:TSearchRec;
  SoloPDF:Boolean;
begin
  if Path = '' then
    raise Exception.Create(A000MSG_B023_ERR_PERCORSO_INVALIDO);
  if not DirectoryExists(Path) then
    raise Exception.Create(A000MSG_B023_ERR_NO_DIR_O_PERC_INVALIDO);

  SoloPDF:=true;
  ElencoFilePdf.Clear;

  Path:=IncludeTrailingPathDelimiter(Path);
  if FindFirst(Path + '*.*',faAnyFile,SearchRecord) = 0 then
  begin
    repeat
      if (SearchRecord.Attr <> faDirectory) then
      begin
        if LowerCase(R180EstraiExtFile(SearchRecord.Name)) = 'pdf' then
          ElencoFilePdf.Add(SearchRecord.Name)
        else
          SoloPDF:=false;
      end;
    until (FindNext(SearchRecord) <> 0);
    FindClose(SearchRecord);
  end
  else
  begin
    FindClose(SearchRecord);
    raise Exception.Create(A000MSG_B023_ERR_DIR_ENUM);
  end;

  Result:=SoloPDF;
end;

function TB023FCifraturaCedoliniDtM.GetNomeFileNoExt(NomeFile:String):String;
var
  SplittedFileName:TArray<String>;
  NomeFileNoExt:String;
  I:Integer;
begin
  NomeFileNoExt:='';
  NomeFile:=ExtractFileName(NomeFile);
  SplittedFileName:=NomeFile.Split(['.']);
  for I := 0 to High(SplittedFileName) - 1 do
  begin
    if I > 0 then
      NomeFileNoExt:=NomeFileNoExt + '.';
    NomeFileNoExt:=NomeFileNoExt + SplittedFileName[I];
  end;
  Result:=NomeFileNoExt;
end;

function TB023FCifraturaCedoliniDtM.GetPathCedolini(Mese,Anno:Integer):String;
var
  PercorsoPDF:String;
begin
  with selP500Ced do
  begin
    Close;
    SetVariable('Anno',Anno);
    Open;
  end;
  if selP500Ced.SearchRecord('COD_AZIENDA_BASE',T440AZIENDA_BASE,[srFromBeginning]) then
  begin
    PercorsoPDF:=selP500Ced.FieldByName('PATH_FILEPDF_CED').AsString
  end
  else
  begin
    Result:='';
    Exit;
  end;

  if Trim(PercorsoPDF) <> '' then
    PercorsoPDF:=IncludeTrailingPathDelimiter(PercorsoPDF) +
                 IntToStr(Anno) + R180LPad(IntToStr(Mese),2,'0') + System.SysUtils.PathDelim
  else
    PercorsoPDF:='';
  Result:=PercorsoPDF;
end;

function TB023FCifraturaCedoliniDtM.GetPathCU(Anno:Integer):String;
var
  PercorsoPDF:String;
begin
  PercorsoPDF:='';

  if Anno < 2015 then
  begin
    Result:='';
    exit;
  end;

  with selP500CU do
  begin
    Close;
    SetVariable('anno',Anno+1);
    Open;
    if SearchRecord('COD_AZIENDA_BASE',T440AZIENDA_BASE,[srFromBeginning]) then
    begin
      PercorsoPDF:=FieldByName('PATH_FILEPDF_CED').AsString;
    end;
  end;

  if Trim(PercorsoPDF) <> '' then
    PercorsoPDF:=IncludeTrailingPathDelimiter(PercorsoPDF) + B023_SUFFISSO_PATH_CU + IntToStr(Anno)
  else
    PercorsoPDF:='';
  Result:=PercorsoPDF;
end;

procedure TB023FCifraturaCedoliniDtM.Esegui(Path:String; Passphrase:String=''; HashAlg:String = HASHTYPE_Sha256; Azione:TB023TipoAzione=b023ActEncrypt;
                                            Sostituisci:Boolean=true);
var
  SoloPDF:Boolean;
  ElencoFilePdf:TStrings;
  I,NumFileElabOK:Integer;
  PercorsoFileAttuale,PercorsoNuovoFile,DomandaAvvioOp:String;
begin
  FPresenzaAnomalie:=false;
  FOperazioneAnnullata:=false;
  InterrompiElaborazione:=false;
  CallerForm.ResetProgressBar;
  CallerForm.SetStatusText('');
  ElencoFilePdf:=TStringList.Create;

  try
    SoloPDF:=CheckPercorso(Path,ElencoFilePdf);

    // Al momento disabilito la possibilità di usare una passphrase "plain".
    // Da rimuovere quando tale funzionalità sarà supportata.
    if HashAlg = HASHTYPE_NoHash then
    begin
      R180MessageBox(A000MSG_B023_ERR_NO_HASH,ESCLAMA,'Avviso');
      FOperazioneAnnullata:=true;
      exit;
    end;

    if ElencoFilePdf.Count = 0 then
    begin
      R180MessageBox(A000MSG_B023_ERR_NO_PDF,ERRORE,'Errore');
      FOperazioneAnnullata:=true;
      exit;
    end;

    if not SoloPDF then
    begin
      if (R180MessageBox(A000MSG_B023_DLG_NO_SOLO_PDF,DOMANDA,'Domanda') = mrNo) then
      begin
        FOperazioneAnnullata:=true;
        exit;
      end;
    end;

    DomandaAvvioOp:=IfThen(Azione = b023ActEncrypt, A000MSG_B023_DLG_CIFR_AVVIO, A000MSG_B023_DLG_DECIFR_AVVIO);
    if (R180MessageBox(Format(DomandaAvvioOp,[ElencoFilePdf.Count]),DOMANDA,'Conferma') = mrNo) then
    begin
      FOperazioneAnnullata:=true;
      exit;
    end;

    if Length(Passphrase) = 0 then
      Passphrase:=P441Passphrase;

    NumFileElabOK:=0;
    CallerForm.AbilitaComponenti(false);
    CallerForm.ResetProgressBar;
    CallerForm.SetProgressBarMaxValue(ElencoFilePdf.Count);
    RegistraMsg.IniziaMessaggio('B023');
    for I:=0 to ElencoFilePdf.Count - 1 do
    begin
      if InterrompiElaborazione then
      begin
        FOperazioneAnnullata:=true;
        break;
      end;

      CallerForm.SetStatusText(format('%s (%d/%d)', [ElencoFilePdf[I], I, ElencoFilePdf.Count]));
      Application.ProcessMessages;
      PercorsoFileAttuale:=IncludeTrailingPathDelimiter(Path) + ElencoFilePdf[I];
      try
        PercorsoNuovoFile:='';
        if not Sostituisci then
        begin
          PercorsoNuovoFile:=GetNomeFileNoExt(ElencoFilePdf[I]) +
                         IfThen(Azione = b023ActEncrypt, B023_SUFFISSO_FILE_CIFRATO, B023_SUFFISSO_FILE_DECIFRATO) +
                         ExtractFileExt(ElencoFilePdf[I]);
          PercorsoNuovoFile:=IncludeTrailingPathDelimiter(Path) + PercorsoNuovoFile;
        end;
        R180FileEncryptAES(Azione = b023ActEncrypt, PercorsoFileAttuale,PercorsoNuovoFile,Passphrase,HashAlg);
        inc(NumFileElabOK);
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A','File: ' + ElencoFilePdf[I] + ': ' + E.Message,Parametri.Azienda);
      end;
      CallerForm.StepItProgressBar;
    end;
    if not InterrompiElaborazione then
      CallerForm.SetStatusText('Fatto. Elaborati ' + IntToStr(NumFileElabOK) + ' file.')
    else
      CallerForm.SetStatusText('Operazione interrotta. Elaborati ' + IntToStr(NumFileElabOK) + ' file.');
  finally
    ElencoFilePdf.Free;
    CallerForm.AbilitaComponenti(true);
    FPresenzaAnomalie:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB;
    CallerForm.btnAnomalie.Enabled:=FPresenzaAnomalie;
    CallerForm.ResetProgressBar;
  end;
end;

end.
