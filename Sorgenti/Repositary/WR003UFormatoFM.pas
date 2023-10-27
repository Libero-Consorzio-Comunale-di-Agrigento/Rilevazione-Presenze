unit WR003UFormatoFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit,
  medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, WR100UBase, IWCompButton, meIWButton,
  R003UGeneratoreStampeMW,  WR003UGeneratoreStampe,WR003UGeneratoreStampeDM,
  A000UInterfaccia, medpIWMessageDlg;

type
  TWR003FFormatoFM = class(TWR200FBaseFM)
    lblFormato: TmeIWLabel;
    cmbFormato: TMedpIWMultiColumnComboBox;
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    FDato:TRiep;
    FUsaDato: Boolean;
    procedure CaricaCombo;
  public
    ResultEvent: TProc<TObject,Boolean,String>;
    procedure Visualizza(Titolo,CaptLabel: String);
    property Dato:TRiep read FDato write FDato;
    property UsaDato:Boolean read FUsaDato write FUsaDato;
  end;

implementation

{$R *.dfm}

{ TWR003FFormatoFM }

procedure TWR003FFormatoFM.btnChiudiClick(Sender: TObject);
var
  Res: Boolean;
  S, Msg: string;
begin
  if Sender = btnConferma then
    Res:=True
  else
    Res:=False;

  if Res then
  begin
    S:=UpperCase(Trim(cmbFormato.Text));
    //Replicato in FProprieta Dati. Qui Obsoleto
    if (S <> '') and
       (UsaDato) then
    begin
      //verifiche
      with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
      begin
        if IsDatoGiustificativi(Dato) then
        begin
          Msg:=VerificaFormatoGiust(S);
          if Msg <> '' then
          begin
            MsgBox.WebMessageDlg(Msg ,mtError,[mbOK],nil,'');
            Abort;
          end;
        end
        else if IsDatoTimbr(Dato) then
        begin
          Msg:=VerificaFormatoTimbr(S);
          if Msg <> '' then
          begin
            MsgBox.WebMessageDlg(Msg ,mtError,[mbOK],nil,'');
            Abort;
          end;
        end
        else if IsDatoPresCaus(Dato) or
                IsDatoAssCaus(Dato) then
        begin
          VerificaFormatoCaus(S);
        end;
      end;
    end;
  end;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Res,S);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  ReleaseOggetti;
  Free;
end;

procedure TWR003FFormatoFM.CaricaCombo;
var
  lstTmp: TStringList;
  s: string;
begin
  try
    cmbFormato.CustomElement:=True;
    with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    begin
      if not FUsaDato then
      begin
        cmbFormato.CustomElement:=False;
        lstTmp:=getListFormato;
      end
      else if IsDatoGiustificativi(FDato) then
      begin
        lstTmp:=getListFormatoGiust;
      end
      else if IsDatoTimbr(FDato) then
      begin
        lstTmp:=getListFormatoTimb;
      end
      else if IsDatoPresCaus(FDato) then
      begin
        lstTmp:=getListPresCaus;
      end
      else if IsDatoAssCaus(FDato) then
      begin
        lstTmp:=getListAssCaus;
      end
      else if IsDatoOre(FDato) then
      begin
        cmbFormato.CustomElement:=False;
        lstTmp:=getListOre;
      end
      else if IsDatoF0(FDato) then
      begin
        lstTmp:=getListF0;
      end
      else if IsDatoF1(FDato) then
      begin
        lstTmp:=getListF1;
      end
      else if IsDatoF2(FDato) then
      begin
        lstTmp:=getListF2;
      end
      else if IsDatoF3(FDato) then
      begin
        lstTmp:=getListF3;
      end;
    end;

    for s in lstTmp do
      cmbFormato.AddRow(s);

  finally
    FreeAndNil(lstTmp);
  end;
end;

procedure TWR003FFormatoFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  FUsaDato:=True;
end;

procedure TWR003FFormatoFM.Visualizza(Titolo,CaptLabel: String);
begin
  if CaptLabel <> '' then
    lblFormato.Caption:=CaptLabel;
  CaricaCombo;
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,270,160,160,Titolo,'#' + Self.Name,False,True);
end;


end.
