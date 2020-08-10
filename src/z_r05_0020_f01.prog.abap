*&---------------------------------------------------------------------*
*& Include          Z_R05_0020_F01
*&---------------------------------------------------------------------*


FORM SET_ALV_0100.

IF GO_CONT IS INITIAL.

*INSTANCE 생성
   PERFORM CREATE_OBJECT.

*출력 필드 생성
   PERFORM MAKE_CATALOG.

*LAYOUT 세팅
   PERFORM SET_LAYOUT.

*ENENT 세팅
   PERFORM SET_EVENT.


*ALV 호출
  PERFORM DISPLY_ALV.

ELSE.
   PERFORM REFRESH_DATA.

ENDIF.

ENDFORM.


FORM CREATE_OBJECT.

  "CONTAINER 생성
   CREATE OBJECT GO_CONT
     EXPORTING
       CONTAINER_NAME              = 'CC1'.


   CREATE OBJECT GO_ALV
     EXPORTING
       I_PARENT          = GO_CONT.


ENDFORM.

FORM MAKE_CATALOG.

           CLEAR GS_FCAT.
           CLEAR GT_FCAT.

           GS_FCAT-FIELDNAME = 'STATUS'.
           GS_FCAT-COLTEXT = '상태'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'EBELN'.
           GS_FCAT-COLTEXT = '구매 오더'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'BUKRS'.
           GS_FCAT-COLTEXT = '회사 코드'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'BSART'.
           GS_FCAT-COLTEXT = '문서 유형'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'ERNAM'.
          GS_FCAT-COLTEXT = '생성자'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'LIFNR'.
          GS_FCAT-COLTEXT = '공급 업체 '.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'ZTERM'.
          GS_FCAT-COLTEXT = '지급 조건'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'VERKF'.
          GS_FCAT-COLTEXT = '담당자'.
          GS_FCAT-EDIT = 'X'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'TELF1'.
          GS_FCAT-COLTEXT = '연락처'.
          GS_FCAT-EDIT = 'X'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'RESULT'.
          GS_FCAT-COLTEXT = '처리 결과'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_LAYOUT .

              CLEAR GS_LAYOUT.
              GS_LAYOUT-ZEBRA = 'X'.
              GS_LAYOUT-CWIDTH_OPT = 'A'.
              GS_LAYOUT-SEL_MODE = 'D'. "D의 의미"
              GS_LAYOUT-NO_ROWINS = 'X'. "ROW 추가 삭제 아이콘 삭제

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLY_ALV .
            "CTRL + F6 / CALL_METHOD 클릭.
            " 인스턴스  : G_GRID / 클래스 : Cl_GUI_ALV_GRID. / METHOD : set_table_for_first_display/
            CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
            EXPORTING
                  IS_LAYOUT = GS_LAYOUT

            CHANGING
                   IT_OUTTAB = GT_DISP
                   IT_FIELDCATALOG = GT_FCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .

      CLEAR GS_DISP.
      SELECT EBELN, BUKRS, BSART, ERNAM, LIFNR ,ZTERM ,VERKF ,TELF1
            INTO CORRESPONDING FIELDS OF TABLE @GT_DISP
            FROM EKKO
            WHERE EBELN IN @EBELN
                  AND BUKRS IN @BUKRS
                  AND BSART IN @BSART
                  AND BSTYP = 'F' "DOC CATEGORY가 구매 오더 인것만 조회
                  AND LOEKZ = ''. "삭제 처리가 되지 않은 구매 오더만 조회

        SORT GT_DISP BY EBELN.

*<필드명 강제 매칭 >
* '@5@' ICON FIELD 에서 ICON_LED_GREEN을 의미
* SELECT 에서 초록 불에 AS STATUS를 해 필드명을 부여
*      CLEAR GS_DISP.
*      SELECT '@5B@' AS STATUS, EBELN, BUKRS, BSART, ERNAM, LIFNR ,ZTERM ,VERKF ,TELF1
*            INTO CORRESPONDING FIELDS OF TABLE @GT_DISP
*            FROM EKKO
*            WHERE EBELN IN @EBELN
*                  AND BUKRS IN @BUKRS
*                  AND BSART IN @BSART
*                  AND BSTYP = 'F'
*                  AND LOEKZ = ''.

