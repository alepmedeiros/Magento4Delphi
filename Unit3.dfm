object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 133
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 47
    Width = 47
    Height = 13
    Caption = 'Categoria'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 24
    Width = 201
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Descri'#231#227'o'
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 64
    Width = 201
    Height = 21
    TabOrder = 1
    Text = 'ComboBox1'
  end
  object Button1: TButton
    Left = 134
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 2
  end
end
