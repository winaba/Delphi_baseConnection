unit uClassDBConnection;

interface

uses
  Data.SqlExpr, Data.DBXFirebird, uClassWorkIni;

type

  TBaseDBConnection = class

  private

    sqlConn : TSQLConnection;
    FConnected: boolean;
    FConnection: TSQLConnection;

    procedure SetConnected(const Value: boolean);
    constructor Create;
    procedure SetConnection(const Value: TSQLConnection);

  public

    destructor Destroy;
    property Connected : boolean read FConnected write SetConnected;
    class function getInstance : TBaseDBConnection;
    property Connection : TSQLConnection read FConnection write SetConnection;

  end;

implementation

uses
  System.SysUtils;

Var
  FInstance : TBaseDBConnection;

{ TBaseDBConnection }

constructor TBaseDBConnection.Create;
  var
    ini : TBaseWorkIni;
begin

  sqlConn := TSQLConnection.Create(nil);

  ini := TBaseWorkIni.create;

  with sqlConn do
  begin
    ConnectionName := 'FBConnection';
    DriverName := 'Firebird';
    LibraryName := 'dbxfb.dll';
    GetDriverFunc := 'getSQLDriverINTERBASE';
    VendorLib := 'fbclient.dll';
    Params.Values['SQLDialect'] := '3';
    Params.Values['Database'] := ini.path;
    Params.Values['User_Name'] := ini.username;
    Params.Values['Password'] := ini.password;;
    LoginPrompt := False;
    Connected := true;
  end;

  SetConnected(sqlConn.Connected);
  SetConnection(sqlConn);
end;

destructor TBaseDBConnection.Destroy;
begin
  FreeAndNil(sqlConn);
end;

class function TBaseDBConnection.getInstance: TBaseDBConnection;
begin
  if FInstance = Nil then
    FInstance := TBaseDBConnection.Create;

  result := FInstance;
end;

procedure TBaseDBConnection.SetConnected(const Value: boolean);
begin
  FConnected := Value;
end;

procedure TBaseDBConnection.SetConnection(const Value: TSQLConnection);
begin
  FConnection := Value;
end;

end.
