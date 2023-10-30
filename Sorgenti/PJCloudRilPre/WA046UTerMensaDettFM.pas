unit WA046UTerMensaDettFM;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,Db,
  Dialogs, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWCompLabel, meIWLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompListbox, meIWDBLookupComboBox,
  IWCompCheckbox, meIWDBCheckBox, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali, WR205UDettTabellaFM;

type
  TWA046FTerMensaDettFM = class(TWR205FDettTabellaFM)
    dcmbCodice: TmeIWDBLookupComboBox;
    lblCodice: TmeIWLabel;
    dedtIntervalloMinimo: TmeIWDBEdit;
    lblTimbraturePerPasto: TmeIWLabel;
    lblIntervalloMinimo: TmeIWLabel;
    lblVocePaghe: TmeIWLabel;
    rgpTimbraturePerPasto: TmeIWDBRadioGroup;
    dchkAlimentabp: TmeIWDBCheckBox;
    lblAlimentabp: TmeIWLabel;
    dedtVocePaghe: TmeIWDBEdit;
    lblIntervalloDellaCenaDalle: TmeIWLabel;
    lblIntervalloDellaCenaAlle: TmeIWLabel;
    dedtIntervalloDellaCenaDalle: TmeIWDBEdit;
    dedtIntervalloDellaCenaAlle: TmeIWDBEdit;
    lblVocePagheImpIntero: TmeIWLabel;
    dedtVocePagheImpIntero: TmeIWDBEdit;
    lblSegnalazAnomalia: TmeIWLabel;
    dchkMensaStimbrataAnom: TmeIWDBCheckBox;
    lblTimbratNonCompresa: TmeIWLabel;
    lblTimbrMensaCompresa: TmeIWLabel;
    lblTimbrMensaAntecedente: TmeIWLabel;
    lblTimbrMensaSuccessiva: TmeIWLabel;
    lblTimbrPresNonEsistenti: TmeIWLabel;
    lblTimbrCausalizzata: TmeIWLabel;
    lblOreReseInferiori: TmeIWLabel;
    lblNonRispettaRegole: TmeIWLabel;
    lblOrarioSpezzato: TmeIWLabel;
    lblOrarioNoPausaMensa: TmeIWLabel;
    dchkMensaStimbrataIntero: TmeIWDBCheckBox;
    dchkMensaNonStimbrataAnom: TmeIWDBCheckBox;
    dchkMensaNonStimbrataIntero: TmeIWDBCheckBox;
    dchkMensaAntecedenteAnom: TmeIWDBCheckBox;
    dchkMensaAntecedenteIntero: TmeIWDBCheckBox;
    dchkMensaSuccessivaAnom: TmeIWDBCheckBox;
    dchkMensaSuccessivaIntero: TmeIWDBCheckBox;
    dchkMensaNonPresentiAnom: TmeIWDBCheckBox;
    dchkMensaNonPresentiIntero: TmeIWDBCheckBox;
    dchkTimbrNonCausalizzataAnom: TmeIWDBCheckBox;
    dchkOreReseInferioriAnom: TmeIWDBCheckBox;
    dchkOreReseInferioriIntero: TmeIWDBCheckBox;
    dchkMaturaBuonoAnom: TmeIWDBCheckBox;
    dchkMaturaBuonoIntero: TmeIWDBCheckBox;
    dchkOrarioSpezzatoAnom: TmeIWDBCheckBox;
    dchkOrarioSpezzatoIntero: TmeIWDBCheckBox;
    dchkOrarioNoPausaMensaAnom: TmeIWDBCheckBox;
    lblAnomalia: TmeIWLabel;
    lblImportoIntero: TmeIWLabel;
    lblIntMinimo: TmeIWLabel;
    dedtIntervalloAnom: TmeIWDBEdit;
    dChkIntervalloIntero: TmeIWDBCheckBox;
    lblIntMinimoDalle: TmeIWLabel;
    dEdtIntMensaDa: TmeIWDBEdit;
    lblIntMinimoAlle: TmeIWLabel;
    dEdtIntMensaA: TmeIWDBEdit;
    dChkIntMensaIntero: TmeIWDBCheckBox;
    lblOreMinime: TmeIWLabel;
    dChkOreMinimeIntero: TmeIWDBCheckBox;
    dEdtOreMinimeAnom: TmeIWDBEdit;
    dchkOrarioNoPausaMensaIntero: TmeIWDBCheckBox;
    lblInterfaccia: TmeIWLabel;
    procedure dchkMensaStimbrataAnomClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dEdtOreMinimeAnomAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dEdtOreMinimeAnomAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dcmbCodiceChange(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    {private declaration}
  end;

implementation

uses WA046UTerMensaDM;

{$R *.dfm}

procedure TWA046FTerMensaDettFM.dchkMensaStimbrataAnomClick(Sender: TObject);
begin
  if TWA046FTerMensaDM(WR302DM) <> nil then
  begin
    with TWA046FTerMensaDM(WR302DM).SelTabella do
    begin
      if Active then
      begin
        //Massimo ini
        if sender = dchkMensaStimbrataAnom then
        begin
          if dchkMensaStimbrataAnom.Checked and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMensaNonStimbrataAnom.DataField).AsString:='N';
          dchkMensaStimbrataIntero.Enabled:=dchkMensaStimbrataAnom.Checked;
          if (not dchkMensaStimbrataAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMensaStimbrataIntero.DataField).AsString:='N';
        end
        else if sender = dchkMensaNonStimbrataAnom then
        begin
          if dchkMensaNonStimbrataAnom.Checked and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMensaStimbrataAnom.DataField).AsString:='N';
          dchkMensaNonStimbrataIntero.Enabled:=dchkMensaNonStimbrataAnom.Checked;
          if (not dchkMensaNonStimbrataAnom.Checked) and (State in [dsInsert,dsEdit]) then
             FieldByName(dchkMensaNonStimbrataIntero.DataField).AsString:='N';
        end
        //fine
        (*
        if sender = dchkMensaStimbrataAnom then
        begin
          dchkMensaNonStimbrataAnom.Enabled:=not dchkMensaStimbrataAnom.Checked;
          if dchkMensaStimbrataAnom.Checked and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMensaNonStimbrataAnom.DataField).AsString:='N';

          dchkMensaStimbrataIntero.Enabled:=dchkMensaStimbrataAnom.Checked;
          if (not dchkMensaStimbrataAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMensaStimbrataIntero.DataField).AsString:='N';
        end
        else if sender = dchkMensaNonStimbrataAnom then
        begin
          dchkMensaNonStimbrataIntero.Enabled:=dchkMensaNonStimbrataAnom.Checked;
          if (not dchkMensaNonStimbrataAnom.Checked) and (State in [dsInsert,dsEdit]) then
             FieldByName(dchkMensaNonStimbrataIntero.DataField).AsString:='N';
        end
        *)
        else if sender = dchkMensaAntecedenteAnom then
        begin
          dchkMensaAntecedenteIntero.Enabled:=dchkMensaAntecedenteAnom.Checked;
          if (not dchkMensaAntecedenteAnom.Checked) and (State in [dsInsert,dsEdit]) then
              FieldByName(dchkMensaAntecedenteIntero.DataField).AsString:='N';
        end
        else if sender = dchkMensaSuccessivaAnom then
        begin
          dchkMensaSuccessivaIntero.Enabled:=dchkMensaSuccessivaAnom.Checked;
          if (not dchkMensaSuccessivaAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMensaSuccessivaIntero.DataField).AsString:='N';
        end
        else if sender = dchkMensaNonPresentiAnom then
        begin
          dchkMensaNonPresentiIntero.Enabled:=dchkMensaNonPresentiAnom.Checked;
          if (not dchkMensaNonPresentiAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMensaNonPresentiIntero.DataField).AsString:='N';
        end
        else if sender = dchkOrarioSpezzatoAnom then
        begin
          dchkOrarioSpezzatoIntero.Enabled:=dchkOrarioSpezzatoAnom.Checked;
          if (not dchkOrarioSpezzatoAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkOrarioSpezzatoIntero.DataField).AsString:='N';
        end
        else if sender = dchkOrarioNoPausaMensaAnom then
        begin
          dchkOrarioNoPausaMensaIntero.Enabled:=dchkOrarioNoPausaMensaAnom.Checked;
          if (not dchkOrarioNoPausaMensaAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkOrarioNoPausaMensaIntero.DataField).AsString:='N';
        end
        else if sender = dchkOreReseInferioriAnom then
        begin
          dchkOreReseInferioriIntero.Enabled:= dchkOreReseInferioriAnom.Checked;
          if (not dchkOreReseInferioriAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkOreReseInferioriIntero.DataField).AsString:='N';
        end
        else if sender = dEdtIntervalloAnom then
        begin
          dchkIntervalloIntero.Enabled:=(FieldByName(dEdtIntervalloAnom.DataField).AsString<>'00.00') and (trim(FieldByName(dEdtIntervalloAnom.DataField).AsString)<>'.');
          if ((FieldByName(dEdtIntervalloAnom.DataField).AsString='00.00') or (trim(FieldByName(dEdtIntervalloAnom.DataField).AsString)='.')) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkIntervalloIntero.DataField).AsString:='N';
        end
        else if sender = dEdtOreMinimeAnom then
        begin
           dchkOreMinimeIntero.Enabled:=(FieldByName(dEdtOreMinimeAnom.DataField).AsString<>'00.00') and (trim(FieldByName(dEdtOreMinimeAnom.DataField).AsString)<>'.');
          if ((FieldByName(dEdtOreMinimeAnom.DataField).AsString='00.00') or (trim(FieldByName(dEdtOreMinimeAnom.DataField).AsString)='.')) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkOreMinimeIntero.DataField).AsString:='N';
        end
        else if sender = dchkMaturaBuonoAnom then
        begin
          dchkMaturaBuonoIntero.Enabled:=dchkMaturaBuonoAnom.Checked;
          if (not dchkMaturaBuonoAnom.Checked) and (State in [dsInsert,dsEdit]) then
            FieldByName(dchkMaturaBuonoIntero.DataField).AsString:='N';
          //Alberto: l'attivazione delle regole buoni pasto disattiva le regole che sono già presenti sui buoni pasto
          lblOrarioSpezzato.Enabled:=not dchkMaturaBuonoAnom.Checked;
          dchkOrarioSpezzatoAnom.Enabled:=not dchkMaturaBuonoAnom.Checked;
          lblOrarioNoPausaMensa.Enabled:=not dchkMaturaBuonoAnom.Checked;
          dchkOrarioNoPausaMensaAnom.Enabled:=not dchkMaturaBuonoAnom.Checked;
          lblOreMinime.Enabled:=not dchkMaturaBuonoAnom.Checked;
          dedtOreMinimeAnom.Enabled:=not dchkMaturaBuonoAnom.Checked;
          if dchkMaturaBuonoAnom.Checked and (State in [dsInsert,dsEdit]) then
          begin
            FieldByName(dchkOrarioSpezzatoAnom.DataField).AsString:='N';
            FieldByName(dchkOrarioNoPausaMensaAnom.DataField).AsString:='N';
            FieldByName(dedtOreMinimeAnom.DataField).AsString:='00.00';
            //Massimo ini
            FieldByName(dchkOreMinimeIntero.DataField).AsString:='N';
            dchkOreMinimeIntero.Enabled:=False;
            //fine
          end;
        end;
      end;
    end;
  end;
