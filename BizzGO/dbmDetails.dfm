object DMLoginDetails: TDMLoginDetails
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 255
  Width = 427
  object conDBM: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=mydat' +
      'a.mdb;Mode=ReadWrite;Persist Security Info=False;Jet OLEDB:Syste' +
      'm database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Pass' +
      'word="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=' +
      '1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Tran' +
      'sactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create S' +
      'ystem Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:' +
      'Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Without Rep' +
      'lica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 48
    Top = 56
  end
  object table: TADOTable
    Active = True
    Connection = conDBM
    CursorType = ctStatic
    TableDirect = True
    TableName = 'tblLogin'
    Left = 48
    Top = 104
  end
  object dsLoginDetails: TDataSource
    DataSet = table
    Left = 48
    Top = 160
  end
  object conClients: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=data.mdb;Persist Se' +
      'curity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 328
    Top = 56
  end
  object tblClients: TADOTable
    Active = True
    Connection = conClients
    CursorType = ctStatic
    TableDirect = True
    TableName = 'Customers'
    Left = 304
    Top = 112
  end
  object dsClients: TDataSource
    DataSet = tblClients
    Left = 328
    Top = 168
  end
  object tblEvent: TADOTable
    Connection = conDBM
    CursorType = ctStatic
    TableDirect = True
    TableName = 'Event'
    Left = 224
    Top = 112
  end
end
