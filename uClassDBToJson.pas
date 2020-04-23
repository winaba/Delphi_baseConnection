unit uClassDBToJson;

interface

uses
  Data.DB, DBXJSon, System.JSON;

type
  TBaseDBToJson = class
  private
  public
    function convert(SqlDs : TDataSet) : String;

  end;

implementation

{ TBaseDBToJson }

function TBaseDBToJson.convert(SqlDs: TDataSet): String;
  var
    ArrayJSon:TJSONArray;
    ObjJSon:TJSONObject;
    strJSon:TJSONString;
    intJSon:TJSONNumber;
    TrueJSon:TJSONTrue;
    FalseJSon:TJSONFalse;
    I: Integer;
    pField:TField;
begin
  ArrayJSon:=TJSONArray.Create;
  try
    SqlDs.First;
    while not SqlDs.Eof do
    begin
      ObjJSon:=TJSONObject.Create;
      for pField in SqlDs.Fields do
        case pField.DataType of
          ftString:
            begin
              strJSon:=TJSONString.Create(pField.AsString);
              ObjJSon.AddPair(pField.FieldName,strJSon);
            end;
          ftInteger:
            begin
              IntJSon:=TJSONNumber.Create(pField.AsInteger);
              ObjJSon.AddPair(pField.FieldName,IntJSon);
            end;
        else //casos gerais são tratados como string
        begin
          strJSon:=TJSONString.Create(pField.AsString);
          ObjJSon.AddPair(pField.FieldName,strJSon);
        end;
      end;
      ArrayJSon.AddElement(ObjJSon);
      SqlDs.next;
    end;

    result:=ArrayJSon.ToString;
  finally
    ArrayJSon.Free;
  end;
end;

end.