*< 01 신호등  >
*        LOOP AT GT_DISP INTO GS_DISP.
*                GS_DISP-STATUS = ICON_LED_GREEN.
*                MODIFY GT_DISP FROM GS_DISP.
*        ENDLOOP.

*< 02 신호등 >
        GS_DISP-STATUS = ICON_LED_GREEN.
        MODIFY GT_DISP FROM GS_DISP TRANSPORTING STATUS
                        WHERE STATUS <> ICON_LED_GREEN.





ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_DATA .
            CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY
*              EXPORTING
*                IS_STABLE      =
*                I_SOFT_REFRESH =
*              EXCEPTIONS
*                FINISHED       = 1
*                OTHERS         = 2
                    .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SAVE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SAVE_DATA .


  DATA: LT_RETURN TYPE TABLE OF BAPIRET2,
             LS_RETURN TYPE BAPIRET2,
             LS_HEADER TYPE BAPIMEPOHEADER, "HEADER TYPE 확인 = STRUCTURE
             LS_HEADERX TYPE BAPIMEPOHEADERX.

   CALL METHOD GO_ALV->CHECK_CHANGED_DATA. "DATA 변화를 확인하는 로직

*USER_COMMAND를 타기 때문에 PBO를 거침
*따라서 CHECK_CHANGED_DATA 를 사용해 데이터 변화에 따른인터널 테이블과 ALV를 동기화할 필요가 X
*PBO에서 작업을 통해  ALV에 반영이 되기 때문 = INTERNAL TABLE만 작업하자

*< 변경 DATA 유 무 체크 >
    READ TABLE GT_DISP INTO GS_DISP
            WITH KEY STATUS = ICON_LED_YELLOW.

    IF SY-SUBRC NE 0.
        MESSAGE S006. "NO DATA CHANGED
        EXIT.
     ENDIF.

*< USER CONFIRM >
      PERFORM USER_CONFIRM USING TEXT-Q01
                        TEXT-Q02 CHANGING LV_ANSWER.
      CHECK LV_ANSWER EQ '1'.


    LOOP AT GT_DISP INTO GS_DISP WHERE STATUS
               EQ ICON_LED_YELLOW.

      CLEAR: LS_HEADER, LS_HEADERX.

*< 구매 담당자 > *< 전화 번호 >
       LS_HEADER-SALES_PERS = GS_DISP-VERKF. "BAPI_CHANGE HEADER TYPE  > SALES PERSON
       LS_HEADER-TELEPHONE = GS_DISP-TELF1.  "BAPI_CHANGE HEADER TYPE  > TELEPHONE
       LS_HEADERX-SALES_PERS = 'X'.
       LS_HEADERX-TELEPHONE = 'X'.


*< BAPI DATA 수행  >
    CLEAR LT_RETURN.

    CALL FUNCTION 'BAPI_PO_CHANGE'
      EXPORTING
        PURCHASEORDER                = GS_DISP-EBELN
        POHEADER                     = LS_HEADER
        POHEADERX                    = LS_HEADERX

     TABLES
       RETURN                       = LT_RETURN.


*< 성공 / 실패에 따른 결과를 ALV에 적용 >
    READ TABLE LT_RETURN INTO LS_RETURN
               WITH KEY TYPE = 'E'.

    IF SY-SUBRC = 0. "실패

        CALL FUNCTION  'BAPI_TRANSACTION_ROLLBACK'.
          GS_DISP-STATUS = ICON_LED_RED.

        CLEAR GS_DISP-RESULT.
        LOOP AT LT_RETURN INTO LS_RETURN WHERE TYPE = 'E'.
          IF GS_DISP-RESULT IS INITIAL.
              GS_DISP-RESULT =  LS_RETURN-MESSAGE.
           ELSE.
              CONCATENATE GS_DISP-RESULT LS_RETURN-MESSAGE
                  INTO GS_DISP-RESULT
                  SEPARATED BY'#'.  "두개를 CONCATENATE했지만 구분자 #으로 나누어 취합하곘다.
          ENDIF.
        ENDLOOP.

    ELSE. "성공

         CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
              EXPORTING
                  WAIT = 'X'.

               GS_DISP-STATUS = ICON_LED_GREEN.
               GS_DISP-RESULT =''.
     ENDIF.

          MODIFY GT_DISP FROM GS_DISP.

   ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_DATA_CHNGED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_ER_DATA_CHANGED  text
