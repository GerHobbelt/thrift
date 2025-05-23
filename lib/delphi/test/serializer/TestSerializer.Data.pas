(*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *)

unit TestSerializer.Data;

interface

uses
  SysUtils,
  ActiveX,
  ComObj,
  Thrift.Protocol,
  Thrift.Collections,
  test.ExceptionStruct,
  test.SimpleException,
  DebugProtoTest;


type
  Fixtures = class
  public
    class function CreateOneOfEach : IOneOfEach;
    class function CreateNesting : INesting;
    class function CreateHolyMoley : IHolyMoley;
    class function CreateCompactProtoTestStruct : ICompactProtoTestStruct;
    class function CreateBatchGetResponse : IBatchGetResponse;
    class function CreateSimpleException : IError;

  // These byte arrays are serialized versions of the above structs.
  // They were serialized in binary protocol using thrift 0.6.x and are used to
  // test backwards compatibility with respect to the standard scheme.
  (*
          all data copied from JAVA version,
          to be used later

  public static final byte[] persistentBytesOneOfEach = new byte[] {
    $02, $00, $01, $01, $02, $00, $02, $00, $03, $00,
    $03, $D6, $06, $00, $04, $69, $78, $08, $00, $05,
    $01, $00, $00, $00, $0A, $00, $06, $00, $00, $00,
    $01, $65, $A0, $BC, $00, $04, $00, $07, $40, $09,
    $21, $FB, $54, $44, $2D, $18, $0B, $00, $08, $00,
    $00, $00, $0D, $4A, $53, $4F, $4E, $20, $54, $48,
    $49, $53, $21, $20, $22, $01, $0B, $00, $09, $00,
    $00, $00, $2E, $D3, $80, $E2, $85, $AE, $CE, $9D,
    $20, $D0, $9D, $CE, $BF, $E2, $85, $BF, $D0, $BE,
    $C9, $A1, $D0, $B3, $D0, $B0, $CF, $81, $E2, $84,
    $8E, $20, $CE, $91, $74, $74, $CE, $B1, $E2, $85,
    $BD, $CE, $BA, $EF, $BF, $BD, $E2, $80, $BC, $02,
    $00, $0A, $00, $0B, $00, $0B, $00, $00, $00, $06,
    $62, $61, $73, $65, $36, $34, $0F, $00, $0C, $03,
    $00, $00, $00, $03, $01, $02, $03, $0F, $00, $0D,
    $06, $00, $00, $00, $03, $00, $01, $00, $02, $00,
    $03, $0F, $00, $0E, $0A, $00, $00, $00, $03, $00,
    $00, $00, $00, $00, $00, $00, $01, $00, $00, $00,
    $00, $00, $00, $00, $02, $00, $00, $00, $00, $00,
    $00, $00, $03, $00 };


  public static final byte[] persistentBytesNesting = new byte[] {
    $0C, $00, $01, $08, $00, $01, $00, $00, $7A, $69,
    $0B, $00, $02, $00, $00, $00, $13, $49, $20, $61,
    $6D, $20, $61, $20, $62, $6F, $6E, $6B, $2E, $2E,
    $2E, $20, $78, $6F, $72, $21, $00, $0C, $00, $02,
    $02, $00, $01, $01, $02, $00, $02, $00, $03, $00,
    $03, $D6, $06, $00, $04, $69, $78, $08, $00, $05,
    $01, $00, $00, $00, $0A, $00, $06, $00, $00, $00,
    $01, $65, $A0, $BC, $00, $04, $00, $07, $40, $09,
    $21, $FB, $54, $44, $2D, $18, $0B, $00, $08, $00,
    $00, $00, $0D, $4A, $53, $4F, $4E, $20, $54, $48,
    $49, $53, $21, $20, $22, $01, $0B, $00, $09, $00,
    $00, $00, $2E, $D3, $80, $E2, $85, $AE, $CE, $9D,
    $20, $D0, $9D, $CE, $BF, $E2, $85, $BF, $D0, $BE,
    $C9, $A1, $D0, $B3, $D0, $B0, $CF, $81, $E2, $84,
    $8E, $20, $CE, $91, $74, $74, $CE, $B1, $E2, $85,
    $BD, $CE, $BA, $EF, $BF, $BD, $E2, $80, $BC, $02,
    $00, $0A, $00, $0B, $00, $0B, $00, $00, $00, $06,
    $62, $61, $73, $65, $36, $34, $0F, $00, $0C, $03,
    $00, $00, $00, $03, $01, $02, $03, $0F, $00, $0D,
    $06, $00, $00, $00, $03, $00, $01, $00, $02, $00,
    $03, $0F, $00, $0E, $0A, $00, $00, $00, $03, $00,
    $00, $00, $00, $00, $00, $00, $01, $00, $00, $00,
    $00, $00, $00, $00, $02, $00, $00, $00, $00, $00,
    $00, $00, $03, $00, $00 };

  public static final byte[] persistentBytesHolyMoley = new byte[] {
    $0F, $00, $01, $0C, $00, $00, $00, $02, $02, $00,
    $01, $01, $02, $00, $02, $00, $03, $00, $03, $23,
    $06, $00, $04, $69, $78, $08, $00, $05, $01, $00,
    $00, $00, $0A, $00, $06, $00, $00, $00, $01, $65,
    $A0, $BC, $00, $04, $00, $07, $40, $09, $21, $FB,
    $54, $44, $2D, $18, $0B, $00, $08, $00, $00, $00,
    $0D, $4A, $53, $4F, $4E, $20, $54, $48, $49, $53,
    $21, $20, $22, $01, $0B, $00, $09, $00, $00, $00,
    $2E, $D3, $80, $E2, $85, $AE, $CE, $9D, $20, $D0,
    $9D, $CE, $BF, $E2, $85, $BF, $D0, $BE, $C9, $A1,
    $D0, $B3, $D0, $B0, $CF, $81, $E2, $84, $8E, $20,
    $CE, $91, $74, $74, $CE, $B1, $E2, $85, $BD, $CE,
    $BA, $EF, $BF, $BD, $E2, $80, $BC, $02, $00, $0A,
    $00, $0B, $00, $0B, $00, $00, $00, $06, $62, $61,
    $73, $65, $36, $34, $0F, $00, $0C, $03, $00, $00,
    $00, $03, $01, $02, $03, $0F, $00, $0D, $06, $00,
    $00, $00, $03, $00, $01, $00, $02, $00, $03, $0F,
    $00, $0E, $0A, $00, $00, $00, $03, $00, $00, $00,
    $00, $00, $00, $00, $01, $00, $00, $00, $00, $00,
    $00, $00, $02, $00, $00, $00, $00, $00, $00, $00,
    $03, $00, $02, $00, $01, $01, $02, $00, $02, $00,
    $03, $00, $03, $D6, $06, $00, $04, $69, $78, $08,
    $00, $05, $01, $00, $00, $00, $0A, $00, $06, $00,
    $00, $00, $01, $65, $A0, $BC, $00, $04, $00, $07,
    $40, $09, $21, $FB, $54, $44, $2D, $18, $0B, $00,
    $08, $00, $00, $00, $0D, $4A, $53, $4F, $4E, $20,
    $54, $48, $49, $53, $21, $20, $22, $01, $0B, $00,
    $09, $00, $00, $00, $2E, $D3, $80, $E2, $85, $AE,
    $CE, $9D, $20, $D0, $9D, $CE, $BF, $E2, $85, $BF,
    $D0, $BE, $C9, $A1, $D0, $B3, $D0, $B0, $CF, $81,
    $E2, $84, $8E, $20, $CE, $91, $74, $74, $CE, $B1,
    $E2, $85, $BD, $CE, $BA, $EF, $BF, $BD, $E2, $80,
    $BC, $02, $00, $0A, $00, $0B, $00, $0B, $00, $00,
    $00, $06, $62, $61, $73, $65, $36, $34, $0F, $00,
    $0C, $03, $00, $00, $00, $03, $01, $02, $03, $0F,
    $00, $0D, $06, $00, $00, $00, $03, $00, $01, $00,
    $02, $00, $03, $0F, $00, $0E, $0A, $00, $00, $00,
    $03, $00, $00, $00, $00, $00, $00, $00, $01, $00,
    $00, $00, $00, $00, $00, $00, $02, $00, $00, $00,
    $00, $00, $00, $00, $03, $00, $0E, $00, $02, $0F,
    $00, $00, $00, $03, $0B, $00, $00, $00, $00, $0B,
    $00, $00, $00, $03, $00, $00, $00, $0F, $74, $68,
    $65, $6E, $20, $61, $20, $6F, $6E, $65, $2C, $20,
    $74, $77, $6F, $00, $00, $00, $06, $74, $68, $72,
    $65, $65, $21, $00, $00, $00, $06, $46, $4F, $55,
    $52, $21, $21, $0B, $00, $00, $00, $02, $00, $00,
    $00, $09, $61, $6E, $64, $20, $61, $20, $6F, $6E,
    $65, $00, $00, $00, $09, $61, $6E, $64, $20, $61,
    $20, $74, $77, $6F, $0D, $00, $03, $0B, $0F, $00,
    $00, $00, $03, $00, $00, $00, $03, $74, $77, $6F,
    $0C, $00, $00, $00, $02, $08, $00, $01, $00, $00,
    $00, $01, $0B, $00, $02, $00, $00, $00, $05, $57,
    $61, $69, $74, $2E, $00, $08, $00, $01, $00, $00,
    $00, $02, $0B, $00, $02, $00, $00, $00, $05, $57,
    $68, $61, $74, $3F, $00, $00, $00, $00, $05, $74,
    $68, $72, $65, $65, $0C, $00, $00, $00, $00, $00,
    $00, $00, $04, $7A, $65, $72, $6F, $0C, $00, $00,
    $00, $00, $00 };


*)

  private
    const
      kUnicodeBytes : packed array[0..43] of Byte
                    = ( $d3, $80, $e2, $85, $ae, $ce, $9d, $20, $d0, $9d,
                        $ce, $bf, $e2, $85, $bf, $d0, $be, $c9, $a1, $d0,
                        $b3, $d0, $b0, $cf, $81, $e2, $84, $8e, $20, $ce,
                        $91, $74, $74, $ce, $b1, $e2, $85, $bd, $ce, $ba,
                        $83, $e2, $80, $bc);

  end;


