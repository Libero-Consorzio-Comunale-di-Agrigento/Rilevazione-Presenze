unit WA079UAssenzeAuto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, medpIWC700NavigatorBar,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, A000UMessaggi,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, A079UAssenzeAutoMW,
  C180FunzioniGenerali, A000UInterfaccia, meIWImageFile;

type
  TWA079FAssenzeAuto = class(TWR100FBase)
    lblDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    btnEsegui: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtAlAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnEseguiClick(Sender: TObject);
  private
    A079MW: TA079FAssenzeAutoMW;
  public
    { Public declarations }
    function InizializzaAccesso: Boolean; override;
  protected
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA079FAssenzeAuto.IWAppFormCreate(Sender: TObject);
begin
  A079MW:=TA079FAssenzeAutoMW.Create(Self);
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.AttivaBrowse:=False;
  A079MW.selAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
end;

function TWA079FAssenzeAuto.InizializzaAccesso: Boolean;
begin
  Result:=AccessoAbilitato and (not SolaLettura);
end;

procedure TWA079FAssenzeAuto.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA079FAssenzeAuto.edtAlAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  try
    grdC700.WC700FM.C700DataLavoro:=StrToDate(edtAl.Text);
  except
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA079FAssenzeAuto.btnEseguiClick(Sender: TObject);
begin
  A079MW.ControllaDate(StrToDate(edtDal.Text), StrToDate(edtAl.Text));
  StartElaborazioneCiclo((Sender as TmeIWButton).HTMLName);
end;

procedure TWA079FAssenzeAuto.InizioElaborazione;
begin
  R180SetVariable(grdC700.SelAnagrafe,'DataLavoro',A079MW.AData);
  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;
end;

function TWA079FAssenzeAuto.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

function TWA079FAssenzeAuto.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

procedure TWA079FAssenzeAuto.ElaboraElemento;
begin
  A079MW.InserimentoAutomaticoAssenze;
  SessioneOracle.Commit;
end;

function TWA079FAssenzeAuto.ElementoSuccessivo: Boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.EOF;
end;

end.
