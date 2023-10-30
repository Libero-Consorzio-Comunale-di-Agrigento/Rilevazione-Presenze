unit WA143UMedicineLegaliDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DBClient, DB, OracleData,
  C180FunzioniGenerali, medpIWMessageDlg,A000UInterfaccia;

type
  TWA143FMedicineLegaliDM = class(TWR302FGestTabellaDM)
    selT485CODICE: TStringField;
    selT485DESCRIZIONE: TStringField;
    selTabellaINDIRIZZO: TStringField;
    selTabellaCAP: TStringField;
    selTabellaTELEFONO: TStringField;
    selTabellaEMAIL: TStringField;
    selTabellaCOD_COMUNE: TStringField;
    selT480: TOracleDataSet;
    selTabellaCOMUNE: TStringField;
    dsrT480: TDataSource;
    selT480CODICE: TStringField;
    selT480CITTA: TStringField;
    selT480CAP: TStringField;
    selT480PROVINCIA: TStringField;
    selT480CODCATASTALE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
     function CheckEmail: Boolean;
      procedure OnConfermaMsgAction(Sender: TObject; Res: TmeIWModalResult; KeyID: String);

  public
    { Public declarations }
  end;

implementation

 uses WA143UMedicineLegali;

 {$R *.dfm}

procedure TWA143FMedicineLegaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
  selT480.SetVariable('ORDERBY','ORDER BY CITTA');
  selT480.Open;
end;

procedure TWA143FMedicineLegaliDM.BeforePostNoStorico(DataSet: TDataSet);

begin
  inherited;

    with selTabella do
    begin
      // codice obbligatorio
      if FieldByName('CODICE').AsString = '' then
      begin
         MsgBox.MessageBox('Indicare il codice della medicina legale!', 'ERRORE');
         Abort;
      end;

      // descrizione obbligatoria
      if FieldByName('DESCRIZIONE').AsString = '' then
      begin
         MsgBox.MessageBox('Indicare la descrizione della medicina legale!', 'ERRORE');
         Abort;
      end;

      // email valida
      if not MsgBox.KeyExists('CONFERMA_MAIL')then
      begin
        if not CheckEmail then
        begin
          MsgBox.WebMessageDlg('L''indirizzo e-mail indicato non è valido.' + #13#10 +
                              'Vuoi continuare?',mtConfirmation,[mbYes,mbNo],OnConfermaMsgAction,'CONFERMA_MAIL');
          Abort;
        end;
      end;
    end;

end;

function TWA143FMedicineLegaliDM.CheckEmail: Boolean;
{ confronta l'email rispetto al modello [user] @ [dominio]
  il metodo è un po' artigianale, ma dovrebbe evitare gli errori più grossolani }
var
  PosAt, PosDot: Integer;
  Dominio, LastToken: String;
begin
  Result:=True;
  with selTabella.FieldByName('EMAIL') do
    begin
    // email vuota -> ok
    if Trim(AsString) = '' then
      Exit;

    // cerca il simbolo "@" nell'email
    PosAt:=Pos('@', AsString);
    Result:=(PosAt > 0);
    if not Result then
      Exit;

    // considera la parte dopo la "@" (il dominio)
    Dominio:=Copy(AsString, PosAt + 1, Length(AsString) - PosAt + 1);

    // verifica la presenza di un altro simbolo "@"
    Result:=(Pos('@', Dominio) <= 0);
    if not Result then
      Exit;

    // cerca il simbolo "punto" (.) dopo la chiocciolina
    PosDot:=Pos('.', Dominio);
    Result:=(PosDot > 0);
    if not Result then
      Exit;

    // considera la parte dopo il punto
    LastToken:=Copy(Dominio, PosDot + 1, Length(Dominio) - PosDot + 1);

    // verifica la presenza di una stringa non vuota dopo il punto
    Result:=(Trim(LastToken) <> '');
  end;
end;

procedure TWA143FMedicineLegaliDM.OnConfermaMsgAction(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// risposta del TWA143FMedicineLegaliDM modale di conferma
begin
  if KeyID = 'CONFERMA_MAIL' then
  begin
    case Res of
      mrYes:
        selTabella.Post;
      mrNo:
        MsgBox.ClearKeys;
    end;
  end;
end;

end.

