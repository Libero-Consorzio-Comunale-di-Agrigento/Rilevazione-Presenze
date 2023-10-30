unit WA145UComVisiteFiscaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, A145UComVisiteFiscaliMW, medpIWMessageDlg,
  A000UInterfaccia;

type
  TWA145FComVisiteFiscaliDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    procedure ConfermaPostEsenzioni(Msg: String);
    procedure resultConfermaPostEsenzioni(Sender: TObject;
      Res: TmeIWModalResult; KeyID: String);
    procedure AfterPostEsenzioni;
  public
    A145FComVisiteFiscaliMW: TA145FComVisiteFiscaliMW;
  end;

implementation

uses
  WA145UComVisiteFiscali;

{$R *.dfm}

procedure TWA145FComVisiteFiscaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A145FComVisiteFiscaliMW:=TA145FComVisiteFiscaliMW.Create(Self);
  A145FComVisiteFiscaliMW.ConfermaBeforePostEsenzioni:=ConfermaPostEsenzioni;
  A145FComVisiteFiscaliMW.AfterPostEsenzioni:=AfterPostEsenzioni;
end;

procedure TWA145FComVisiteFiscaliDM.ConfermaPostEsenzioni(Msg: String);
begin
  if not MsgBox.keyExists('PUNTO_1') then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultConfermaPostEsenzioni,'PUNTO_1');
    Abort;
  end;
end;

procedure TWA145FComVisiteFiscaliDM.resultConfermaPostEsenzioni(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
    begin
      (Self.Owner as TWA145FComVisiteFiscali).grdEsenzioni.medpRiconferma;
    end;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA145FComVisiteFiscaliDM.AfterPostEsenzioni;
begin
  MsgBox.ClearKeys;
end;

procedure TWA145FComVisiteFiscaliDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A145FComVisiteFiscaliMW);
  inherited;
end;

end.
