unit uClassWorkIni;

interface

uses IniFiles;

type
  TBaseWorkIni = class

    private
    ArqIni: TIniFile;
    Fpath: string;
    Fusername: string;
    Fpassword: string;
    FdriverName: string;
    pathIni : String;
    procedure Setpath(const Value: string);
    procedure Setusername(const Value: string);
    procedure Setpassword(const Value: string);
    procedure SetdriverName(const Value: string);

    public
    constructor create(path : string='');
    property path : string read Fpath write Setpath;
    property driverName : string read FdriverName write SetdriverName;
    property username : string read Fusername write Setusername;
    property password : string  read Fpassword write Setpassword;

  end;

implementation

uses
  System.SysUtils;

{ TBaseWorkIni }

constructor TBaseWorkIni.create(path: string);
  procedure createDefault;
  begin
    ArqIni.WriteString('DATABASE', 'Path', 'E:\projetos\delphi\basePOO\base\base.fdb');
    ArqIni.WriteString('DATABASE', 'DriverName', 'Firebird');
    ArqIni.WriteString('DATABASE', 'Username', 'SYSDBA');
    ArqIni.WriteString('DATABASE', 'Password', 'masterkey');
  end;
begin

  pathIni := ExtractFileDir(GetCurrentDir) + '\conf.ini';

  ArqIni := TIniFile.Create(pathIni);

  if not FileExists(pathIni) then
    createDefault;

  Setpath(ArqIni.ReadString('DATABASE','Path','E:\projetos\delphi\basePOO\base\base.fdb'));
  Setusername(ArqIni.ReadString('DATABASE', 'Username', 'SYSDBA'));
  Setpassword(ArqIni.ReadString('DATABASE', 'Password', 'masterkey'));
  SetdriverName(ArqIni.ReadString('DATABASE', 'DriverName', 'Firebird'));
end;

procedure TBaseWorkIni.SetdriverName(const Value: string);
begin
  FdriverName := Value;
end;

procedure TBaseWorkIni.Setpassword(const Value: string);
begin
  Fpassword := Value;
end;

procedure TBaseWorkIni.Setpath(const Value: string);
begin
  Fpath := Value;
end;

procedure TBaseWorkIni.Setusername(const Value: string);
begin
  Fusername := Value;
end;

end.
