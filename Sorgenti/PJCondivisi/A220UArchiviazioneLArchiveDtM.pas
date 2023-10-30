unit A220UArchiviazioneLArchiveDtM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, A220UArchiviazioneLArchiveMW;

type
  TA220FArchiviazioneLArchiveDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A220MW: TA220FArchiviazioneLarchiveMW;
  end;

var
  A220FArchiviazioneLArchiveDtM: TA220FArchiviazioneLArchiveDtM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses A220UArchiviazioneLarchive;

procedure TA220FArchiviazioneLArchiveDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A220MW:=TA220FArchiviazioneLarchiveMW.Create(Self);

  A220FArchiviazioneLarchive.dgrdFileCaricati.DataSource:=A220MW.dsrFileCaricati;
  A220FArchiviazioneLarchive.dgrdStorico.DataSource:=A220MW.dsrselI220a;

  A220FArchiviazioneLarchive.btnAggiornaClick(nil);

  A220MW.ResettaProgressBar:=A220FArchiviazioneLarchive.ResettaProgressBar;
  A220MW.IncrementaProgressBar:=A220FArchiviazioneLarchive.IncrementaProgressBar;
  A220MW.MaxProgressBar:=A220FArchiviazioneLarchive.MaxProgressBar;
  A220MW.ResettaProgressBarPdvStatus:=A220FArchiviazioneLarchive.ResettaProgressBarPdvStatus;
  A220MW.IncrementaProgressBarPdvStatus:=A220FArchiviazioneLarchive.IncrementaProgressBarPdvStatus;
  A220MW.MaxProgressBarPdvStatus:=A220FArchiviazioneLarchive.MaxProgressBarPdvStatus;
  A220MW.ScriviStatusBar:=A220FArchiviazioneLarchive.ScriviStatusBar;
  A220MW.ScriviStatusBarPdvStatus:=A220FArchiviazioneLarchive.ScriviStatusBarPdvStatus;
end;

procedure TA220FArchiviazioneLArchiveDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A220MW);
  inherited;
end;

end.
