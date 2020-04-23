# Delphi_baseConnection

Class usage example:
 
```uses uClassDBDataSet;

var
  conn : TBaseDBDataSet;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  conn := TBaseDBDataSet.Create;

  conn.CommandText :=   'Select * from DOMAIN_TABLES';

  conn.Activated := true;

  dbGridBase.DataSource := conn.DataSource;
end;

```