implementation


class function Fixtures.CreateOneOfEach : IOneOfEach;
var db : Double;
    us : Utf8String;
begin
  result := TOneOfEachImpl.Create;
  result.setIm_true( TRUE);
  result.setIm_false( FALSE);
  result.setA_bite( ShortInt($D6));
  result.setInteger16( 27000);
  result.setInteger32( 1 shl 24);
  result.setInteger64( Int64(6000) * Int64(1000) * Int64(1000));
  db := Pi;
  result.setDouble_precision( db);
  result.setSome_characters( 'JSON THIS! \"\1');

  // ??
  SetLength( us, Length(kUnicodeBytes));
  Move( kUnicodeBytes[0], us[1], Length(kUnicodeBytes));
  // ??
  SetString( us, PChar(@kUnicodeBytes[0]), Length(kUnicodeBytes));
  // !!
  result.setZomg_unicode( UnicodeString( us));

  result.Rfc4122_uuid := TGuid.Create('{00112233-4455-6677-8899-aabbccddeeff}');

  {$IF cDebugProtoTest_Option_AnsiStr_Binary}
  result.SetBase64('base64');
  {$ELSEIF cDebugProtoTest_Option_COM_Types}
  result.SetBase64( TThriftBytesImpl.Create( TEncoding.UTF8.GetBytes('base64')));
  {$ELSE}
  result.SetBase64( TEncoding.UTF8.GetBytes('base64'));
  {$IFEND}

  // byte, i16, and i64 lists are populated by default constructor
