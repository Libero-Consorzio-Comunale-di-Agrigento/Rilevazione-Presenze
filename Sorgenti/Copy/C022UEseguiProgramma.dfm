object C022FEseguiProgramma: TC022FEseguiProgramma
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 20
  Margins.Right = 4
  Margins.Bottom = 4
  Caption = '<C022> Esegui programma'
  ClientHeight = 371
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spltSplitter: TSplitter
    Left = 0
    Top = 0
    Width = 624
    Height = 2
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    MinSize = 50
    ExplicitTop = 50
    ExplicitWidth = 479
  end
  object pnlContainer: TPanel
    Left = 0
    Top = 52
    Width = 624
    Height = 319
    Align = alClient
    TabOrder = 0
    object pnlGridMain: TGridPanel
      Left = 1
      Top = 1
      Width = 622
      Height = 317
      Align = alClient
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = pnlGridOutput
          Row = 0
        end
        item
          Column = 0
          Control = pnlGridError
          Row = 1
        end>
      RowCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      TabOrder = 0
      object pnlGridOutput: TGridPanel
        Left = 0
        Top = 0
        Width = 622
        Height = 158
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 100.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = pnlOutputLabel
            Row = 0
          end
          item
            Column = 0
            Control = memOutput
            Row = 1
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 20.000000000000000000
          end
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 0
        object pnlOutputLabel: TPanel
          Left = 0
          Top = 0
          Width = 622
          Height = 20
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Output'
          TabOrder = 0
        end
        object memOutput: TMemo
          Left = 0
          Top = 20
          Width = 622
          Height = 138
          Align = alClient
          Color = clBtnFace
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
      object pnlGridError: TGridPanel
        Left = 0
        Top = 158
        Width = 622
        Height = 159
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 100.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = pnlErrorLabel
            Row = 0
          end
          item
            Column = 0
            Control = memError
            Row = 1
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 20.000000000000000000
          end
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 1
        object pnlErrorLabel: TPanel
          Left = 0
          Top = 0
          Width = 622
          Height = 20
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Errori'
          TabOrder = 0
        end
        object memError: TMemo
          Left = 0
          Top = 20
          Width = 622
          Height = 139
          Align = alClient
          Color = clBtnFace
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 2
    Width = 624
    Height = 50
    Align = alTop
    Anchors = []
    TabOrder = 1
    object pnlHeaderLabel: TPanel
      Left = 1
      Top = 1
      Width = 88
      Height = 48
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object lblStato: TLabel
        Left = 1
        Top = 1
        Width = 36
        Height = 13
        Caption = 'lblStato'
      end
    end
    object pnlHeaderCmdLine: TPanel
      Left = 89
      Top = 1
      Width = 534
      Height = 48
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 1
      Padding.Top = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 1
      object lblInEsecuzione: TLabel
        Left = 1
        Top = 1
        Width = 532
        Height = 46
        Align = alClient
        Caption = 'lblInEsecuzione'
        WordWrap = True
        ExplicitWidth = 73
        ExplicitHeight = 13
      end
    end
  end
  object tmrStart: TTimer
    OnTimer = tmrStartTimer
    Left = 1
    Top = 1
  end
end
