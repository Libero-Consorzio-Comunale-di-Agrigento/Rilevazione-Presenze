unit WA013USviluppoIndivFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,OracleData,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl,IWBaseHTMLControl, IWControl, IWCompGrids, meIWGrid, C190FunzioniGeneraliWeb, QueryStorico,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, IWAppForm, IWApplication, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, medpIWMessageDlg;

type
  TWA013FSviluppoIndivFM = class(TWR200FBaseFM)
    grdCalendario: TmeIWGrid;
    btnChiudi: TmeIWButton;
    grdLegenda: TmeIWGrid;
    edtData: TmeIWEdit;
    lblData: TmeIWLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure OnModificaTipoData(EventParams: TStringList);
  private
    Anni:array [1..240] of word;
    Mesi:array [1..240] of word;
    QSCalendario:TQueryStorico;
    procedure CaricaCalendario;
    procedure CaricaLegenda;
  public
    NumMesi:Integer;
    Anno,Mese:Word;
    DaData,AData:TDateTime;
    procedure Visualizza;
  end;

implementation

uses WR100UBase, A013UCalendIndivMW, WA013UCalendIndiv;

{$R *.dfm}


procedure TWA013FSviluppoIndivFM.Visualizza;
var i,m,a:integer;
begin
  QSCalendario:=TQueryStorico.Create(nil);
  QSCalendario.Session:=SessioneOracle;
  QSCalendario.GetDatiStorici('T430CALENDARIO',TWA013FCalendIndiv(Self.Owner).grdC700.SelAnagrafe.FieldByName('progressivo').AsInteger,DaData,AData);
  a:=anno;
  m:=mese;
  if NumMesi > High(Mesi) then
  begin
    NumMesi:=High(Mesi);
  end;
  for i:=1 to NumMesi do
  begin
    Mesi[i]:=m;
    Anni[i]:=a;
    m:=m+1;
    if m > 12 then
    begin
      m:=1;
      a:=a+1;
    end;
  end;

  CaricaLegenda;
  CaricaCalendario;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,1150,-1,EM2PIXEL * 30,'Calendario ','#wc013_container',False,True);
end;

procedure TWA013FSviluppoIndivFM.CaricaLegenda;
begin
  grdLegenda.ColumnCount:=11;
  grdLegenda.RowCount:=1;

  grdLegenda.Cell[0,0].Css:='bg_white border_standard cal_legenda';
  grdLegenda.Cell[0,1].Text:='Lavorativo';

  grdLegenda.Cell[0,3].Css:='bg_lime border_standard cal_legenda';
  grdLegenda.Cell[0,4].Text:='Non Lavorativo';

  grdLegenda.Cell[0,6].Css:='bg_white' + ' ' + 'border_rosso';
  grdLegenda.Cell[0,7].Text:='Domenica';

  grdLegenda.Cell[0,9].Css:='bg_giallo border_standard cal_legenda';
  grdLegenda.Cell[0,10].Text:='Festivo';
end;

procedure TWA013FSviluppoIndivFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  GGetWebApplicationThreadVar.RegisterCallBack('OnModificaTipoData', OnModificaTipoData);
end;

procedure TWA013FSviluppoIndivFM.OnModificaTipoData(EventParams: TStringList);
var idLegenda,cssCella:String;
    A,M,G:Word;
    i,row:Integer;
    find:Boolean;
begin
  row:=-1;
  idLegenda:=EventParams.Values['idLegenda'];
  try
    if Trim(edtData.Text) = '' then
      raise Exception.Create('Data non Valida!');
    try
      DecodeDate(StrToDate(edtData.Text),A,M,G);
    except
      raise Exception.Create('Data non Valida!');
    end;

    find:=False;
    for i:=Low(Anni) to High(Anni) do
      if Anni[i] = A then
      begin
        find:=True;
        break;
      end;
    if not find then
      raise Exception.Create('Anno non presente in questo calendario!');

    find:=False;
    for i:=Low(Mesi) to High(Mesi) do
      if Mesi[i] = M then
      begin
        row:=i;
        find:=True;
        break;
      end;
    if not find then
      raise Exception.Create('Mese non presente in questo calendario!');
  except
    on E : Exception do
     begin
       GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('window.alert('''+E.Message+''');');
       Exit;
     end;
  end;

  if(idLegenda = 'cal_legenda_0') then  //Lavorativo
    cssCella:='border_standard'
  else if(idLegenda = 'cal_legenda_1') then //non lavorativo
    cssCella:='bg_lime cal_target'
  else if(idLegenda = 'cal_legenda_2') then //festivo
    cssCella:='bg_giallo';

  with TA013FCalendIndivMW(TWA013FCalendIndiv(Self.Owner).A013MW) do
  begin
    if not Q012.Locate('Data',StrToDate(edtData.Text),[]) then exit;
    Q012.Edit;
    if (idLegenda = 'cal_legenda_0') then
      Q012['Lavorativo']:='S';
    if (idLegenda = 'cal_legenda_1') then
      Q012['Lavorativo']:='N';
    if (idLegenda = 'cal_legenda_2') then
      if Q012['Festivo'] = 'S' then
        Q012['Festivo']:='N'
      else
        Q012['Festivo']:='S';
    Q012.Post;
  end;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('window.alert('''+Format('Data %s modificata correttamente',[edtData.Text])+''');  ');
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('$(''.table_calendar tr:eq('+IntToStr(Row)+') > td:eq('+IntToStr(G)+')'').removeClass().addClass('''+cssCella+' cal_target'');');
end;

