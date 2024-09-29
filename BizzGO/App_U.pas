unit App_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, ComCtrls, StdCtrls, dbmDetails, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompMenu, Menus, ActnMan,
  ActnColorMaps, Buttons, ImgList, DBCtrls, Grids, DBGrids, DB, ADODB, Spin,
  uOOP, Calendar;

type
  TfrmApplication = class(TForm)
    PageControl1: TPageControl;
    TabClients: TTabSheet;
    lblName: TLabel;
    Panel1: TPanel;
    Image7: TImage;
    Image2: TImage;
    Image8: TImage;
    Image3: TImage;
    imgNotes: TImage;
    Image9: TImage;
    TabNotes: TTabSheet;
    Image11: TImage;
    redout: TMemo;
    btnSave: TButton;
    Button2: TButton;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Help1: TMenuItem;
    LogOut1: TMenuItem;
    TabItems: TTabSheet;
    imgBackground: TImage;
    bttAddItems: TBitBtn;
    edtItem: TEdit;
    imgClientBackground: TImage;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    icons32: TImageList;
    Navigate1: TMenuItem;
    First1: TMenuItem;
    Prior1: TMenuItem;
    Next1: TMenuItem;
    Last1: TMenuItem;
    btnDetails: TButton;
    imgDelete: TImage;
    dsItems: TDataSource;
    adoItems: TADOTable;
    DBGrid2: TDBGrid;
    Image1: TImage;
    Delete: TImage;
    sedCents: TSpinEdit;
    Label9: TLabel;
    Label6: TLabel;
    cboOwned: TCheckBox;
    Label3: TLabel;
    redClientDetails: TRichEdit;
    sedQuantity: TSpinEdit;
    sedRands: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    btnShowClientEvents: TButton;
    abs1: TMenuItem;
    Clients1: TMenuItem;
    Items1: TMenuItem;
    Notes1: TMenuItem;
    DBGrid3: TDBGrid;
    tblEvents: TADOTable;
    dsEvents: TDataSource;
    DateAdd: TDateTimePicker;
    sedRI: TSpinEdit;
    sedRE: TSpinEdit;
    Panel2: TPanel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btnUpdate: TButton;
    edtDiscount: TEdit;
    Label8: TLabel;
    tblDiscounts: TADOTable;
    dsDiscount: TDataSource;
    btnAddEvent: TButton;
    btnUnowned: TButton;
    btnOwned: TButton;
    Button1: TButton;
    imgAddClient: TImage;
    procedure imgNotesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LogOut1Click(Sender: TObject);
    /// ///////////////////////////////CUSTOM FUNCTIONS AND PROCEDURES/////////////////////////////
    procedure DeleteFileContent(FileName: String);
    procedure Image9Click(Sender: TObject);
    procedure First1Click(Sender: TObject);
    procedure Last1Click(Sender: TObject);
    procedure Prior1Click(Sender: TObject);
    procedure Next1Click(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
    procedure imgDeleteClick(Sender: TObject);
    procedure bttAddItemsClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAddEventClick(Sender: TObject);
    procedure btnShowClientEventsClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnUnownedClick(Sender: TObject);
    procedure btnOwnedClick(Sender: TObject);
    procedure btnStatsClick(Sender: TObject);
    procedure Items1Click(Sender: TObject);
    procedure Clients1Click(Sender: TObject);
    procedure Notes1Click(Sender: TObject);
    procedure imgAddClientClick(Sender: TObject);

    /// //////////////////////////////////////////////////////////////////////////////////////////
  private
  { Private declarations }
  const
    fieldsSize = 6;

  const
    fields: Array [1 .. fieldsSize] of String = ('CustomerID', 'CustomerName',
      'LastName', 'FirstName', 'Phone', 'Email');
  const
    title: Array [1 .. fieldsSize] of String = ('Customer ID: ',
      'Customer Name: ', 'Last Name: ', 'First Name: ', 'Phone: ', 'Email: ');

  var
    isSaved: Boolean;
  public
    { Public declarations }
  end;

var
  frmApplication: TfrmApplication;
  sCustomerID : String;
  rIncome : real;
  rExpenses : real;
  rProfit : real;

implementation

uses Login_U;
{$R *.dfm}

procedure TfrmApplication.bttAddItemsClick(Sender: TObject);
var
  Price: real;
  check: TValidator;
begin

  check := TValidator.Create;

  if (check.isTEditEmpty(edtItem) = False)  then   //TValidator is declared in OOP
  begin
    Price := 0;
    Price := sedRands.Value + (sedCents.Value / 100); //converts Value into cents

    try
      adoItems.Insert;
      adoItems['ItemName'] := edtItem.Text;
      adoItems['UnitPrice'] := FloatToStrF(Price, ffCurrency, 6, 2);
      adoItems['Quantity'] := sedQuantity.Value;
      adoItems['Owned'] := cboOwned.Checked;
      adoItems.Post;

      adoItems.Refresh;
      showMessage('Item Added');
    except
      showMessage('Item unable to be added - error in action');
    end;
  end
  else
    Dialogs.showMessage('Item not added, Fill in missing fields');
end;

procedure TfrmApplication.btnDetailsClick(Sender: TObject);
var
  iloop : integer;
begin
  redClientDetails.Clear;
  for iloop := 1 to FieldsSize do
    redClientDetails.Lines.Add
      (title[iloop] + dbmDetails.DMLoginDetails.tblClients.FieldByName
        (fields[iloop]).AsString);
 //array "fields" contains the field names of tblClients
 //fieldsSize is a constant storing the amount of fields in tblClients
end;

procedure TfrmApplication.btnShowClientEventsClick(Sender: TObject);
begin
tblEvents.Filtered := false;
tblEvents.Filter:= 'IDCustomer =' + QuotedStr(dmLoginDetails.tblClients['CustomerID']);
tblEvents.Filtered := true;

end;

procedure TfrmApplication.btnUpdateClick(Sender: TObject);
var iDiscount, iCount : integer;
begin
sCustomerID := dmLoginDetails.tblClients['CustomerID'];

With dmLoginDetails do
tblEvents.Filtered := false;
tblEvents.Filter:= 'IDCustomer =' + QuotedStr(dmLoginDetails.tblClients['CustomerID']);
tblEvents.Filtered := true;
{This is done so that only the events which were requested by the customer who has a discount show }

iCount := tblEvents.RecordCount;
showmessage (Inttostr(iCount) + ' Events will be updated. ');
{A friendly message to let the user know how many events will be updated}

 if tblDiscounts.Locate('Code', edtDiscount.text, []) then   //if code is found
 begin
 iDiscount := tblDiscounts['DiscountPercentage'];

while NOT (tblEvents.Eof) do begin
tblEvents.Edit ;
tblEvents['Income'] := FloatToStrF((tblEvents['Income'] - iDiscount/100*tblEvents['Income']), ffCurrency, 6, 2 );
 tblEvents.Post;
tblEvents.Next ;
End;
ShowMessage('Discount applied :)');
 end
 else showMessage('Invalid Discount Code');

tblEvents.Filtered := false;
tblEvents.First ;

end;

procedure TfrmApplication.btnSaveClick(Sender: TObject);
var tf : textfile;
i : integer;
aline : string;
begin
isSaved := True;
AssignFile(tf,'notes.txt');

If FileExists('notes.txt') = false then
Rewrite(tf);

Append(tf);

for i := 1 to redout.Lines.count do
Writeln(tf, redout.Lines[i]); //write everything on redout

Closefile(tf);
end;

procedure TfrmApplication.btnAddEventClick(Sender: TObject);
begin

if self.tblEvents.Active then BEGIN
with dmLoginDetails do
begin
   tblEvents.Insert;
   tblEvents['DateDetails'] := DateAdd.date;
   tblEvents['Income']:= sedRI.Value;
   tblEvents['Expense']:= sedRE.Value;
   tblEvents['IDCustomer'] := tblClients['CustomerID'];
   tblEvents.Post;
   dialogs.ShowMessage('Event Added :)');
end
END else showMessage('');
end;


procedure TfrmApplication.btnUnownedClick(Sender: TObject);
begin
ADOItems.Filtered := false;
ADOItems.Filter:= 'Owned = false';
ADOItems.Filtered := true;
end;

procedure TfrmApplication.btnStatsClick(Sender: TObject);
var sProfit, sIncome, sExpenses : String;
begin
while not tblEvents.eof  do
begin
rIncome := rIncome + tblEvents['Income'];
rExpenses := rExpenses + tblEvents['Expense'];
end;
 sProfit := FloatToStrF(rIncome - rExpenses, ffCurrency, 6,2);
 sIncome := FloatToStrF(rIncome, ffCurrency, 6,2);
 sExpenses := FloatToStrF(rExpenses, ffCurrency, 6,2);
dialogs.ShowMessage('Income: ' + sIncome + 'Expenses: ' + sExpenses + 'Profit: ' + sProfit);
// When this button is clicked, the program may not respond. I will fix the bug in Phase 3
end;

procedure TfrmApplication.Button2Click(Sender: TObject);
begin

if isSaved = False then
begin
if MessageDlg('If you do not save, your notes will be deleted', mtWarning,
    [mbYes, mbCancel], 0) = 6 then
    TabNotes.TabVisible := False;
    TabClients.TabVisible := True;
end
else
end;

procedure TfrmApplication.Clients1Click(Sender: TObject);
begin
 TabClients.TabVisible := True;
 TabItems.TabVisible := False;
 TabNotes.TabVisible := False;
end;

procedure TfrmApplication.btnOwnedClick(Sender: TObject);
begin
ADOItems.Filtered := false;
ADOItems.Filter:= 'Owned = true';
ADOItems.Filtered := true;
end;

procedure TfrmApplication.DeleteClick(Sender: TObject);
var
  ID: integer;
begin
  ID := StrToInt(InputBox('Delete',
      'Enter the ID of the file you want to delete', ''));
      //ID is the unique identifier for the items in ADOItems
  with adoItems do
  begin
    if Locate('ItemID', ID, []) then
    begin
      Delete;
      showMessage('Item Deleted');
    end
    else
      showMessage('Item not found');
  end;
end;

procedure TfrmApplication.DeleteFileContent(FileName: String);
var
  tf: textfile;
begin
  AssignFile(tf, FileName);
  Rewrite(tf);
  CloseFile(tf);
end;

procedure TfrmApplication.First1Click(Sender: TObject);
begin
  dbmDetails.DMLoginDetails.tblClients.First;
  ADOItems.First;
  tblEvents.First;
end;

procedure TfrmApplication.FormActivate(Sender: TObject);
begin
  imgClientBackground.Picture.LoadFromFile('purple.png');
  Dialogs.showMessage('Welcome ' + Login_U.frmMain.sFirst);
  imgDelete.Picture.LoadFromFile('.\icons....sino\Trash.png');
  Delete.Picture.LoadFromFile('.\icons....sino\Trash.png');

  if Login_U.frmMain.sUserType = 'General' then
  begin
    btnUpdate.Enabled := False;
    btnAddEvent.Enabled := False;
    imgDelete.Enabled := False;
    bttAddItems.Enabled := False;
    Delete.Enabled := False;
    imgAddClient.Enabled := False;
    btnSave.Enabled := False;
  end else
   begin
      btnUpdate.Enabled;
    btnAddEvent.Enabled;
    imgDelete.Enabled;
    bttAddItems.Enabled;
    Delete.Enabled;
    imgAddClient.Enabled;
    btnSave.Enabled;
   end;


end;

procedure TfrmApplication.imgNotesClick(Sender: TObject);
var
  tf: textfile;
  aline: string;
begin
  isSaved := False;

  TabClients.TabVisible := False;
  TabNotes.TabVisible := True;
  redout.Clear;

  AssignFile(tf, 'notes.txt');
  Reset(tf);

  while not eof(tf) do
  begin
    Readln(tf, aline);
    redout.Lines.Add(aline);
  end;
  CloseFile(tf);

  DeleteFileContent('Notes.txt');
end;

procedure TfrmApplication.Items1Click(Sender: TObject);
begin
TabItems.TabVisible := True;
TabClients.TabVisible := False;
TabNotes.TabVisible := False;
end;

procedure TfrmApplication.Image9Click(Sender: TObject);
begin

  imgBackground.Picture.LoadFromFile('shelf.jpg');
  TabItems.TabVisible := True;
  TabClients.TabVisible := False;

end;

procedure TfrmApplication.imgAddClientClick(Sender: TObject);
var sName, sFirst, sLast, sEmail, sPhone : String;
begin
 sName := InputBox('Add a Client', 'Enter the Company Name', '');
  sFirst := InputBox('Add a Client', 'Enter the First Name of Client', '');
   sLast := InputBox('Add a Client', 'Enter the Last Name of Client', '');
    sEmail := InputBox('Add a Client', 'Enter the Email of Client', '');
  sPhone := InputBox('Add a Client', 'Enter the cellphone number of client', '');

  if (length(sPhone)<> 10) or (sName = '') or (sFirst = '') or (sLast = '')
  or (Pos('@', sEmail) = 0) //validation of fields before they are entered
  then
   begin
     ShowMessage('Error: Ensure that there are no missing fields, the Email is valid and the cellphone number is valid');
   end
   else
   begin
   with dmLoginDetails do
   begin
     tblClients.insert;
     //array fields contains the field names of tblClients
     tblClients[fields[2]] := sName;
     tblClients[fields[3]] := sFirst;
     tblClients[fields[4]] := sLast;
     tblClients[fields[5]] := sPhone;
     tblClients[fields[6]] := sEmail;
     tblClients.Post;
     ShowMessage('Client Added :)');
     end;
   end;

end;

procedure TfrmApplication.imgDeleteClick(Sender: TObject);
var
  iNum : integer;
begin

 sCustomerID := dmLoginDetails.tblClients['CustomerID'];

tblEvents.Filtered := false;
tblEvents.Filter:= 'IDCustomer =' + QuotedStr(dmLoginDetails.tblClients['CustomerID']);
tblEvents.Filtered := true;

iNum:= tblEvents.RecordCount;
if MessageDlg('Are you sure you want to delete this client together will all ' +
IntToStr(iNum) + ' of their Events?', mtWarning,
    [mbYes, mbNo], 0) = 6  then
begin // when the user wants to delete everything
 tblEvents.First;
while not tblEvents.eof do
begin
tblEvents.Delete;
end;//end of while
//dmLogindetails.tblClients.Delete ;
tblEvents.Filtered:= false;
dmLogindetails.tblClients.Delete ;
showmessage('Client was deleted');
end//end of if
else //when they do not want to delete everything
showmessage('Nothing was deleted.');


end;

procedure TfrmApplication.Last1Click(Sender: TObject);
begin
  dbmDetails.DMLoginDetails.tblClients.Last;
   ADOItems.Last;
  tblEvents.Last;
end;

procedure TfrmApplication.LogOut1Click(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to log out?', mtConfirmation,
    [mbYes, mbCancel], 0) = 6 then
  begin
    frmApplication.Hide;
    frmMain.Show;
  end;
end;

procedure TfrmApplication.Next1Click(Sender: TObject);
begin
  dbmDetails.DMLoginDetails.tblClients.Next;
   ADOItems.Next;
  tblEvents.Next;
end;

procedure TfrmApplication.Notes1Click(Sender: TObject);
begin
TabNotes.TabVisible := True;
TabClients.TabVisible := False;
TabItems.TabVisible := False;
end;

procedure TfrmApplication.Prior1Click(Sender: TObject);
begin
  dbmDetails.DMLoginDetails.tblClients.Prior;
   ADOItems.Prior;
  tblEvents.Prior;
end;

end.
