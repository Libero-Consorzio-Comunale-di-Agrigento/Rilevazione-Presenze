unit WA188UCampiAnagrafeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Oracle, OracleData, A000UInterfaccia, A188UCampiAnagrafeMW, WR302UGestTabellaDM,
  medpIWMessageDlg;

type
  TWA188FCampiAnagrafeDM = class(TWR302FGestTabellaDM)
    selTabellaNOME_CAMPO: TStringField;
    selTabellaNOME_LOGICO: TStringField;
    selTabellaPOSIZIONE: TFloatField;
    selTabellaRICERCA: TIntegerField;
    selTabellaVAL_DEFAULT: TStringField;
    selTabellaAPPLICAZIONE: TStringField;
    selTabellaPROVVEDIMENTO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure selTabellaPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  private
    { Private declarations }
  public
    A188MW:TA188FCampiAnagrafeMW;
    EseguiAfterOpen:Boolean;
  end;

implementation

{$R *.dfm}

procedure TWA188FCampiAnagrafeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A188MW:=TA188FCampiAnagrafeMW.Create(nil);
  A188MW.I010:=SelTabella;
  SelTabella.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  SelTabella.SetVariable('ORDERBY','order by nvl(RICERCA,99999999), nvl(POSIZIONE,99999999), NOME_LOGICO');
  EseguiAfterOpen:=True;
  inherited;
end;

procedure TWA188FCampiAnagrafeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A188MW);
end;

procedure TWA188FCampiAnagrafeDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A188MW.I010AfterScroll;
end;

procedure TWA188FCampiAnagrafeDM.BeforeInsert(DataSet: TDataSet);
begin
  A188MW.I010BeforeInsert;
  inherited;
end;

procedure TWA188FCampiAnagrafeDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A188MW.I010BeforePost;
  inherited;
end;

procedure TWA188FCampiAnagrafeDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  if EseguiAfterOpen then
  begin
    selTabella.BeforePost:=nil;
    try
      A188MW.I010AfterOpen;
    finally
      selTabella.BeforePost:=BeforePostNoStorico;
    end;
  end;
end;

procedure TWA188FCampiAnagrafeDM.selTabellaPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  MsgBox.WebMessageDlg('Nome gia'' usato per altro dato',mtInformation,[mbOK],nil,'');
  Action:=daAbort;
end;

end.
