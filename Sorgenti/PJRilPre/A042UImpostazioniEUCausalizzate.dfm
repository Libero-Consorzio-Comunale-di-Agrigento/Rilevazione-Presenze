object A042FImpostazioniEUCausalizzate: TA042FImpostazioniEUCausalizzate
  Left = 222
  Top = 178
  HelpContext = 42000
  BorderIcons = [biSystemMenu]
  Caption = '<A042> Impostazione causali di presenza'
  ClientHeight = 111
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 305
    Height = 80
    Align = alTop
    Caption = 'Causali di presenza '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 311
    object Label2: TLabel
      Left = 9
      Top = 27
      Width = 41
      Height = 13
      Caption = 'Causale:'
    end
    object DbLblDescPresenza: TDBText
      Left = 63
      Top = 48
      Width = 254
      Height = 12
      DataField = 'DESCRIZIONE'
    end
    object DbCmbPresenza: TDBLookupComboBox
      Left = 64
      Top = 24
      Width = 101
      Height = 21
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE; DESCRIZIONE'
      TabOrder = 0
      OnKeyDown = DbCmbPresenzaKeyDown
    end
  end
  object BtnClose: TBitBtn
    Left = 126
    Top = 85
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 1
  end
end
