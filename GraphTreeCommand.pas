unit GraphTreeCommand;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DataTypes, QueueCommand;


//создание узла
procedure MakeGTree(var Tree: TGTree; Data: TItemGT; Form: TForm);
//добавление одного узла
procedure InsertNode(var Tree: TGTree; Data: TItemGT; Form: TForm);
//добовление нескольких узлов из переменной типа string
Procedure InsertGTree(var Tree: TGTree; Str: String; Form: TForm);
//Обход для отрисовки
Procedure OrderForDraw(GTree: TGTree; Canvas: TCanvas; Color: TColor);
procedure DrawFigure(Canvas: TCanvas; Tree: TGTree; color: TColor; WidthPen: byte);
procedure DrawLine(Canvas: TCanvas; Gt1, GT2: TGTree);                          
procedure OrderForTextOut(Tree: TGTree; canvas: TCanvas);    
procedure DrawPointers(var Queue: TPointerQueue; canvas: TCanvas; color: TColor);

//обход для вывода
procedure OrderForOutputPostorder(Tree: TGTree; var str: string);
procedure OrderForOutputPreorder(Tree: TGTree; var str: string);      
procedure OrderForOutputInorder(Tree: TGTree; var str: string);

//переводы
procedure FileInGTree(fName: string; Var Tree: TGTree; Form: TForm );
procedure GTreeInFile(fName: string; Tree: TGTree);                   
Procedure GTreeInStr(Tree: TGTree; Var str: string);
procedure GTreeInQueue(Tree: TGTree; var Queue: TPointerQueue);
procedure QueueInGTree(var Queue: TPointerQueue; var Tree: TGTree);

//подсчёт кол-ва эл-в на каждом уровне
Procedure CountElGT(Tree: TGTree; var Mass: TMassCount);
//Обход для подсчёта кол-ва эл,  нахождения макс и мин(обход для собирания основной инфы)
procedure OrderCollectBasicInfo(Tree: TGTree);
//установка позиций узлов дерева
Procedure GTreeSetPos(Tree: TGTree; Form: TForm);   
procedure GTreeSlowSetPos(var Tree: TGTree);

procedure GTreeSearch(Tree: TGTree; data: integer; var SearchTree: TGTree);

procedure GTreeClear(var Tree: TGTree);    
Procedure GTreeDelNode(var Tree: TGTree);
procedure ImgClear(var I: TImage; color: TColor);
implementation

uses Unit_OAiP_GraphTree_Form2;
procedure MakeGTree(var Tree: TGTree; Data: TItemGT; Form: TForm);
begin
  new(Tree);
  With Tree^ do
    begin
      Edit:=TEdit.Create(Form);
      Edit.Parent:=Form;
      Edit.Name:='Edt_';
      Edit.Visible:=True;
      Edit.Width:=32;
      Edit.Text:=data;
      Edit.Enabled:=false;
      Edit.Font.Color:=clBlack;
      Edit.Ctl3D:=false;
      SetLength(Next,2);
      next[0]:=nil;
      next[1]:=nil;
      Parent:=nil;
      edit.SendToBack;
    end;
end;

procedure DrawFigure(Canvas: TCanvas; Tree: TGTree; color: TColor; WidthPen: byte);
begin
  if tree=nil then
    exit;
  Canvas.Brush.Color:= color;
  Canvas.Pen.Width:=WidthPen;
  with tree^ do
    Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  Canvas.Pen.Width:=1;
end;

procedure DrawLine(Canvas: TCanvas; Gt1, GT2: TGTree);
begin
  Canvas.MoveTo( Round( (Gt1.Rect.Left+Gt1.Rect.Right)/2 ) ,Gt1.Rect.Bottom );
  Canvas.LineTo( Round((Gt2.Rect.Left+Gt2.Rect.Right)/2),Gt2.Rect.Top );
end;

function CountNLevel(Tree: TGTree):Integer;
begin
  Result:=0;
  While tree<> nil do
    begin
      tree:=tree^.Parent;
      inc(Result);
    end;
end;

Procedure OrderForDraw(GTree: TGTree; Canvas: TCanvas; Color: TColor);
  procedure OrderForDraw2(GTree: TGTree; Canvas: TCanvas; Color: TColor);
  var i: byte;
  begin
    if GTree<>nil then
      begin
        for i:=0 to high(GTree^.next) do
          begin
            if GTree^.Next[i]<>nil then
              DrawLine(Canvas, GTree, GTree.Next[i]);
            OrderForDraw2(GTree^.Next[i], canvas, color);
          end;
        DrawFigure(Canvas, GTree, Color, 1);
      end;
  end;
