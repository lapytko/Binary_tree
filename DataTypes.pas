unit DataTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

Type

//Графическое дерево
     TItemGT= String;
     TGTree= ^TNodeGT;

     TSENPos=record
       Start, Ending, Now: real;
     end;
     TNodeGT=record
       Edit: TEdit;
       Rect: TRect;
       Next: Array of TGTree;
       Parent: TGTree;
       Pos:record
         left,Top:TSENPos
       end
     end;

     TMassCount= Array of integer;

//Стек
  TItemS = record
    value: String; // тип информационное поле  //Элемент Стека - строка, в которой значения узлов дерева
  end;

  TStack =^ TNodeS; // ссылка на узел
  TNodeS = record
    Data: TItemS;  // информационное поле
    Next: TStack;  // ссылка на следующий узел
  end;

//Очередь
  TItemQ = TGTree;  // тип информационного поля


  TQueue =^TNodeQ;  // ссылка на узел
  // описание узла
  TNodeQ = record
    Data: TItemQ;  // информационное поле      //Элемент очереди - Граф Дерево
    Next: TQueue;  // ссылка на следующий узел
  end;

  // ссылка на очередь
  TPointerQueue = record
    Head: TQueue;  // указатель на голову очереди
    Tail: TQueue;  // указатель на хвост очереди
  end;

  TInfoRecord=record
    Quantity, Depth: integer;
    Min, Max: TGTree;
  end;

  TMass= array of word;
var SelectNode: TGTree;
    ColorSNode, BackGroundColor: TColor;
    MIn, MCol : TMassCount;
    GrafFlag, rgDWFlag: Boolean;
    QueueForArrow : TPointerQueue;
    InfoRecord: TInfoRecord;
    Index, kMaxSpeed: integer;
    strOrder: string;
implementation

end.
