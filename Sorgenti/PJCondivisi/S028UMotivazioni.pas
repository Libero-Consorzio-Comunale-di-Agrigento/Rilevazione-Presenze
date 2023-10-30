unit S028UMotivazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls, A000UCostanti, A000USessione,A000UInterfaccia, Buttons,
  C013UCheckList, C180FunzioniGenerali, System.Actions, OracleData,
  System.ImageList;

type
  TS028FMotivazioni = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    dEdtCodice: TDBEdit;
    dGrdMotivazioni: TDBGrid;
    Label3: TLabel;
    pnlGestioneNPA: TPanel;
    dedtNumeriSucc: TDBEdit;
    Label5: TLabel;
    dedtNumeriPrec: TDBEdit;
    Label4: TLabel;
    DBCheckBox1: TDBCheckBox;
    btnSucc: TBitBtn;
    btnPrec: TBitBtn;
    dedtDescrizione: TDBEdit;
    dedtDescrAgg: TDBEdit;
    Label2: TLabel;
    procedure TInserClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPrecClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  S028FMotivazioni: TS028FMotivazioni;

procedure OpenS028Motivazioni(Codice:String);

implementation

uses S028UMotivazioniDtM;

{$R *.dfm}

procedure OpenS028Motivazioni(Codice:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS028Motivazioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S028FMotivazioni:=TS028FMotivazioni.Create(nil);
  with S028FMotivazioni do
    try
      S028FMotivazioniDtM:=TS028FMotivazioniDtM.Create(nil);
      S028FMotivazioniDtM.selSG104.SearchRecord('CODICE',Codice,[srFromBeginning]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale; 
      S028FMotivazioniDtM.Free;
      Free;
    end;
end;

procedure TS028FMotivazioni.btnPrecClick(Sender: TObject);
var S:String;
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco numeri';
  with C013FCheckList do
    try
      with S028FMotivazioniDtM.S028MW.selP660 do
      begin
        First;
        clbListaDati.Items.Clear;
        while not Eof do
        begin
          clbListaDati.Items.Add(Format('%-4s',[FieldByName('NUMERO').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
      end;
      if Sender = btnPrec then
        S:=dedtNumeriPrec.Text
      else if Sender = btnSucc then
        S:=dedtNumeriSucc.Text;
      R180PutCheckList(S,4,clbListaDati);
      if ShowModal = mrOK then
      begin
        S:=R180GetCheckList(4,clbListaDati);
        if Sender = btnPrec then
          dedtNumeriPrec.Text:=S
        else if Sender = btnSucc then
          dedtNumeriSucc.Text:=S;
      end;
    finally
      Free;
    end;
end;

procedure TS028FMotivazioni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnPrec.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnSucc.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TS028FMotivazioni.FormActivate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=S028FMotivazioniDtM.selSG104;
end;

procedure TS028FMotivazioni.FormShow(Sender: TObject);
begin
  inherited;
  pnlGestioneNPA.Visible:=S028FMotivazioniDtM.S028MW.selP660.RecordCount > 0;
  CopiaDa1.Visible:=True;
end;

procedure TS028FMotivazioni.TInserClick(Sender: TObject);
begin
  inherited;
  dEdtCodice.SetFocus;
end;

end.
