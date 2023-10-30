unit S130UOrdiniProfessionali;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, C001UFiltroTabelleDtM,
  C001UFiltroTabelle, C001UScegliCampi, A002UInterfacciaSt, C005UDatiAnagrafici, C013UCheckList, C180FunzioniGenerali,
  ActnList, ImgList, ToolWin, Variants, Grids, DBGrids,
  System.Actions, System.ImageList;

type
  TS130FOrdiniProfessionali = class(TR001FGestTab)
    grdOrdiniProf: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure grdOrdiniProfEditButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  LUNGHEZZA = 10;

var
  S130FOrdiniProfessionali: TS130FOrdiniProfessionali;

procedure OpenS130OrdiniProfessionali;

implementation

uses S130UOrdiniProfessionaliDtM;

{$R *.DFM}

procedure OpenS130OrdiniProfessionali;
{Ordini Professionali}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS130OrdiniProfessionali') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S130FOrdiniProfessionali:=TS130FOrdiniProfessionali.Create(nil);
  with S130FOrdiniProfessionali do
    try
      S130FOrdiniProfessionaliDtM:=TS130FOrdiniProfessionaliDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      S130FOrdiniProfessionaliDtM.Free;
      Free;
    end;
end;

procedure TS130FOrdiniProfessionali.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  SolaLettura:=SolaLetturaOriginale;
end;

procedure TS130FOrdiniProfessionali.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=S130FOrdiniProfessionaliDtM.selSG221;
end;

procedure TS130FOrdiniProfessionali.grdOrdiniProfEditButtonClick(Sender: TObject);
begin
  inherited;
  if grdOrdiniProf.SelectedField.FieldName = 'QUALIFICHE_COLLEGATE' then
  begin
  //utilizzo della c013 per selezionare in una maschera apposita i valori dei dati selezionati
    if not (S130FOrdiniProfessionaliDtM.selSG221.State in [dsInsert,dsEdit]) then
      Exit;
    C013FCheckList:=TC013FCheckList.Create(nil);
    S130FOrdiniProfessionaliDtM.S130MW.selC36OrdiniProfessionali.First;
    try
      while not S130FOrdiniProfessionaliDtM.S130MW.selC36OrdiniProfessionali.Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-*s %s',[LUNGHEZZA,S130FOrdiniProfessionaliDtM.S130MW.selC36OrdiniProfessionali.FieldByName('CODICE').AsString,
                                                                          S130FOrdiniProfessionaliDtM.S130MW.selC36OrdiniProfessionali.FieldByName('DESCRIZIONE').AsString]));
        S130FOrdiniProfessionaliDtM.S130MW.selC36OrdiniProfessionali.Next;
      end;
      R180PutCheckList(grdOrdiniProf.DataSource.DataSet.FieldByName('QUALIFICHE_COLLEGATE').AsString,LUNGHEZZA,C013FCheckList.clbListaDati);
      if C013FCheckList.ShowModal = mrOK then
        grdOrdiniProf.DataSource.DataSet.FieldByName('QUALIFICHE_COLLEGATE').AsString:=R180GetCheckList(LUNGHEZZA,C013FCheckList.clbListaDati);
    finally
      FreeAndNil(C013FCheckList);
    end;
  end;
end;

end.
