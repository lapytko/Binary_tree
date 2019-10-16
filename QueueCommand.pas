unit QueueCommand;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DataTypes;

      // ��������� �������� �������
      procedure CreateQueue(var Work: TPointerQueue);
      // ��������� �������� ������ ����
      procedure makeQueue(var Work: TQueue; x: TItemQ);
      // ������� ���������� ������ ���� ������� ������, � ���� � ��������� ������
      function isEmptyQueue(Work: TPointerQueue): boolean;
      // ��������� ���������� ���� � �������
      procedure InsertQueue(var Work: TPointerQueue; x: TItemQ);
      // ��������� �������� ���� �� �������
      procedure DeleteQueue(var Work: TPointerQueue; var x: TItemQ);
      // ��������� ������ ����������� �������
      // ��������� ��������� ����� �������
      procedure CopyQueue(var SourceQueue: TPointerQueue; var DuplicateQueue: TPointerQueue);
      // ��������� ������� �������
      Procedure ClearQueue(var work: TPointerQueue);
      //������� �������� ���-�� ��-� � �������
      function CountElQueue(work: TPointerQueue): byte;
implementation

// ��������� �������� �������
procedure CreateQueue(var Work: TPointerQueue);
begin
  // �������� ������ �� ������ �������
  Work.Head:=nil;
  // �������� ������ �� ����� �������
  Work.Tail:=nil;
end;

// ��������� �������� ������ ����
procedure makeQueue(var Work: TQueue; x: TItemQ);
begin
  // �������� ������ ��� ����� ����
  New(Work);
  // ���������� ���������� � ���� ����
  Work^.Data:=x;
  // �������� ������
  Work^.Next:=nil;
end;

// ������� ���������� ������ ���� ������� ������, � ���� � ��������� ������
function isEmptyQueue(Work: TPointerQueue): boolean;
begin
  Result:=Work.Head=nil;
end;

// ��������� ���������� ���� � �������
procedure InsertQueue(var Work: TPointerQueue; x: TItemQ);
var Work2: TQueue;
begin
  // ������� ����� ����
  makeQueue(Work2,x);
  // ���������, ������ �� �������
  if (isEmptyQueue(Work)) then
    begin
      // ���� ������� ������ ��
      // ������ � ����� ������� �� �����, ���� ��������� ����
      Work.Head:=Work2;
      Work.Tail:=Work2;
    end
  else
    begin
      // ���� ������� �� ������ ��
      // ����������� ���� ���� � ������ �������
      // ����������� ����� ���� � �������
      Work.Tail^.Next:=Work2;
      // ������� ��������� �� ����� ����� �������
      Work.Tail:=Work2;
    end;
end;


{procedure InsertQueueAscending(var Work: TPointerQueue; x: TItemQ);
var TempWork, workPred: TQueue;
begin
  empWork:=Work.head;
  while (x<>nil) do
    begin
      workPred:=tempWork;
      if StrToInt(x^.Edit.Text)>StrToInt(TempWork.data^.edit.text) then
        TempWork:=TempWork^.Next
      else
        begin
          if TempWork= work.Head then
            TempWork^.Next:=work;
            work:=TempWork;
        end;
    end; 


end;   }

// ��������� �������� ���� �� �������
procedure DeleteQueue(var Work: TPointerQueue; var x: TItemQ);
var Work2: TQueue;
begin
  if not(isEmptyQueue(Work)) then
    begin
     { // ���� � ������� ������ 1 �������
      // ������� �����
      if work.head=work.tail then
        work.tail:=nil;   }
      // ���� ������� �� ������
      // ��������� ��������� ����
      Work2:=Work.Head;
      // ������� ��������� �� ����� ������ �������
      Work.Head:=Work.Head^.Next;
      // ���������� ��������� ���� �� �������
      Work2^.Next:=nil;
      // ���������� ���������� �� ���������� ����
      x:=Work2^.Data;
      // ����������� ������ ���������� ��������� �����
      Dispose(Work2);
    end
  else
    begin
      // ���� ������� ������
      // ������� ��������� �� ������ � �����
      Work.Head:=nil;
      Work.Tail:=nil;
    end;
end;

//	��������� ��������� ����� �������
procedure CopyQueue(var SourceQueue: TPointerQueue; var DuplicateQueue: TPointerQueue);
var TempQueue: TPointerQueue; // ��������� �������
    temp: TItemQ;
begin
  // ��������� ������� ����������� �������� �������
  TempQueue:=SourceQueue;
  // �������������� ��� ������� � ������� ����� �������� �������� � ����� �������
  CreateQueue(SourceQueue);
  CreateQueue(DuplicateQueue);
  // �������� �� ������� � ���������� �������� � ��� �������
  while not(isEmptyQueue(TempQueue)) do
    begin
      // ������� ���� �� �������
      DeleteQueue(TempQueue,temp);
      // �������� ��������� ������� � ��� �������
      InsertQueue(SourceQueue,temp);
      InsertQueue(DuplicateQueue, temp);
    end;
end;

Procedure ClearQueue(var work: TPointerQueue);
var temp:TItemQ;
begin
  while not(isEmptyQueue(work)) do
    DeleteQueue(work,temp);
end;

function CountElQueue(work: TPointerQueue): byte;
var tempNode: TQueue;
begin
  result:=0;
  tempNode:=work.Head;
  while tempNode<>nil do
    begin
      inc(result);
      tempNode:=tempNode^.Next;
    end;
end;

end.

