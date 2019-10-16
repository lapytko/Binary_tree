unit QueueCommand;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DataTypes;

      // процедура создания очереди
      procedure CreateQueue(var Work: TPointerQueue);
      // процедура создания нового узла
      procedure makeQueue(var Work: TQueue; x: TItemQ);
      // функция возвращает ИСТИНУ если очередь пустая, и ЛОЖЬ в противном случае
      function isEmptyQueue(Work: TPointerQueue): boolean;
      // процедура добовление узла в очередь
      procedure InsertQueue(var Work: TPointerQueue; x: TItemQ);
      // процедура удаления узла из очереди
      procedure DeleteQueue(var Work: TPointerQueue; var x: TItemQ);
      // процедура печати содержимого очереди
      // процедура создающая копию очереди
      procedure CopyQueue(var SourceQueue: TPointerQueue; var DuplicateQueue: TPointerQueue);
      // процедура очистка очереди
      Procedure ClearQueue(var work: TPointerQueue);
      //функция подсчёта кол-ва эл-в в очереди
      function CountElQueue(work: TPointerQueue): byte;
implementation

// процедура создания очереди
procedure CreateQueue(var Work: TPointerQueue);
begin
  // обнуляем ссылку на голову очереди
  Work.Head:=nil;
  // обнуляем ссылку на хвост очереди
  Work.Tail:=nil;
end;

// процедура создания нового узла
procedure makeQueue(var Work: TQueue; x: TItemQ);
begin
  // выделяем память под новый узел
  New(Work);
  // записываем информацию в поле узла
  Work^.Data:=x;
  // обнуляем ссылку
  Work^.Next:=nil;
end;

// функция возвращает ИСТИНУ если очередь пустая, и ЛОЖЬ в противном случае
function isEmptyQueue(Work: TPointerQueue): boolean;
begin
  Result:=Work.Head=nil;
end;

// процедура добовление узла в очередь
procedure InsertQueue(var Work: TPointerQueue; x: TItemQ);
var Work2: TQueue;
begin
  // создаем новый узел
  makeQueue(Work2,x);
  // провераем, пустая ли очередь
  if (isEmptyQueue(Work)) then
    begin
      // если очередь пустая то
      // голову и хвост ссылаем на новый, выше созданный узел
      Work.Head:=Work2;
      Work.Tail:=Work2;
    end
  else
    begin
      // если очередь не пустая то
      // привязываем этот узел к хвосту очереди
      // привязываем новый узел к очереди
      Work.Tail^.Next:=Work2;
      // смещаем указатель на новый хвост очереди
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

// процедура удаления узла из очереди
procedure DeleteQueue(var Work: TPointerQueue; var x: TItemQ);
var Work2: TQueue;
begin
  if not(isEmptyQueue(Work)) then
    begin
     { // если в очереди только 1 элемент
      // очищаем хвост
      if work.head=work.tail then
        work.tail:=nil;   }
      // если очередь не пустая
      // запоминам удаляемый узел
      Work2:=Work.Head;
      // смещаем указатель на новую голову очереди
      Work.Head:=Work.Head^.Next;
      // отвязываем удаляемый узел от очереди
      Work2^.Next:=nil;
      // запоминаем информацию из удоляемого узла
      x:=Work2^.Data;
      // освобождаем память занимаемаю удаляемым узлом
      Dispose(Work2);
    end
  else
    begin
      // если очередь пустая
      // очищаем указатели на голову и хвост
      Work.Head:=nil;
      Work.Tail:=nil;
    end;
end;

//	процедура создающая копию очереди
procedure CopyQueue(var SourceQueue: TPointerQueue; var DuplicateQueue: TPointerQueue);
var TempQueue: TPointerQueue; // временная очередь
    temp: TItemQ;
begin
  // временной очереди присваиваем исходную очередь
  TempQueue:=SourceQueue;
  // инициализируем две очереди в которых будут хранится исходный и копия очереди
  CreateQueue(SourceQueue);
  CreateQueue(DuplicateQueue);
  // проходим по очереди и содержимое помещаем в две очереди
  while not(isEmptyQueue(TempQueue)) do
    begin
      // удаляем узел из очереди
      DeleteQueue(TempQueue,temp);
      // помещаем удаленный элемент в две очереди
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

