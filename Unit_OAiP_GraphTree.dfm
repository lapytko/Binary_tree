object Form1: TForm1
  Left = 248
  Top = 223
  BorderStyle = bsSingle
  Caption = 'GraphTree'
  ClientHeight = 338
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 14
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lblSpeedAnim: TLabel
    Left = 187
    Top = 280
    Width = 130
    Height = 17
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1040#1085#1080#1084#1072#1094#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object tbSpeedAnim: TTrackBar
    Left = 187
    Top = 304
    Width = 137
    Height = 33
    Max = 20
    Min = 1
    Position = 10
    TabOrder = 5
    OnChange = tbSpeedAnimChange
  end
  object gbBasicInfo: TGroupBox
    Left = 0
    Top = 234
    Width = 185
    Height = 105
    Caption = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1076#1077#1088#1077#1074#1077':'
    TabOrder = 2
    object lblQuantity: TLabel
      Left = 8
      Top = 24
      Width = 75
      Height = 14
      Caption = #1050#1086#1083'-'#1074#1086' '#1101#1083'. : -'
    end
    object lblMax: TLabel
      Left = 8
      Top = 64
      Width = 64
      Height = 14
      Cursor = crHandPoint
      Caption = #1052#1072#1082#1089' '#1101#1083'. : -'
      OnClick = lblMaxClick
    end
    object lblMin: TLabel
      Left = 8
      Top = 80
      Width = 60
      Height = 14
      Cursor = crHandPoint
      Caption = #1052#1080#1085' '#1101#1083'. : -'
      OnClick = lblMinClick
    end
    object lblDepth: TLabel
      Left = 8
      Top = 40
      Width = 106
      Height = 14
      Cursor = crArrow
      Caption = #1043#1083#1091#1073#1080#1085#1072' '#1076#1077#1088#1077#1074#1072' : -'
    end
  end
  object pgc: TPageControl
    Left = 0
    Top = 0
    Width = 336
    Height = 231
    ActivePage = tsOrder
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Style = tsButtons
    TabOrder = 3
    OnChange = pgcChange
    object tsPush: TTabSheet
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      object lblPush: TLabel
        Left = 6
        Top = 6
        Width = 212
        Height = 17
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
      end
      object edtPush: TEdit
        Left = 6
        Top = 26
        Width = 100
        Height = 30
        Hint = '321'
        HelpType = htKeyword
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        OnKeyPress = edtPushKeyPress
      end
      object btnPushNode: TButton
        Left = 6
        Top = 56
        Width = 100
        Height = 24
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1079#1077#1083
        TabOrder = 1
        OnClick = btnPushNodeClick
      end
      object btnPushTree: TButton
        Left = 6
        Top = 85
        Width = 190
        Height = 24
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1077#1088#1077#1074#1086' '#1080#1079' '#1092#1072#1081#1083#1072
        TabOrder = 2
        OnClick = btnPushTreeClick
      end
    end
    object tsPop: TTabSheet
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 17
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object lblPop: TLabel
        Left = 6
        Top = 6
        Width = 168
        Height = 17
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1089#1087#1086#1089#1086#1073' '#1091#1076#1072#1083#1077#1085#1080#1103
      end
      object lblPopError: TLabel
        Left = 8
        Top = 80
        Width = 4
        Height = 17
      end
      object btnPop: TButton
        Left = 6
        Top = 56
        Width = 100
        Height = 24
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 0
        OnClick = btnPopClick
      end
      object cbbPop: TComboBox
        Left = 6
        Top = 26
        Width = 150
        Height = 25
        Ctl3D = False
        ItemHeight = 17
        ItemIndex = 0
        ParentCtl3D = False
        TabOrder = 1
        Text = #1058#1086#1083#1100#1082#1086' '#1091#1079#1077#1083
        OnChange = cbbPopChange
        Items.Strings = (
          #1058#1086#1083#1100#1082#1086' '#1091#1079#1077#1083
          #1058#1086#1083#1100#1082#1086' '#1087#1086#1076#1076#1077#1088#1077#1074#1100#1103
          #1059#1079#1077#1083' '#1080' '#1055#1086#1076#1076#1077#1088#1077#1074#1100#1103)
      end
    end
    object tsChange: TTabSheet
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 17
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      object lblChange: TLabel
        Left = 6
        Top = 6
        Width = 204
        Height = 34
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103#13#10
      end
      object btnChange: TButton
        Left = 6
        Top = 56
        Width = 100
        Height = 24
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100
        TabOrder = 0
        OnClick = btnChangeClick
      end
      object edtChange: TEdit
        Left = 6
        Top = 26
        Width = 100
        Height = 30
        TabOrder = 1
        OnKeyPress = edtChangeKeyPress
      end
    end
    object tsSearch: TTabSheet
      Caption = #1055#1086#1080#1089#1082
      ImageIndex = 3
      object lblSearch: TLabel
        Left = 6
        Top = 6
        Width = 181
        Height = 17
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072
      end
      object edtSearch: TEdit
        Left = 6
        Top = 26
        Width = 100
        Height = 30
        TabOrder = 0
        OnKeyPress = edtSearchKeyPress
      end
      object btnSearch: TButton
        Left = 6
        Top = 56
        Width = 100
        Height = 24
        Caption = #1053#1072#1081#1090#1080
        TabOrder = 1
        OnClick = btnSearchClick
      end
    end
    object tsOrder: TTabSheet
      Caption = #1054#1073#1093#1086#1076
      ImageIndex = 4
      object lblOrder: TLabel
        Left = 6
        Top = 6
        Width = 154
        Height = 17
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1089#1087#1086#1089#1086#1073' '#1086#1073#1093#1086#1076#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblOrder2: TLabel
        Left = 174
        Top = 6
        Width = 118
        Height = 17
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1086#1073#1093#1086#1076#1072
      end
      object cbbOrder: TComboBox
        Left = 6
        Top = 26
        Width = 117
        Height = 25
        ItemHeight = 17
        TabOrder = 0
        Text = #1055#1088#1103#1084#1086#1081
        Items.Strings = (
          #1055#1088#1103#1084#1086#1081
          #1057#1080#1084#1084#1077#1090#1088#1080#1095#1085#1099#1081
          #1054#1073#1088#1072#1090#1085#1099#1081)
      end
      object btnOrder: TButton
        Left = 6
        Top = 56
        Width = 100
        Height = 24
        Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
        TabOrder = 1
        OnClick = btnOrderClick
      end
      object mmoOrder: TMemo
        Left = 174
        Top = 26
        Width = 146
        Height = 55
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  object rgDoWith: TRadioGroup
    Left = 10
    Top = 165
    Width = 223
    Height = 62
    Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1103':'
    Ctl3D = True
    ItemIndex = 0
    Items.Strings = (
      #1057#1086' '#1074#1089#1077#1084' '#1076#1077#1088#1077#1074#1086#1084
      #1057' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1084' '#1087#1086#1076#1076#1077#1088#1077#1074#1086#1084)
    ParentCtl3D = False
    TabOrder = 1
    OnClick = rgDoWithClick
  end
  object cbGraf: TCheckBox
    Left = 12
    Top = 141
    Width = 225
    Height = 16
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077' '#1075#1088#1072#1092#1080#1095#1077#1089#1082#1080
    Checked = True
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    State = cbChecked
    TabOrder = 0
    OnClick = cbGrafClick
  end
  object btnResetPos: TButton
    Left = 186
    Top = 240
    Width = 137
    Height = 33
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1087#1086#1079#1080#1094#1080#1080
    TabOrder = 4
    OnClick = btnResetPosClick
  end
  object mm: TMainMenu
    Left = 288
    Top = 128
    object mniFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mniOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'..'
        ShortCut = 16453
        OnClick = mniOpenClick
      end
      object mniOpenExample: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1080#1084#1077#1088
        ShortCut = 49221
        OnClick = mniOpenExampleClick
      end
      object mniInRandom: TMenuItem
        Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1089#1083#1091#1095#1072#1081#1085#1086
        ShortCut = 16466
        OnClick = mniInRandomClick
      end
      object mniL01: TMenuItem
        Caption = '-'
      end
      object mniSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100'..'
        ShortCut = 16467
        OnClick = mniSaveClick
      end
      object mniSavePicture: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077'..'
        ShortCut = 49235
        OnClick = mniSavePictureClick
      end
      object mniClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        ShortCut = 16499
        OnClick = mniCloseClick
      end
      object mniL02: TMenuItem
        Caption = '-'
      end
      object mniExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 32883
        OnClick = mniExitClick
      end
    end
    object mniEdit: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object mniUndo: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' (0)'
        Enabled = False
        ShortCut = 16474
        OnClick = mniUndoClick
      end
      object mniRedo: TMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100' (0)'
        Enabled = False
        ShortCut = 16473
        OnClick = mniRedoClick
      end
      object mniL03: TMenuItem
        Caption = '-'
      end
      object mniClearUndo: TMenuItem
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        OnClick = mniClearUndoClick
      end
    end
  end
  object dlgOpen: TOpenDialog
    Filter = #1090#1077#1082#1089#1090#1086#1074#1099#1077'(txt)|*.txt'
    Left = 256
    Top = 160
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'OutPut'
    Filter = #1090#1077#1082#1089#1090#1086#1074#1099#1077'(txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 288
    Top = 160
  end
  object dlgSP: TSavePictureDialog
    DefaultExt = 'jpg'
    FileName = 'OutputGT'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 288
    Top = 192
  end
  object pm: TPopupMenu
    Left = 256
    Top = 128
    object mniNUndo: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Enabled = False
      OnClick = mniUndoClick
    end
    object mniNredo: TMenuItem
      Caption = #1042#1077#1088#1085#1091#1090#1100
      Enabled = False
      OnClick = mniRedoClick
    end
    object mniNL04: TMenuItem
      Caption = '-'
    end
    object mniNPop1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = mniNPop1Click
    end
    object mniNPop2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1087#1086#1076#1076#1077#1088#1077#1074#1100#1103
      OnClick = mniNPop2Click
    end
    object mniNPop3: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1077#1088#1077#1074#1086' '
      OnClick = mniNPop3Click
    end
    object mniNL05: TMenuItem
      Caption = '-'
    end
    object mniNClear: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnClick = mniCloseClick
    end
    object mniNExit: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = mniExitClick
    end
  end
  object XPM: TXPManifest
    Left = 256
    Top = 192
  end
end
