unit WA150UCodiciAccorpamentoCausali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, System.Actions, meIWImageFile,
  IWCompEdit, meIWEdit;

type
  TWA150FCodiciAccorpamentoCausali = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    {private}
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA150UCodiciAccorpamentoCausaliDM , WA150UCodiciAccorpamentoCausaliBrowseFM ;

{$R *.dfm}

function TWA150FCodiciAccorpamentoCausali.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.Close;
  WR302DM.selTabella.SetVariable('CodTipoAccorpCausali',GetParam('cod_tipoaccorpcausali'));
  WR302DM.selTabella.SetVariable('CodCodiciAccorpCausali',GetParam('cod_codiciaccorpcausali'));
  WR302DM.selTabella.Open;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA150FCodiciAccorpamentoCausali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.DettaglioFM:=False;
  // Massimo: Senza OttimizzaStorico posso avere due record uguali dove cambia solo la data decorrenza.
  // viene usato in WR302DM, funzione OttimizzazioneStorico
  InterfacciaWR102.OttimizzaStorico:=False;

  WR302DM:=TWA150FCodiciAccorpamentoCausaliDM.Create(Self);
  WBrowseFM:=TWA150FCodiciAccorpamentoCausaliBrowseFM.Create(Self);
  CreaTabDefault;
end;



end.
