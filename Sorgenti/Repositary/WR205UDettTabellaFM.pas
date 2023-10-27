unit WR205UDettTabellaFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWDBStdCtrls, meIWDBEdit, medpIWDBGrid,
  IWDBExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  DB, meIWDBLabel, meIWDBRadioGroup, meIWDBComboBox,
  meIWDBLookupComboBox, meIWDBCheckBox,
  IWCompJQueryWidget,OracleData,meIWLink,meIWLabel,
  MedpIWMultiColumnComboBox,meIWEdit,meIWmemo,TypInfo,meIWDBMemo;

type
  TWR205FDettTabellaFM = class(TWR200FBaseFM)
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SvuotaMultiColumnCombobox(Region: TIWRegion);
    procedure DataSourceControlli(Region:TIWRegion);
  protected
    procedure ImpostaCss(control:TControl;css:String);
  public
    //Caratto 26/11/2011. procedura mai usata. commentata come deprecata
//  procedure RenderHTMLControlli;
    procedure AbilitaAllComponenti(WorkDataSet : TOracleDataSet); virtual;
    procedure AbilitaComponenti; virtual;
    procedure DataSet2Componenti; virtual;
    procedure Componenti2DataSet; virtual;
    procedure CaricaMultiColumnCombobox; virtual;
  end;

implementation

{$R *.dfm}

//imposta il nuovo css.
//se il vecchio css contiene la classe noDisabled la mantiene.
//Necessario per la gestione dei componenti data-aware come readOnly non disabilitati
procedure TWR205FDettTabellaFM.ImpostaCss(control: TControl; css: String);
var
  PropInfo: PPropInfo;
  ValCss: String;
begin
  PropInfo:=GetPropInfo(control, 'css');
  if Assigned(PropInfo) then
  begin
    ValCss:=GetStrProp(control,'css');
    if Pos('noDisabled',ValCss) <=0 then
      ValCss:=css
    else
      ValCss:=css + ' noDisabled';

    SetStrProp(control, 'css', ValCss);
  end;
end;

procedure TWR205FDettTabellaFM.IWFrameRegionCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  for i:=0 to ControlCount - 1 do
    if Controls[i] is TIWRegion then
    begin
      DataSourceControlli(TIWRegion(Controls[i]));
      Break;
    end;
  DataSet2Componenti;

  AbilitaAllComponenti(nil);
end;

(*
Caratto 28/06/2012
Abilita o disabilita tutti i componenti non data-aware in base allo stato del dataset
se edit o insert, abilita; altrimenti disabilita.
Inoltre richiama la gestione specifica per ogni dettaglio per abilitare/disabilitare
i controlli in base al valore di campi specifici
Richiamato da dsrTabellaStateChange di TWR302FGestTabellaDM
*)
procedure TWR205FDettTabellaFM.AbilitaAllComponenti(WorkDataSet : TOracleDataSet);
var
  DataSet : TOracleDataSet;
begin
  if WR302DM <> nil then
  begin
    if WorkDataSet <> nil then
      DataSet:=WorkDataSet
    else
      DataSet:=WR302DM.selTabella;

    if  DataSet.State <> dsInactive then
    begin
      AbilitaComponentiRegion(IWFrameRegion,DataSet);
      AbilitaComponenti;
      //Gestione caricamento MultiColumnCombobox
      if DataSet.State in [dsEdit,dsInsert] then //caricamento lista elementi multicolumn
        CaricaMultiColumnCombobox
      else //svuota lista elementi
        SvuotaMultiColumnCombobox(IWFrameRegion);
    end;
  end;
end;

procedure TWR205FDettTabellaFM.SvuotaMultiColumnCombobox(Region : TIWRegion);
var
  i : Integer;
begin
  for i:=0 to Region.ControlCount - 1 do
  begin
    if (Region.Controls[i] is TIWRegion) then
      SvuotaMultiColumnCombobox(TIWRegion(Region.Controls[i]))
    else if (Region.Controls[i] is TMedpIWMultiColumnComboBox) then
      if TMedpIWMultiColumnComboBox(Region.Controls[i]).medpAutoResetItems then
        TMedpIWMultiColumnComboBox(Region.Controls[i]).Items.Clear;
  end;
end;

(*
Caratto 28/06/2012
Abilita o disabilita  i componenti in base a logica specifica
La logica va inserita nei frame specifici.
richiamato da AbilitaAllComponenti e nei frame figli per la gestione della logica di abilitazione componenti
*)
procedure TWR205FDettTabellaFM.AbilitaComponenti;
begin

end;

(*
Caratto 28/06/2012
Carica i componenti non data-aware con i campi del dataset
La logica va inserita nei frame specifici.
richiamato da AfterDelete, AfterCancel, AfterPost, AfterScroll di TWR302FGestTabellaDM
*)
procedure TWR205FDettTabellaFM.DataSet2Componenti;
begin

end;

procedure TWR205FDettTabellaFM.CaricaMultiColumnCombobox;
begin

end;

(*
Caratto 28/06/2012
Imposta i campi del dataset con i componenti non data-aware
La logica va inserita nei frame specifici.
richiamato da BeforePostNoStorico  di TWR302FGestTabellaDM
*)
procedure TWR205FDettTabellaFM.Componenti2DataSet;
begin