var BMP: TBitmap;
begin
  BMP:= TBitmap.Create;
  bmp.Width:=canvas.ClipRect.Right-canvas.ClipRect.Left;
  bmp.Height:=canvas.ClipRect.Bottom-canvas.ClipRect.Top;
  canvas.Pen.Width:=1;
  canvas.Pen.color:=clBlack;
  if  (Color <> clRed) then
    begin
      bmp.Canvas.Brush.Color:=BackGroundColor;
      bmp.Canvas.FillRect(bmp.canvas.ClipRect);
    end
  else
    begin
      bmp.Canvas.Brush.Color:=clWhite;
      bmp.Canvas.FillRect(bmp.canvas.ClipRect);
      bmp.TransparentMode:=tmAuto;
      bmp.Transparent:=true;
      bmp.TransparentColor:=clWhite;
    end;
  OrderForDraw2(GTree, BMP.Canvas, Color);
  if SelectNode<>nil then
    DrawFigure(BMP.Canvas, SelectNode, ColorSNode, 3);
  canvas.Draw(0,0,bmp);
  bmp.Free;
end;

procedure OrderForTextOut(Tree: TGTree; canvas: TCanvas);
begin
  if tree<>nil then
    begin
      canvas.Brush.color:=BackGroundColor;
      canvas.Rectangle(Tree^.Edit.Left,Tree^.Edit.Top,Tree^.Edit.Left+Tree^.Edit.Width, Tree^.Edit.Top+Tree^.Edit.Height);
      canvas.TextOut(Tree^.Rect.Left+18, Tree^.Rect.Top+9, Tree^.Edit.Text);
      OrderForTextOut(Tree^.next[0], canvas);
      OrderForTextOut(Tree^.next[1], canvas);
    end;
end;

procedure InsertNode(var Tree: TGTree; Data: TItemGT; Form: TForm);
var tree1, TreeO: TGTree;
             pos: Integer;
         edtName: string;
     temp, index: integer;
begin
  val(data, temp, index);   //проверка data
  if (index <>0) then
    exit;
  if tree = nil then  // проверка, не пустое ли дерево
    begin
      makeGTree(tree,data, Form);
      Tree.Edit.Top:=-100;
      Tree.Edit.Left:=round(form.ClientWidth/2 - tree^.Edit.Width/2);
      tree^.Edit.Name:=tree^.Edit.Name+'_';
      exit;
    end;
  TreeO:=Tree;
  while tree<>nil do  // нахождение место вставки нового узла
    begin
      tree1:=tree;   // запаминаем предыдущий узел
      edtName:=edtName+intToStr(pos);
      if StrToInt(data)=StrToInt(tree^.Edit.Text) then
        begin 
          Tree:=TreeO;
          exit;
        end;
      if StrToInt(data)<StrToInt(tree^.Edit.Text) then
        pos:=0
      else
        pos:=1;
      tree:=tree^.next[pos];
    end;
  tree:=tree1;
  // проверка в какое поддерево нужно вставить новый узел
  tree1:=nil;
  makeGTree(Tree1, data, form);
  if StrToInt(data)<StrToInt(tree^.Edit.Text) then
    Pos:=0
  else
    Pos:=1;
  tree^.next[pos]:=Tree1;
  tree1.Parent:=tree;
  tree1^.Edit.Name:=tree^.Edit.Name+IntToStr(Pos);
  Tree1.Edit.Top:=Tree^.Edit.Top;
  Tree1.Edit.Left:=Tree^.Edit.Left;
  Tree:=TreeO;
end;

Procedure InsertGTree(var Tree: TGTree; Str: String; Form: TForm);
var PosSpace: integer;
        data: TItemGT;
begin
  if str='' then
    exit;
  PosSpace:=Pos(' ',Str);
  While Length(str) > 0 do
    begin
      Data:=copy(Str, 1, PosSpace-1);
      if length(Data)>0 then
        InsertNode(Tree, Data, Form);
      Delete(Str, 1, PosSpace);
      PosSpace:=Pos(' ',Str);
      if PosSpace = 0 then
        PosSpace:=Length(str)+1;
    end;
  GTreeSetPos(Tree, Form);
  SelectNode:=Tree;
