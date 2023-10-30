unit WA040UInserimentoFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, OracleData,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, StrUtils,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWTMSCheckList, meTIWCheckListBox,
  meIWEdit, IWCompListbox, meIWComboBox, IWCompLabel, meIWLabel, IWDBStdCtrls,
  meIWDBLookupComboBox, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  IWCompButton, meIWButton, WR010UBase, CheckLst, IWHTMLControls, meIWLink,
  Menus, medpIWMultiColumnComboBox;

type
  TWA040FInserimentoFM = class(TWR200FBaseFM)
    clbGiorni: TmeTIWCheckListBox;
    lblDatoLibero: TmeIWLabel;
    btnInserisci: TmeIWButton;
    btnCancella: TmeIWButton;
    lnkTurno1: TmeIWLink;
    lnkTurno2: TmeIWLink;
    lnkTurno3: TmeIWLink;
    pmnAzioniGiorni: TPopupMenu;
    Selezionatutto1Giorni: TMenuItem;
    Deselezionatutto1Giorni: TMenuItem;
    Invertiselezione1Giorni: TMenuItem;
    cmbTurno1: TMedpIWMultiColumnComboBox;
    cmbTurno2: TMedpIWMultiColumnComboBox;
    cmbTurno3: TMedpIWMultiColumnComboBox;
    cmbDatoLibero: TMedpIWMultiColumnComboBox;
    cmbDipNominativo: TMedpIWMultiColumnComboBox;
    lnkDipNominativo: TmeIWLink;
    edtDipMatricola: TmeIWEdit;
    lblDipMatricola: TmeIWLabel;
    lblContratto: TmeIWLabel;
    procedure btnInserisciClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure lnkTurno1Click(Sender: TObject);
    procedure InvertiselezioneGiorniClick(Sender: TObject);
    procedure clbGiorniAsyncCheckClick(Sender: TObject; EventParams: TStringList; Index: Integer; Check: LongBool);
    procedure cmbDipNominativoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
  private
    { Private declarations }
  public
    procedure Visualizza;
  end;

implementation

uses WA040UPianifRep, WA040UPianifRepDM, WR100UBase;

{$R *.dfm}

procedure TWA040FInserimentoFM.Visualizza;
var
  i,m,a,g:Word;
  D:TDatetime;
  ProgVis:Integer;
begin
  inherited;
  with ((Self.Owner as TWA040FPianifRep).WR302DM as TWA040FPianifRepDM).A040MW do
  begin
    // caricamento combo dipendenti
    ProgVis:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    cmbDipNominativo.Text:='';
    cmbDipNominativo.Items.Clear;
    cmbDipNominativo.ItemIndex:=-1;
    edtDipMatricola.Text:='';
    lblContratto.Text:='Contratto: ';
    selAnagrafe.First;
    while not selAnagrafe.Eof do
    begin
      cmbDipNominativo.AddRow(selAnagrafe.FieldByName('MATRICOLA').AsString + ';' + selAnagrafe.FieldByName('COGNOME').AsString + ' ' + selAnagrafe.FieldByName('NOME').AsString);
      selAnagrafe.Next;
    end;
    selAnagrafe.SearchRecord('PROGRESSIVO',ProgVis,[srFromBeginning]);
    // caricamento combo turni
    if cmbTurno1.Items.Count = 0 then
    begin
      Q350.First;
      while not Q350.Eof do
      begin
        cmbTurno1.AddRow(Q350.FieldByName('CODICE').AsString + ';' + Q350.FieldByName('DESCRIZIONE').AsString);
        cmbTurno2.AddRow(Q350.FieldByName('CODICE').AsString + ';' + Q350.FieldByName('DESCRIZIONE').AsString);
        cmbTurno3.AddRow(Q350.FieldByName('CODICE').AsString + ';' + Q350.FieldByName('DESCRIZIONE').AsString);
        Q350.Next;
      end;
    end;
    // caricamento combo dato libero
    cmbDatoLibero.Visible:=A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero);
    lblDatoLibero.Visible:=cmbDatoLibero.Visible;
    if lblDatoLibero.Visible then
      lblDatoLibero.Caption:=selT380.FieldByName('DATOLIBERO').DisplayLabel;
    if cmbDatoLibero.Visible and (cmbDatoLibero.Items.Count = 0) then
    begin
      selDatoLibero.First;
      while not selDatoLibero.Eof do
      begin
        cmbDatoLibero.AddRow(selDatoLibero.FieldByName('CODICE').AsString + ';' + selDatoLibero.FieldByName('DESCRIZIONE').AsString);
        selDatoLibero.Next;
      end;
    end;
    // caricamento lista giorni
    if clbGiorni.Items.Count = 0 then
    begin
      if selT380.RecordCount > 0 then
        D:=selT380.FieldByName('DATA').AsDateTime
      else
        D:=DataInizio;
      DecodeDate(D,a,m,g);
      for i:=1 to R180GiorniMese(D) do
        clbGiorni.Items.Add(FormatDateTime('ddd dd/mm/yyyy',EncodeDate(a,m,i)));
    end;
  end;
