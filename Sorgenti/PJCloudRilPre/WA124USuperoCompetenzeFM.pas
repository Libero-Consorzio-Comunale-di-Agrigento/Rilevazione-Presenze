unit WA124USuperoCompetenzeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompButton, meIWButton, A000UMessaggi, Math, C180FunzioniGenerali;

type
  TWA124FSuperoCompetenzeFM = class(TWR200FBaseFM)
    lblTitle: TmeIWLabel;
    lblNominativo: TmeIWLabel;
    lblDisponibilita: TmeIWLabel;
    lblResiduo: TmeIWLabel;
    lblDisponibilitaOre: TmeIWLabel;
    lblDurataTitle: TmeIWLabel;
    lblDalle: TmeIWLabel;
    lblAlle: TmeIWLabel;
    lblOre: TmeIWLabel;
    edtDalle: TmeIWEdit;
    edtAlle: TmeIWEdit;
    edtOre: TmeIWEdit;
    btnConferma: TmeIWButton;
    btnAnnullaDip: TmeIWButton;
    btnAnnullaOp: TmeIWButton;
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaDipClick(Sender: TObject);
    procedure btnAnnullaOpClick(Sender: TObject);
    procedure edtDalleAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDalleAsyncExit(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
  public
    (*procedure Visualizza;*)
  end;


implementation

uses WR010UBase, WA124UPermessiSindacali, WA124UPermessiSindacaliDM, WA124UPermessiSindacaliDettFM;

{$R *.dfm}

procedure TWA124FSuperoCompetenzeFM.btnAnnullaDipClick(Sender: TObject);
begin
  (*with (Self.Owner as TWA124FPermessiSindacali),(WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    SelAnagrafe.Next;
    StartElaborazioneCiclo((WDettaglioFM as TWA124FPermessiSindacaliDettFM).btnCompetenze.HTMLName);
  end;
  Free;*)
end;

procedure TWA124FSuperoCompetenzeFM.btnAnnullaOpClick(Sender: TObject);
begin
  (*with (Self.Owner as TWA124FPermessiSindacali),(WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    SelAnagrafe.Last;
    SelAnagrafe.Next;//Forzo l'EOF
    StartElaborazioneCiclo((WDettaglioFM as TWA124FPermessiSindacaliDettFM).btnCompetenze.HTMLName);
  end;
  Free;*)
end;

procedure TWA124FSuperoCompetenzeFM.btnConfermaClick(Sender: TObject);
begin
  (*if Trim(edtOre.Text) = '' then
    raise exception.Create(A000MSG_A124_ERR_NO_ORE);
  with (Self.Owner as TWA124FPermessiSindacali),(WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    DatiColl.Ore:=edtOre.Text;
    if Trim(edtDalle.Text) <> '' then
      DatiColl.Dalle:=edtDalle.Text;
    if Trim(edtAlle.Text) <> '' then
      DatiColl.Alle:=edtAlle.Text;
    StartElaborazioneCiclo((WDettaglioFM as TWA124FPermessiSindacaliDettFM).btnCompetenze.HTMLName);
  end;
  Free;*)
end;

procedure TWA124FSuperoCompetenzeFM.edtDalleAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  (*edtOre.Enabled:=(Trim(edtDalle.Text) = '') and (Trim(edtAlle.Text) = '');
  lblOre.Enabled:=edtOre.Enabled;*)
end;

procedure TWA124FSuperoCompetenzeFM.edtDalleAsyncExit(Sender: TObject;
  EventParams: TStringList);
(*var n:Integer;*)
begin
  (*R180OraValidate((Sender as TmeIWEdit).Text);
  if (Trim(edtDalle.Text) <> '') and
     (Trim(edtAlle.Text) <> '') then
  begin
    n:=R180OreMinutiExt(edtAlle.Text) - R180OreMinutiExt(edtDalle.Text);
    if n < 0 then
      raise exception.Create(A000MSG_A124_ERR_ALLE_MAGGIORE_DALLE)
    else
      edtOre.Text:=R180MinutiOre(n);
  end;*)
end;

(*procedure TWA124FSuperoCompetenzeFM.Visualizza;
begin
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,460,300,300, 'Supero competenze','#wa124competenzeFM_container',False,True);
end;*)

end.
