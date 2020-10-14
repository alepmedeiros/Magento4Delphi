object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form4'
  ClientHeight = 133
  ClientWidth = 164
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 50
    Width = 47
    Height = 13
    Caption = 'Categoria'
  end
  object edtDescricao: TLabeledEdit
    Left = 8
    Top = 24
    Width = 145
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Descri'#231#227'o'
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 66
    Width = 145
    Height = 21
    TabOrder = 1
    OnChange = ComboBox1Change
  end
  object Button1: TButton
    Left = 8
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 2
    OnClick = Button1Click
  end
end
