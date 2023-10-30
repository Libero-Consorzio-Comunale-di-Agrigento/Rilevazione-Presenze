unit W042UDatiConiuge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R012UWebAnagrafico, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData, Math, StrUtils, W000UMessaggi,
  A000UInterfaccia, W042UDatiConiugeDM, IWCompListbox, meIWComboBox, IWCompEdit,
  meIWEdit, IWApplication, Data.DB, C180FunzioniGenerali, IWCompGrids, meIWGrid,
  IWDBGrids, medpIWDBGrid, C190FunzioniGeneraliWeb, meIWImageFile, W042UCaricamentoFM;

type
  TW042FDatiConiuge = class(TR012FWebAnagrafico)
    grdConiugi: TmedpIWDBGrid;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdConiugiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdConiugiRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
  private
    { Private declarations }
    W042DM:TW042FDatiConiugeDM;
    W042Car: TW042FCaricamentoFM;
    procedure PreparaGriglia(Griglia:TmedpIWDBGrid;DataSet:TOracleDataSet);
    procedure PreparaComponenti(Griglia:TmedpIWDBGrid);
    procedure imgInserisciConiugeClick(Sender: TObject);
    procedure imgCancellaConiugeClick(Sender: TObject);
    procedure imgAccediConiugeClick(Sender: TObject);
    procedure CreaFrame(Griglia:TmedpIWDBGrid;Operazione,FN:String);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
    procedure GetConiugi;
  end;

var
  W042FDatiConiuge: TW042FDatiConiuge;

implementation

{$R *.dfm}

function TW042FDatiConiuge.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
end;

procedure TW042FDatiConiuge.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  W042DM:=TW042FDatiConiugeDM.Create(nil);
  W042DM.selAnagrafeW:=selAnagrafeW;
  PreparaGriglia(grdConiugi,W042DM.selSG101);
end;

procedure TW042FDatiConiuge.VisualizzaDipendenteCorrente;
begin
  inherited;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  GetConiugi;
end;

procedure TW042FDatiConiuge.GetConiugi;
begin
  with W042DM do
  begin
    R180SetVariable(selSG101,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG101.Open;
    selSG101.First;
    grdConiugi.Caption:=IfThen(selSG101.RecordCount > 1,'Coniugi','Coniuge');
  end;
  grdConiugi.medpAggiornaCDS;
end;

procedure TW042FDatiConiuge.PreparaGriglia(Griglia:TmedpIWDBGrid;DataSet:TOracleDataSet);
begin
  Griglia.medpPaginazione:=False;
  Griglia.medpDataset:=DataSet;
  DataSet.Open;
  Griglia.medpComandiCustom:=True;
  Griglia.medpAttivaGrid(DataSet,not SolaLettura,not SolaLettura,not SolaLettura);
  PreparaComponenti(Griglia);
end;

procedure TW042FDatiConiuge.PreparaComponenti(Griglia:TmedpIWDBGrid);
begin
  with Griglia do
  begin
    medpCancellaRigaWR102;
    medpPreparaComponentiDefault;
    medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','ACCEDI','Accedi','','S');
    Griglia.medpCaricaCDS;
  end;
end;

procedure TW042FDatiConiuge.grdConiugiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
begin
  inherited;
  with grdConiugi do
  begin
    if not SolaLettura then
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciConiugeClick;
    for i:=IfThen(medpComandiInsert,1,0) to High(medpCompGriglia) do
    begin
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
        (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:='invisibile';
      //Associo l'evento OnClick alle icone dei comandi
      if not SolaLettura then
        if (medpCompGriglia[i].CompColonne[0] <> nil) then
        begin
          //DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
          (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
          (*DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
          if (medpValoreColonna(i,'ACARICO_STORIA') = 'S')
          or (medpValoreColonna(i,'NUCLEO_STORIA') = 'S')
          or (medpValoreColonna(i,'GIUSTIFICATIVI') = 'S') then
            (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile'
          else
          begin
            (medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgCancellaConiugeClick;
            (medpCompCella(i,0,1) as TmeIWImageFile).Confirmation:='Attenzione!' + CRLF +
              'La cancellazione è prevista soltanto nel caso in cui non si fosse mai stati coniugati con la persona selezionata.' + CRLF +
              'Invece, se si vuole indicare che il matrimonio è terminato, bisogna annullare l''operazione di cancellazione e si deve impostare la data di Fine matrimonio.' + CRLF +
              'Si è certi di voler proseguire con la cancellazione definitiva dei dati del coniuge selezionato?';
          end;*)
        end;
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
        (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediConiugeClick;
    end;
  end;
end;

procedure TW042FDatiConiuge.grdConiugiRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
var NumColonna:Integer;
begin
  inherited;
  NumColonna:=grdConiugi.medpNumColonna(AColumn);
  if not grdConiugi.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow = 0) then
    ACell.Text:=StringReplace(ACell.Text,sObbl,'',[rfReplaceAll]);
  ACell.Wrap:=ARow <> 0;
  if (ARow > 0) and (grdConiugi.medpColonna(NumColonna).DataField = 'MESSAGGI') then
    ACell.Css:=IfThen(grdConiugi.medpValoreColonna(ARow - 1,'MESSAGGI') = '',ACell.Css,
               IfThen(grdConiugi.medpValoreColonna(ARow - 1,'ANOMALIE') <> '',' bg_rosa',
               IfThen(grdConiugi.medpValoreColonna(ARow - 1,'INFOW') <> '',' bg_giallo',' bg_verde_pastello')));
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdConiugi.medpCompGriglia) + 1)
  and (grdConiugi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdConiugi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW042FDatiConiuge.imgInserisciConiugeClick(Sender: TObject);
begin
  CreaFrame(grdConiugi,'I',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW042FDatiConiuge.imgCancellaConiugeClick(Sender: TObject);
begin
  (*DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
  grdConiugi.medpColumnClick(nil,(Sender as TmeIWImageFile).FriendlyName);
  W042DM.Registrazione('D');
  //Chiudo il dataset corrente per refresh
  W042DM.selSG101.Close;
  GetConiugi;*)
end;

procedure TW042FDatiConiuge.imgAccediConiugeClick(Sender: TObject);
begin
  CreaFrame(grdConiugi,'A',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW042FDatiConiuge.CreaFrame(Griglia:TmedpIWDBGrid;Operazione,FN:String);
begin
  Griglia.medpColumnClick(nil,FN);
  //Apro frame di gestione dati
  W042Car:=TW042FCaricamentoFM.Create(Self);
  W042Car.ReadOnly:=SolaLettura;
  W042Car.W042DM2:=W042DM;
  W042Car.DataSetCar:=(Griglia.medpDataSet as TOracleDataSet);
  W042Car.AzioneRichiamo:=Operazione;
  W042Car.Apri;
  W042Car.Visualizza;
end;

procedure TW042FDatiConiuge.DistruggiOggetti;
begin
  FreeAndNil(W042DM);
  grdConiugi.medpClearCompGriglia;
end;

end.
