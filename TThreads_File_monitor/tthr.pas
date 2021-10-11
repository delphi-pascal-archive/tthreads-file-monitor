unit tthr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin, SyncObjs, FileCtrl, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, OleCtrls, SHDocVw,
  MSHTML, ActiveX, ShellApi, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Button2: TButton;
    SpinEdit1: TSpinEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    Button7: TButton;
    Label1: TLabel;
    Button8: TButton;
    ListBox1: TListBox;
    Button9: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    procedure UpdateList;
    { Private declarations }
  public
    { Public declarations }
  end;

type
  MyTread = class(TThread)
  private
    procedure Update;
  protected
    s: string;
    n: integer;
    procedure UpdateMemo;
    procedure UpdateGauge;
    procedure Execute; override;
  end;

  TProc_1 = class(TThread)
  protected
    procedure Execute; override;
  end;

  TProc_2 = class(TThread)
  protected
    s: string;
    procedure AddStr;
    procedure Execute; override;
  end;

  TProc_3 = class(TThread)
  protected
    procedure Execute; override;
  end;

  File_Mon = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  Event: TEvent;
  Proc_1: TProc_1;
  Proc_2: TProc_2;
  FM: File_Mon;
  TMyTrDemo_1, TMyTrDemo_2: TProc_2;
  Proc_3: TProc_3;
  CS: TCriticalSection;
  mas: array of integer;
  TMyTrDemo: MyTread;

implementation

{$R *.dfm}

procedure MyTread.Execute;
var
 j,k: integer;
begin
 repeat
  S:='';
  Synchronize(UpdateMemo);
  for k:=0 to 99 do
   begin
    N:=k;
    S:=' ';
    for j:=1 to 20 do
     S:=S+FormatFloat('00', k);
    Synchronize(UpdateMemo);
    Synchronize(UpdateGauge);
    Synchronize(Update);
   end;
 until false;
end;

procedure MyTread.UpdateMemo;
begin
 with Form1.Memo1.Lines do
  if S=' '
  then Clear
  else Add(S);
end;

procedure MyTread.UpdateGauge;
begin
 Form1.ProgressBar1.Position:=n;
end;

procedure MyTread.Update;
begin
 Form1.Caption:=s;
end;

procedure TProc_2.Execute;
begin
 Synchronize(AddStr); // Вызов метода с синхронизацией
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 // Создать поток: 'спать' - true, немедленно начать работу - false
 TMyTrDemo:=MyTread.Create(true);
 // Потом указываем, что после завершения кода потока
 // он сразу завершится, т.е. не надо заботиться о его закрытии.
 // В противном случае, необходимо самим вызывать функцию Terminate
 TMyTrDemo.FreeOnTerminate:=true;
 // Устанавливаем приоритет в одно из возможных значений:
 // tpIdle - Работает, когда система простаивает
 // tpLowest - Нижайший
 // tpLower - Низкий
 // tpNormal - Нормальный
 // tpHigher - Высокий
 // tpHighest - Высочайший
 // tpTimeCritical - Критический
 TMyTrDemo.Priority:=tpNormal;
 //
 CS:=TCriticalSection.Create;
 //
 Event:=TEvent.Create(nil, true, true, '');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 TMyTrDemo.FreeOnTerminate:=true;
 TMyTrDemo.Priority:=tpIdle;
 TMyTrDemo.Resume;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if Tag=0
 then
  begin
   SpinEdit1.Text:=FloatToStr(sqr(StrToFloat(SpinEdit1.Text)));
   if StrToFloat(SpinEdit1.Text)>1
   then
    begin
     Tag:=1;
     Button2.Caption:='Корень';
    end;
  end
 else
  begin
   SpinEdit1.Text:=FloatToStr(sqrt(StrToFloat(SpinEdit1.Text)));
   if StrToFloat(SpinEdit1.Text)<2
   then
    begin
     SpinEdit1.Value:=2;
     Tag:=0;
     Button2.Caption:='Квадрат';
    end;
  end;
