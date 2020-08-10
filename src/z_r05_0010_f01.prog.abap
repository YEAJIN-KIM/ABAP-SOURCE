*&---------------------------------------------------------------------*
*& Include          Z_R05_0010_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form CHANGE_SALES_PERSON
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CHANGE_SALES_PERSON .

*< DATA 선언 >
*FUNCTION에 들어가 RETURN TYPE 확인 = STRUCTURE
*따라서 TABLE로 선언

  DATA: LT_RETURN TYPE TABLE OF BAPIRET2,
             LS_RETURN TYPE BAPIRET2,
             LS_HEADER TYPE BAPIMEPOHEADER, "HEADER TYPE 확인 = STRUCTURE
             LS_HEADERX TYPE BAPIMEPOHEADERX.

             LS_HEADER-SALES_PERS = P_VERKF. "HEADER의 SALES_PERS = P_VERKF
             LS_HEADERX-SALES_PERS = 'X'.

*< FUNCTION 호출 >
*SE37 BAPI FUNCTION 에서 찾아보고 호출 하자 !
  CALL FUNCTION 'BAPI_PO_CHANGE'
    EXPORTING "구매 번호 입력 후 바꾸고 싶은 항목 선택해 입력하면 됨
      PURCHASEORDER                = P_EBELN
      POHEADER                     = LS_HEADER "POHEADER 확인 (SALES PERSON 내역 존재 )
      POHEADERX                    = LS_HEADERX

*BAPI 항목 중 뒤에 X 가 오는 경우
*예를 들어  POHEADERX의 TYPE = CHAR
*X의 의미는 변경하고 싶은 것 들 중  X라고 표기된 필드만 바꿔준다는 의미
*X 표기가  안되어 있을 경우 공백으로 처리
*즉, X가 있으면 반드시 입력을 같이 해줘야 처리가 됨
*예를 들어 POHEADER에 입력하더라도 POHEADERX항목 미입력시 값이 처리되지 않음

   TABLES
     RETURN                       = LT_RETURN. "필수

*아직 값이 처리 되지 않음  = COMMIT 필요

  READ TABLE LT_RETURN INTO LS_RETURN WITH KEY TYPE = 'E'.

  IF SY-SUBRC NE 0. "디버깅 시  값 수행 X  = SY-SUBRC 는 4 반환  = 따라서 NE 사용
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' "COMMIT FUNCTION
        EXPORTING
            WAIT = 'X'. "작업간 연계 필요한 경우 WAIT 옵션 필요
*        IMPORTING
*             RETURN = "ERROR 시 사용 = COMMIT 시 발생 에러 확인

  ENDIF.

*EKKO이름이 변경 되었는지 확인
*< SE11 > EKKO - ERNAM - ID 입력 후 확인 ~!
*ME23N 에서 확인하자 ~ !

ENDFORM.
