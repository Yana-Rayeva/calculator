unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Label1: TLabel;
    procedure Button16Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
	function text1 (i, txt:string):string;
  function text2 (txt:string):string;
  function text3 (txt:string):string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var
txt, i: string;
  first: real;


function TForm1.text1(i, txt: string): string;
begin
txt:= txt + i;
i:= '';
end;

function TForm1.text2(txt: string): string;
begin
Delete(txt,Length(txt),1);
end;

function TForm1.text3(txt: string): string;
begin
ShowMessage(txt);
txt:= '';
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
//
end;

procedure TForm1.Button11Click(Sender: TObject);
var txt, i: string;
begin
txt:= text2(txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button12Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('+', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button13Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('-', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button14Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('*', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button15Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('÷', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button16Click(Sender: TObject);
var txt, i: string;
begin
txt:= text3(txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button10Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('0', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button1Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('1', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button2Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('2', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button3Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('3', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button4Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('4', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button5Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('5', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button6Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('6', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button7Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('7', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button8Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('8', txt);
Label1.Caption:= txt;
end;

procedure TForm1.Button9Click(Sender: TObject);
var txt, i: string;
begin
txt:= text1('9', txt);
Label1.Caption:= txt;
end;

end.
