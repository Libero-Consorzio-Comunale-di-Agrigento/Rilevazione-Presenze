unit WC023UCambioPasswordFM;

interface

uses
  Winapi.Windows, Winapi.Messages, StrUtils, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompCheckbox, meIWCheckBox,
  IWCompButton, meIWButton, IWCompLabel, meIWLabel, IWVCLBaseControl, IWApplication,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, meIWEdit, IWHTMLControls,
  Oracle, A000UInterfaccia, C180FunzioniGenerali, A000UMessaggi;

type
  TWC023FCambioPasswordFM = class(TWR200FBaseFM)
    edtPwdAttuale: TmeIWEdit;
    edtNuovaPwd: TmeIWEdit;
    edtConfermaPwd: TmeIWEdit;
    edtEMailAziendale: TmeIWEdit;
    lblPwdAttuale: TmeIWLabel;
    lblNuovaPwd: TmeIWLabel;
    lblConfermaPwd: TmeIWLabel;
    lblEMailAziendale: TmeIWLabel;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    chkRicMail: TmeIWCheckBox;
    lblRicMail: TmeIWLabel;
    lblEMailPEC: TmeIWLabel;
    edtEMailPEC: TmeIWEdit;
    lblCellulareAziendale: TmeIWLabel;
    edtCellulareAziendale: TmeIWEdit;
    lblCellularePersonale: TmeIWLabel;
    edtCellularePersonale: TmeIWEdit;
    lblEMailPersonale: TmeIWLabel;
    edtEMailPersonale: TmeIWEdit;
    procedure btnConfermaClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    VecchiaEMailAziendale, VecchioCellulareAziendale: String;
    VecchiaEMailPersonale, VecchiaEMailPEC, VecchioCellularePersonale: String;
    VecchiaRicezioneMail: Boolean;
    procedure visibilitaCampi;
  public
    procedure Visualizza;
  end;

implementation

uses WR010UBase;

{$R *.dfm}

