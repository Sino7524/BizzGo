unit dbmDetails;

interface

uses
  SysUtils, Dialogs,Classes, DB, ADODB;

type
  TDMLoginDetails = class(TDataModule)
    conDBM: TADOConnection;
    table: TADOTable;
    dsLoginDetails: TDataSource;
    conClients: TADOConnection;
    tblClients: TADOTable;
    dsClients: TDataSource;
    tblEvent: TADOTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //conDBM: TADOConnection; // Connet to Database
    tblDBM: TADOTable; // Connect to table in Database
    dscDMB: TDataSource;
  end;

var
  DMLoginDetails: TDMLoginDetails;

implementation

{$R *.dfm}

procedure TDMLoginDetails.DataModuleCreate(Sender: TObject);
var
  tf: Textfile;
  connStr: String;
begin
  try
    connStr := '' + 'Provider=Microsoft.ACE.OLEDB.12.0;' + 'Data Source=' +
      ExtractFilePath(ParamStr(0)) + 'dBLoginDetails.accdb;';

    if FileExists('connect.txt') then
    begin
      AssignFile(tf, 'connect.txt');
      Reset(tf);
      Readln(tf, connStr);
      CloseFile(tf);
    end;

    conDBM.Connected := False;
    table.Active := False;

    conDBM.ConnectionString := connStr;
    conDBM.LoginPrompt := False;
    conDBM.Connected := True;

    table.Active := True;
  except
    showMessage('Error: Unable to connect to database');
  end;

end;

end.