end;


class function Fixtures.CreateNesting : INesting;
var bonk : IBonk;
begin
  bonk := TBonkImpl.Create;
  bonk.&Type   := 31337;
  bonk.Message := 'I am a bonk... xor!';

  result := TNestingImpl.Create;
  result.My_bonk := bonk;
  result.My_ooe := CreateOneOfEach;
end;


class function Fixtures.CreateHolyMoley : IHolyMoley;
type
  TStringType = {$IF cDebugProtoTest_Option_COM_Types} WideString {$ELSE} String {$IFEND};
var big : IThriftList<IOneOfEach>;
    stage1 : IThriftList<TStringType>;
    stage2 : IThriftList<IBonk>;
    b      : IBonk;
begin
  result := THolyMoleyImpl.Create;

  big := TThriftListImpl<IOneOfEach>.Create;
  big.add( CreateOneOfEach);
  big.add( CreateNesting.my_ooe);
  result.Big := big;
  result.Big[0].setA_bite( $22);
  result.Big[0].setA_bite( $23);

  result.Contain := TThriftHashSetImpl< IThriftList<TStringType>>.Create;
  stage1 := TThriftListImpl<TStringType>.Create;
  stage1.add( 'and a one');
  stage1.add( 'and a two');
  result.Contain.add( stage1);

  stage1 := TThriftListImpl<TStringType>.Create;
  stage1.add( 'then a one, two');
  stage1.add( 'three!');
  stage1.add( 'FOUR!!');
  result.Contain.add( stage1);

  stage1 := TThriftListImpl<TStringType>.Create;
  result.Contain.add( stage1);

  stage2 := TThriftListImpl<IBonk>.Create;
  result.Bonks := TThriftDictionaryImpl< TStringType, IThriftList< IBonk>>.Create;
  // one empty
  result.Bonks.Add( 'zero', stage2);

  // one with two
  stage2 := TThriftListImpl<IBonk>.Create;
  b := TBonkImpl.Create;
  b.&type := 1;
  b.message := 'Wait.';
  stage2.Add( b);
  b := TBonkImpl.Create;
  b.&type := 2;
  b.message := 'What?';
  stage2.Add( b);
  result.Bonks.Add( 'two', stage2);

  // one with three
  stage2 := TThriftListImpl<IBonk>.Create;
  b := TBonkImpl.Create;
  b.&type := 3;
  b.message := 'quoth';
  stage2.Add( b);
  b := TBonkImpl.Create;
  b.&type := 4;
  b.message := 'the raven';
  stage2.Add( b);
  b := TBonkImpl.Create;
  b.&type := 5;
  b.message := 'nevermore';
  stage2.Add( b);
  result.bonks.Add( 'three', stage2);
