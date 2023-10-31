unit A139UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Printers,
  C001StampaLib;

type
  TA139FDialogStampa = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label2: TLabel;
    edtNote: TEdit;
    Label3: TLabel;
    edtFirmaSx: TEdit;
    chkAssentiGiustificati: TCheckBox;
    chkAssentiNonGiustificati: TCheckBox;
    chkSortCronologico: TCheckBox;
    chkSortCampo1: TCheckBox;
    Label4: TLabel;
    edtFirmaDx: TEdit;
    cmbCampo1: TComboBox;
    chkRaggrTipo: TCheckBox;
    edtNote2: TEdit;
    lblNote2: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataStampa:TDateTime;
    Servizio,Ufficio:String;
  end;

var
  A139FDialogStampa: TA139FDialogStampa;

implementation

uses A139UPianifServiziDtm, A139UStampaServizi;

{$R *.dfm}

procedure TA139FDialogStampa.FormCreate(Sender: TObject);
begin
  A139FStampaServizi:=TA139FStampaServizi.Create(nil);
  with A139FPianifServiziDtm do
  begin
    selCampo1.First;
    while Not selCampo1.Eof do
    begin
      cmbCampo1.Items.Add(selCampo1.FieldByName('DESCRIZIONE').AsString);
      selCampo1.Next;
    end;
  end;  
end;

procedure TA139FDialogStampa.FormShow(Sender: TObject);
var Campo1:String;
begin
  Campo1:=UpperCase(Copy(A139FPianifServiziDtm.ParametriPianServiziRaggr1,1,1));
  Campo1:=Campo1 + LowerCase(Copy(A139FPianifServiziDtm.ParametriPianServiziRaggr1,2,Length(A139FPianifServiziDtm.ParametriPianServiziRaggr1) - 1));
  Label1.Caption:=Campo1;
  chkSortCampo1.Caption:='Raggruppamento per ' + Campo1;
  try C001SettaQuickReport(A139FStampaServizi.QRep); except end;
end;

procedure TA139FDialogStampa.BitBtn2Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    try C001SettaQuickReport(A139FStampaServizi.QRep); except end;
end;

procedure TA139FDialogStampa.BitBtn3Click(Sender: TObject);
begin
  with A139FPianifServiziDtm do
  begin
    CreaTabellaStampa;
    CreaTabellaStampaAssenze;
    CaricaTabellaStampa(chkAssentiGiustificati.Checked,chkAssentiNonGiustificati.Checked);
    if chkSortCronologico.Checked then
    begin
      if chkSortCampo1.Checked then
        TabellaStampa.IndexName:='Idx3'
      else
        TabellaStampa.IndexName:='Idx1';
    end
    else
    begin
      if chkSortCampo1.Checked then
        TabellaStampa.IndexName:='Idx4'
      else
        TabellaStampa.IndexName:='Idx2';
    end;
    TabellaStampa.First;
  end;
  with A139FStampaServizi do
  begin
    Ufficio:=cmbCampo1.Text;
    LEnte.Caption:='';
    LTitolo.Caption:=FormatDateTime('dddd dd mmmm yyyy',DataStampa);//'Carta di servizio ' + Servizio;
    LUfficio.Caption:=Ufficio;

    bndCampo1.Enabled:=chkSortCampo1.Checked;
    bndTipoTurno.Enabled:=chkRaggrTipo.Checked;

    LNote.Caption:=edtNote.Text;
    LNote2.Caption:=edtNote2.Text;
    LFirmaSx.Caption:=edtFirmaSx.Text;
    LFirmaDx.Caption:=edtFirmaDx.Text;
    qedtCampo1.Enabled:=QRep.Page.Orientation = poLandscape;
    if QRep.Page.Orientation = poLandscape then
    begin
      qedtCampo2.Left:=148;
      qedtNominativo.Left:=244;
      qedtDalleAlle.Left:=446;
      qedtApparati.Left:=508;
      qedtCausale.Left:=608;
      qedtNote.Left:=652;
      qedtNote.Width:=400;
    end
    else
    begin
      qedtCampo2.Left:=38;
      qedtNominativo.Left:=134;
      qedtDalleAlle.Left:=336;
      qedtApparati.Left:=398;
      qedtCausale.Left:=498;
      qedtNote.Left:=542;
      qedtNote.Width:=220;
    end;
    qedtNomeAss.Left:=qedtNominativo.Left;
    qedtDalleAlleAss.Left:=qedtDalleAlle.Left;
    qedtCausAss.Left:=qedtNote.Left;
    qedtNomeAss.Width:=qedtDalleAlleAss.Left - qedtNomeAss.Left;
    QRep.Preview;
  end;
end;

procedure TA139FDialogStampa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A139FStampaServizi);
end;

end.