end;

procedure TWR205FDettTabellaFM.DataSourceControlli(Region:TIWRegion);
var
  i:Integer;
  dedtTmp: TmeIWDBEdit;
  dmemoTmp: TmeIWDBMemo;
begin
  for i:=0 to Region.ControlCount - 1 do
    if (Region.Controls[i] is TmeIWDBEdit) then
    begin
      if (TmeIWDBEdit(Region.Controls[i]).DataSource = nil) then
        TmeIWDBEdit(Region.Controls[i]).DataSource:=WR302DM.dsrTabella;
      //Caratto 24/04/2015 imposto maxlength per i campi di tipo stringa che non hanno un css input_
      //(i css input_xxxxx attivano plugin jquery per la digitazione di numeri e date e in quel caso non va impostata maxlength)
      dedtTmp:=(Region.Controls[i] as TmeIWDBEdit);
      if (dedtTmp.MaxLength = 0) and
         (Pos('input_',dedtTmp.Css) = 0) and
         (dedtTmp.DataSource.DataSet.FieldByName(dedtTmp.DataField) is TStringField) then
        dedtTmp.MaxLength:=dedtTmp.DataSource.DataSet.FieldByName(dedtTmp.DataField).Size;
    end
    else if (Region.Controls[i] is TmeIWDBLabel) and (TmeIWDBLabel(Region.Controls[i]).DataSource = nil) then
      TmeIWDBLabel(Region.Controls[i]).DataSource:=WR302DM.dsrTabella
    else if (Region.Controls[i] is TmeIWDBRadioGroup) and (TmeIWDBRadioGroup(Region.Controls[i]).DataSource = nil) then
      TmeIWDBRadioGroup(Region.Controls[i]).DataSource:=WR302DM.dsrTabella

    else if (Region.Controls[i] is TIWDBRadioGroup) and (TIWDBRadioGroup(Region.Controls[i]).DataSource = nil) then
      TIWDBRadioGroup(Region.Controls[i]).DataSource:=WR302DM.dsrTabella

    else if (Region.Controls[i] is TmeIWDBComboBox) and (TmeIWDBComboBox(Region.Controls[i]).DataSource = nil) then
      TmeIWDBComboBox(Region.Controls[i]).DataSource:=WR302DM.dsrTabella
    else if (Region.Controls[i] is TmeIWDBLookupComboBox) and (TmeIWDBLookupComboBox(Region.Controls[i]).DataSource = nil) then
      TmeIWDBLookupComboBox(Region.Controls[i]).DataSource:=WR302DM.dsrTabella
    else if (Region.Controls[i] is TmeIWDBCheckBox) and (TmeIWDBCheckBox(Region.Controls[i]).DataSource = nil) then
      TmeIWDBCheckBox(Region.Controls[i]).DataSource:=WR302DM.dsrTabella
    else if (Region.Controls[i] is TmeIWDBMemo) and (TmeIWDBMemo(Region.Controls[i]).DataSource = nil) then
    begin
      dmemoTmp:=TmeIWDBMemo(Region.Controls[i]);
      dmemoTmp.DataSource:=WR302DM.dsrTabella;
      if (Pos('maxlength',dmemoTmp.ExtraTagParams.Text.ToLower) = 0) and
         (dmemoTmp.DataSource.DataSet.FieldByName(dmemoTmp.DataField) is TStringField) then
        dmemoTmp.ExtraTagParams.Add(Format('maxlength="%d"',[dmemoTmp.DataSource.DataSet.FieldByName(dmemoTmp.DataField).Size]));
    end

    else if (Region.Controls[i] is TIWRegion) then
      DataSourceControlli(TIWRegion(Region.Controls[i]));
end;

//Caratto 26/11/2011. procedura mai usata. commentata come deprecata
(*
procedure TWR205FDettTabellaFM.RenderHTMLControlli;
var
  i:Integer;

begin
  for i:=0 to  TIWRegion(Controls[0]).ControlCount - 1 do
    if (TIWRegion(Controls[0]).Controls[i] is TmeIWDBEdit) then
      TmeIWDBEdit(TIWRegion(Controls[0]).Controls[i]).RenderHTML(nil)
    else if (TIWRegion(Controls[0]).Controls[i] is TmeIWDBLabel) then
      TmeIWDBLabel(TIWRegion(Controls[0]).Controls[i]).RenderHTML(nil)
   else if (TIWRegion(Controls[0]).Controls[i] is TmeIWDBRadioGroup) then
      TmeIWDBRadioGroup(TIWRegion(Controls[0]).Controls[i]).RenderHTML(nil)
    //else if (TIWRegion(Controls[0]).Controls[i] is TmeIWDBComboBox) then
    //  TmeIWDBComboBox(TIWRegion(Controls[0]).Controls[i]).RenderHTML(nil)
    //else if (TIWRegion(Controls[0]).Controls[i] is TmeIWDBLookupComboBox) then
    //  TmeIWDBLookupComboBox(TIWRegion(Controls[0]).Controls[i]).RenderHTML(nil)
    else if (TIWRegion(Controls[0]).Controls[i] is TmeIWDBCheckBox) then
      TmeIWDBCheckBox(TIWRegion(Controls[0]).Controls[i]).RenderHTML(nil);
end;
*)
end.