procedure TWC023FCambioPasswordFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;

  visibilitaCampi;

  if WR000DM.TipoUtente = 'Dipendente' then
  begin
    with TOracleQuery.Create(GGetWebApplicationThreadVar) do
      try
        Session:=SessioneOracle;
        //Lettura vecchia E-Mail
        SQL.Add('SELECT EMAIL, EMAIL_PEC, EMAIL_PERSONALE, CELLULARE, CELLULARE_PERSONALE FROM MONDOEDP.I060_LOGIN_DIPENDENTE ');
        SQL.Add('WHERE NOME_UTENTE = ''' + Parametri.Operatore + '''');
        SQL.Add('AND AZIENDA = ''' + Parametri.Azienda + '''');
        Execute;
        VecchiaEMailAziendale:=FieldAsString('EMAIL');
        VecchioCellulareAziendale:=FieldAsString('CELLULARE');
        VecchiaEMailPEC:=FieldAsString('EMAIL_PEC');
        VecchiaEMailPersonale:=FieldAsString('EMAIL_PERSONALE');
        VecchioCellularePersonale:=FieldAsString('CELLULARE_PERSONALE');
        edtEMailAziendale.Text:=VecchiaEMailAziendale;
        edtCellulareAziendale.Text:=VecchioCellulareAziendale;
        if edtCellulareAziendale.Text = '' then
          edtCellulareAziendale.Text:='3';
        edtEMailPEC.Text:=VecchiaEMailPEC;
        edtEMailPersonale.Text:=VecchiaEMailPersonale;
        edtCellularePersonale.Text:=VecchioCellularePersonale;
        //Lettura vecchio stato ricezione E-Mail
        VecchiaRicezioneMail:=False;
        SQL.Clear;
        SQL.Add('SELECT I061.RICEZIONE_MAIL');
        SQL.Add('  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061');
        SQL.Add(' WHERE I061.AZIENDA = ''' + Parametri.Azienda + '''');
        SQL.Add('   AND I061.NOME_UTENTE = ''' + Parametri.Operatore + '''');
        SQL.Add('   AND I061.NOME_PROFILO = ''' + Parametri.ProfiloWEB + '''');
        Execute;
        if RowCount > 0 then
          VecchiaRicezioneMail:=FieldAsString ('RICEZIONE_MAIL') = 'S';
        chkRicMail.Checked:=VecchiaRicezioneMail;
      finally
        Free;
      end;
  end
  else
  begin
    lblEMailAziendale.Visible:=False;
    edtEMailAziendale.Visible:=False;
    lblRicMail.Visible:=False;
    chkRicMail.Visible:=False;
    lblCellulareAziendale.Visible:=False;
    edtCellulareAziendale.Visible:=False;
    lblEMailPEC.Visible:=False;
    edtEMailPEC.Visible:=False;
    lblEMailPersonale.Visible:=False;
    edtEMailPersonale.Visible:=False;
    lblCellularePersonale.Visible:=False;
    edtCellularePersonale.Visible:=False;
  end;

  //Il cambio password è possibile solo se non si sta usando l'autenticazione su dominio
  if Parametri.AuthDom then
  begin
    edtPwdAttuale.Visible:=False;
    edtNuovaPwd.Visible:=False;
    edtConfermaPwd.Visible:=False;
    lblPwdAttuale.Visible:=False;
    lblNuovaPwd.Visible:=False;
    lblConfermaPwd.Visible:=False;
  end;
end;

procedure TWC023FCambioPasswordFM.Visualizza;
var width, height:Integer;
begin
  width:=410;
  height:=220;
  if Parametri.CampiRiferimento.C90_Contatti_Aziendali <> 'N' then
    height:=height + 40;
  if Parametri.CampiRiferimento.C90_Contatti_Personali <> 'N' then
  begin
    height:=height + 60;
  end;
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,width,height,height, 'Gestione credenziali','#wc023_container',False,True);
end;

procedure TWC023FCambioPasswordFM.btnConfermaClick(Sender: TObject);
var
  NuovaPwd, NuovaEMailAziendale, NuovoCellulareAziendale, NuovaEMailPEC, NuovaEMailPersonale, NuovoCellularePersonale, Err: Boolean;
  S,Dominio,ErrMsg: String;
  LunghMinCell:Integer;
begin
  if (Sender = btnConferma) then
  begin
    S:='';
    NuovaPwd:=False;
    NuovaEMailAziendale:=False;
    NuovaEMailPEC:=False;
    NuovoCellulareAziendale:=False;
    Err:=True;
    Dominio:=IfThen(WR000DM.TipoUtente = 'Dipendente',Parametri.AuthDomInfo.DominioDip,Parametri.AuthDomInfo.DominioUsr);
    LunghMinCell:=StrToIntDef(Parametri.CampiRiferimento.C90_CellulareLunghMin,10);
    //Il cambio password è possibile solo se non si sta usando l'autenticazione su dominio
    if (not Parametri.AuthDom) and (edtNuovaPwd.Text <> edtPwdAttuale.Text) then
    begin
      NuovaPwd:=True;
      //Parametri.RegolePassword.PasswordI060:=False;
      if (Dominio = '') or (Length(edtNuovaPwd.Text) > 0) then
        S:=Parametri.RegolePassword.PasswordValida(edtNuovaPwd.Text);

      if edtPwdAttuale.Text <> Parametri.PassOper then
        ErrMsg:='La password attuale indicata è errata!'
      else if edtNuovaPwd.Text <> edtConfermaPwd.Text then
        ErrMsg:='La nuova password non è stata confermata correttamente!'
      else if S <> '' then
        ErrMsg:=S
      (*
      // controllo lunghezza password solo se dominio di autenticazione non specificato
      //else if Length(edtNuovaPwd.Text) < Parametri.LunghezzaPassword then
      else if (Length(edtNuovaPwd.Text) < Parametri.LunghezzaPassword) and
              ((Dominio = '') or (Length(edtNuovaPwd.Text) > 0)) then
        ErrMsg:=Format('La password deve essere di almeno %d caratteri!',[Parametri.LunghezzaPassword])
      // controllo caratteri password per crittografia su db - daniloc. 25.01.2011
      else if not R180CtrlCripta(edtNuovaPwd.Text) then
        ErrMsg:='La nuova password contiene caratteri non ammessi!'
      *)
      else
      begin
        Err:=False;
        if WR000DM.TipoUtente = 'Dipendente' then
          S:='PASSWORD = ''' + AggiungiApice(R180Cripta(edtNuovaPwd.Text, 30011945)) + ''', DATA_PW = TRUNC(SYSDATE)';
      end;

      // messaggio di errore
      if Err then
      begin
        edtNuovaPwd.Clear;
        edtConfermaPwd.Clear;
        //ActiveControl:=edtNuovaPwd;
        MsgBox.MessageBox(ErrMsg,ESCLAMA);
        Exit;
      end;
    end;
    if WR000DM.TipoUtente = 'Dipendente' then
    begin
      if edtEMailAziendale.Text <> VecchiaEMailAziendale then
      begin
        NuovaEMailAziendale:=True;
        if (Length(edtEMailAziendale.Text) > 0) and ((Pos('@', edtEMailAziendale.Text) = 0) or (Pos('.', edtEMailAziendale.Text) = 0)) then
          GGetWebApplicationThreadVar.ShowMessage('Indirizzo e-mail non valido.')
        else
        begin
          Err:=False;
          S:=IfThen(Length(S) > 0, S + ', ', '') + 'EMAIL = ''' + edtEMailAziendale.Text + '''';
        end;
      end;
      if edtEMailPEC.Text <> VecchiaEMailPEC then
      begin
        NuovaEMailPEC:=True;
        if (Length(edtEMailPEC.Text) > 0) and ((Pos('@', edtEMailPEC.Text) = 0) or (Pos('.', edtEMailPEC.Text) = 0)) then
          GGetWebApplicationThreadVar.ShowMessage('Indirizzo e-mail PEC non valido.')
        else
        begin
          Err:=False;
          S:=IfThen(Length(S) > 0, S + ', ', '') + 'EMAIL_PEC = ''' + edtEMailPEC.Text + '''';
        end;
      end;
      if edtEMailPersonale.Text <> VecchiaEMailPersonale then
      begin
        NuovaEMailPersonale:=True;
        if (Length(edtEMailPersonale.Text) > 0) and ((Pos('@', edtEMailPersonale.Text) = 0) or (Pos('.', edtEMailPersonale.Text) = 0)) then
          GGetWebApplicationThreadVar.ShowMessage('Indirizzo e-mail personale non valido.')
        else
        begin
          Err:=False;
          S:=IfThen(Length(S) > 0, S + ', ', '') + 'EMAIL_PERSONALE = ''' + edtEMailPersonale.Text + '''';
        end;
      end;
      if (edtCellulareAziendale.Text <> VecchioCellulareAziendale) and (edtCellulareAziendale.Text <> '3') then
      begin
        NuovoCellulareAziendale:=True;
        edtCellulareAziendale.Text:=Trim(edtCellulareAziendale.Text);
        if (Length(edtCellulareAziendale.Text) > 0) and ((Copy(edtCellulareAziendale.Text,1,1) <> '3') or (Length(edtCellulareAziendale.Text) < LunghMinCell) or not R180TestoInSetCaratteri(edtCellulareAziendale.Text,'0123456789')) then
        begin
          if Copy(edtCellulareAziendale.Text,1,1) <> '3' then
            ErrMsg:=A000MSG_A186_ERR_INIZ_CELLULARE
          else if Length(edtCellulareAziendale.Text) < LunghMinCell then
            ErrMsg:=Format(A000MSG_A186_ERR_FMT_LUNG_CELLULARE,[LunghMinCell])
          else if not R180TestoInSetCaratteri(edtCellulareAziendale.Text,'0123456789') then
            ErrMsg:=A000MSG_A186_ERR_NON_NUMERICO;
          GGetWebApplicationThreadVar.ShowMessage(ErrMsg);
        end
        else
        begin
          Err:=False;
          S:=IfThen(Length(S) > 0, S + ', ', '') + 'CELLULARE = ''' + edtCellulareAziendale.Text + '''';
        end;
      end;
      if (edtCellularePersonale.Text <> VecchioCellularePersonale) and (edtCellularePersonale.Text <> '3') then
      begin
        NuovoCellularePersonale:=True;
        edtCellularePersonale.Text:=Trim(edtCellularePersonale.Text);
        if (Length(edtCellularePersonale.Text) > 0) and ((Copy(edtCellularePersonale.Text,1,1) <> '3') or (Length(edtCellularePersonale.Text) < LunghMinCell) or not R180TestoInSetCaratteri(edtCellularePersonale.Text,'0123456789')) then
        begin
          if Copy(edtCellularePersonale.Text,1,1) <> '3' then
            ErrMsg:=A000MSG_A186_ERR_INIZ_CELLULARE
          else if Length(edtCellularePersonale.Text) < LunghMinCell then
            ErrMsg:=Format(A000MSG_A186_ERR_FMT_LUNG_CELLULARE,[LunghMinCell])
          else if not R180TestoInSetCaratteri(edtCellularePersonale.Text,'0123456789') then
            ErrMsg:=A000MSG_A186_ERR_NON_NUMERICO;
          GGetWebApplicationThreadVar.ShowMessage(ErrMsg);
        end
        else
        begin
          Err:=False;
          S:=IfThen(Length(S) > 0, S + ', ', '') + 'CELLULARE_PERSONALE = ''' + edtCellularePersonale.Text + '''';
        end;
      end;
    end;
    //Aggiornamento PASSWORD e/o EMAIL
    if (chkRicMail.Checked <> VecchiaRicezioneMail) and (WR000DM.TipoUtente = 'Dipendente') then
    begin
      with TOracleQuery.Create(GGetWebApplicationThreadVar) do
        try
          Session:=SessioneOracle;
          SQL.Add('UPDATE MONDOEDP.I061_PROFILI_DIPENDENTE I061');
          SQL.Add('   SET I061.RICEZIONE_MAIL = ''' + ifThen(chkRicMail.Checked,'S','N') + '''');
          SQL.Add(' WHERE I061.AZIENDA = ''' + Parametri.Azienda + '''');
          SQL.Add('   AND I061.NOME_UTENTE = ''' + Parametri.Operatore + '''');
          SQL.Add('   AND I061.NOME_PROFILO = ''' + Parametri.ProfiloWEB + '''');
          Execute;
          SessioneOracle.Commit;
        finally
          Free;
        end;
    end;
    //Aggiornamento RICEZIONE_MAIL
    if NuovaEMailAziendale or NuovaPwd or NuovoCellulareAziendale or NuovaEMailPEC or NuovaEmailPersonale or NuovoCellularePersonale then
    begin
      if not Err then
        with TOracleQuery.Create(GGetWebApplicationThreadVar) do
        begin
          try
            Session:=SessioneOracle;
            if WR000DM.TipoUtente = 'Dipendente' then
            begin
              SQL.Add('UPDATE MONDOEDP.I060_LOGIN_DIPENDENTE SET ' + S);
              SQL.Add('WHERE NOME_UTENTE = ''' + Parametri.Operatore + '''');
              SQL.Add('AND AZIENDA = ''' + Parametri.Azienda + '''');
            end
            else
            begin
              SQL.Add('UPDATE MONDOEDP.I070_UTENTI SET PASSWD = ''' + R180CriptaI070(edtNuovaPwd.Text) + '''');
              if NuovaPwd then
                SQL.Add(',DATA_PW = TRUNC(SYSDATE), NUOVA_PASSWORD = ''N''');
              SQL.Add('WHERE PROGRESSIVO = ' + IntToStr(Parametri.ProgOper));
            end;
            Execute;
            SessioneOracle.Commit;
            if RowsProcessed <> 0 then
              Parametri.PassOper:=edtNuovaPwd.Text;
          finally
            Free;
          end;
        end;
    end;
    if NuovaEMailAziendale or NuovaPwd or (chkRicMail.Checked <> VecchiaRicezioneMail) or NuovoCellulareAziendale or NuovaEMailPEC or NuovoCellularePersonale or NuovaEmailPersonale then
    begin
      //ClosePage;
      if NuovaPwd then
        GGetWebApplicationThreadVar.ShowMessage('La password è stata modificata correttamente!');
    end
    else
      GGetWebApplicationThreadVar.ShowMessage('Non sono stati modificati né l''indirizzo e-mail né il numero cellulare (sia personale che aziendale) né la password!');
  end;
  Free;
