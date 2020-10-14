object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Form5'
  ClientHeight = 316
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 48
    Width = 668
    Height = 260
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object edtAttributeCode: TLabeledEdit
    Left = 8
    Top = 21
    Width = 185
    Height = 21
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Attribute Code'
    TabOrder = 1
  end
  object edtValue: TLabeledEdit
    Left = 199
    Top = 21
    Width = 185
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'Value'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 390
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object DataSource1: TDataSource
    Left = 376
    Top = 168
  end
end
