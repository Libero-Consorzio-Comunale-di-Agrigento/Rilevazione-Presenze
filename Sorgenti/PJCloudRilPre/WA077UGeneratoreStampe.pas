unit WA077UGeneratoreStampe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR003UGeneratoreStampe, Data.DB,
  Datasnap.DBClient, Datasnap.Win.MConnect, System.Actions, Vcl.ActnList,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, meIWRadioGroup, IWCompEdit,
  meIWEdit, medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid,
  medpIWStatusBar, meIWImageFile, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  medpIWC700NavigatorBar, A000UCostanti, WC700USelezioneAnagrafeFM,
  WA077UGeneratoreStampeDM, WA077UGeneratoreStampeBrowseFM,
  C180FunzioniGenerali, A000UInterfaccia, WA077UGeneratoreStampeDettFM, medpIWImageButton;

type
  TWA077FGeneratoreStampe = class(TWR003FGeneratoreStampe)
    procedure IWAppFormCreate(Sender: TObject);
  protected
    procedure DCOMPrint; override;
    { Private declarations }
  end;

implementation

{$R *.dfm}

procedure TWA077FGeneratoreStampe.DCOMPrint;
begin

  DCOMConnection.AppServer.PrintA077(grdC700.selAnagrafe.SubstitutedSQL,
                                     DCOMNomeFile,
                                     Parametri.Operatore,
                                     Parametri.Azienda,
                                     WR000DM.selAnagrafe.Session.LogonDataBase,
                                     DatiUtente,
                                     DettaglioLog);
end;

procedure TWA077FGeneratoreStampe.IWAppFormCreate(Sender: TObject);
var Dal,Al:TDateTime;
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  WR302DM:=TWA077FGeneratoreStampeDM.Create(Self);

  AttivaGestioneC700;
  grdC700.WC700FM.C700SelezionePeriodica:=True;

  WBrowseFM:=TWA077FGeneratoreStampeBrowseFM.Create(Self);
  WDettaglioFM:=TWA077FGeneratoreStampeDettFM.Create(Self);
  CreaToolbarComandi(actlstComandi,grdComandi,imgComandiClick);
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtDal.Text:=FormatDateTime('dd/mm/yyyy',Dal);
  edtAl.Text:=FormatDateTime('dd/mm/yyyy',Al);
  //isActTabella:=False;
  TipoGenerazione:=tgPDF;
  CreaTabDefault;
end;

end.
