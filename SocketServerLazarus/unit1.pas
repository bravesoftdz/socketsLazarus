unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  IdTCPServer, IdCustomTCPServer, IdContext , IdGlobal , IdSync;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    IdTCPServer1: TIdTCPServer;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdTCPServer1Connect(AContext: TIdContext);
    procedure IdTCPServer1Disconnect(AContext: TIdContext);
    procedure IdTCPServer1Execute(AContext: TIdContext);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  libera : integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.IdTCPServer1Execute(AContext: TIdContext);
var
  LLine: String;
  recebe : TFileStream;
  testa : TextFile;
  x : integer;
  memo : Tmemo;
begin
  //TIdNotify.NotifyMethod( ShowStartServerdMessage );
  //LLine := AContext.Connection.IOHandler.ReadLn(TIdEncoding.enDefault);
  memo1.Clear;
  memo := Tmemo.Create(nil);
  recebe := TFileStream.Create('/home/douglas/teste2.txt' , fmCreate);
  //Memo1.Lines.Add(LLine);
  AContext.Connection.IoHandler.LargeStream := true;
  AContext.Connection.IOHandler.ReadStream(recebe , -1 , false);

  recebe.Position:=0;

  memo1.Lines.LoadFromStream(recebe);

  recebe.Position:=0;

  memo.Lines.LoadFromStream(recebe);
  recebe.free;

  x := 0;

  AssignFile(testa , '/home/douglas/teste3.txt');

  Rewrite(testa);

  while x < memo1.Lines.Count do
  begin
    LLine := Memo.Lines[x];
    writeln(testa , LLine);
    //Memo1.Lines.Add(LLine);
    inc(x);
  end;


  closefile(testa);
  Memo1.Lines.Add('OK');
  AContext.Connection.IOHandler.WriteLn('OK');



  //TIdNotify.NotifyMethod( StopStartServerdMessage );
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  {IdTCPServer1.Bindings.Add.Port:=40001;
  IdTCPServer1.Bindings.Add.IP:='10.0.164.170'; }

  IdTCPServer1.Active:=true;

  Label1.Caption:='ATIVADO';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if(libera = 0) then
  begin
       IdTCPServer1.Active:=false;
       Label1.Caption:='DESATIVADO';
  end
  else
  begin
    ShowMessage('EXISTEM ' + IntToStr(libera) + ' CONEXÕES ABERTAS COM O SERVIDOR');
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  valor : Boolean;
begin
  valor := true;
  if(libera <> 0) then
  begin
    if(MessageDlg('Existem ' + IntToStr(libera) + ' CONEXÕES EXISTENTES COM O SERVIDOR. '
      + 'DESEJA MESMO ENCERRAR A APLICAÇÃO?', mtConfirmation,[mbYes, mbNo], 0) = mrNo) then
    begin
       valor := false;
       ShowMessage('OPERAÇÃO CANCELADA');
    end;
  end;

  if(valor = true)then
  begin
    IdTCPServer1.FreeInstance;
    Application.Terminate;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  libera := 0;
end;

procedure TForm1.IdTCPServer1Connect(AContext: TIdContext);
begin
    libera := libera + 1;
    Memo1.Lines.Add('CONECTOU');
end;

procedure TForm1.IdTCPServer1Disconnect(AContext: TIdContext);
begin
   libera := libera - 1;
   Memo1.Lines.Add('DESCONECTOU');
end;

end.

