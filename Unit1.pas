unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, mySQLDbTables, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    MySQLQuery1: TMySQLQuery;
    MySQLDatabase1: TMySQLDatabase;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Edit2: TEdit;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    Edit3: TEdit;
    Image1: TImage;
    Button3: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button4: TButton;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

    function FillGrid(Sender: TObject; strSQL : String) : Boolean;
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
      nRow:Integer;
      nCol:Integer;
      blDrop:Boolean;

implementation

{$R *.dfm}

function TForm1.FillGrid(Sender: TObject; strSQL : String) : Boolean;
begin
  MySQLQuery1.Active:=false;
  MySQLQuery1.SQL.Clear;
  MySQLQuery1.SQL.Add(strSQL);
  MySQLQuery1.Active:=true;

  StringGrid1.Cells[0,0]:='#';
  StringGrid1.Cells[1,0]:='text';
  StringGrid1.Cells[2,0]:='description';
  StringGrid1.Cells[3,0]:='keywords';

  nRow:=1;
  repeat
    StringGrid1.RowCount:=nRow+1;
    StringGrid1.ColCount:=MySQLQuery1.FieldCount;

    nCol:=0;
    while nCol< MySQLQuery1.FieldCount do
    begin
      StringGrid1.Cells[nCol,nRow]:=MySQLQuery1.Fields[nCol].AsString;
      nCol:=nCol+1;
    end;

    MySQLQuery1.Next;
    nRow:=nRow+1;
  until MySQLQuery1.EOF;
  FillGrid := true;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  Label1.Caption := RadioButton1.Caption;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  Label1.Caption := RadioButton2.Caption;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  Label1.Caption := RadioButton3.Caption;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  strSQL : String;
begin
  strSQL := Edit1.Text;
  FillGrid(Sender, strSQL);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  MySQLQuery1.SQL.Clear;
  MySQLQuery1.SQL.Add('DELETE FROM '+Edit3.Text+' WHERE '+Label1.Caption+Edit2.Text);
  MySQLQuery1.ExecSQL;
  Button4.Click;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  MySQLQuery1.SQL.Clear;
  MySQLQuery1.SQL.Add('INSERT INTO myarttable SET text="'+Edit4.Text+'", description="'+Edit5.Text+'", keywords="'+Edit6.Text+'"');
  MySQLQuery1.ExecSQL;
  Button4.Click;
end;

// Refresh
procedure TForm1.Button4Click(Sender: TObject);
var
  strSQL : String;
begin
  mySQLDatabase1.Connected := false;
  mySQLDatabase1.DatabaseName := 'test';
  mySQLDatabase1.Connected := true;

  strSQL := 'SELECT * FROM myarttable ORDER by id DESC; ';
  FillGrid(Sender, strSQL);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Memo1.Text := 'DROP TABLE IF EXISTS files;DROP TABLE IF EXISTS myarttable;DROP DATABASE IF EXISTS test;';
  blDrop:=true;
end;

// Run down
procedure TForm1.Button6Click(Sender: TObject);
var
  I: Integer;
begin
  MySQLQuery1.SQL.Clear;
  MySQLQuery1.SQL.Add(Memo1.Text);
  MySQLQuery1.ExecSQL;

  if blDrop then
  begin
    for I := 0 to StringGrid1.ColCount - 1 do
      StringGrid1.Cols[I].Clear;
    StringGrid1.RowCount := 1;
  end else begin
    Button4.Click;
  end;
  blDrop := false;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  mySQLDatabase1.Connected := false;
  mySQLDatabase1.DatabaseName := '';
  mySQLDatabase1.Connected := true;

  Memo1.Text := 'CREATE DATABASE IF NOT EXISTS test;USE test;';
  Memo1.Text := Memo1.Text+'CREATE TABLE IF NOT EXISTS myArtTable (id int(11) NOT NULL auto_increment, text text NOT NULL, description text NOT NULL, keywords text NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=cp1251;';
  Memo1.Text := Memo1.Text+'CREATE TABLE IF NOT EXISTS files (id_file int(11) NOT NULL auto_increment, id_my int(11) NOT NULL, description text NOT NULL, name_origin text NOT NULL, path text NOT NULL, date_upload text NOT NULL,';
  Memo1.Text := Memo1.Text+' PRIMARY KEY (id_file), FOREIGN KEY (id_my) REFERENCES myarttable(id)) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=cp1251;';
  Memo1.Text := Memo1.Text+'INSERT INTO myarttable (text, description, keywords) values ("at1", "at2", "at3");';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Memo1.Text := 'UPDATE myarttable SET keywords = "Ivanov" WHERE id = 18;';
end;

end.
