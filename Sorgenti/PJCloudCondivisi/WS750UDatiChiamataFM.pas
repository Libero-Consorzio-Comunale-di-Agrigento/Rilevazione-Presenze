unit WS750UDatiChiamataFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, meIWImageFile, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  OracleData, C190FunzioniGeneraliWeb, WS750UParProtocolloDM,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, DB, WC011UListBoxFM, meIWEdit;

type
  TWS750FDatiChiamataFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    Row:Integer;
    WC011:TWC011FListBoxFM;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure imgCampiAnagClick(Sender: TObject);
    procedure lstModelloResult(Sender: TObject; DialogResult: Boolean; ResultValue: string);
  public
  end;

implementation

{$R *.dfm}

procedure TWS750FDatiChiamataFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATO'),0,DBG_EDT,'40','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATO'),1,DBG_IMG,'','PUNTINI','null','','S');
  grdTabella.medpCaricaCDS;
end;

procedure TWS750FDatiChiamataFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  img : TmeIWImageFile;
begin
  inherited;
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATO'),1) <> nil then
  begin
    img:=TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATO'),1));
    img.OnClick:=imgCampiAnagClick;
    if((Row <> 11) And (Row <> 14)) then
    begin
      img.Css:='invisibile';
      FreeAndNil(img);
    end;
  end;
end;

procedure TWS750FDatiChiamataFM.imgCampiAnagClick(Sender: TObject);
var LstCodice, LstDescrizione, LstCausaliSelezionate: TStringList;
begin
  LstCodice:=TStringList.Create;
  LstDescrizione:=TStringList.Create;
  LstCausaliSelezionate:=TStringList.Create;
  try
    WC011:=TWC011FListBoxFM.Create(Self.Parent);
    with WC011 do
    begin
      with (WR302DM as TWS750FParProtocolloDM).S750FParProtocolloMW.selI010 do
      begin
        First;
        while not Eof do
        begin
          LstCodice.Add(FieldByName('NOME_LOGICO').AsString);
          LstDescrizione.Add(FieldByName('NOME_LOGICO').AsString);
          Next;
        end;
      end;
      WC011.lstValori.Items.AddStrings(LstDescrizione);
      WC011.ResultEvent:=lstModelloResult;
      Row:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);

      WC011.Visualizza('Selezione');
    end;
  finally
    FreeAndNil(LstCodice);
    FreeAndNil(LstDescrizione);
    FreeAndNil(LstCausaliSelezionate);
  end;
end;

procedure TWS750FDatiChiamataFM.lstModelloResult(Sender: TObject; DialogResult: Boolean; ResultValue: string);
var S,DatoOld:String;
begin
  if DialogResult then
  begin
    try
      begin
        S:='';
        if ResultValue <> '' then
          S:=VarToStr( (WR302DM as TWS750FParProtocolloDM).S750FParProtocolloMW.selI010.Lookup('NOME_LOGICO',ResultValue,'NOME_CAMPO'));
        if S <> '' then
          begin
            DatoOld:=(WR302DM as TWS750FParProtocolloDM).SG751.FieldByName('DATO').AsString;
            TmeIWEdit(grdTabella.medpCompCella(Row,4,0)).Text:=(WR302DM as TWS750FParProtocolloDM).S750FParProtocolloMW.formatDato(DatoOld,S);
          end;
        end;
      finally
    end;
  end;
end;

end.
