program Project_OAiP_GraphTree;

uses
  Forms,
  Unit_OAiP_GraphTree in 'Unit_OAiP_GraphTree.pas' {Form1},
  DataTypes in 'DataTypes.pas',
  Unit_OAiP_GraphTree_Form2 in 'Unit_OAiP_GraphTree_Form2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GraphTree';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
