unit WR003UProprietaDatiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR100UBase,
  IWCompCheckbox, meIWCheckBox, Datasnap.DBClient, WR003UGeneratoreStampe, WR003UGeneratoreStampeDM,
  IWCompEdit, medpIWMultiColumnComboBox, IWCompLabel, meIWLabel,
  R003UGeneratoreStampeMW,A000UInterfaccia,medpIWMessageDlg;

type
  TWR003FProprietaDatiFM = class(TWR200FBaseFM)
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    chkRipeti: TmeIWCheckBox;
    chkContatore: TmeIWCheckBox;
    chkProporziona: TmeIWCheckBox;
    lblFormato: TmeIWLabel;
    cmbFormato: TMedpIWMultiColumnComboBox;
    chkConvertiValuta: TmeIWCheckBox;
    procedure btnChiudiClick(Sender: TObject);
  private
    P:Integer;
    cds:TClientDataSet;
    procedure CaricaCombo(FDato: TRiep);
    procedure VerificaFormato(FDato: TRiep);
  public
    procedure Visualizza(var parcds: TClientDataSet;bConvertiVisible:boolean);
  end;

implementation

{$R *.dfm}

procedure TWR003FProprietaDatiFM.Visualizza(var parcds:TClientDataSet;bConvertiVisible:Boolean);
var
  NomeCampo: string;
begin
  cds:=parcds;
  NomeCampo:=cds.FieldByName('NOME').AsString;
  with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    P:=GetDato(NomeCampo,False);
    if P >= 0 then
    begin
      //ripeti su ogni riga
      chkRipeti.Enabled:=Dati[P].M = 0;
      chkRipeti.Checked:=(chkRipeti.Enabled) and (Dati[P].Ripetuto);
      //contatote
      chkContatore.Enabled:=Dati[P].F in [0,1,2];
      chkContatore.Checked:=(chkContatore.Enabled) and (Dati[P].Cont = 1);
      //proporziona
      chkProporziona.Enabled:=Dati[P].F in [1,2];
      chkProporziona.Checked:=(chkProporziona.Enabled) and (Dati[P].CDCPerc);
      //Formato
      cmbFormato.Enabled:=Dati[P].Fex = 'S';
      if cmbFormato.Enabled then
      begin
        CaricaCombo(Dati[P]);
        cmbFormato.Text:=Dati[P].Fmt;
      end;
      //Converti in valuta
      chkConvertiValuta.Visible:=bConvertiVisible;
      chkConvertiValuta.Checked:=(chkConvertiValuta.Visible) and (Dati[P].ConvValuta);
    end
    else
    begin
      chkRipeti.Enabled:=False;
      chkContatore.Enabled:=False;
      chkProporziona.Enabled:=False;
      cmbFormato.Enabled:=False;
      chkConvertiValuta.Visible:=False;
    end;
  end;
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,300,270,270,'Proprietà dati','#' + Self.Name,False,True);
end;

//su WR003FFormatoFM non più necessario tutto il ramo di usaDato.
//Per ora lasciato pechè non so se cosi andrà bene
procedure TWR003FProprietaDatiFM.CaricaCombo(FDato:TRiep);
var
  lstTmp: TStringList;
  s: string;
begin
  try
    cmbFormato.CustomElement:=True;
    with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    begin
      if IsDatoGiustificativi(FDato) then
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

procedure TWR003FProprietaDatiFM.VerificaFormato(FDato:TRiep);
var
  S: string;
  Msg:String;
begin
  S:=cmbFormato.Text;
  if S <> '' then
  begin
    //verifiche
    with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    begin
      if IsDatoGiustificativi(FDato) then
      begin
        Msg:=VerificaFormatoGiust(S);
        if Msg <> '' then
        begin
          MsgBox.WebMessageDlg(Msg ,mtError,[mbOK],nil,'');
          Abort;
        end;
      end
      else if IsDatoTimbr(FDato) then
      begin
        Msg:=VerificaFormatoTimbr(S);
        if Msg <> '' then
        begin
          MsgBox.WebMessageDlg(Msg ,mtError,[mbOK],nil,'');
          Abort;
      end;
      end
      else if IsDatoPresCaus(FDato) or
              IsDatoAssCaus(FDato) then
      begin
        VerificaFormatoCaus(S);
      end;
    end;
  end;
end;

procedure TWR003FProprietaDatiFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if Sender = btnConferma then
  begin
    with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    begin
      if P >= 0 then
      begin
        //ripeti su ogni riga
        Dati[P].Ripetuto:=chkRipeti.Checked;
        //Contatore
        if chkContatore.Checked then
          Dati[P].Cont:=1
        else
          Dati[P].Cont:=0;
        //proporziona
        Dati[P].CDCPerc:=chkProporziona.Checked;
        if cmbFormato.Enabled then
        begin
          cmbFormato.Text:=UpperCase(Trim(cmbFormato.Text));
          VerificaFormato(Dati[P]);
          Dati[P].Fmt:=cmbFormato.Text;
        end;
        if (chkConvertiValuta.Visible) then
          Dati[P].ConvValuta:=chkConvertiValuta.Checked;
      end;
    end;
  end;

  ReleaseOggetti;
  Free;
end;

end.
