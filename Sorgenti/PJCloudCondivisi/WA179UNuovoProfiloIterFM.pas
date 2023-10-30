unit WA179UNuovoProfiloIterFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, meIWEdit,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, meIWButton, WA179UProfiliIterAutDM, C180FunzioniGenerali,
  WA179UProfiliIterAut;

type
  TWA179FNuovoProfiloIterFM = class(TWR200FBaseFM)
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    lblNuovoProfilo: TmeIWLabel;
    edtNuovoProfilo: TmeIWEdit;
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
  private
    { Private declarations }
    PTipoInserimento:TNuovoProfilo;
  public
    { Public declarations }
    Profilo, Azienda, Iter:String;
    W179DM:TWA179FProfiliIterAutDM;
    procedure Visualizza;
  end;

implementation

uses
  WR100UBase, WA179UProfiliIterAutBrowseFM, OracleData;

{$R *.dfm}

procedure TWA179FNuovoProfiloIterFM.btnConfermaClick(Sender: TObject);
begin
  inherited;
  if edtNuovoProfilo.Text = '' then
  begin
    R180MessageBox('Specificare nome profilo.',ERRORE,'Errore');
    Exit;
  end;
  if not VarToStr(W179DM.selTabella.Lookup('PROFILO',edtNuovoProfilo.Text,'PROFILO')).IsEmpty then
  begin
    R180MessageBox(Format('Il nome profilo [%s] esiste già.',[edtNuovoProfilo.Text]),ERRORE,'Errore');
    Exit;
  end;

  W179DM.InsI075.ClearVariables;
  W179DM.InsI075.SetVariable('AZIENDA',Azienda);
  W179DM.InsI075.SetVariable('PROFILO',edtNuovoProfilo.Text);
  W179DM.InsI075.SetVariable('ITER',null);
  W179DM.InsI075.SetVariable('COD_ITER',null);
  W179DM.InsI075.Execute;
  W179DM.InsI075.Session.Commit;
  W179DM.selTabella.Refresh;
  ((Self.Parent as TWA179FProfiliIterAut).WBrowseFM as  TWA179FProfiliIterAutBrowseFM).grdTabella.medpAggiornaCDS(True);
  (Self.Parent as TWA179FProfiliIterAut).AggiornaRecord;
  W179DM.selTabella.SearchRecord('PROFILO',W179DM.insI075.GetVariable('PROFILO'),[srFromBeginning]);
  FreeAndNil(Self);
end;

procedure TWA179FNuovoProfiloIterFM.Visualizza;
begin
  W179DM:=((Self.Parent as TWA179FProfiliIterAut).WR302DM as TWA179FProfiliIterAutDM);
  edtNuovoProfilo.Text:=Profilo;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,520,-1,250, 'Nuovo profilo','#' + Self.name,False,True);
end;

procedure TWA179FNuovoProfiloIterFM.btnAnnullaClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self);
end;

end.
