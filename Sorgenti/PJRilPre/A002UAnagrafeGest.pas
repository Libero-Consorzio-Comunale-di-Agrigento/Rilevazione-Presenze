unit A002UAnagrafeGest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A002UAnagrafeGestPadre, ActnList, ImgList, Menus, ComCtrls, ToolWin,
  DBCtrls, StdCtrls, ExtCtrls, Db, Mask,
  A007UProfiliOrari,A009UProfiliAsse,
  A012UCalendari,A014UPlusOrario,A016UCausAssenze,A018URaggrPres,
  A022UContratti,A024UIndPresenza,
  A080UModConte,A084UTipoRapporto,A085UPartTime,
  A143UMedicineLegali,A205USquadre,
  A000UInterfaccia,C700USelezioneAnagrafe,S030UProvved,OracleData,
  Variants, Buttons, System.Actions, System.ImageList;

type
  TA002FAnagrafeGest = class(TA002FAnagrafeGestPadre)
    Provvedimento1: TMenuItem;
    procedure NuovoClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Provvedimento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A002FAnagrafeGest: TA002FAnagrafeGest;

implementation

uses A002UAnagrafeVista, A002UAnagrafeDtM1;

{$R *.DFM}

procedure TA002FAnagrafeGest.NuovoClick(Sender: TObject);
begin
  case PopupMenu1.PopupComponent.Tag of
    2:if A002FAnagrafeVista.Squadre1.Enabled then
        OpenA205Squadre((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    3:OpenA022Contratti((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    4:OpenA014PlusOrario((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    5:OpenA012Calendari((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    6:OpenA024IndPresenza((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    7:OpenA007ProfiliOrari((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    8:OpenA009ProfiliAsse((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    9:OpenA016CausAssenze((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    10:OpenA018RaggrPres((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    11:OpenA080ModConte((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    12:OpenA084TipoRapporto((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    13:OpenA085PartTime((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
    15:OpenA143MedicineLegali((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
  end;
  inherited;
end;

procedure TA002FAnagrafeGest.PopupMenu1Popup(Sender: TObject);
var S:String;
begin
  inherited;
  A002FAnagrafeDtM1.QI010.Open;
  Provvedimento1.Visible:=(PopupMenu1.PopupComponent is TDBLookupComboBox) or (PopupMenu1.PopupComponent is TDBEdit);
  if Provvedimento1.Visible then
  begin
    if PopupMenu1.PopupComponent is TDBLookupComboBox then
      S:=(PopupMenu1.PopupComponent as TDBLookupComboBox).Field.FieldName
    else
      S:=(PopupMenu1.PopupComponent as TDBEdit).Field.FieldName;
    Provvedimento1.Visible:=A002FAnagrafeDtM1.QI010.SearchRecord('NOME_CAMPO;PROVVEDIMENTO',VarArrayOf(['T430' + S,'S']),[srFromBeginning]);
  end;
end;

procedure TA002FAnagrafeGest.Provvedimento1Click(Sender: TObject);
var NC:String;
begin
  if PopupMenu1.PopupComponent is TDBLookupComboBox then
    NC:=(PopupMenu1.PopupComponent as TDBLookupComboBox).Field.FieldName
  else
    NC:=(PopupMenu1.PopupComponent as TDBEdit).Field.FieldName;
  with A002FAnagrafeDtM1 do
  begin
    A002FAnagrafeVista.frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    try
      OpenS030Provvedimento(NC,Q030Progressivo.AsInteger);
    finally
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      A002FAnagrafeVista.frmSelAnagrafe.RipristinaC00SelAnagrafe;
    end;
  end;
end;

end.
