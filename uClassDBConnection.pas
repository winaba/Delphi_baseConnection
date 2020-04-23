unit uClassDBConnection;

interface

uses
  Data.SqlExpr, Data.DBXFirebird;

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
begin
  sqlConn := TSQLConnection.Create(nil);

//  sqlConn := dmBase.SQLConnection1;

  with sqlConn do
  begin
    ConnectionName := 'FBConnection';
    DriverName := 'Firebird';
    LibraryName := 'dbxfb.dll';
    GetDriverFunc := 'getSQLDriverINTERBASE';
    VendorLib := 'fbclient.dll';
    Params.Values['SQLDialect'] := '3';
    Params.Values['Database'] := 'E:\projetos\delphi\basePOO\base\base.fdb';
    Params.Values['User_Name'] := 'SYSDBA';
    Params.Values['Password'] := 'masterkey';
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
