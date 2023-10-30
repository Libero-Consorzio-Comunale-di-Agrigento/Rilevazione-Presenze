unit WA001UPaginaPrincipale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, WR100UBase, ActnList, IWApplication, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWDBGrids,
  A000UInterfaccia, medpIWDBGrid, WC700USelezioneAnagrafeFM, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton,
  meIWButton, medpIWC700NavigatorBar, meIWImageFile, Vcl.Menus, IWCompEdit, meIWEdit;

type
  TWA001FPaginaPrincipale = class(TWR100FBase)
    grdSelezioneAnagrafe: TmedpIWDBGrid;
    pmnGrdSelezionaAnagrafica: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdSelezioneAnagrafeRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure actScaricaInCSVClick(Sender: TObject);
  protected
    procedure ImpostazioniWC700; override;
  public
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure ScrollSelAnagrafe(DataSet: TDataSet);
  end;

implementation

{$R *.dfm}

procedure TWA001FPaginaPrincipale.actScaricaInCSVClick(Sender: TObject);
var
  NomeFile: String;
begin
  if not Assigned(Sender) then
    csvDownload:=grdSelezioneAnagrafe.ToCsv
  else
  begin
    NomeFile:='SelezioneAnagrafica.xls';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    InviaFile(NomeFile,csvDownload);
  end;
end;

procedure TWA001FPaginaPrincipale.actScaricaInExcelClick(Sender: TObject);
var
  NomeFile: String;
begin
  if not Assigned(Sender) then
    streamDownload:=grdSelezioneAnagrafe.ToXlsx
  else
  begin
    NomeFile:='SelezioneAnagrafica.xlsx';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    InviaFile(NomeFile,streamDownload);
  end;
end;

procedure TWA001FPaginaPrincipale.grdSelezioneAnagrafeRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  DataInizioRap,
  DataFineRap: TDateTime;
begin
  inherited;
  grdSelezioneAnagrafe.medpRenderCell(ACell,ARow,Acolumn,True,True,True);

  with  grdSelezioneAnagrafe.medpClientDataSet do
  begin
    if (State <> dsInactive) and
       (RecordCount > 0) then
    begin
      DataFineRap:=FieldByName('T430FINE').AsDateTime;
      if DataFineRap = 0 then
        DataFineRap:=EncodeDate(3999,12,31);
      DataInizioRap:=FieldByName('T430INIZIO').AsDateTime;
      if DataInizioRap = 0 then
        DataInizioRap:=EncodeDate(1899,12,30);
      if ( (DataInizioRap > Parametri.DataLavoro) or
           (DataFineRap < Parametri.DataLavoro) ) and
         (not ACell.Header)  then
        ACell.Css:=ACell.Css + ' font_rosso';
    end;
  end;
end;

procedure TWA001FPaginaPrincipale.ImpostazioniWC700;
(*
var
  lstDatiSelezionati: TStringList;
*)
begin
  //serve perchè se seleziono un elemento sulla grid deve aggiornare la statusbar
  //??verificare se può essere fatto diversamente
  grdC700.WC700DM.ScrollEvent:=ScrollSelAnagrafe;

  //todo. non tutti i campi ma cdsi010
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase;
(*
  lstDatiSelezionati:=TStringList.Create();
  try
    WR000DM.cdsI010.First;
    while not WR000DM.cdsI010.Eof do
    begin
      S:=WR000DM.cdsI010.FieldByName('NOME_CAMPO').AsString;
      if Copy(S,1,6) = 'T430D_' then
        S:=Copy(S,7,Length(S))
      else if Copy(S,1,4) = 'T430' then
        S:=Copy(S,5,Length(S));
      if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or
         (WR000DM.cdsI010.FieldByName('ACCESSO').AsString = 'S' ) then
        lstDatiSelezionati.Add(WR000DM.cdsI010.FieldByName('NOME_CAMPO').AsString);
      WR000DM.cdsI010.Next;
    end;
    WC700FM.C700DatiSelezionati:=lstDatiSelezionati.CommaText;
  finally
    FreeAndNil(lstDatiSelezionati);
  end;
*)
end;

procedure TWA001FPaginaPrincipale.IWAppFormAfterRender(Sender: TObject);
begin
  inherited;
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    if not jqPublicIP.Enabled then
      RimuoviNotifiche;
  end;
end;

procedure TWA001FPaginaPrincipale.IWAppFormCreate(Sender: TObject);
begin
  medpFissa:=True;
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.SelezioneVuota:=True;//False;
  AttivaGestioneC700;

  WR000DM.C700NavigatorBarMain:=grdC700;

  grdSelezioneAnagrafe.medpPaginazione:=True;
  grdSelezioneAnagrafe.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
  grdSelezioneAnagrafe.medpAttivaGrid(grdC700.selAnagrafe,False,False);

  //Gestione Notifiche custom
  NotificheCustom;

  // MONDOEDP - commessa MAN/07 SVILUPPO#0.ini
  // verifica se il browser in uso è supportato e notifica nel caso di incompatibilità
  VerificaCompatibilitaBrowser;
  // MONDOEDP - commessa MAN/07 SVILUPPO#0.fine

end;

procedure TWA001FPaginaPrincipale.ScrollSelAnagrafe(DataSet: TDataSet);
begin
  AggiornaAnagr;
end;

procedure TWA001FPaginaPrincipale.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  if grdSelezioneAnagrafe.medpDataSet <> nil then
    grdSelezioneAnagrafe.medpAggiornaCDS;
end;

end.