end;


class function Fixtures.CreateCompactProtoTestStruct : ICompactProtoTestStruct;
// superhuge compact proto test struct
begin
  result := TCompactProtoTestStructImpl.Create;
  result.A_byte := DebugProtoTest.TConstants.COMPACT_TEST.A_byte;
  result.A_i16 := DebugProtoTest.TConstants.COMPACT_TEST.A_i16;
  result.A_i32 := DebugProtoTest.TConstants.COMPACT_TEST.A_i32;
  result.A_i64 := DebugProtoTest.TConstants.COMPACT_TEST.A_i64;
  result.A_double := DebugProtoTest.TConstants.COMPACT_TEST.A_double;
  result.A_string := DebugProtoTest.TConstants.COMPACT_TEST.A_string;
  result.A_binary := DebugProtoTest.TConstants.COMPACT_TEST.A_binary;
  result.True_field := DebugProtoTest.TConstants.COMPACT_TEST.True_field;
  result.False_field := DebugProtoTest.TConstants.COMPACT_TEST.False_field;
  result.Empty_struct_field := DebugProtoTest.TConstants.COMPACT_TEST.Empty_struct_field;
  result.Byte_list := DebugProtoTest.TConstants.COMPACT_TEST.Byte_list;
  result.I16_list := DebugProtoTest.TConstants.COMPACT_TEST.I16_list;
  result.I32_list := DebugProtoTest.TConstants.COMPACT_TEST.I32_list;
  result.I64_list := DebugProtoTest.TConstants.COMPACT_TEST.I64_list;
  result.Double_list := DebugProtoTest.TConstants.COMPACT_TEST.Double_list;
  result.String_list := DebugProtoTest.TConstants.COMPACT_TEST.String_list;
  result.Binary_list := DebugProtoTest.TConstants.COMPACT_TEST.Binary_list;
  result.Boolean_list := DebugProtoTest.TConstants.COMPACT_TEST.Boolean_list;
  result.Struct_list := DebugProtoTest.TConstants.COMPACT_TEST.Struct_list;
  result.Byte_set := DebugProtoTest.TConstants.COMPACT_TEST.Byte_set;
  result.I16_set := DebugProtoTest.TConstants.COMPACT_TEST.I16_set;
  result.I32_set := DebugProtoTest.TConstants.COMPACT_TEST.I32_set;
  result.I64_set := DebugProtoTest.TConstants.COMPACT_TEST.I64_set;
  result.Double_set := DebugProtoTest.TConstants.COMPACT_TEST.Double_set;
  result.String_set := DebugProtoTest.TConstants.COMPACT_TEST.String_set;
  result.String_set := DebugProtoTest.TConstants.COMPACT_TEST.String_set;
  result.String_set := DebugProtoTest.TConstants.COMPACT_TEST.String_set;
  result.Binary_set := DebugProtoTest.TConstants.COMPACT_TEST.Binary_set;
  result.Boolean_set := DebugProtoTest.TConstants.COMPACT_TEST.Boolean_set;
  result.Struct_set := DebugProtoTest.TConstants.COMPACT_TEST.Struct_set;
  result.Byte_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_byte_map;
  result.I16_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.I16_byte_map;
  result.I32_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.I32_byte_map;
  result.I64_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.I64_byte_map;
  result.Double_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.Double_byte_map;
  result.String_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.String_byte_map;
  result.Binary_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.Binary_byte_map;
  result.Boolean_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.Boolean_byte_map;
  result.Byte_i16_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_i16_map;
  result.Byte_i32_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_i32_map;
  result.Byte_i64_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_i64_map;
  result.Byte_double_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_double_map;
  result.Byte_string_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_string_map;
  result.Byte_binary_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_binary_map;
  result.Byte_boolean_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_boolean_map;
  result.List_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.List_byte_map;
  result.Set_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.Set_byte_map;
  result.Map_byte_map := DebugProtoTest.TConstants.COMPACT_TEST.Map_byte_map;
  result.Byte_map_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_map_map;
  result.Byte_set_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_set_map;
  result.Byte_list_map := DebugProtoTest.TConstants.COMPACT_TEST.Byte_list_map;

  result.Field500 := 500;
  result.Field5000 := 5000;
  result.Field20000 := 20000;

  {$IF cDebugProtoTest_Option_AnsiStr_Binary}
  result.A_binary := AnsiString( #0#1#2#3#4#5#6#7#8);
  {$ELSEIF cDebugProtoTest_Option_COM_Types}
  result.A_binary := TThriftBytesImpl.Create( TEncoding.UTF8.GetBytes( #0#1#2#3#4#5#6#7#8));
  {$ELSE}
  result.A_binary := TEncoding.UTF8.GetBytes( #0#1#2#3#4#5#6#7#8);
  {$IFEND}
end;


class function Fixtures.CreateBatchGetResponse : IBatchGetResponse;
var
  data : IGetRequest;
  error : ISomeException;
const
  REQUEST_ID = '123';
begin
  data := TGetRequestImpl.Create;
  data.Id := REQUEST_ID;
  data.Data := TThriftBytesImpl.Create( TEncoding.UTF8.GetBytes( #0#1#2#3#4#5#6#7#8));

  error := TSomeExceptionImpl.Create;
  error.Error := TErrorCode.GenericError;

  result := TBatchGetResponseImpl.Create;
  result.Responses := TThriftDictionaryImpl<WideString, IGetRequest>.Create;
  result.Responses.Add( REQUEST_ID, data);
  result.Errors := TThriftDictionaryImpl<WideString, ISomeException>.Create;
  result.Errors.Add( REQUEST_ID, error);
end;


class function Fixtures.CreateSimpleException : IError;
var i : Integer;
    inner : IError;
    guid : TGuid;
const
  IDL_GUID_VALUE : TGuid = '{00000000-4444-CCCC-ffff-0123456789ab}';
begin
  result := nil;
  for i := 0 to 4 do begin
    inner := result;
    result := TErrorImpl.Create;

    // validate const values set in IDL
    ASSERT( result.ErrorCode = 42);  // IDL default value
    ASSERT( IsEqualGUID( result.ExceptionData, IDL_GUID_VALUE));

    // set fresh, but reproducible values
    FillChar( guid, SizeOf(guid), i);
    result.ErrorCode := i;
    result.ExceptionData := guid;
    result.InnerException := inner;
  end;
end;


end.