end;

procedure SetPosErrorLevel(Tree: TGTree);
var tempQueue: TPointerQueue;
     tempTree: TGTree;
     tempNode: TQueue;
  i, QElQueue: byte;
begin
  CreateQueue(tempQueue);
  insertQueue(tempQueue, tree);
  while not(isEmptyQueue(tempQueue)) do
    begin
      deleteQueue(tempQueue, tempTree);
      for i:=0 to 1 do
        if tempTree^.next[i]<>nil then
          insertQueue(tempQueue, tempTree^.next[i]);
      if  isEmptyQueue(tempQueue) then
        exit;

      if CountNLevel(tempQueue.head.Data)=CountNLevel(tempQueue.tail.Data) then
        begin
          tempNode:=tempQueue.Head;
          while tempNode<>nil do
            begin
              if not(GrafFlag) then
                begin
                  if ( (tempNode.Data.Edit.Left+tempNode.Data.Edit.Width)>form2.ClientWidth ) then
                    begin
                      tempNode:=tempQueue.Head;
                      QElQueue:=CountElQueue(tempQueue);
                      for i:=1 to QElQueue do
                        begin
                          tempNode^.Data^.Edit.Left:=round(i*(form2.ClientWidth)/(QElQueue+1) - tempNode^.Data^.Edit.Width/2 );

                          tempNode^.Data^.Rect.Left:=tempNode^.Data^.edit.Left-16;
                          tempNode^.Data^.Rect.Top:=tempNode^.Data^.Edit.Top-8;
                          tempNode^.Data^.Rect.Right:=tempNode^.Data^.edit.Left+tempNode^.Data^.edit.Width+16;
                          tempNode:=tempNode.Next;
                        end;
                      break;
                    end;
                end
              else
                begin
                  if ( (tempNode.Data.Pos.left.Ending+tempNode.Data.Edit.Width)>form2.ClientWidth )    then
                    begin
                      tempNode:=tempQueue.Head;
                      QElQueue:=CountElQueue(tempQueue);
                      for i:=1 to QElQueue do
                        begin
                          tempNode^.Data^.Pos.left.Ending:=round( i*(form2.ClientWidth)/(QElQueue+1) - tempNode^.Data^.Edit.Width/2);

                          tempNode^.Data^.Rect.Left:=tempNode^.Data^.edit.Left-16;
                          tempNode^.Data^.Rect.Top:=tempNode^.Data^.Edit.Top-8;
                          tempNode^.Data^.Rect.Right:=tempNode^.Data^.edit.Left+tempNode^.Data^.edit.Width+16;
                          tempNode:=tempNode.Next;
                        end;
                      break;
                    end;
                end;
              tempNode:=tempNode.Next;
            end;
        end;
    end;
  ClearQueue(tempQueue);
end;


Procedure GTreeSetPos(Tree: TGTree; Form: TForm);
  procedure GTreeSetPos2(Tree: TGTree; level, int: integer);
  var i: word;
  begin
    if Tree<>nil then
      begin
        inc(MIn[level]);
        with Tree^ do
          begin
            if (Level<>0)and(MCol[level]<MCol[level-1]) then
              MCol[level]:=MCol[level-1];
            if (Level<>0)and(MIn[level]<MIn[level-1]) then
              MIn[level]:=MIn[level-1];
            if not(GrafFlag) then
              begin
                Edit.Left:=Round(Form.clientWidth*MIn[Level]/(MCol[level]+1) - (Edit.Width / 2));
                Edit.Top:=int*level+(int div 2);
                Rect.Left:=edit.Left-16;
                Rect.Top:=Edit.Top-8;
                Rect.Right:=edit.Left+edit.Width+16;
                Rect.Bottom:=Edit.Top+edit.Height+8;
              end
            else
              begin
                tree^.Pos.left.Start:=Edit.Left;
                tree^.Pos.left.Ending:=Round(Form.clientWidth*MIn[Level]/(MCol[level]+1) - (Edit.Width / 2));
                Tree^.Pos.Top.Start:=Edit.Top;
                Tree^.pos.Top.Ending:=int*level+(int div 2);
                Tree^.pos.left.Now:=tree^.Pos.left.Start;
                Tree^.pos.Top.Now:=tree^.Pos.Top.Start;
              end;
          end; //with
        inc(level);
        For i:=0 to high(Tree^.Next) do
          GTreeSetPos2(Tree^.Next[i], level, int);
      end; //if
  end;
