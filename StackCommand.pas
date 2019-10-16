unit StackCommand;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataTypes;

  // ��������� ������������� �����
  procedure createStack(var Work: TStack);
  // ������� �������� �� ������ ����, ���������� �������� True - ���� ���� ������
  function isEmptyStack(Work: TStack): Boolean;
  // ��������� �������� ������ ���� �����
  procedure makeStack(var Work: TStack; x: TItemS);
  // ��������� ���������� ���� � ����
  procedure push(var Work: TStack; x: TItemS);
  // ��������� �������� ���� �� �����
  procedure pop(var Work:TStack; var x: TItemS);
  // ������� ���������� �������� �� ������� ����� ��� ��������� �����
  function topStack(Work: TStack):TItemS;
  // ��������� �������������� �����
  procedure InvertStack(StratStek: TStack; var FinalSteck: TStack);
  // ��������� ������� �����
  procedure ClearStack(var Work: TStack);
implementation

// ��������� ������������� �����
procedure createStack(var Work: TStack);
begin
  Work:=nil;
end;

// ��������� �������� ������ ���� �����
procedure makeStack(var Work: TStack; x: TItemS);
begin
  // �������� ������ ��� ����� ����
  New(Work);
  // ���������� �������� � �������������� ����
  Work^.Data:=x;
  // �������� ������ �� ��������� ����
  Work^.Next:=nil;
end;

// ������� ���������� ������ ���� ���� ������, � ���� � ��������� ������
function isEmptyStack(Work: TStack): boolean;
begin
  Result:=Work=nil;
end;

// ��������� ���������� ���� � ����
procedure push(var Work: TStack; x: TItemS);
var Work2: TStack;
begin
  // ���� ���� ������, ������� ������ �������
  if (isEmptyStack(Work)) then
    begin
      makeStack(Work,x);
    end
  else
    begin
      // ������� ����� ����
      makeStack(Work2,x);
      // � ������ ���� ����������� ���� ����
      Work2^.Next:=Work;
      // ���������� ��������� �� ����� ������ �����
      Work:=Work2;         
    end;
end;

// ��������� �������� ���� �� �����
procedure pop(var Work:TStack; var x: TItemS);
var Work2: TStack;
begin
  if not(isEmptyStack(Work)) then
    begin
      // ���� ���� �� ������
      // ���������� ������ ���� �����
      Work2:=Work;
      // ������ ���� ����� ������ ������
      Work:=Work^.Next;
      // ���������� ������ ���� �� �����
      Work2^.Next:=nil;
      // ���������� ���������� �� ���������� ����
      x:=Work2^.Data;
      // ����������� ������ ���������� ��������� �����
      Dispose(Work2);
    end
  else
    begin
      // ���� ���� ������
      // ������� ��������� �� ���
      Work:=nil;
    end;
end;

// ������� ���������� �������� �� ������� ����� ��� ��������� �����
function topStack(Work: TStack):TItemS;
begin
  Result:=Work^.Data;
end;

// ��������� �������������� �����
procedure InvertStack(StratStek: TStack; var FinalSteck: TStack);
var temp: TItemS;
begin
  // ������� ����� ����
  createStack(FinalSteck);
  // �������� �� ����� ���������� �����
  while not(isEmptyStack(StratStek)) do
    begin
      // ��������� ������� �� ���������� �����
      pop(StratStek,temp);
      // �������� ��������� ������� � ����� ����
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
