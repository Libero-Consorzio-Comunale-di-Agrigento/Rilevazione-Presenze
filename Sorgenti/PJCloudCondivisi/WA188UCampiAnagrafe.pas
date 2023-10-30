unit WA188UCampiAnagrafe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, System.Actions,
  IWCompEdit, meIWEdit;

type
  TWA188FCampiAnagrafe = class(TWR102FGestTabella)
    btnValoriDefault: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnValoriDefaultClick(Sender: TObject);
    procedure actModificaExecute(Sender: TObject); override;
    procedure actAnnullaExecute(Sender: TObject); override;
    procedure actConfermaExecute(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA188UCampiAnagrafeDM, WA188UCampiAnagrafeBrowseFM;

{$R *.dfm}

procedure TWA188FCampiAnagrafe.actModificaExecute(Sender: TObject);
begin
  (WR302DM as TWA188FCampiAnagrafeDM).EseguiAfterOpen:=False;
  inherited;
end;

procedure TWA188FCampiAnagrafe.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA188FCampiAnagrafeDM).EseguiAfterOpen:=True;
end;

procedure TWA188FCampiAnagrafe.actConfermaExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA188FCampiAnagrafeDM).EseguiAfterOpen:=True;
end;

procedure TWA188FCampiAnagrafe.btnValoriDefaultClick(Sender: TObject);
begin
  try
    (WR302DM as TWA188FCampiAnagrafeDM).A188MW.AssegnaValoriDefault;
  finally
    WBrowseFM.grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA188FCampiAnagrafe.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA188FCampiAnagrafeDM.Create(Self);
  WBrowseFM:=TWA188FCampiAnagrafeBrowseFM.Create(Self);
end;

end.