end;

procedure TWA046FTerMensaDettFM.dcmbCodiceChange(Sender: TObject);
begin
  inherited;
  lblInterfaccia.Caption:=TWA046FTerMensaDM(WR302DM).SelTabella.FieldByName('D_CODICE').AsString;
end;

procedure TWA046FTerMensaDettFM.dEdtOreMinimeAnomAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkMensaStimbrataAnomClick(Sender);
end;

procedure TWA046FTerMensaDettFM.dEdtOreMinimeAnomAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkMensaStimbrataAnomClick(Sender);
end;

procedure TWA046FTerMensaDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  dcmbCodice.ListSource:=TWA046FTerMensaDM(WR302DM).dsrInterfaccia;
  if Parametri.CampiRiferimento.C18_AccessiMensa <> '' then
    lblCodice.Caption:=Parametri.CampiRiferimento.C18_AccessiMensa
  else
    lblCodice.Caption:='Codice';
  //Massimo: su irisWin, per questo componente, Enabled è una propietà gestibile da Object Inspector
  //mentre invece su WebPJ no.
  dchkMaturaBuonoIntero.Enabled:=False;
  dchkMensaStimbrataAnomClick(dchkMensaStimbrataAnom);
  dchkMensaStimbrataAnomClick(dchkMensaNonStimbrataAnom);
  dchkMensaStimbrataAnomClick(dchkMensaAntecedenteAnom);
  dchkMensaStimbrataAnomClick(dchkMensaSuccessivaAnom);
  dchkMensaStimbrataAnomClick(dchkMensaNonPresentiAnom);
  dchkMensaStimbrataAnomClick(dchkTimbrNonCausalizzataAnom);
  dchkMensaStimbrataAnomClick(dchkOrarioSpezzatoAnom);
  dchkMensaStimbrataAnomClick(dchkOrarioNoPausaMensaAnom);
  dchkMensaStimbrataAnomClick(dchkOreReseInferioriAnom);
  dchkMensaStimbrataAnomClick(dEdtIntervalloAnom);
  dchkMensaStimbrataAnomClick(dEdtOreMinimeAnom);
end;

procedure TWA046FTerMensaDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  lblInterfaccia.Caption:=TWA046FTerMensaDM(WR302DM).SelTabella.FieldByName('D_CODICE').AsString;
end;

end.
