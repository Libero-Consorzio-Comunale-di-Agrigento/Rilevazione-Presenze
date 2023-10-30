unit WA012UVisualizzaCalendarioFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, C190FunzioniGeneraliWeb,
  IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, meIWGrid, IWCompGrids, IWCompJQueryWidget;

type
  TWA012FVisualizzaCalendarioFM = class(TWR200FBaseFM)
    grdCalendario: TmeIWGrid;
    btnChiudi: TmeIWButton;
    grdLegenda: TmeIWGrid;
    procedure btnChiudiClick(Sender: TObject);
  private
    Anni:array [1..240] of word;
    Mesi:array [1..240] of word;
    procedure CaricaLegenda;
    procedure CaricaCalendario;
  public
    NumMesi:Integer;
    Anno,Mese:Word;
    procedure Visualizza(Title:String);
  end;

implementation

uses WR100UBase, WA012UCalendariDM, WA012UCalendari;

{$R *.dfm}

procedure TWA012FVisualizzaCalendarioFM.Visualizza(Title:String);
var i,m,a:integer;
begin
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

  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,1150,-1,EM2PIXEL * 30,'Calendario ' + Title,'#wc012_container',False,True);
end;

procedure TWA012FVisualizzaCalendarioFM.CaricaLegenda;
begin
  grdLegenda.ColumnCount:=11;
  grdLegenda.RowCount:=1;

  grdLegenda.Cell[0,0].Css:='bg_white border_standard';
  grdLegenda.Cell[0,1].Text:='Lavorativo';

  grdLegenda.Cell[0,3].Css:='bg_lime border_standard';
  grdLegenda.Cell[0,4].Text:='Non Lavorativo';

  grdLegenda.Cell[0,6].Css:='bg_white' + ' ' + 'border_rosso';
  grdLegenda.Cell[0,7].Text:='Domenica';

  grdLegenda.Cell[0,9].Css:='bg_giallo border_standard';
  grdLegenda.Cell[0,10].Text:='Festivo';
end;

procedure TWA012FVisualizzaCalendarioFM.CaricaCalendario;
var
  r,c:Integer;
  Data:TDateTime;
  MeseAnno:String;
begin
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

           with TWA012FCalendariDM(TWA012FCalendari(Self.Parent).WR302DM) do
            try
            if Q011.Locate('Data',Data,[]) then
            begin
              if Q011['Festivo']='S' then
                begin
                grdCalendario.Cell[r,c].Css:='bg_giallo'; {Festivo}
                end;
              if not (Q011['Lavorativo'] = 'S') then
                if Q011['Festivo']='S' then
                  grdCalendario.Cell[r,c].Css:='bg_lime_giallo'       {Festivo} {Non lavorativo}
                else
                  grdCalendario.Cell[r,c].Css:='bg_lime';        {Non lavorativo}
              if DayOfWeek(Q011['Data']) = 1 then
                grdCalendario.Cell[r,c].Css:=grdCalendario.Cell[r,c].Css + ' ' + 'border_rosso'
              else
                grdCalendario.Cell[r,c].Css:=grdCalendario.Cell[r,c].Css + ' ' + 'border_standard';

              grdCalendario.Cell[r,c].Text:={$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(Data)];
            end;
            except
              //
            end;
         except
         end;
       end;
     end;
  end;
end;

procedure TWA012FVisualizzaCalendarioFM.btnChiudiClick(Sender: TObject);
begin
  ReleaseOggetti;
  Free;
end;

end.
