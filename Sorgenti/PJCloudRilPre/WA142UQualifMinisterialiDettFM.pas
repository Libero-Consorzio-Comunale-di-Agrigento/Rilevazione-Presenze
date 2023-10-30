unit WA142UQualifMinisterialiDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent, Db,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBComboBox,
  C180FunzioniGenerali, meIWEdit, IWCompJQueryWidget, meIWLabel;

type
  TWA142FQualifMinisterialiDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    lblMacroCategoria: TmeIWLabel;
    dedtProgressivo: TmeIWDBEdit;
    lblProgressivo: TmeIWLabel;
    dedtDebitoGg: TmeIWDBEdit;
    lblDebitoGg: TmeIWLabel;
    dedtMacroCategoria: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    Elenco:TStringList;
    procedure LoaddedtMacroCatergoriaAutocomplete;
  public
    procedure selTabellaAfterPost(DataSet: TDataSet);
  end;

implementation

{$R *.dfm}

procedure TWA142FQualifMinisterialiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  LoaddedtMacroCatergoriaAutocomplete;
end;

procedure TWA142FQualifMinisterialiDettFM.selTabellaAfterPost(DataSet: TDataSet);
begin
  if  (WR302DM.selTabella.FieldByName('MACRO_CATEG_QM').AsString <> '')
  and (Elenco.IndexOf(WR302DM.selTabella.FieldByName('MACRO_CATEG_QM').AsString) = -1) then
    LoaddedtMacroCatergoriaAutocomplete;
end;

procedure TWA142FQualifMinisterialiDettFM.LoaddedtMacroCatergoriaAutocomplete;
var
  Elementi:String;
begin
  WR302DM.selTabella.Open;
  Elenco:=TStringList.Create;
  Elementi:='';
  with WR302DM.selTabella do
  begin
    Open;
    while not Eof do
    begin
      if Elenco.IndexOf(FieldByName('MACRO_CATEG_QM').AsString) = -1 then
      begin
        Elementi:=Elementi + '''' + AggiungiApice(FieldByName('MACRO_CATEG_QM').AsString) + ''',';
        Elenco.Add(FieldByName('MACRO_CATEG_QM').AsString);
      end;
      Next;
    end;
    First;
  end;

  JQuery.OnReady.Clear;
  if Elementi <> '' then
  begin
    Elementi:='var elementi = [' + Copy(Elementi,1,Length(Elementi) - 1) + '];';

    JQuery.OnReady.Add(Elementi);
    JQuery.OnReady.Add('$("#' + dedtMacroCategoria.HTMLName + '").autocomplete({');
    JQuery.OnReady.Add('  source: elementi');
    JQuery.OnReady.Add('});');
  end;
end;

end.