var level, interval: integer;
    massErrorLevel: TMass;
begin
  if Tree = nil then
    exit;
  CountElGT(Tree, MCol);
  SetLength(MIn,0);
  SetLength(MIn,High(MCol)+1);
  level:=0;
  interval:=64;
  if interval*(high(MCol)+1)>form.ClientHeight then
    interval:= form.ClientHeight div (high(MCol)+1);
  SetLength(massErrorLevel, 1);
  massErrorLevel[0]:=0;
  form2.OnResize:=nil;
  GTreeSetPos2(Tree, level, interval);
  CountElGT(Tree, MCol);
  SetPosErrorLevel(Tree);
  form2.tmrSetPos.Enabled:=GrafFlag;  
  form2.OnResize:=Form2.FormResize;
end;


PROCEDURE SLOWmove( S, E: real; Kx, Ks, Kss: real; var N: real);//kx - часть от растояния, на котором убыв/возрас скорость
var maxSpeed,startSpeed, x: real;                               //ks - часть от растояния, равная макс скорости
begin                                                           //kss- часть макс скорости, равная начальной скорости
  E:= E - S;
  N:= N - S;
  if ks<>0 then
    maxSpeed:= E/ks
  else
    ks:=kx;
  if kss<>0 then
    startSpeed:= maxSpeed/kss
  else
    startSpeed:=0;
  ks:=(ks/kss)*(kss-1);
  if n= 0 then
    n:=E/10000;
  if ( (E > n)and(N < E/Kx) )or( (E < n) and (N > E/Kx) ) then
    begin
      x:=startSpeed+N*kx/ks;
      N:=N+ x; 
      if (E>0)and(N>E)or(E<0)and(N<e) then
        n:=e;
      N:=N+S;
      exit;
    end;
  if (E > n)and(N > E - (E/Kx)) or((e<n)and(N < E - (E/Kx))) then
    begin
      x:= startSpeed+(E-N)*kx/ks;
      if (E > n)and(N+X>E)or(E < n)and(N+X<E) then
        N:=E
      else
        N:=N+x;
      N:=N+S;
      exit;
    end;
  E:=e+s;
  N:=N+S+ maxSpeed;
end;

procedure GTreeSlowSetPos(var Tree: TGTree);
  procedure GTreeSlowSetPos2(var SENPos: TSENPos);
  begin
    if SENPos.Start<>SENPos.Ending then
        begin
          SLOWmove(SENPos.Start,SENPos.Ending,2,kMaxSpeed,4,SENPos.now);
          if round(SENPos.now) = round(SENPos.Ending) then
            begin
              SENPos.Start:=round(SENPos.now);
              SENPos.Ending:=round(SENPos.now);
            end;
        end; //if
  end;
begin
  if Tree<>nil then
    begin
      GTreeSlowSetPos(Tree^.next[0]);
      GTreeSlowSetPos(Tree^.next[1]);

      GTreeSlowSetPos2(Tree^.Pos.left,);
      Tree^.edit.left:=Round(Tree^.Pos.left.now);
      GTreeSlowSetPos2(Tree^.Pos.top);
      Tree^.edit.top:=Round(Tree^.Pos.top.now);

      with Tree^ do
        begin
          Rect.Left:=edit.Left-16;
          Rect.Top:=Edit.Top-8;
          Rect.Right:=edit.Left+edit.Width+16;
          Rect.Bottom:=Edit.Top+edit.Height+8;
        end;
    end; //if
end;

procedure GTreeClear(var Tree: TGTree);
var i:byte;
begin
  if Tree<>nil then
    begin
      for i:=0 to high(Tree^.next) do
        GTreeClear(Tree^.next[i]);
      Tree^.Edit.Free;
      Dispose(Tree);
      Tree:=nil;
    end;
end;

Procedure GTreeDelNode(var Tree: TGTree);
begin
  Tree^.Next[0]:=nil;
  Tree^.Next[1]:=nil;
  Tree^.Edit.Free;
  Dispose(tree);
  Tree:=nil;
end;

