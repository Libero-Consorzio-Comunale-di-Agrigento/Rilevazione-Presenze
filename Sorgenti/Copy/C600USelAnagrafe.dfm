object C600frmSelAnagrafe: TC600frmSelAnagrafe
  Left = 0
  Top = 0
  Width = 451
  Height = 24
  TabOrder = 0
  TabStop = True
  object pnlSelAnagrafe: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 24
    Align = alClient
    BevelOuter = bvLowered
    ParentShowHint = False
    PopupMenu = pmnuDatiAnagrafici
    ShowHint = True
    TabOrder = 0
    object btnPrimo: TSpeedButton
      Left = 91
      Top = 1
      Width = 23
      Height = 22
      Hint = 'Primo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00FFFF
        00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00FFFF
        00FFFF00FFFF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF0042FF0042FF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00FFFF
        0042FF0042FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF0042FF0042FF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00FFFF
        00FFFF00FFFF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00FFFF
        00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnBrowseClick
    end
    object btnPrecedente: TSpeedButton
      Left = 114
      Top = 1
      Width = 23
      Height = 22
      Hint = 'Precedente'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        0042FF0042FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnBrowseClick
    end
    object btnSuccessivo: TSpeedButton
      Left = 137
      Top = 1
      Width = 23
      Height = 22
      Hint = 'Successivo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF
        0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnBrowseClick
    end
    object btnUltimo: TSpeedButton
      Left = 160
      Top = 1
      Width = 23
      Height = 22
      Hint = 'Ultimo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF
        00FFFF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF
        00FFFF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF0042FF0042FF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF
        0042FF0042FF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF0042FF0042FF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF
        00FFFF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF00FFFF00FFFF
        00FFFF00FFFF00FFFF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnBrowseClick
    end
    object lblDipendente: TLabel
      Left = 189
      Top = 4
      Width = 91
      Height = 14
      Caption = 'lblDipendente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      PopupMenu = pmnuDatiAnagrafici
      ShowHint = True
    end
    object btnSelezione: TBitBtn
      Left = 1
      Top = 1
      Width = 23
      Height = 22
      Hint = 'Selezione anagrafiche'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3303333333333333300033333333333300033333333333300033333333333300
        0333333800083B8033333308888800B33333308F7F7F8033333388F7FCF7F883
        3333087F7C7F7803333308FCCCCCF8033333087F7C7F7803333388F7FCF7F883
        3333308F7F7F8033333333088888033333333338000833333333}
      TabOrder = 0
      OnClick = btnSelezioneClick
    end
    object btnRicerca: TBitBtn
      Left = 61
      Top = 1
      Width = 23
      Height = 22
      Hint = 'Ricerca'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042
        FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF00
        42FF0042FF0042FF00FFFF0042FFFFFFFF0042FF0042FF0042FF00FFFF00FFFF
        00FFFF00FFFF00FFFF0042FFFFFFFF0042FF0042FF0042FF00FFFF0042FFFFFF
        FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF0042FFFFFFFF00
        42FF0042FF0042FF00FFFF0042FF0042FF0042FF0042FF0042FF0042FF0042FF
        00FFFF0042FF0042FF0042FF0042FF0042FF0042FF0042FF00FFFF0042FF0042
        FFFFFFFF0042FF0042FF0042FF0042FF0042FF0042FFFFFFFF0042FF0042FF00
        42FF0042FF0042FF00FFFF0042FF0042FFFFFFFF0042FF0042FF0042FFFFFFFF
        0042FF0042FFFFFFFF0042FF0042FF0042FF0042FF0042FF00FFFF0042FF0042
        FFFFFFFF0042FF0042FF0042FFFFFFFF0042FF0042FFFFFFFF0042FF0042FF00
        42FF0042FF0042FF00FFFF00FFFF0042FF0042FF0042FF0042FF0042FF0042FF
        0042FF0042FF0042FF0042FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FF
        FF0042FFFFFFFF0042FF0042FF0042FF00FFFF0042FFFFFFFF0042FF0042FF00
        42FF00FFFF00FFFF00FFFF00FFFF00FFFF0042FF0042FF0042FF0042FF0042FF
        00FFFF0042FF0042FF0042FF0042FF0042FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF0042FF0042FF0042FF00FFFF00FFFF00FFFF0042FF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0042FFFFFFFF0042FF00FFFF
        00FFFF00FFFF0042FFFFFFFF0042FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF0042FF0042FF0042FF00FFFF00FFFF00FFFF0042FF0042FF0042FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnRicercaClick
    end
    object btnEreditaSelezione: TBitBtn
      Left = 24
      Top = 1
      Width = 23
      Height = 22
      Hint = 'Eredita selezione principale'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFCFFFFFFFFFFFFFFCCFFFFFFFFFFFFFCCCCCCFFFFFFFFFFFCCFFF
        CFFFFFFFFFFFCFFFCFFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFCFFFFFFFCFFFFFFF
        FFFFFFFFCFFFFFFFFFFFFFFFCFFFCFFFFFFFFFFFCFFFCCFFFFFFFFFFFCCCCCCF
        FFFFFFFFFFFFCCFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 2
      OnClick = btnEreditaSelezioneClick
    end
  end
  object pmnuDatiAnagrafici: TPopupMenu
    Left = 208
    Top = 65534
    object Ereditaselezioneprecedente1: TMenuItem
      Caption = 'Eredita selezione precedente'
    end
    object R003Datianagrafici: TMenuItem
      Caption = 'Dati anagrafici'
      OnClick = R003DatianagraficiClick
    end
  end
end
