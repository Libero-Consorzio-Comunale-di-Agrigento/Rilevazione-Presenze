object A058FDettaglioTipiOperatori: TA058FDettaglioTipiOperatori
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = '<A058> Dettaglio limiti minimi e massimi al dd/mm/yyyy'
  ClientHeight = 168
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 372
    Height = 168
    Align = alClient
    DataSource = A058FPianifTurniDtM1.dsrT606a
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_TIPOOPE'
        Title.Caption = 'Operatore'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_GIORNO'
        Title.Caption = 'Tipo giorno'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA_TURNO'
        Title.Caption = 'Sigla turno'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MINIMO'
        Title.Caption = 'Minimo'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MASSIMO'
        Title.Caption = 'Massimo'
        Width = 45
        Visible = True
      end>
  end
end