Procedure CountElGT(Tree: TGTree; var Mass: TMassCount);
var Num: cardinal;
  procedure CountElGT_2(Tree: TGTree; var Mass: TMassCount; Num: Cardinal);
  var i: byte;
  begin
    inc(num);
    if Tree<>nil then
      begin
        if  num > High(mass) then
          SetLength(mass, num+1);
        inc(Mass[num-1]);
        for i:=0 to high(Tree^.Next) do
          CountElGT_2(Tree^.next[i], Mass, Num);
      end;
  end;
begin
  SetLength(mass,1);
  Mass[0]:=0;
  num:=0;
  CountElGT_2(Tree, Mass, num);
end;
    
procedure FileInGTree(fName: string; Var Tree: TGTree; Form: TForm );
var str, strTemp: string;
             fIn: TextFile;
begin
  AssignFile(fIn,fName );
  Reset(fIn);
  str:='';
  while not(EOF(fIn)) do
    begin
      readln(fIn,strTemp);
      str:=str+' '+strTemp;
    end;
  InsertGTree(Tree, str, form);
  GTreeSetPos(Tree, form);
  CloseFile(fIn);
end;

Procedure GTreeInStr(Tree: TGTree; Var str: string);
var i: byte;
begin
  if Tree<>nil then
    begin
      Str:=str+Tree^.Edit.Text+' ';
      for i:=0 to high(tree.next) do
        GTreeInStr(Tree.Next[i], str);
    end;
end;

procedure GTreeInFile(fName: string; Tree: TGTree);
var fOut: TextFile;
    str, Data: string;
     PosSpace:integer;
begin
  Assignfile(fOut,fName);
  RewRite(fOut);
  GTreeInStr(Tree, Str);
  Str:=Str+' ';
  PosSpace:=Pos(' ',Str);
  While PosSpace <>0 do
    begin
      Data:=copy(Str, 1, PosSpace-1);
      if length(Data)>0 then
        writeLn(fOut, data);
      Delete(Str, 1, PosSpace);
      PosSpace:=Pos(' ',Str);
    end;
  closeFile(fOut);
end;

procedure GTreeInQueue(Tree: TGTree; var Queue: TPointerQueue);
var  QueueOrder: TPointerQueue;
      TempTree: TGTree;
             i: byte;
begin
  CreateQueue(QueueOrder);
  InsertQueue(QueueOrder, Tree);

  InsertQueue(Queue, Tree);
  while not(isEmptyQueue(QueueOrder)) do
    begin
      DeleteQueue(QueueOrder,TempTree);

      for i:=0 to 1 do
        if TempTree^.Next[i]<>nil then
          begin
            InsertQueue(QueueOrder, TempTree^.Next[i]);
            InsertQueue(Queue, TempTree^.Next[i]);
            TempTree^.Next[i]:=nil;
          end;
      if Tree<>TempTree then
        TempTree^.Parent:=nil;
    end;
end;

procedure QueueInGTree(var Queue: TPointerQueue; var Tree: TGTree);
var tempTree,tempTree2: TGTree;
                     i: Shortint;
begin
  while not(isEmptyQueue(Queue)) do
    begin
      tempTree:= Tree;
      DeleteQueue(Queue, tempTree2);
      i:=0;
      while i<>(-1) do
        if tempTree<> nil then
          begin
            if strToInt(TempTree2^.Edit.Text)= strToInt(tempTree^.Edit.Text) then
              begin
                i:=-1;
                TempTree2^.Edit.Free;
                selectNode:=tree;
                Continue;
              end;
            if strToInt(TempTree2^.Edit.Text)< strToInt(tempTree^.Edit.Text) then
              i:=0
            else
              i:=1;
            if tempTree^.Next[i]<> nil then
              tempTree:=tempTree^.Next[i]
            else
              begin
                tempTree^.Next[i]:=TempTree2;
                i:=-1;
                TempTree2^.Parent:=tempTree;
              end;
          end
        else
          begin
            Tree:=TempTree2;
            i:=-1;
          end;
    end;
end;

procedure ImgClear(var I: TImage; color: TColor);
begin
  I.Canvas.Brush.Color:=color;
  I.Canvas.FillRect(I.ClientRect);
end;

function AngleBetweenPoints(A,B: TPoint): real;
begin
  If B.x-A.x<>0 then
    result:=ArcTan( (B.y-A.y)/(B.x-A.x) )
  else
    if B.Y>A.Y then
      result:=pi/2
    else
      result:=-pi/2;
  If B.x < A.x then
    result:=pi+ result;
