{
  Lua4Lazarus

    StringsObject

    License: New BSD
      Copyright(c)2010- Malcome@Japan All rights reserved.

}
unit l4l_strings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, lua54, l4l_object;

type

  { TLuaStringsObject }

  TLuaStringsObject = class(TLuaObject)
  private
    FStrings: TStringList;
    function GetCommaText: string;
    function GetCount: Integer;
    function GetText: string;
    procedure SetCommaText(const AValue: string);
    procedure SetText(const AValue: string);
  protected
    function Iterator(index: Integer): Integer; override;
  public
    property Strings: TStringList read FStrings;
    constructor Create(L : Plua_State); override;
    destructor Destroy; override;
  published
    function l4l_Add: Integer;
    function l4l_Insert: Integer;
    function l4l_Delete: Integer;
    function l4l_Clear: Integer;
    function l4l_IndexOf: Integer;
    function l4l_Sort: Integer;
    function l4l_SaveToFile: Integer;
    function l4l_LoadFromFile: Integer;
    function l4l_Strings: Integer;
    property l4l_Count: integer read GetCount;
    property l4l_Text: string read GetText write SetText;
    property l4l_CommaText: string read GetCommaText write SetCommaText;
  end;

  function CreateStringsObject(L : Plua_State) : Integer; cdecl;

implementation

{ TLuaStringsObject }

function TLuaStringsObject.GetText: string;
begin
  Result := FStrings.Text;
end;

function TLuaStringsObject.GetCommaText: string;
begin
  Result := FStrings.CommaText;
end;

function TLuaStringsObject.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

procedure TLuaStringsObject.SetCommaText(const AValue: string);
begin
  FStrings.CommaText:=AValue;
end;

procedure TLuaStringsObject.SetText(const AValue: string);
begin
  FStrings.Text:=AValue;
end;

function TLuaStringsObject.Iterator(index: Integer): Integer;
begin
  try
    lua_pushstring(LS, PChar(FStrings[index]));
  except
    lua_pushnil(LS);
  end;
  Result:=1;
end;

constructor TLuaStringsObject.Create(L: Plua_State);
begin
  inherited Create(L);
  FStrings:= TStringList.Create;
end;

destructor TLuaStringsObject.Destroy;
begin
  FStrings.Free;
  inherited Destroy;
end;

function TLuaStringsObject.l4l_Add: Integer;
begin
  lua_pushinteger(LS, FStrings.Add(lua_tostring(LS, 1)));
  Result:=1;
end;

function TLuaStringsObject.l4l_Insert: Integer;
begin
  FStrings.Insert(lua_tointeger(LS, 1), lua_tostring(LS, 2));
  Result := 0;
end;

function TLuaStringsObject.l4l_Delete: Integer;
begin
  FStrings.Delete(lua_tointeger(LS, 1));
  Result := 0;
end;

function TLuaStringsObject.l4l_Clear: Integer;
begin
  FStrings.Clear;
  Result := 0;
end;

function TLuaStringsObject.l4l_IndexOf: Integer;
begin
  lua_pushinteger(LS, FStrings.IndexOf(lua_tostring(LS, 1)));
  Result:=1;
end;

function TLuaStringsObject.l4l_Sort: Integer;
begin
  FStrings.Sort;
  Result := 0;
end;

function TLuaStringsObject.l4l_SaveToFile: Integer;
begin
  FStrings.SaveToFile(lua_tostring(LS, 1));
  Result := 0;
end;

function TLuaStringsObject.l4l_LoadFromFile: Integer;
begin
  FStrings.LoadFromFile(lua_tostring(LS, 1));
  Result := 0;
end;

function TLuaStringsObject.l4l_Strings: Integer;
begin
  lua_pushstring(LS, PChar(FStrings[lua_tointeger(LS, 1)]));
  Result:=1;
end;

function CreateStringsObject(L : Plua_State) : Integer; cdecl;
begin
  l4l_PushLuaObject(TLuaStringsObject.Create(L));
  Result := 1;
end;

end.

