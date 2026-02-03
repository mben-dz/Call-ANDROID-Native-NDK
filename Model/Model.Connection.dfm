object dmConnection: TdmConnection
  OnCreate = DataModuleCreate
  Height = 172
  Width = 206
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    LoginPrompt = False
    Left = 60
    Top = 18
  end
end