end;

procedure DrawLineOnPoints(p1,p2: TPoint; canvas: TCanvas);
begin
  canvas.MoveTo(p1.X,p1.Y);
  canvas.LineTo(p2.X,p2.Y);
end;

procedure DrawPointers(var Queue: TPointerQueue; canvas: TCanvas; color: TColor);
var Temp: TItemQ;
    int: integer;
    p1, p2, p3: TPoint;
    angle: real;
begin
  inc(index);
  canvas.Pen.Width:=2;
  canvas.Pen.Color:=color;
  DeleteQueue(Queue, Temp);
  if Queue.Head=nil then
    exit;
  canvas.Brush.Color:=clWhite;
  if (Queue.Head.Data<>nil)and(Queue.Head.Data=temp) then
    begin
      DeleteQueue(Queue, Temp);
      p2.X:=Temp^.Rect.Left;
      p2.Y:=Round( (Temp^.Rect.Top+Temp^.Rect.Bottom)/2 );
      p1.Y:=p2.Y;
      p1.X:=p2.X-40;
      DrawLineOnPoints(p1,p2,canvas);
      angle:=AngleBetweenPoints(p2,p1);

      p3.X:=round( p2.x+cos(angle+0.5)*10);
      p3.Y:=round( p2.Y+sin(angle+0.5)*10);
      DrawLineOnPoints(p2,p3,canvas);

      p3.X:=round( p2.x+cos(angle-0.5)*10);
      p3.Y:=round( p2.Y+sin(angle-0.5)*10);
      DrawLineOnPoints(p2,p3,canvas);
      canvas.TextOut(temp.Rect.Left+4, temp.Rect.Top+2, intToStr(temp.Edit.tag));
      exit;
    end;
  while (temp=nil)or(Queue.Head.Data=nil) do
    begin
      if temp=nil then
        DeleteQueue(Queue, Temp)
      else
        canvas.TextOut(temp.Rect.Left+2, temp.Rect.Top+2, intToStr(temp.Edit.tag));
      if (Queue.Head.Data=nil) then
        begin
          DeleteQueue(Queue, Temp);
          DeleteQueue(Queue, Temp);
        end;
      if isEmptyQueue(Queue) then
        exit;
    end;
  if (Queue.Head<>nil) then
    begin
      if Queue.Head.Data.Rect.Left-Temp.Rect.Left <> 0 then
        int:= Round((Queue.Head.Data.Rect.Left-Temp.Rect.Left)/abs(Queue.Head.Data.Rect.Left-Temp.Rect.left))
      else
        int:=1;
      int:=int*20;
      if CountNLevel(Queue.Head.Data) <> CountNLevel(Temp) then
        begin
          if CountNLevel(Queue.Head.Data) > CountNLevel(Temp) then
            begin
              p1.X:=Round( (Temp.Rect.Left+Temp.Rect.Right)/2 ) +int;
              p1.Y:=Temp.Rect.Bottom;
              p2.X:=Round((Queue.Head.Data.Rect.Left+Queue.Head.Data.Rect.Right)/2) +int;
              p2.Y:=Queue.Head.Data.Rect.Top;
            end
          else
            begin
              p1.X:=Round( (Temp.Rect.Left+Temp.Rect.Right)/2 ) +int;
              p1.Y:=Temp.Rect.Top ;
              p2.X:=Round((Queue.Head.Data.Rect.Left+Queue.Head.Data.Rect.Right)/2) +int;
              p2.Y:=Queue.Head.Data.Rect.Bottom;
            end;
        end
      else
        begin
          p1.X:=Temp.Rect.Right;
          p1.Y:=Round( (Temp.Rect.Top+Temp.Rect.Bottom)/2 );
          p2.X:= Queue.Head.Data.Rect.Left;
          p2.Y:=Round( (Queue.Head.Data.Rect.Top+Queue.Head.Data.Rect.Bottom)/2 );
        end;
      DrawLineOnPoints(p1,p2,canvas);
      angle:=AngleBetweenPoints(p2,p1);

      p3.X:=round( p2.x+cos(angle+0.5)*10);
      p3.Y:=round( p2.Y+sin(angle+0.5)*10);
      DrawLineOnPoints(p2,p3,canvas);

      p3.X:=round( p2.x+cos(angle-0.5)*10);
      p3.Y:=round( p2.Y+sin(angle-0.5)*10);
      DrawLineOnPoints(p2,p3,canvas);
      canvas.TextOut(temp.Rect.Left+2, temp.Rect.Top+2, intToStr(temp.Edit.tag));
      canvas.TextOut(Queue.Head.Data.Rect.Left+2, Queue.Head.Data.Rect.Top+2, intToStr(Queue.Head.Data.Edit.tag));
    end;