end;

procedure TWA040FInserimentoFM.lnkTurno1Click(Sender: TObject);
begin
  inherited;
  TWR100FBase(Self.Parent).AccediForm(123,'CODICE=' + IfThen((Sender as TmeIWLink).Name = 'lnkTurno1',cmbTurno1.Text,
                                                      IfThen((Sender as TmeIWLink).Name = 'lnkTurno2',cmbTurno2.Text,
                                                                                                      cmbTurno3.Text)));
end;

procedure TWA040FInserimentoFM.InvertiselezioneGiorniClick(Sender: TObject);
var i:Integer;
begin
  with (pmnAzioniGiorni.PopupComponent as TmeTIWCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1Giorni then
        Selected[i]:=True
      else if Sender = DeselezionaTutto1Giorni then
        Selected[i]:=False
      else if Sender = InvertiSelezione1Giorni then
        Selected[i]:=not Selected[i];
end;

procedure TWA040FInserimentoFM.btnInserisciClick(Sender: TObject);
var i:Integer;
begin
  with ((Self.Owner as TWA040FPianifRep).WR302DM as TWA040FPianifRepDM).A040MW do
    try
      Dipendente:=edtDipMatricola.Text;
      ProgGM:=StrToIntDef(VarToStr(selAnagrafe.Lookup('MATRICOLA',edtDipMatricola.Text,'PROGRESSIVO')),0);
      DataControllo:=DataInizio;
      ListaGiorniSel.Clear;
      for i:=0 to clbGiorni.Items.Count - 1 do
        if clbGiorni.Selected[i] then
          ListaGiorniSel.Append(clbGiorni.Items[i]);
      Turno1Value:=cmbTurno1.Text;
      Turno2Value:=cmbTurno2.Text;
      Turno3Value:=cmbTurno3.Text;
      DatoLiberoValue:=cmbDatoLibero.Text;
      NonContDipPian:=(Self.Owner as TWA040FPianifRep).chkNonContDipPian.Checked;
      InserisciGestioneMensile;
    finally
      btnInserisci.Enabled:=False;
      RefreshT380;
    end;
end;

procedure TWA040FInserimentoFM.clbGiorniAsyncCheckClick(Sender: TObject; EventParams: TStringList; Index: Integer; Check: LongBool);
begin
  inherited;
   btnInserisci.Enabled:=True;
end;

procedure TWA040FInserimentoFM.cmbDipNominativoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbDipNominativo.ItemIndex = -1 then
  begin
    edtDipMatricola.Text:='';
    lblContratto.Caption:='Contratto: ';
  end
  else
  begin
    edtDipMatricola.Text:=cmbDipNominativo.Items[cmbDipNominativo.ItemIndex].RowData[0];
    with ((Self.Owner as TWA040FPianifRep).WR302DM as TWA040FPianifRepDM).A040MW do
      lblContratto.Caption:='Contratto: ' + VarToStr(selAnagrafe.Lookup('MATRICOLA',edtDipMatricola.Text,'T430CONTRATTO')) + ' ' + VarToStr(selAnagrafe.Lookup('MATRICOLA',edtDipMatricola.Text,'T430D_CONTRATTO'));
    btnInserisci.Enabled:=True;
  end;
end;

procedure TWA040FInserimentoFM.btnCancellaClick(Sender: TObject);
var
  i:Integer;
begin
  with ((Self.Owner as TWA040FPianifRep).WR302DM as TWA040FPianifRepDM).A040MW do
  begin
    Dipendente:=edtDipMatricola.Text;
    ProgGM:=StrToIntDef(VarToStr(selAnagrafe.Lookup('MATRICOLA',edtDipMatricola.Text,'PROGRESSIVO')),0);
    DataControllo:=DataInizio;
    ListaGiorniSel.Clear;
    for i:=0 to clbGiorni.Items.Count - 1 do
      if clbGiorni.Selected[i] then
        ListaGiorniSel.Append(clbGiorni.Items[i]);
    Turno1Value:=cmbTurno1.Text;
    Turno2Value:=cmbTurno2.Text;
    Turno3Value:=cmbTurno3.Text;
    DatoLiberoValue:=CmbDatoLibero.Text;
    NonContDipPian:=(Self.Owner as TWA040FPianifRep).chkNonContDipPian.Checked;
    CancellaGestioneMensile;
    if RecordT380Cancellati then
    begin
      RefreshT380;
    end;
  end;
end;

end.
