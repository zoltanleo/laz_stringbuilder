unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType,
  LazUTF8;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnAppend: TButton;
    btnAppendLine: TButton;
    btnAppendFormat: TButton;
    btnCopyTo: TButton;
    Memon: TMemo;
    procedure btnAppendClick(Sender: TObject);
    procedure btnAppendLineClick(Sender: TObject);
    procedure btnAppendFormatClick(Sender: TObject);
    procedure btnCopyToClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    FSL: TStringList;
    FSB: TStringBuilder;
  public

  end;

const
{$IFDEF MSWINDOWS}
fn = 'd:\Archive\my_repo\stringbuilder\example_list.txt';
{$ELSE}
  {$IFDEF LINUX}
  fn = '/home/leyba/laz_proj/stringbuilder/example_list.txt';
  {$ELSE}
  fn = '/Users/admin/laz_project/stringbuilder/example_list.txt';
  {$ENDIF}
{$ENDIF}

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  FSB:= TStringBuilder.Create;
  FSL:= TStringList.Create;
  if FileExists(fn) then FSL.LoadFromFile(fn);
  Memon.ScrollBars:= ssAutoBoth;
  Memon.WordWrap:= False;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FreeAndNil(FSL);
  FreeAndNil(FSB);
end;

procedure TForm1.btnAppendClick(Sender: TObject);
var
  i: Integer;
begin
  FSB.Clear;

  for i:= 0 to Pred(FSL.Count) do
    FSB.Append(Trim(FSL.Strings[i]) + '~');

  Memon.Clear;
  Memon.Text:= FSB.ToString;
end;

procedure TForm1.btnAppendLineClick(Sender: TObject);
var
  i: Integer;
begin
  FSB.Clear;

  for i:= 0 to Pred(FSL.Count) do
    FSB.Append(Trim(FSL.Strings[i]) + '~').AppendLine('*');

  Memon.Clear;
  Memon.Text:= FSB.ToString;
end;

procedure TForm1.btnAppendFormatClick(Sender: TObject);
var
  i: Integer;
begin
  FSB.Clear;

  for i:= 0 to Pred(FSL.Count) do
    FSB.AppendFormat('%d. %s(%s)%s ', [
                      i + 1,
                      '*',
                      Trim(FSL.Strings[i]),
                      '~'
                      ]);

  Memon.Clear;
  Memon.Text:= FSB.ToString;
end;

procedure TForm1.btnCopyToClick(Sender: TObject);
const
  ss = 'qrtwyeженксыф';
var
  ch_arr: array of AnsiChar;
  i: Integer;
begin
  FSB.Clear;
  SetLength(ch_arr,Length(ss));

  for i:= 0 to Pred(Length(ss)) do
    ch_arr[i]:= PAnsiChar(ss)[i];

    FSB.Append(FSL.CommaText);

  Memon.Clear;

  //for CounterVar := 0 to Pred(Count) do

  FSB.CopyTo(10,ch_arr,2,15);
end;

end.

