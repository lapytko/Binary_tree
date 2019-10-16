unit DataTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

Type

//����������� ������
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

//����
  TItemS = record
    value: String; // ��� �������������� ����  //������� ����� - ������, � ������� �������� ����� ������
  end;

  TStack =^ TNodeS; // ������ �� ����
  TNodeS = record
    Data: TItemS;  // �������������� ����
    Next: TStack;  // ������ �� ��������� ����
  end;

//�������
  TItemQ = TGTree;  // ��� ��������������� ����


  TQueue =^TNodeQ;  // ������ �� ����
  // �������� ����
  TNodeQ = record
    Data: TItemQ;  // �������������� ����      //������� ������� - ���� ������
    Next: TQueue;  // ������ �� ��������� ����
  end;

  // ������ �� �������
  TPointerQueue = record
    Head: TQueue;  // ��������� �� ������ �������
    Tail: TQueue;  // ��������� �� ����� �������
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