end;

procedure TProc_2.AddStr;
begin
 CS.Enter;
 //
 Form1.Memo1.Lines.Add(s);
 Sleep(20);
 Form1.Memo1.Lines.Add(s);
 Sleep(20);
 Form1.Memo1.Lines.Add(s);
 Sleep(20);
 Form1.Memo1.Lines.Add(s);
 Sleep(20);
 Form1.Memo1.Lines.Add(s);
 Sleep(5);
 //
 CS.Leave;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 //
 TMyTrDemo_1:=TProc_2.Create(true);
 TMyTrDemo_1.FreeOnTerminate:=true;
 TMyTrDemo_1.s:='1 Thread';
 TMyTrDemo_1.Priority:=tpIdle;
 //
 TMyTrDemo_2:=TProc_2.Create(true);
 TMyTrDemo_2.FreeOnTerminate:=true;
 TMyTrDemo_2.s:='2 Thread';
 TMyTrDemo_2.Priority:=tpTimeCritical;
 //
 TMyTrDemo_1.Resume;
 TMyTrDemo_2.Resume;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 TMyTrDemo.Suspend;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 CS.Free;
 Event.Free;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 // Устанавливаем событие
 // wait-функция будет фозвращать управление сразу
 Event.SetEvent;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 // wait-функция блокирует выполнение кода потока
 Event.ResetEvent;
end;

procedure TProc_3.Execute;
begin
 while true do
  begin
   // wait-функция
   Event.WaitFor(INFINITE);
   Form1.Label1.Caption:='Proccessing...';
   sleep(2000);
   // Подготовка данных
   //...
   // разрешаем работать другому потоку
   Event.SetEvent;
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 // Создаем событие до того как будем его использовать
 Event:=TEvent.Create(nil,false,true,'');
 // Запускаем потоки
 Proc_3:=TProc_3.Create(true);
 Proc_3.FreeOnTerminate:=true;
 Proc_3.Priority:=tpTimeCritical;
 Proc_3.Resume;
 TMyTrDemo.Resume;
end;

procedure TProc_1.Execute;
var
 n: integer;
begin
 n:=0;
 while true do
  begin
   // wait-функция
   Event.WaitFor(INFINITE);
   if n>99
   then n:=0;
   // Одновременно приращиваем
   Form1.ProgressBar1.Position:=n;
   Form1.ProgressBar2.Position:=n;
   Form1.ProgressBar3.Position:=n;
   // задержка для видимости
   Sleep(10);
   inc(n);
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 Proc_1:=TProc_1.Create(true);
 Proc_1.FreeOnTerminate:=true;
 Proc_1.Priority:=tpIdle;
 Proc_1.Resume;
end;

var
 DirName: string;

procedure File_Mon.Execute;
var
 r: Cardinal;
 fn: THandle;
begin
 fn:=FindFirstChangeNotification(pChar(DirName), true,
 FILE_NOTIFY_CHANGE_FILE_NAME);
 repeat
  r:=WaitForSingleObject(fn,2000);
  if r=WAIT_OBJECT_0
  then Synchronize(Form1.UpdateList);
  if not FindNextChangeNotification(fn)
  then Break;
 until Terminated;
 FindCloseChangeNotification(fn);
end;

procedure TForm1.Button9Click(Sender: TObject);
var
 dir: string;
begin
 if SelectDirectory(dir,[],0)
 then
  begin
   Edit1.Text:=dir;
   DirName:=dir;
   //
   FM:=File_Mon.Create(true);
   FM.FreeOnTerminate:=true;
   FM.Priority:=tpIdle;
   FM.Resume;
  end;
end;

procedure TForm1.UpdateList;
var
 SearchRec: TSearchRec;
begin
 ListBox1.Clear;
 FindFirst(Edit1.Text+'\*.*', faAnyFile, SearchRec);
 repeat
  ListBox1.Items.Add(SearchRec.Name);
 until FindNext(SearchRec)<>0;
 FindClose(SearchRec);
end;

end.
