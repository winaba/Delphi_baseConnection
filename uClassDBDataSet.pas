unit uClassDBDataSet;

interface

uses uClassDBConnection, Data.SqlExpr, Datasnap.Provider, Datasnap.DBClient,
  Data.DB, System.Generics.Collections;

type
  TBaseDBDataSet = Class
  private
    sqlConn : TBaseDBConnection;
    sqlBase : TSQLDataSet;
    dspBase : TDataSetProvider;
    cdsBase : TClientDataSet;
    dsBase  : TDataSource;

    FCommandText: String;
    FActivated: boolean;
    FDataSource: TDataSource;
    FDictParams : TDictionary<String, String>;
    procedure SetCommandText(const Value: String);
    procedure SetActivated(const Value: boolean);
    procedure SetDataSource(const Value: TDataSource);

  public
    constructor Create;
    destructor Destroy;
    property CommandText : String read FCommandText write SetCommandText;
    property Activated : boolean read FActivated write SetActivated;
    property DataSource : TDataSource read FDataSource write SetDataSource;
    procedure ParamByName(name : string; value : variant);


  End;

implementation

uses
  System.SysUtils;

{ TBaseDBDataSet }

constructor TBaseDBDataSet.Create;
  procedure createComponents;
  begin
    sqlConn := TBaseDBConnection.getInstance;

    sqlBase := TSQLDataSet.Create(nil);

    dspBase := TDataSetProvider.Create(nil);

    cdsBase := TClientDataSet.Create(Nil);

    dsBase := TDataSource.Create(Nil);
  end;

  procedure setPropertys;
  begin
    sqlBase.SQLConnection := sqlConn.Connection;

    dspBase.DataSet := sqlBase;

    dspBase.Options := [poAllowCommandText];

    cdsBase.SetProvider(dspBase);

    dsBase.DataSet := cdsBase;

    SetDataSource(dsBase);
  end;
begin
  createComponents;
  setPropertys;
end;

destructor TBaseDBDataSet.Destroy;
begin
  FreeAndNil(sqlConn);
  FreeAndNil(sqlBase);
  FreeAndNil(dspBase);
  FreeAndNil(cdsBase);
  FreeAndNil(dsBase);
end;

procedure TBaseDBDataSet.ParamByName(name : string; value : variant);
begin
  cdsbase.ParamByName(name).Value := value;
end;

procedure TBaseDBDataSet.SetActivated(const Value: boolean);
begin
  FActivated := Value;
  cdsBase.Active := FActivated;
end;

procedure TBaseDBDataSet.SetCommandText(const Value: String);
begin
  FCommandText := Value;
  cdsBase.CommandText := FCommandText;
end;

procedure TBaseDBDataSet.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
end;

end.
