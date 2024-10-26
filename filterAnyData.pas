procedure filterAnyData(optFltr: string; DataSet: Tdataset;
  fieldNames: array of string; Value: string);
var
  filterstr: string;
begin
  try
    if (Length(fieldNames) > 0) and (trim(Value) <> '') then
    begin
      var
        i: integer;
      for i := 0 to Length(fieldNames) - 1 do
      begin
        if i = 0 then
          filterstr := '(Upper(' + (fieldNames[i]) + ') like ' +
            quotedstr('%' + UpperCase(Value) + '%') + ')'
        else
          filterstr := filterstr + ' or (Upper(' + (fieldNames[i]) + ') like ' +
            quotedstr('%' + UpperCase(Value) + '%') + ')'
      end;
    end;
    if optFltr <> '' then
    begin
      DataSet.Filtered := False;
      DataSet.Filter := '(' + filterstr + ')' + ' and (' + optFltr + ')';
      if trim(filterstr) <> '' then
        DataSet.Filtered := True;
    end
    else
    begin
      DataSet.Filtered := False;
      DataSet.Filter := filterstr;
      if trim(filterstr) <> '' then
        DataSet.Filtered := True;
    end;
  except
    on e: exception do
      showmessage('[#filterAnyData ]' + e.message)
  end;
end;
