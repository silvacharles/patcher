unit Unit1;

{   / )|                                 |( \
   / / |           Charles Silva         | \ \
 _( (_ |   _ [www.charlessilva.com.br]  _  | _) )_
(((\ \)|_/ )___________________________( \_|(/ /)))
(\\\\ \_/ /                             \ \_/ ////)
 \       /                               \       /
  \    _/                                 \_    /
  /   /                                     \   \


Autor   : Charles Silva (suporte@charlessilva.com.br)
Linguagen : Delphi 2007 (Object Pascal)
twitter: http://twitter.com/charlessilva_
GitHub: https://github.com/silvacharles
}   
   interface
   
   uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
      Dialogs, StdCtrls,MiniFMOD, ExtCtrls, Effects;
      
   type
      Tpatch = class(TForm)
      OpenDialog1: TOpenDialog;
      fond: TImage;
      Open: TImage;
      original: TLabel;
      patch: TImage;
    Trasnparencia: TFormAlphaBlended;

    procedure OpenClick(Sender: TObject);
    procedure patchClick(Sender: TObject);
    procedure Inicio(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

   private
   { Private declarations }
   public
   { Public declarations }
end;

   var
      patch: Tpatch;

implementation


{$R *.dfm}
{$R sequelinha.res}


procedure BackupFile(const FileName, BackupExt: string; const BackupConfirm: boolean);
var cnt: boolean;
begin
      cnt := true;
      if BackupConfirm then
         cnt := MessageDlg('Criar Backup '+         //messageBox Criar backup
      ExtractFileName(FileName)+' ?',                //Pega o nome do Programa
      mtConfirmation, [mbYes,mbNo],0) = mrYes;       //Botao sim ou nao
      if not cnt then
         exit;

      CopyFile(PChar(FileName),                      //cCopia o Software
      PChar(ChangeFileExt(FileName, BackupExt)),
      false);
   end;

procedure Tpatch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
MiniFmod.XMFree;
end;

procedure Tpatch.Inicio(Sender: TObject);
var
  CurRes : TResourceStream;
begin
ReportMemoryLeaksOnShutdown := True;
XMPlayFromRes('XM', 'MUSIC');
  CurRes := TResourceStream.Create(hInstance,'CURSOR',RT_RCDATA);
  try
  CurRes.SaveToFile('sequelinha.cur');
  Screen.Cursors[1] := LoadCursorFromFile('sequelinha.cur');
  Screen.Cursor := 1;
  DeleteFile('sequelinha.cur');
  finally
    CurRes.Free;
  end;
end;

procedure Tpatch.OpenClick(Sender: TObject);
begin
 if opendialog1.execute then
begin
 original.caption:=OpenDialog1.FileName;
BackupFile(OpenDialog1.FileName, '.bak', true); // Cria um backup .bak....
end;
end;


procedure Tpatch.patchClick(Sender: TObject);
var
FB : File Of Byte;
b : Byte;
begin  //Primeiro
assignfile(FB , original.caption);   // Pega arquivo executavel e e carrega na Edit!
Reset(FB);
b := $90;                          //Adiciona um NOP(No Operation) Nenhuma operação trava o programa nesse ponto ao endereço
seek(FB,$0000325C);         //offset do Patcher convertir esse numero com o LordPE VA VRA Offset consegui no OllyDBG
Write(FB,b);                   // Modifica as linhas
closefile(FB);                 //Fecha o programa
// SEGUE O MESMO PROCESSO NOVAMENTE DEPENDENDO QUANTOS NOPS E ADICIONADO NO OLLYDBG
begin  //Segunda
assignfile(FB , original.caption);
Reset(FB);
b := $90;
seek(FB,$0000325D);
Write(FB,b);
closefile(FB);
begin      //Terceira
assignfile(FB , original.caption);
Reset(FB);
b := $90;
seek(FB,$0000325E);
Write(FB,b);
closefile(FB);
begin   //Quarta
assignfile(FB , original.caption);
Reset(FB);
b := $90;
seek(FB,$0000325F);
Write(FB,b);
closefile(FB);
begin    //Quinta
assignfile(FB , original.caption);
Reset(FB);
b := $90;
seek(FB,$00003260);
Write(FB,b);
closefile(FB);
begin    //Sexta
assignfile(FB , original.caption);
Reset(FB);
b := $90;
seek(FB,$00003261);
Write(FB,b);
closefile(FB);
MessageDlg('Crackeado com Sucesso!', mtInformation ,[mbOk],0);//Finaliza
end;
end;
end;
end;
end;
end;


end.
