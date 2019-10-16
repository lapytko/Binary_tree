unit Unit_OAiP_GraphTree_Form2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Unit_OAiP_GraphTree, GraphTreeCommand, StackCommand, QueueCommand, DataTypes;

type
  TForm2 = class(TForm)
    img1: TImage;
    TmrDrawPointer: TTimer;
    tmrSetPos: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure img1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmrDrawPointerTimer(Sender: TObject);
    procedure tmrSetPosTimer(Sender: TObject);
  private
    { Private declarations }                
    procedure WMMoving(var Msg: TWMMoving); message WM_MOVING;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
implementation


{$R *.dfm}
var NodeMove: TGTree;
    MousePos: TPoint;
procedure TForm2.FormCreate(Sender: TObject);
begin
  NodeMove:=nil;
  CreateQueue(QueueForArrow);
end;

procedure TForm2.WMMoving(var Msg: TWMMoving);
begin
  form1.left:=msg.Dragrect.Left-form1.Width+12;
  form1.top:=msg.Dragrect.top;
end;

// ќбход дл€ нахождени€ узла дл€ движени€
procedure OrderSearchM(Tree: TGTree; X,Y: integer; var NodeMove: TGTree);
var i: byte;
begin
  if (Tree<>nil)and(NodeMove=nil) then
    begin
      For i:=0 to high(Tree^.Next) do
        OrderSearchM(Tree^.next[i], X,Y, NodeMove);
      with Tree^.Rect do
        if (NodeMove=nil)and(X>Left)and(X<Right)and(Y<Bottom)and(Y>Top) then
          begin
            NodeMove:=Tree;
            exit;
          end;
    end;
end;

Procedure OrderForMove(Tree: TGTree; X,Y: integer);
var i:byte;
begin
  if Tree<>nil then
    begin
      For i:=0 to high(Tree^.next) do
        OrderForMove(Tree^.Next[i], X,Y);
      with Tree^.Edit do
        begin
          Left:=Left+x;
          Top:=Top+Y;
          if (left<0)or (top<0)then
            begin
              GTreeSetPos(GTree, form2);
              exit;
            end;
        end;
      with Tree^.Rect do
        begin
          Left:=Left+x;
          Top:=Top+Y;
          Right:=Right+x;
          Bottom:=Bottom+y;
        end;
    end;
end;
      
procedure TForm2.img1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (Shift=[ssLeft])and(NodeMove<> nil)  then
    begin
      OrderForMove(NodeMove,-MousePos.X+x ,-MousePos.Y+Y );
      MousePos.x:=x;
      MousePos.y:=y;
      OrderForDraw(GTree, Form2.img1.Canvas, clWhite);  
    end
  else
    begin
      MousePos.x:=x;
      MousePos.y:=y;
    end;     
end;

procedure TForm2.img1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OrderSearchM(GTree, x, y, NodeMove);
  if NodeMove=nil then
    begin
      SelectNode:=GTree;
      Form1.rgDoWith.ItemIndex:=0;
    end
  else
    begin
      SelectNode:=NodeMove;
      if  SelectNode=GTree then
        Form1.rgDoWith.ItemIndex:=0
      else
        Form1.rgDoWith.ItemIndex:=1;
    end;
  Form1.pgcChange(sender);
  OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
end;

procedure TForm2.img1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  NodeMove:=nil;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
  GTreeSetPos(GTree, form2);
  img1.Width:=Form2.Width;
  img1.Height:=Form2.Height;
  Img1.picture:=nil;        
  OrderForDraw(Gtree, img1.canvas, clwhite);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Close;
end;

procedure TForm2.TmrDrawPointerTimer(Sender: TObject);
begin
  form1.mmoOrder.Text:=form1.mmoOrder.Text+copy(strOrder, 1,pos(' ', strOrder));
  delete(strOrder, 1,pos(' ', strOrder));
  DrawPointers(QueueForArrow, form2.img1.Canvas, ColorSNode);
  if isEmptyQueue(QueueForArrow) then
    begin
      TmrDrawPointer.Enabled:=false;
      img1.canvas.pen.color:=clBlack;
      if selectNode=nil then
        begin
          showMessage('Ёлемент не найден');
          selectNode:=GTree;
          OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
        end
      else
        begin
          DrawFigure(form2.img1.Canvas,SelectNode, ColorSNode, 3);
          form2.img1.canvas.TextOut(SelectNode^.Rect.Left+2, SelectNode^.Rect.Top+2, intToStr(SelectNode^.Edit.tag));
        end;
      rgDWFlag:=true;
      if selectNode<>GTree then
        form1.rgDoWith.ItemIndex:=1
      else
        form1.rgDoWith.ItemIndex:=0;
    end;
end;

Procedure OrderForCheckPos(Tree: TGTree; var flag: boolean);
begin
  if (tree<>nil)and (flag) then
    begin
      if (round(Tree^.Pos.left.Ending)<>Tree^.Edit.Left) or
         (round(Tree^.Pos.top.Ending)<>Tree^.Edit.top) then
        begin
          flag:=false;
          exit;
        end;
      OrderForCheckPos(tree^.next[0], flag);
      OrderForCheckPos(tree^.next[1], flag);
    end;
end;
procedure TForm2.tmrSetPosTimer(Sender: TObject);
var flagPos:boolean;
begin
  GTreeSlowSetPos(GTree);
  OrderForDraw(GTree, Form2.img1.Canvas, clwhite);
  flagPos:=true;
  OrderForCheckPos(GTree, flagPos);
  tmrSetPos.Enabled:=not(flagPos);
end;

end.
