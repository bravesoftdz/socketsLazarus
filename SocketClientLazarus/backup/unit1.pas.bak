unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  IdTCPClient, IdGlobal;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    IdTCPClient1: TIdTCPClient;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  libera: boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if(IdTCPClient1.Connected = false) then
  begin
    try
      IdTCPClient1.Connect;
      libera := True;
      Label1.Caption := 'ATIVADO';
    except
      Label1.Caption := 'ERRO NA CONEXÃO';
    end;
  end;
  end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  try
    IdTCPClient1.Disconnect;

    libera := False;
    Label1.Caption := 'DESATIVADO';
  except
    libera := False;
    Label1.Caption := 'DESATIVADO';
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  LLine: string;
  teste : TFileStream;
begin
  if (IdTCPClient1.Connected = True) then
  begin
    try
      teste := TFileStream.Create('/home/douglas/teste.txt' , fmOpenRead);

      IdTCPClient1.IOHandler.LargeStream := True;

      IdTCPClient1.IOHandler.Write(teste, 0 , True);
      //IdTCPClient1.IOHandler.WriteLn(Edit1.Text, TIdEncoding.enUTF8);
      //IdTCPClient1.IOHandler.WriteLn('teste1', TIdEncoding.enUTF8);
      //IdTCPClient1.IOHandler.WriteLn('teste2', TIdEncoding.enUTF8);
      Edit1.Text := '';
      LLine := IdTCPClient1.IOHandler.ReadLn();
      if (LLine = 'OK') then
      begin
        Memo1.Lines.Add('Server says it has received your String');
      end;
      teste.Free;
    except
      ShowMessage('ERRO DE CONEXÃO COM O SERVIDOR');
    end;
  end
  else
  begin
    ShowMessage('CONECTAR COM O SERVIDOR');
  end;
end;

end.