*&---------------------------------------------------------------------*

*단순한 CHAR과 같은 타입으로 정해진 것이아니라면 PARAMETER를 가지고 올때는 형식에 맞게 선언을 꼭 해주어야한다.
FORM HANDLE_DATA_CHNGED  USING   PO_DATA_CHANGED
                TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

*디버깅을 활용해서 PO_DATA_CHANGED가 가지고 있는 값을 보면 이전에 했던 것과 마찬가지로 MT_GOOD_CELLS를 가지고 있음.
*이것이 셀의 값이 변경된 것을 가지고 있기 때문에 이를 활용.

*내가 무엇이 필요할까? 에 대해 생각해보니 MT_GOOD_CELLS의 ROW_ID를 알면 되곘다는  판단.

           DATA: LS_CHANGED TYPE LVC_S_MODI.
           DATA: LT_CHANGED TYPE LVC_T_MODI.

            LT_CHANGED = PO_DATA_CHANGED->MT_GOOD_CELLS.

            SORT LT_CHANGED BY ROW_ID.

            LOOP AT LT_CHANGED INTO LS_CHANGED.

*              AT FIRST.
*
*                 ENDAT.

             AT NEW ROW_ID.
               CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
                  EXPORTING
                    I_ROW_ID = LS_CHANGED-ROW_ID
                    I_FIELDNAME = 'STATUS'
                    I_VALUE = ICON_LED_YELLOW. "변경된 DATA 에 대해 YELLOW

                 ENDAT.

*             AT END OF ROW_ID.
*
*                 ENDAT.
*
*             AT LAST.
*
*                 ENDAT.

           ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_EVENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_EVENT .

          CREATE OBJECT GO_EVENT_RECEIVER.

          SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED FOR GO_ALV.

*이벤트를 받아들이는 부분.
*인스턴스  : G_GRID / 클래스 : Cl_GUI_ALV_GRID. / METHOD : Rregister_edit_event
"MC_EVT_MIDIFIED는 내가 엔터를 눌렀을 때 ALV에서 이벤트를 인식하고 MODIFY를 수행하는 CL_GUI_ALV_GRID의 Attribute.

          CALL METHOD GO_ALV->REGISTER_EDIT_EVENT "ALV 이벤트 변경을 받아가는 메소드 선언.
            EXPORTING
              I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.
*             I_EVENT_ID = GO_ALV->MC_EVT_MODIFIED.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form USER_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_TEXT_Q01  text
*      -->P_TEXT_Q02  text
*      <--P_LV_ANSWER  text
*&---------------------------------------------------------------------*
FORM USER_CONFIRM  USING    P_TITLE P_QUEST
           CHANGING P_ANSWER.

           CLEAR: P_ANSWER.

           CALL FUNCTION 'POPUP_TO_CONFIRM'
               EXPORTING
                 TITLEBAR      = P_TITLE
                 TEXT_QUESTION = P_QUEST
                 TEXT_BUTTON_1 = 'YES'
                 TEXT_BUTTON_2 = 'NO'
               IMPORTING
                 ANSWER        = P_ANSWER.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form EXIT_0010
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM EXIT_0010 .

  LOOP AT GT_DISP INTO GS_DISP WHERE STATUS
    EQ ICON_LED_YELLOW OR STATUS EQ ICON_LED_RED.

    EXIT.
  ENDLOOP.
     IF SY-SUBRC = 0."일단 조건에 걸리면( 데이터 변경을 통해 노란불이나 빨간불을 확인했다면 0 /
*                   아니면 (변경된 것이 없을때) 0을 내보내지 않음. )

      PERFORM USER_CONFIRM USING TEXT-Q03
                        TEXT-Q04 CHANGING LV_ANSWER.
      CHECK LV_ANSWER EQ '1'.
          LEAVE TO SCREEN 0.
     ENDIF.

ENDFORM.
