unit AboutTheProgramUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  TAboutTheProgramForm = class(TForm)
    Panel1: TPanel;
    PZLabel: TLabel;
    GLLabel: TLabel;
    GSLabel: TLabel;
    lEmailGA: TLabel;
    lEmailGS: TLabel;
    GAImage: TImage;
    GSImage: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TAboutTheProgramForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAboutTheProgramForm.FormCreate(Sender: TObject);
begin
  Width := 509;
  Height := 327;
end;

end.
