unit StackCommand;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataTypes;

  // процедура инициализации стека
  procedure createStack(var Work: TStack);
  // функция проверки на пустой стек, возвращает занчение True - если стек пустой
  function isEmptyStack(Work: TStack): Boolean;
  // процедура создания нового узла стека
  procedure makeStack(var Work: TStack; x: TItemS);
  // процедура добовления узла в стек
  procedure push(var Work: TStack; x: TItemS);
  // процедура удаления узла из стека
  procedure pop(var Work:TStack; var x: TItemS);
  // функция фозвращает значение из вершины стека без изменения стека
  function topStack(Work: TStack):TItemS;
  // процедура перевертывания стека
  procedure InvertStack(StratStek: TStack; var FinalSteck: TStack);
  // процедура очистки стека
  procedure ClearStack(var Work: TStack);
implementation

// процедура инициализации стека
procedure createStack(var Work: TStack);
begin
  Work:=nil;
end;

// процедура создания нового узла стека
procedure makeStack(var Work: TStack; x: TItemS);
begin
  // выделяем память под новый узел
  New(Work);
  // записываем значение в информационное поле
  Work^.Data:=x;
  // обнуляем ссылку на следующий узел
  Work^.Next:=nil;
end;

// функция возвращает ИСТИНУ если стек пустой, и ЛОЖЬ в противном случае
function isEmptyStack(Work: TStack): boolean;
begin
  Result:=Work=nil;
end;

// процедура добовления узла в стек
procedure push(var Work: TStack; x: TItemS);
var Work2: TStack;
begin
  // если стек пустой, создаем первый элемент
  if (isEmptyStack(Work)) then
    begin
      makeStack(Work,x);
    end
  else
    begin
      // создаем новый узел
      makeStack(Work2,x);
      // к новому узлу подвязываем весь стек
      Work2^.Next:=Work;
      // возвращаем указатель на новае начало стека
      Work:=Work2;         
    end;
end;

// процедура удаления узла из стека
procedure pop(var Work:TStack; var x: TItemS);
var Work2: TStack;
begin
  if not(isEmptyStack(Work)) then
    begin
      // если стек не пустой
      // запоминаем первый узел стека
      Work2:=Work;
      // втарой узел стека делаем первым
      Work:=Work^.Next;
      // отвязываем первый узел от стека
      Work2^.Next:=nil;
      // запоминаем информацию из удоляемого узла
      x:=Work2^.Data;
      // освобождаем память занимаемую удоляемым узлом
      Dispose(Work2);
    end
  else
    begin
      // если стек пустой
      // очищаем указатели на его
      Work:=nil;
    end;
end;

// функция фозвращает значение из вершины стека без изменения стека
function topStack(Work: TStack):TItemS;
begin
  Result:=Work^.Data;
end;

// процедура перевертывания стека
procedure InvertStack(StratStek: TStack; var FinalSteck: TStack);
var temp: TItemS;
begin
  // создаем новый стек
  createStack(FinalSteck);
  // проходим по всему начальному стеку
  while not(isEmptyStack(StratStek)) do
    begin
      // извлекаем элемент из начального стека
      pop(StratStek,temp);
      // помещаем извленный элемент в новый стек
      push(FinalSteck,temp);
    end;
end;

procedure ClearStack(var Work: TStack);
var temp: TItemS;
begin
  while Work<>nil do
    pop(Work,temp);
end;

end.
