unit WA127UTurniPrestazioniAggiuntiveDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, OracleData, WR302UGestTabellaDM, A127UTurniPrestazioniAggiuntiveMW;

type
  TWA127FTurniPrestazioniAggiuntiveDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaORAINIZIO: TDateTimeField;
    selTabellaORAFINE: TDateTimeField;
    selTabellaCONTROLLO_PT: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaORAINIZIOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selTabellaORAINIZIOSetText(Sender: TField; const Text: String);
  private
    { Private declarations }
  public
    A127MW: TA127FTurniPrestazioniAggiuntiveMW;
  end;

implementation

{$R *.dfm}

procedure TWA127FTurniPrestazioniAggiuntiveDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  A127MW:=TA127FTurniPrestazioniAggiuntiveMW.Create(Self);
  A127MW.selT330:=SelTabella;
  inherited;
end;

procedure TWA127FTurniPrestazioniAggiuntiveDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A127MW.selT330AfterPost;
end;

procedure TWA127FTurniPrestazioniAggiuntiveDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A127MW.selT330BeforePost;
  inherited;
end;

procedure TWA127FTurniPrestazioniAggiuntiveDM.selTabellaORAINIZIOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  A127MW.selT330ORAINIZIOGetText(Sender,Text);
end;

procedure TWA127FTurniPrestazioniAggiuntiveDM.selTabellaORAINIZIOSetText(Sender: TField; const Text: String);
begin
  A127MW.selT330ORAINIZIOSetText(Sender,Text);
end;

end.