end;

procedure TWC023FCambioPasswordFM.visibilitaCampi;
begin

  (* ..Contatti_Aziendali.. *)

  // S= accesso completo
  if Parametri.CampiRiferimento.C90_Contatti_Aziendali = 'S' then
  begin
    lblEmailAziendale.Visible:=True;
    edtEmailAziendale.Visible:=True;
    lblCellulareAziendale.Visible:=True;
    edtCellulareAziendale.Visible:=True;
  end
  // R = accesso in sola lettura (edit non modificabile)
  else if Parametri.CampiRiferimento.C90_Contatti_Aziendali = 'R'  then
  begin
    lblEmailAziendale.Visible:=True;
    edtEmailAziendale.Visible:=True;
    edtEmailAziendale.Editable:=False;
    edtEmailAziendale.Css:=edtEmailAziendale.Css + ' readonly_like_disabled';
    lblCellulareAziendale.Visible:=True;
    edtCellulareAziendale.Visible:=True;
    edtCellulareAziendale.Editable:=False;
    edtCellulareAziendale.Css:=edtCellulareAziendale.Css + ' readonly_like_disabled';
  end
  // N = dato non visibile
  else
  begin
    lblEmailAziendale.Visible:=False;
    edtEmailAziendale.Visible:=False;
    lblCellulareAziendale.Visible:=False;
    edtCellulareAziendale.Visible:=False;
  end;

  (* ..Contatti_Personali.. *)

  // S= accesso completo
  if Parametri.CampiRiferimento.C90_Contatti_Personali = 'S' then
  begin
    lblEmailPersonale.Visible:=True;
    edtEmailPersonale.Visible:=True;
    lblEmailPEC.Visible:=True;
    edtEmailPEC.Visible:=True;
    lblCellularePersonale.Visible:=True;
    edtCellularePersonale.Visible:=True;
  end
  // R = accesso in sola lettura (edit non modificabile)
  else if Parametri.CampiRiferimento.C90_Contatti_Personali = 'R'  then
  begin
    lblEmailPersonale.Visible:=True;
    edtEmailPersonale.Visible:=True;
    edtEmailPersonale.Editable:=False;
    edtEmailPersonale.Css:=edtEmailPersonale.Css + ' readonly_like_disabled';
    lblEmailPEC.Visible:=True;
    edtEmailPEC.Visible:=True;
    edtEmailPEC.Editable:=False;
    edtEmailPEC.Css:=edtEmailPEC.Css + ' readonly_like_disabled';
    lblCellularePersonale.Visible:=True;
    edtCellularePersonale.Visible:=True;
    edtCellularePersonale.Editable:=False;
    edtCellularePersonale.Css:=edtCellularePersonale.Css + ' readonly_like_disabled';
  end
  // N = dato non visibile
  else
  begin
    lblEmailPersonale.Visible:=False;
    edtEmailPersonale.Visible:=False;
    lblEmailPEC.Visible:=False;
    edtEmailPEC.Visible:=False;
    lblCellularePersonale.Visible:=False;
    edtCellularePersonale.Visible:=False;
  end;
end;

end.
