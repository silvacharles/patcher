program Patcher;

uses
  Forms,
  Unit1 in 'Unit1.pas' {patch};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tpatch, patch);
  Application.Run;
end.
