unit Unit_OAiP_GraphTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtDlgs, ComCtrls,
  GraphTreeCommand, StackCommand, QueueCommand, DataTypes, ExtCtrls, XPMan, DateUtils;

type
  TForm1 = class(TForm)
    mm: TMainMenu;
    mniFile: TMenuItem;
    mniOpen: TMenuItem;
    mniL01: TMenuItem;
    mniSave: TMenuItem;
    mniL02: TMenuItem;
    mniExit: TMenuItem;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    dlgSP: TSavePictureDialog;
    mniOpenExample: TMenuItem;
    mniClose: TMenuItem;
    mniSavePicture: TMenuItem;
    mniInRandom: TMenuItem;
    cbGraf: TCheckBox;
    rgDoWith: TRadioGroup;
    mniEdit: TMenuItem;
    mniUndo: TMenuItem;
    mniRedo: TMenuItem;
    mniL03: TMenuItem;
    mniClearUndo: TMenuItem;
    pm: TPopupMenu;
    mniNPop1: TMenuItem;
    mniNL05: TMenuItem;
    mniNClear: TMenuItem;
    mniNL04: TMenuItem;
    mniNUndo: TMenuItem;
    mniNredo: TMenuItem;
    mniNPop2: TMenuItem;
    mniNPop3: TMenuItem;
    gbBasicInfo: TGroupBox;
    lblQuantity: TLabel;
    lblMax: TLabel;
    lblMin: TLabel;
    lblDepth: TLabel;
    pgc: TPageControl;
    tsPush: TTabSheet;
    lblPush: TLabel;
    edtPush: TEdit;
    btnPushNode: TButton;
    btnPushTree: TButton;
    tsPop: TTabSheet;
    lblPop: TLabel;
    lblPopError: TLabel;
    btnPop: TButton;
    cbbPop: TComboBox;
    tsChange: TTabSheet;
    lblChange: TLabel;
    btnChange: TButton;
    edtChange: TEdit;
    tsSearch: TTabSheet;
    lblSearch: TLabel;
    edtSearch: TEdit;
    btnSearch: TButton;
    tsOrder: TTabSheet;
    lblOrder: TLabel;
    lblOrder2: TLabel;
    cbbOrder: TComboBox;
    btnOrder: TButton;
    mmoOrder: TMemo;
    btnResetPos: TButton;
    tbSpeedAnim: TTrackBar;
    lblSpeedAnim: TLabel;
    XPM: TXPManifest;
    mniNExit: TMenuItem;
    procedure mniOpenClick(Sender: TObject);
    procedure mniOpenExampleClick(Sender: TObject);
    procedure mniCloseClick(Sender: TObject);
    procedure mniSaveClick(Sender: TObject);
    procedure mniSavePictureClick(Sender: TObject);
    procedure btnPushNodeClick(Sender: TObject);
    procedure pgcChange(Sender: TObject);
    procedure cbbPopChange(Sender: TObject);
    procedure mniInRandomClick(Sender: TObject);
    procedure btnPushTreeClick(Sender: TObject);
    procedure btnPopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure cbGrafClick(Sender: TObject);
    procedure mniUndoClick(Sender: TObject);
    procedure mniRedoClick(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure mniClearUndoClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure mniNPop1Click(Sender: TObject);
    procedure mniNPop2Click(Sender: TObject);
    procedure mniNPop3Click(Sender: TObject);
    procedure btnOrderClick(Sender: TObject);
    procedure rgDoWithClick(Sender: TObject);
    procedure lblMaxClick(Sender: TObject);
    procedure lblMinClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPushKeyPress(Sender: TObject; var Key: Char);
    procedure edtChangeKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure btnResetPosClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tbSpeedAnimChange(Sender: TObject);
  private
    { Private declarations }
    procedure WMMoving(var Msg: TWMMoving); message WM_MOVING;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  GTree: TGTree;

procedure CollectAndOutBasicInfo(Tree: TGTree);
implementation

{$R *.dfm}
uses Unit_OAiP_GraphTree_Form2;
var ColorSelect: array [0..5] of TColor;
    SUndo, SRedo: TStack;
    QUndo, QRedo: integer;

Procedure SetQInName;
begin
  Form1.mniUndo.Caption:='Отменить ('+intToStr(QUndo)+')';
  Form1.mniRedo.Caption:='Вернуть ('+intToStr(QRedo)+')';
end;

Procedure SaveUndo;
var str: TItemS;
begin
  ClearQueue(QueueForArrow);
  form2.TmrDrawPointer.Enabled:=false;
  form2.tmrSetPos.Enabled:=false;
  strOrder:='';
  GTreeInStr(GTree, str.value);
  Push(SUndo, str);
  inc(QUndo);
  QRedo:=0;
  ClearStack(SRedo);
  form1.mniUndo.enabled:=true;
  form1.mniRedo.enabled:=False;
  form1.mniNUndo.Enabled:=true;
  form1.mniNRedo.Enabled:=False;
  SetQInName;
end;

Procedure EditS(var S1,S2: TStack);
var str: TItemS;
begin
  GTreeInStr(GTree, str.value);
  Push(S2, str);
  Pop(S1, str);
  GTreeClear(GTree); 
  imgClear(Form2.img1, BackGroundColor);
  InsertGTree(GTree, str.value, form2);
  selectNode:=GTree;
  if Not(Grafflag) then
    OrderForDraw(Gtree, form2.img1.Canvas, clWhite);
  SetQInName;
end;

// Отмена
procedure TForm1.mniUndoClick(Sender: TObject);
begin
//помещение в SRedo
//загрузка из SUndo
  dec(QUndo);
  inc(QRedo);
  EditS(SUndo,SRedo);
  form1.mniRedo.enabled:=True;
  form1.mniNRedo.Enabled:=True;
  if SUndo=nil then
    begin
      form1.mniUndo.enabled:=false;
      form1.mniNUndo.Enabled:=false;
    end;
  CollectAndOutBasicInfo(GTree);
end;

// Возврат
procedure TForm1.mniRedoClick(Sender: TObject);
begin 
//помещение в SUndo
//загрузка из SRedo
  dec(QRedo);
  Inc(QUndo);
  EditS(SRedo,SUndo);
  form1.mniUndo.enabled:=true;
  form1.mniNUndo.enabled:=true;
  if SRedo=nil then
    begin
      form1.mniRedo.enabled:=false;
      form1.mniNRedo.Enabled:=false;
    end;
  CollectAndOutBasicInfo(GTree);
end;

//очистка содержимого из кнопок 'Отмена' и 'Возврат'
procedure TForm1.mniClearUndoClick(Sender: TObject);
begin
  ClearStack(SRedo);
  ClearStack(SUndo);
  QRedo:=0;
  QUndo:=0;
  SetQInName;
  form1.mniRedo.enabled:=false;
  form1.mniUndo.enabled:=false;
end;

procedure TForm1.WMMoving(var Msg: TWMMoving);
begin
  form2.left:=msg.Dragrect.Right-12;
  form2.top:=msg.Dragrect.top;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if form1.Visible then
    begin
      Form2.Left:=Form1.Left+Form1.Width-12;
      Form2.Top:=Form1.Top;
      Form2.Height:=Form1.Height+6;
    end;
end;

procedure CollectAndOutBasicInfo(Tree: TGTree);
begin
  form1.lblQuantity.Caption:='Кол-во эл. : ';
  form1.lblMax.Caption:='Макс эл. : ';
  form1.lblMin.Caption:='Мин эл. : ';
  form1.lblDepth.Caption:='Глубина дерева : ';
  if tree<>nil then
    begin
      OrderCollectBasicInfo(Tree);
      form1.lblQuantity.Caption:=form1.lblQuantity.Caption+IntToStr(InfoRecord.Quantity);
      form1.lblMax.Caption:=form1.lblMax.Caption+InfoRecord.max^.edit.text;
      form1.lblMin.Caption:=form1.lblMin.Caption+InfoRecord.min^.edit.text;
      form1.lblDepth.Caption:=form1.lblDepth.Caption+IntToStr(InfoRecord.Depth);
    end
  else
    begin
      form1.lblQuantity.Caption:=form1.lblQuantity.Caption+'-';
      form1.lblMax.Caption:=form1.lblMax.Caption+'-';
      form1.lblMin.Caption:=form1.lblMin.Caption+'-';
      form1.lblDepth.Caption:=form1.lblDepth.Caption+'-';
      InfoRecord.max:=nil;
      InfoRecord.min:=nil;
    end;
  form2.TmrDrawPointer.Enabled:=false;
end;

procedure TForm1.mniOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    begin
      SaveUndo;
      GTreeClear(GTree);
      FileInGTree(dlgopen.FileName, GTree, Form2);
      OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
      CollectAndOutBasicInfo(GTree);
    end;
end;

procedure TForm1.mniOpenExampleClick(Sender: TObject);
var fileName: string;
begin
  fileName:='file/Input.txt';
  if not(FileExists(fileName)) then
    fileName:='Input.txt';
  if FileExists(fileName) then
    begin
      SaveUndo;
      GTreeClear(GTree);
      FileInGTree(fileName, GTree, Form2);
      OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
      CollectAndOutBasicInfo(GTree);
    end;
end;

//Очистка
procedure TForm1.mniCloseClick(Sender: TObject);
begin
  SaveUndo;
  GTreeClear(GTree);
  ImgClear(form2.img1,Form2.Color);
  CollectAndOutBasicInfo(GTree);
end;

//Сохранение дерева в текстовый файл
procedure TForm1.mniSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then
    GtreeInFile(dlgsave.FileName, GTree);
end;

//Сохранение Дерева в изображение
procedure TForm1.mniSavePictureClick(Sender: TObject);
begin
  OrderForTextOut(GTree, Form2.img1.Canvas);
  if dlgSP.Execute then
     form2.img1.Picture.SaveToFile(dlgSP.FileName);
end;

procedure TForm1.btnPushNodeClick(Sender: TObject);
begin
  if EdtPush.text='' then
    exit;
  SaveUndo;
  InsertGTree(GTree, EdtPush.Text, Form2);
  edtPush.Text:='';
  GTreeSetPos(GTree, Form2);
  OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
  CollectAndOutBasicInfo(GTree);
end;

procedure TForm1.pgcChange(Sender: TObject);
begin
  ColorSNode:=ColorSelect[pgc.TabIndex];
  if SelectNode<>nil then
    DrawFigure(Form2.img1.Canvas, SelectNode, ColorSNode, 3);
end;

procedure TForm1.cbbPopChange(Sender: TObject);
begin
  OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
  case cbbpop.ItemIndex of
  0:ColorSNode:=clRed;
  1:begin
      ColorSNode:=clWhite;
      OrderForDraw(SelectNode, Form2.img1.Canvas, clRed);
    end;
  2:begin
      ColorSNode:=clRed;
      OrderForDraw(SelectNode, Form2.img1.Canvas, clRed);
    end;
  end;
  if SelectNode<> nil then
    DrawFigure(Form2.img1.Canvas, SelectNode, ColorSNode, 3);
end;

procedure TForm1.mniInRandomClick(Sender: TObject);
var Str: String;
      i: integer;
begin
  SaveUndo;
  randomize;
  for i:=0 to (random(21)+10) do
    Str:=Str+' '+IntToStr(random(40));
  GTreeClear(GTree);
  imgclear(form2.img1, BackGroundColor);
  InsertGTree(GTree, Str, Form2);
  GTreeSetPos(GTree, Form2);
  if Not(Grafflag) then
    OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
  CollectAndOutBasicInfo(GTree);
end;

procedure TForm1.btnPushTreeClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    begin
      SaveUndo;
      FileInGTree(dlgopen.FileName, GTree, Form2);
      form2.Img1.Canvas.Brush.color:=Form2.Color;
      form2.Img1.Canvas.FillRect(form2.img1.ClientRect);
      OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
    end;
end;

procedure TForm1.btnPopClick(Sender: TObject);
var tempNode: TGTree;
    BufQueue: TPointerQueue;
begin
  if selectNode= nil then
    begin
      exit;
    end;
  SaveUndo;
  case cbbPop.ItemIndex of
  0:begin
      CreateQueue(BufQueue);
      GtreeInQueue(selectNode, BufQueue);
      DeleteQueue(BufQueue, tempNode);
      tempNode:=selectnode.Parent;

      if tempNode<>nil then
        begin
          if selectNode=tempNode.Next[0] then
            GTreeDelNode(tempNode.Next[0])
          else
            GTreeDelNode(tempNode.Next[1]);
          QueueInGtree(BufQueue,GTree);
        end
      else
        begin
          GTreeDelNode(GTree);
          QueueInGtree(BufQueue,GTree);
        end;
    end;
  1:begin
      GTreeClear(SelectNode.next[0]);
      GTreeClear(SelectNode.next[1]);
    end;
  2:if selectnode.Parent<>nil then
      if selectnode.Parent.Next[0] =selectNode then
        GTreeClear(selectnode.Parent.Next[0])
      else
        GTreeClear(selectnode.Parent.Next[1])
    else
      GTreeClear(GTree);
  end;
  GTreeSetPos(GTree, form2);
  if cbbPop.ItemIndex<>1 then
    selectNode:=GTree;
  OrderForDraw(GTree, Form2.img1.Canvas, clWhite);
  CollectAndOutBasicInfo(GTree);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ColorSelect[0]:=clLime;
  ColorSelect[1]:=clRed;
  ColorSelect[2]:=clYellow;
  ColorSelect[3]:=clBlue;
  ColorSelect[4]:=$00FFDD00;
  ColorSNode:=ColorSelect[0];
  pgc.TabIndex:=0;
  InfoRecord.Quantity:=0;
  InfoRecord.Min:=nil;
  InfoRecord.Max:=nil;  
  CreateQueue(QueueForArrow);
  GrafFlag:=true;
  BackGroundColor:=clBtnFace;
  kMaxSpeed:=20;
  rgDWFlag:=false;
end;

procedure TForm1.btnChangeClick(Sender: TObject);
var BufQueue: TPointerQueue;
    int, index: integer;
begin
  val(EdtChange.Text,int,index);
  if (index<>0)or(selectNode=nil) then
    exit;
  selectNode^.Edit.Text:=EdtChange.Text;

  CreateQueue(BufQueue);
  GtreeInQueue(GTree, BufQueue);
  GTree:=nil;
  QueueInGtree(BufQueue,GTree);

  GTreeSetPos(GTree, form2);
  CollectAndOutBasicInfo(GTree);
end;

procedure TForm1.cbGrafClick(Sender: TObject);
begin
  GrafFlag:= cbGraf.Checked;
end;

procedure TForm1.mniExitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.btnSearchClick(Sender: TObject);
var    data: integer;
  indexError: integer;
begin
  val(edtSearch.Text, data, indexError);
  if indexError<>0 then
    exit;
  form2.TmrDrawPointer.Enabled:=false;
  ClearQueue(QueueForArrow);
  mmoOrder.Clear;
  strOrder:='';
  SelectNode:=nil;
  OrderForDraw(GTree, form2.img1.Canvas, clWhite);
  Index:=0;
  GTreeSearch(Gtree, Data, SelectNode);
  if cbGraf.Checked then
    form2.TmrDrawPointer.Enabled:=cbGraf.Checked
  else
    begin
      DrawFigure(form2.img1.Canvas,SelectNode, ColorSNode, 3);
      ClearQueue(QueueForArrow);
    end;
  edtSearch.Text:='';
end;

procedure TForm1.mniNPop1Click(Sender: TObject);
begin
  cbbPop.ItemIndex:=0;
  btnPopclick(sender);
end;

procedure TForm1.mniNPop2Click(Sender: TObject);
begin
  cbbPop.ItemIndex:=1;
  btnPopclick(sender);
end;

procedure TForm1.mniNPop3Click(Sender: TObject);
begin
  cbbPop.ItemIndex:=2;
  btnPopclick(sender);
end;

// Обход дерева
procedure TForm1.btnOrderClick(Sender: TObject);
begin
  form2.TmrDrawPointer.Enabled:=false;
  ClearQueue(QueueForArrow);
  mmoOrder.Clear;
  strOrder:='';
  if GTree = nil then
    exit;
  orderForDraw(Gtree, form2.img1.Canvas, clWhite);
  Index:=0;
  case cbbOrder.ItemIndex of
    0: OrderForOutputPreorder(SelectNode, strOrder);  // Прямой
    1: OrderForOutputInorder(SelectNode, strOrder);   // Симметричный
    2: OrderForOutputPostorder(SelectNode, strOrder); // Обратный
  end;
  if cbGraf.Checked then
    begin
      form1.mmoOrder.Text:=form1.mmoOrder.Text+copy(strOrder, 1,pos(' ', strOrder));
      delete(strOrder, 1,pos(' ', strOrder));
      form2.TmrDrawPointer.Enabled:=cbGraf.Checked;
    end
  else
    MmoOrder.Lines.Add(strOrder);
  Index:=0;
end;

procedure TForm1.rgDoWithClick(Sender: TObject);
begin
  if (rgDWFlag) then
    begin
      rgDWFlag:=false;
      exit;
    end;
  if rgDoWith.ItemIndex = 0 then
    selectNode:=GTree;
  orderForDraw(GTree, form2.img1.canvas, clWhite);
end;

procedure TForm1.lblMaxClick(Sender: TObject);
begin
  if infoRecord.Max<>nil then
    selectNode:=infoRecord.Max
  else
    exit;
  orderForDraw(GTree, form2.img1.canvas, clWhite);
  if selectNode<>GTree then
    rgDoWith.ItemIndex:=1
  else
    rgDoWith.ItemIndex:=0;
end;

procedure TForm1.lblMinClick(Sender: TObject);
begin
  if infoRecord.Min<>nil then
    selectNode:=infoRecord.Min
  else
    exit;
  orderForDraw(GTree, form2.img1.canvas, clWhite); 
  if selectNode<>GTree then
    rgDoWith.ItemIndex:=1
  else
    rgDoWith.ItemIndex:=0; 
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  dlgOpen.InitialDir:=ExtractFilePath(Application.ExeName)+'file\';
  dlgSave.InitialDir:=dlgOpen.InitialDir;
  dlgSP.InitialDir:=dlgOpen.InitialDir;
end;

procedure TForm1.edtPushKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnPushNodeClick(sender);
  if not( key in ['0'..'9',#32,#8]) then
    key:=#0;
end;

procedure TForm1.edtChangeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnChangeClick(sender);
  if not( key in ['0'..'9']) then
    key:=#0;
end;

procedure TForm1.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnSearchClick(sender);
  if not( key in ['0'..'9']) then
    key:=#0;
end;

procedure TForm1.btnResetPosClick(Sender: TObject);
begin
  GTreeSetPos(GTree, Form2);
end;

procedure TForm1.tbSpeedAnimChange(Sender: TObject);
begin
  form2.TmrDrawPointer.Interval:=(tbSpeedAnim.Max-tbSpeedAnim.Position)*40+1;
  kMaxSpeed:=(1+tbSpeedAnim.Max-tbSpeedAnim.Position)*4;
end;

end.
