unit WB007UManipolazioneDatiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, B007UManipolazioneDatiMW,
  A000UMessaggi, A000UInterfaccia;

type
  TWB007FManipolazioneDatiDM = class(TWR300FBaseDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    B007FManipolazioneDatiMW: TB007FManipolazioneDatiMW;
    procedure CancellaDatiDipendente;
    procedure CancellaDati(indice: Integer; DallaData, AllaData: TDateTime; tempoCancellazione: TTempoCancellazione; bTotale: Boolean);
  end;

implementation

{$R *.dfm}

procedure TWB007FManipolazioneDatiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  B007FManipolazioneDatiMW:=TB007FManipolazioneDatiMW.Create(Self);
end;

procedure TWB007FManipolazioneDatiDM.CancellaDatiDipendente;
begin
  with B007FManipolazioneDatiMW do
  begin
    selCols.Close;
    selCols.Open;

    selCols.First;
    while not selCols.Eof do
    begin
      ElaborazioneCancellaTabellaDipendente(selCols.FieldByName('TABELLA').AsString);
      selCols.Next;
    end;
    ElaborazioneCancellatabelleAnagDipendente;
  end;
end;

procedure TWB007FManipolazioneDatiDM.CancellaDati(indice: Integer; DallaData, AllaData: TDateTime; tempoCancellazione: TTempoCancellazione; bTotale: Boolean);
var
  s: String;
begin
  try
    if B007FManipolazioneDatiMW.IsBudgetAnno(indice) then
    begin
      if tempoCancellazione.AnnoOk then
        B007FManipolazioneDatiMW.CancellaBudget(tempoCancellazione.DaMese, tempoCancellazione.AMese, tempoCancellazione.DaAnno, tempoCancellazione.AAnno);
    end
    else if B007FManipolazioneDatiMW.IsSchedaRiepil(indice) then
    begin
      if tempoCancellazione.MeseOk then
      begin
        if bTotale then
        begin
          B007FManipolazioneDatiMW.CancellaSchedaRiepil(tempoCancellazione.DaDataMese, tempoCancellazione.ADataMese);
        end
        else
        begin
          B007FManipolazioneDatiMW.SelAnagrafe.First;
          while not B007FManipolazioneDatiMW.SelAnagrafe.Eof do
          begin
            B007FManipolazioneDatiMW.CancellaSchedaRiepilDipendente(tempoCancellazione.DaDataMese, tempoCancellazione.ADataMese);
            B007FManipolazioneDatiMW.SelAnagrafe.Next;
          end;
        end;
      end;
    end
    else if B007FManipolazioneDatiMW.IsGiustificativi(indice) then
    begin
      if bTotale then
      begin
        B007FManipolazioneDatiMW.CancellaDatiGiustif(DallaData,AllaData);
      end
      else
      begin
        B007FManipolazioneDatiMW.SelAnagrafe.First;
        while not B007FManipolazioneDatiMW.SelAnagrafe.Eof do
        begin
          B007FManipolazioneDatiMW.CancellaDatiGiustifDipendente(DallaData,AllaData);
          B007FManipolazioneDatiMW.SelAnagrafe.Next;
        end;
      end;
    end
    else if TabelleCancella[indice].Peri = 'M' then    //cancellazione per mesi
    begin
      if tempoCancellazione.MeseOk then
      begin
        if bTotale then
        begin
          B007FManipolazioneDatiMW.CancellaMesi(indice,tempoCancellazione);
        end
        else
        begin
          B007FManipolazioneDatiMW.SelAnagrafe.First;
          while not B007FManipolazioneDatiMW.SelAnagrafe.Eof do
          begin
            B007FManipolazioneDatiMW.CancellaMesiDipendente(indice,tempoCancellazione);
            B007FManipolazioneDatiMW.SelAnagrafe.Next;
          end;
        end;
      end;
    end
    else if TabelleCancella[indice].Peri = 'A' then    //cancellazione per anni
    begin
      if tempoCancellazione.AnnoOk then
      begin
        if bTotale then
        begin
          B007FManipolazioneDatiMW.CancellaAnni(indice,tempoCancellazione);
        end
        else
        begin
          B007FManipolazioneDatiMW.SelAnagrafe.First;
          while not B007FManipolazioneDatiMW.SelAnagrafe.Eof do
          begin
            B007FManipolazioneDatiMW.CancellaAnniDipendente(indice,tempoCancellazione);
            B007FManipolazioneDatiMW.SelAnagrafe.Next;
          end;
        end;
      end;
    end
    else if TabelleCancella[indice].Peri = 'G' then    //cancellazione per anni
    begin
      if bTotale then
      begin
        B007FManipolazioneDatiMW.CancellaDate(indice, DallaData, AllaData, tempoCancellazione);
      end
      else
      begin
        B007FManipolazioneDatiMW.SelAnagrafe.First;
        while not B007FManipolazioneDatiMW.SelAnagrafe.Eof do
        begin
          B007FManipolazioneDatiMW.CancellaDateDipendente(indice,DallaData, AllaData,tempoCancellazione);
          B007FManipolazioneDatiMW.SelAnagrafe.Next;
        end;
      end;
    end
    else if TabelleCancella[indice].Peri = 'E' then    //cancellazione per giorni minimo 1 mese
    begin
      if tempoCancellazione.MeseOk then
      begin
        if bTotale then
        begin
          B007FManipolazioneDatiMW.CancellaDate(indice, DallaData, AllaData, tempoCancellazione);
        end
        else
        begin
          B007FManipolazioneDatiMW.SelAnagrafe.First;
          while not B007FManipolazioneDatiMW.SelAnagrafe.Eof do
          begin
            B007FManipolazioneDatiMW.CancellaDateDipendente(indice,DallaData, AllaData,tempoCancellazione);
            B007FManipolazioneDatiMW.SelAnagrafe.Next;
          end;
        end;
      end;
    end
    else if TabelleCancella[indice].Peri = 'D' then    ////Cancellazione Da..A
    begin
      if bTotale then
      begin
        B007FManipolazioneDatiMW.CancellaDaA(indice, DallaData, AllaData);
      end
      else
      begin
        B007FManipolazioneDatiMW.SelAnagrafe.First;
        while not B007FManipolazioneDatiMW.SelAnagrafe.Eof do
        begin
          B007FManipolazioneDatiMW.CancellaDaADipendente(indice,DallaData, AllaData);
          B007FManipolazioneDatiMW.SelAnagrafe.Next;
        end;
      end;
    end;
  except
    on E:Exception do
    begin
      s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,[TabelleCancella[indice].Nome]);
      RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',B007FManipolazioneDatiMW.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
end;

procedure TWB007FManipolazioneDatiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(B007FManipolazioneDatiMW);
  inherited;
end;

end.
