unit WA128UInserimentoFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, Menus, medpIWMultiColumnComboBox, IWHTMLControls,
  meIWLink, IWCompButton, meIWButton, IWCompLabel, meIWLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, IWTMSCheckList,
  meTIWCheckListBox, C180FunzioniGenerali, StrUtils, meIWEdit, IWDBStdCtrls,
  meIWDBEdit;

type
  TWA128FInserimentoFM = class(TWR200FBaseFM)
    clbGiorni: TmeTIWCheckListBox;
    btnInserisci: TmeIWButton;
    btnCancella: TmeIWButton;
    lnkTurno1: TmeIWLink;
    lnkTurno2: TmeIWLink;
    cmbTurno1: TMedpIWMultiColumnComboBox;
    cmbTurno2: TMedpIWMultiColumnComboBox;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    edtAlleOreTurno1: TmeIWEdit;
    edtDalleOreTurno2: TmeIWEdit;
    edtAlleOreTurno2: TmeIWEdit;
    lnkDalleOreTurno1: TmeIWLink;
    lnkAlleOreTurno1: TmeIWLink;
    lnkDalleOreTurno2: TmeIWLink;
    lnkAlleOreTurno2: TmeIWLink;
    edtDalleOreTurno1: TmeIWEdit;
    procedure lnkTurno1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure cmbTurnoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtOreAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
  public
    procedure Visualizza;
  end;

implementation

uses WA128UPianPrestazioniAggiuntive, WA128UPianPrestazioniAggiuntiveDM, WR100UBase;

{$R *.dfm}

procedure TWA128FInserimentoFM.Visualizza;
var i,m,a,g:Word;
    D:TDatetime;
begin
  inherited;
  with ((Self.Owner as TWA128FPianPrestazioniAggiuntive).WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
  begin
    // caricamento combo
    if cmbTurno1.Items.Count = 0 then
    begin
      Q330.First;
      while not Q330.Eof do
      begin
        cmbTurno1.AddRow(Q330.FieldByName('CODICE').AsString + ';' + Q330.FieldByName('DESCRIZIONE').AsString);
        cmbTurno2.AddRow(Q330.FieldByName('CODICE').AsString + ';' + Q330.FieldByName('DESCRIZIONE').AsString);
        Q330.Next;
      end;
    end;
    // caricamento lista giorni
    if clbGiorni.Items.Count = 0 then
    begin
      if selT332.RecordCount > 0 then
        D:=selT332.FieldByName('DATA').AsDateTime
      else
        D:=DataInizio;
      DecodeDate(D,a,m,g);
      for i:=1 to R180GiorniMese(D) do
        clbGiorni.Items.Add(FormatDateTime('ddd dd/mm/yyyy',EncodeDate(a,m,i)));
    end;
  end;
end;

procedure TWA128FInserimentoFM.lnkTurno1Click(Sender: TObject);
begin
  inherited;
  TWR100FBase(Self.Parent).AccediForm(60,'CODICE=' + IfThen((Sender as TmeIWLink).Name = 'lnkTurno1',cmbTurno1.Text,cmbTurno2.Text));
end;

procedure TWA128FInserimentoFM.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  with (pmnAzioni.PopupComponent as TmeTIWCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        Selected[i]:=True
      else if Sender = DeselezionaTutto1 then
        Selected[i]:=False
      else if Sender = InvertiSelezione1 then
        Selected[i]:=not Selected[i];
end;

procedure TWA128FInserimentoFM.btnInserisciClick(Sender: TObject);
var i:Integer;
begin
  with ((Self.Owner as TWA128FPianPrestazioniAggiuntive).WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
    try
      Dipendente:=selAnagrafe.FieldByName('MATRICOLA').AsString + ' ' +
                  selAnagrafe.FieldByName('T430BADGE').AsString + ' ' +
                  selAnagrafe.FieldByName('COGNOME').AsString + ' ' +
                  selAnagrafe.FieldByName('NOME').AsString;
      ListaGiorniSel.Clear;
      for i:=0 to clbGiorni.Items.Count - 1 do
        if clbGiorni.Selected[i] then
          ListaGiorniSel.Append(clbGiorni.Items[i]);
      Turno1Value:=cmbTurno1.Text;
      Turno2Value:=cmbTurno2.Text;
      OraInizioTurno1:=edtDalleOreTurno1.Text;
      OraFineTurno1:=edtAlleOreTurno1.Text;
      OraInizioTurno2:=edtDalleOreTurno2.Text;
      OraFineTurno2:=edtAlleOreTurno2.Text;
      InserisciGestioneMensile;
    finally
      RefreshSelT332;
    end;
end;

procedure TWA128FInserimentoFM.cmbTurnoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  if ((Sender as TMedpIWMultiColumnComboBox).Text <> '') then
  begin
    if edtDalleOreTurno1.Text <> '' then
      edtDalleOreTurno1.Text:='';
    if edtAlleOreTurno1.Text <> '' then
      edtAlleOreTurno1.Text:='';
    if edtDalleOreTurno2.Text <> '' then
      edtDalleOreTurno2.Text:='';
    if edtAlleOreTurno2.Text <> '' then
      edtAlleOreTurno2.Text:='';
  end;
end;

procedure TWA128FInserimentoFM.edtOreAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  if ((Sender as TmeIWEdit).Text <> '') then
  begin
    if cmbTurno1.Text <> '' then
      cmbTurno1.Text:='';
    if cmbTurno2.Text <> '' then
      cmbTurno2.Text:='';
  end;
end;

procedure TWA128FInserimentoFM.btnCancellaClick(Sender: TObject);
var i:Integer;
begin
  with ((Self.Owner as TWA128FPianPrestazioniAggiuntive).WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
  begin
    Dipendente:=selAnagrafe.FieldByName('MATRICOLA').AsString + ' ' +
                selAnagrafe.FieldByName('T430BADGE').AsString + ' ' +
                selAnagrafe.FieldByName('COGNOME').AsString + ' ' +
                selAnagrafe.FieldByName('NOME').AsString;
    ListaGiorniSel.Clear;
    for i:=0 to clbGiorni.Items.Count - 1 do
      if clbGiorni.Selected[i] then
        ListaGiorniSel.Append(clbGiorni.Items[i]);
    Turno1Value:=cmbTurno1.Text;
    Turno2Value:=cmbTurno2.Text;
    OraInizioTurno1:=edtDalleOreTurno1.Text;
    OraFineTurno1:=edtAlleOreTurno1.Text;
    OraInizioTurno2:=edtDalleOreTurno2.Text;
    OraFineTurno2:=edtAlleOreTurno2.Text;
    CancellaGestioneMensile;
  end;
end;

end.
