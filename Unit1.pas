unit Unit1;

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
    Edit1: TEdit;
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
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var
  txt, second: string;
  first: real;


procedure TForm1.Button11Click(Sender: TObject);
begin

Delete(txt,Length(txt),1);
Edit1.Text:= txt;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin

txt:= txt + '+';
Edit1.Text:= txt;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin

txt:= txt + '-';
Edit1.Text:= txt;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin

txt:= txt + '*';
Edit1.Text:= txt;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin

txt:= txt + '÷';
Edit1.Text:= txt;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
Edit1.Text:= txt;
ShowMessage(txt);
txt:= '';
Edit1.Text:= txt;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin

txt:= txt + '0';
Edit1.Text:= txt;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

txt:= txt + '1';
Edit1.Text:= txt;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

txt:= txt + '2';
Edit1.Text:= txt;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

txt:= txt + '3';
Edit1.Text:= txt;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin

txt:= txt + '4';
Edit1.Text:= txt;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin

txt:= txt + '5';
Edit1.Text:= txt;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin

txt:= txt + '6';
Edit1.Text:= txt;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin

txt:= txt + '7';
Edit1.Text:= txt;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin

txt:= txt + '8';
Edit1.Text:= txt;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin

txt:= txt + '9';
Edit1.Text:= txt;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
Edit1.Text:= txt;
end;

end.