procedure TWA013FSviluppoIndivFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  ReleaseOggetti;
  Free;
  if QSCalendario <> nil then
    FreeAndNil(QSCalendario);
end;

procedure TWA013FSviluppoIndivFM.CaricaCalendario;
var
  r,c:Integer;
  Data:TDateTime;
  MeseAnno:String;
begin
  grdCalendario.Css:=grdCalendario.Css + ' table_calendar ';
  grdCalendario.ColumnCount:=32;
  grdCalendario.RowCount:=NumMesi + 1;

  for r:=0 to grdCalendario.RowCount - 1 do
  begin
     for c:=0 to grdCalendario.ColumnCount - 1 do
     begin
       if (c = 0) and (r = 0) then
       begin
          //
       end
       else if (c = 0) and (r > 0) then
       begin
         MeseAnno:=IntToStr(Anni[r])+' '+{$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[Mesi[r]];
         grdCalendario.Cell[r,c].Css:='riga_intestazione border_standard';
         grdCalendario.Cell[r,c].Text:=MeseAnno;
       end
       else if (c > 0) and (c < 32) and (r = 0) then
       begin
         grdCalendario.Cell[r,c].Css:='riga_intestazione border_standard';
         grdCalendario.Cell[r,c].Text:=IntToStr(c);
       end
       else
       begin
         try
          Data:=EncodeDate(Anni[r],Mesi[r],c);
          with TA013FCalendIndivMW(TWA013FCalendIndiv(Self.Owner).A013MW) do
            if Q012.Locate('Data',Data,[]) then
            {Calendario del dipendente}
            begin
              if Q012['Festivo']='S' then
                grdCalendario.Cell[r,c].Css:='bg_giallo cal_target';           {Festivo}
              if not(Q012['Lavorativo'] = 'S') then
                if Q012['Festivo']='S' then
                  grdCalendario.Cell[r,c].Css:='bg_lime_giallo cal_target'     {Festivo} {Non lavorativo}
                else
                  grdCalendario.Cell[r,c].Css:='bg_lime cal_target';           {Non lavorativo}

              if DayOfWeek(Q012['Data']) = 1 then    {Domenica}
                grdCalendario.Cell[r,c].Css:=grdCalendario.Cell[r,c].Css + ' ' + 'border_rosso cal_target'
              else
                grdCalendario.Cell[r,c].Css:=grdCalendario.Cell[r,c].Css + ' ' + 'border_standard cal_target';
              grdCalendario.Cell[r,c].Text:={$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(Data)];
            end
            else
            begin
              {Attingo dal calendario registrato in anagrafico}
              if not QSCalendario.LocDatoStorico(Data) then
                exit;
              if QSCalendario.FieldByName('T430CALENDARIO').AsString <> VarToStr(Q011.GetVariable('Codice')) then
              begin
                Q011.Close;
                Q011.SetVariable('Codice',QSCalendario.FieldByName('T430CALENDARIO').AsString);
                Q011.SetVariable('Data1',DaData);
                Q011.SetVariable('Data2',AData);
                Q011.Open;
              end;
              if Q011.Locate('Data',Data,[]) then
              begin
                if Q011['Festivo']='S' then
                  grdCalendario.Cell[r,c].Css:='bg_giallo cal_target'; {Festivo}
                if not (Q011['Lavorativo'] = 'S') then
                  if Q011['Festivo']='S' then
                    grdCalendario.Cell[r,c].Css:='bg_lime_giallo cal_target'       {Festivo} {Non lavorativo}
                  else
                    grdCalendario.Cell[r,c].Css:='bg_lime cal_target';        {Non lavorativo}
                if DayOfWeek(Q011['Data']) = 1 then
                  grdCalendario.Cell[r,c].Css:=grdCalendario.Cell[r,c].Css + ' ' + 'border_rosso cal_target'
                else
                  grdCalendario.Cell[r,c].Css:=grdCalendario.Cell[r,c].Css + ' ' + 'border_standard cal_target';
                grdCalendario.Cell[r,c].Text:={$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(Data)];
              end;
            end;
         except
         end;
       end;
     end;
  end;
end;

end.
