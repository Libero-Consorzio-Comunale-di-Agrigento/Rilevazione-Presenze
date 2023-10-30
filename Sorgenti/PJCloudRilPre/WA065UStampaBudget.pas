unit WA065UStampaBudget;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton, Vcl.Menus,
  IWAdvCheckGroup, meTIWAdvCheckGroup, IWCompCheckbox, meIWCheckBox, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, IWApplication, OracleData, C180FunzioniGenerali,
  A000UCostanti, A000UInterfaccia, ActiveX, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} Data.DB, Datasnap.DBClient,
  Datasnap.Win.MConnect, C190FunzioniGeneraliWeb, medpIWMultiColumnComboBox,
  WA065UStampaBudgetFM, A065UStampaBudgetMW, IWCompListbox, meIWComboBox, StrUtils, meIWRadioGroup,
  A000UMessaggi, C004UParamForm;

type
  TWA065FStampaBudget = class(TWR100FBase)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    { Private declarations }
    A065MW:TA065FStampaBudgetMW;
    C004DM_1:TC004FParamForm;
    WA065Stm:TWA065FStampaBudgetFM;
    wCodGruppo,wTipo:String;
    wDecorrenza:TDateTime;
    procedure ElaborazioneServer; override;
  public
    { Public declarations }
    Anno, DaMese, AMese: Integer;
    function InizializzaAccesso: Boolean; override;
    procedure EseguiStampa;
  end;

implementation

{$R *.dfm}

procedure TWA065FStampaBudget.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  C004DM_1:=CreaC004(SessioneOracle,'WA040_1',Parametri.ProgOper,False);
  A065MW:=TA065FStampaBudgetMW.Create(Self);
  WA065Stm:=TWA065FStampaBudgetFM.Create(Self);

  WA065Stm.C004DMStm:=C004DM_1;
  WA065Stm.SolaLettura:=SolaLettura;
  WA065Stm.evtEseguiStampa:=EseguiStampa;
end;

function TWA065FStampaBudget.InizializzaAccesso: Boolean;
begin
  Result:=WA065Stm.InizializzaFrame(GetParam('TIPO'),GetParam('CODGRUPPO'),GetParam('DECORRENZA'));
end;

procedure TWA065FStampaBudget.ElaborazioneServer;
begin
  WA065Stm.ElaborazioneServer;
end;

procedure TWA065FStampaBudget.EseguiStampa;
begin
  StartElaborazioneServer(WA065Stm.btnGeneraPDF.HTMLName);
end;

procedure TWA065FStampaBudget.IWAppFormDestroy(Sender: TObject);
begin
  WA065Stm.ReleaseOggetti;
  FreeAndNil(C004DM_1);
  FreeAndNil(WA065Stm);//.Free;

  FreeAndNil(A065MW);
  inherited;
end;

end.