end;

procedure GTreeSearch(Tree: TGTree; data: integer; var SearchTree: TGTree);
var Temp: integer;
begin
  if (tree<>nil)and(SearchTree=nil) then
    begin
      inc(Index);
      tree.Edit.Tag:=Index;
      InsertQueue(QueueForArrow,Tree);
      Temp:=StrToInt(tree^.Edit.Text);
      if (temp=data) then
        begin
          SearchTree:=Tree;
          exit;
        end;
      if (data< temp) then
        GTreeSearch(Tree^.Next[0], data, SearchTree)
      else
        GTreeSearch(Tree^.Next[1], data, SearchTree);
    end;
end;

procedure OrderForOutputPreorder(Tree: TGTree; var str: string);
begin
  if tree <> nil then
    begin
      if (tree^.Parent<>nil)and(not(isEmptyQueue(QueueForArrow))) then
        begin
          InsertQueue(QueueForArrow, nil);
          InsertQueue(QueueForArrow, tree^.Parent);
        end;
      inc(Index);
      tree^.Edit.Tag:=Index;
      InsertQueue(QueueForArrow,Tree);
      str:=str+tree^.Edit.Text+' ';

      OrderForOutputPreorder(Tree^.next[0], str);
      OrderForOutputPreorder(Tree^.next[1], str);
    end;
end;

procedure OrderForOutputInorder(Tree: TGTree; var str: string);
begin
  if tree <> nil then
    begin
      OrderForOutputInorder(Tree^.next[0], str);

      inc(Index);
      tree^.Edit.Tag:=Index;
      InsertQueue(QueueForArrow, Tree);
      InsertQueue(QueueForArrow, Tree);
      str:=str+tree^.Edit.Text+' ';

      OrderForOutputInorder(Tree^.next[1], str);
    end;
end;

procedure OrderForOutputPostorder(Tree: TGTree; var str: string);
begin
  if tree <> nil then
    begin
      OrderForOutputPostorder(Tree^.next[0], str);
      OrderForOutputPostorder(Tree^.next[1], str);

      if not(isEmptyQueue(QueueForArrow))and(abs(CountNLevel(tree)-CountNLevel(QueueForArrow.tail.Data))>1) then
        InsertQueue(QueueForArrow, nil);
      inc(Index);
      tree^.Edit.Tag:=Index;
      InsertQueue(QueueForArrow,Tree);
      str:=str+tree^.Edit.Text+' ';
    end;
end;

procedure DepthGTree(Tree: TGTree; sum: integer; var max: integer);
begin
  if tree<>nil then
    begin
      inc(sum);
      DepthGTree(Tree^.next[0],sum, max);
      DepthGTree(Tree^.next[1],sum, max);
    end
  else
    if sum>max then
      max:=sum;
end;

procedure OrderCollectBasicInfo(Tree: TGTree);
var QueueOrder: TPointerQueue;
          Temp: TGTree;
begin
  if tree=nil then
    exit;
  //глубина
  InfoRecord.Depth:=0;
  DepthGTree(Tree, 0, InfoRecord.Depth);
  //кол-во эл
  CreateQueue(QueueOrder);
  InsertQueue(QueueOrder,Tree);
  InfoRecord.Quantity:=0;
  while not(isEmptyQueue(QueueOrder)) do
    begin
      DeleteQueue(QueueOrder, temp);
      inc(infoRecord.Quantity);
      if temp^.Next[0] <>nil then
        InsertQueue(QueueOrder,Temp^.next[0]);
      if temp^.Next[1] <>nil then
        InsertQueue(QueueOrder,Temp^.next[1]);
    end;
  temp:=tree;
  while temp^.Next[0]<>nil do   // мин  эл-т
    temp:=temp^.next[0];
  InfoRecord.min:=temp;
  temp:=tree;
  while temp^.Next[1]<>nil do   // макс эл-т
    temp:=temp^.next[1];
  InfoRecord.max:=temp;
end;

end.
