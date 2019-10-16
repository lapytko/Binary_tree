object Form2: TForm2
  Left = 859
  Top = 74
  Width = 698
  Height = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object img1: TImage
    Left = 0
    Top = 0
    Width = 680
    Height = 523
    Align = alClient
    PopupMenu = Form1.pm
    OnMouseDown = img1MouseDown
    OnMouseMove = img1MouseMove
    OnMouseUp = img1MouseUp
  end
  object TmrDrawPointer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TmrDrawPointerTimer
    Left = 40
    Top = 480
  end
  object tmrSetPos: TTimer
    Enabled = False
    Interval = 5
    OnTimer = tmrSetPosTimer
    Left = 136
    Top = 480
  end
end
