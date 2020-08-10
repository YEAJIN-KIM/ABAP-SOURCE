*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_051_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form MAKE_CATALOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM MAKE_CATALOG .
           GS_FCAT-FIELDNAME = 'EMPNO'.
           GS_FCAT-REF_FIELD = 'EMPNO'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '사원'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'NAME'.
           GS_FCAT-REF_FIELD = 'NAME'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '이름'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'DEPT'.
           GS_FCAT-REF_FIELD = 'DEPT'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '부서'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'DEPT_T'.
*           GS_FCAT-REF_FIELD = 'DEPT'.
*           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '부서설명'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'ENTDT'.
           GS_FCAT-REF_FIELD = 'ENTDT'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '입사일'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'GRADE'.
           GS_FCAT-REF_FIELD = 'GRADE'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '직급'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'GRADE_T'.
*           GS_FCAT-REF_FIELD = 'GRADE'.
*           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '직급설명'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'RETDT'.
           GS_FCAT-REF_FIELD = 'RETDT'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '퇴사일'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'STATUS'.
           GS_FCAT-REF_FIELD = 'STATUS'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '재직여부'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'STATUS_T'.
*           GS_FCAT-REF_FIELD = 'STATUS'.
*           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '재직여부설명'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'PHONE'.
           GS_FCAT-REF_FIELD = 'PHONE'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '전화번호'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'ADDR_H'.
           GS_FCAT-REF_FIELD = 'ADDR_H'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '자택주소'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'ADDR_W'.
           GS_FCAT-REF_FIELD = 'ADDR_W'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '근무지 주소'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'SALARY'.
           GS_FCAT-REF_FIELD = 'SALARY'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-CFIELDNAME = 'WAERS'.
           GS_FCAT-COLTEXT = '기본급'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SELECT_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SELECT_DATA .

           SELECT *
             FROM ZT05_0010
             INTO CORRESPONDING FIELDS OF TABLE ITAB
             WHERE EMPNO IN EMPNO
                     AND NAME IN NAME
                     AND DEPT IN DEPT
                     AND ENTDT IN ENTDT
                     AND GRADE IN GRADE
                     AND RETDT IN RETDT
                     AND STATUS IN STATUS.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form MAKE_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM MAKE_LAYOUT .
     GS_LAYOUT-CWIDTH_OPT = 'A'. "유동적으로 변경 됨
ENDFORM.

*FORM DOMAIN_TEXT.
*          DATA LV_LINE TYPE I. "DD07T ROW INDEX
*          DATA LT_DOMAIN TYPE TABLE OF DD07T WITH HEADER LINE.  "DD07T와 형태가 같은 HEADER LINE TABLE
*
*          SELECT *
*            FROM DD07T
*            INTO CORRESPONDING FIELDS OF TABLE LT_DOMAIN
*            WHERE DOMNAME IN ('ZDEPT_05', 'Z_GRADE_05', 'Z_STATUS_05')
*                 AND  DDLANGUAGE = SY-LANGU.
*
*            LOOP AT  ITAB  INTO ISTR.
*              LV_LINE = SY-TABIX.            "DD07T ROW INDEX
*
*            READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'ZDEPT_05'
*               DOMVALUE_L = ISTR-DEPT.
*               IF SY-SUBRC = 0.
*                ISTR-DEPT_T = LT_DOMAIN-DDTEXT.
*               ENDIF.
*
*            READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_GRADE_05'
*               DOMVALUE_L = ISTR-GRADE.
*               IF SY-SUBRC = 0.
*                ISTR-GRADE_T = LT_DOMAIN-DDTEXT.
*               ENDIF.
*
*            READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_STATUS_05'
*               DOMVALUE_L = ISTR-STATUS.
*               IF SY-SUBRC = 0.
*                ISTR-STATUS_T = LT_DOMAIN-DDTEXT.
*               ENDIF.
*
*            MODIFY ITAB FROM ISTR INDEX LV_LINE.
*           ENDLOOP.
*ENDFORM.


FORM DOMAIN_TEXT.
          FIELD-SYMBOLS: <FS_ISTR> LIKE ISTR.


            DATA LV_LINE TYPE I.
            DATA LT_DOMAIN TYPE TABLE OF DD07T WITH HEADER LINE.

            SELECT *
              FROM DD07T
              INTO CORRESPONDING FIELDS OF TABLE LT_DOMAIN
              WHERE DOMNAME IN ('ZDEPT_05', 'Z_GRADE_05', 'Z_STATUS_05')
                   AND  DDLANGUAGE = SY-LANGU.

              LOOP AT  ITAB  ASSIGNING <FS_ISTR> .

                LV_LINE = SY-TABIX.

              READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'ZDEPT_05'
                 DOMVALUE_L = <FS_ISTR>-DEPT.
                 IF SY-SUBRC = 0.
                  <FS_ISTR>-DEPT_T = LT_DOMAIN-DDTEXT.
                 ENDIF.

              READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_GRADE_05'
                 DOMVALUE_L = <FS_ISTR>-GRADE.
                 IF SY-SUBRC = 0.
                  <FS_ISTR>-GRADE_T = LT_DOMAIN-DDTEXT.
                 ENDIF.

              READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_STATUS_05'
                 DOMVALUE_L = <FS_ISTR>-STATUS.
                 IF SY-SUBRC = 0.
                  <FS_ISTR>-STATUS_T = LT_DOMAIN-DDTEXT.
                 ENDIF.

           ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA . "CREATE DATA

           DATA: LV_ANSWER.

           PERFORM USER_CONFIRM USING TEXT-Q01 TEXT-Q03
                 CHANGING LV_ANSWER.


*          "USER CONFIRM
*          CALL FUNCTION 'POPUP_TO_CONFIRM'
*            EXPORTING
*             TITLEBAR                    = '※NOTICE※'
*              TEXT_QUESTION               = 'ARE YOU SURE?'
*             TEXT_BUTTON_1               = 'YES'
*             TEXT_BUTTON_2               = 'NO'
*
*           IMPORTING
*             ANSWER                      =  LV_ANSWER. "POPUP 에 대해 버튼 입력 값


          CHECK LV_ANSWER EQ '1'. "LV_ANSER가 1인지 아닌지 확인 해 EXIT.


          "저장할 WA 로  DATA 이관
           MOVE-CORRESPONDING GS_DISP_0150 TO ISTR.

          "레코드 생성 정보 적용
          ISTR-ERDAT = SY-DATUM.
          ISTR-ERZET = SY-UZEIT.
          ISTR-ERNAM = SY-UNAME.

          "DATA 지정
          INSERT ZT05_0010 FROM ISTR.

          IF SY-SUBRC = 0.
             COMMIT WORK AND WAIT.
             MESSAGE S001.

             CLEAR ISTR.
             MOVE-CORRESPONDING GS_DISP_0150 TO ISTR.

             "DOMAIN 내역 조회
              PERFORM DOMAIN_TEXT_SINGLE_LINE  CHANGING ISTR.

             APPEND ISTR TO ITAB.
             LEAVE TO SCREEN 0.

          ELSE.
             ROLLBACK WORK.
             MESSAGE S002 DISPLAY LIKE 'E' .
             "최후의 수단... I002..
          ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DOMAIN_TEXT_SINGLE_LINE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_ISTR  text
*&---------------------------------------------------------------------*
FORM DOMAIN_TEXT_SINGLE_LINE  CHANGING P_ISTR LIKE ISTR.


           DATA LT_DOMAIN TYPE TABLE OF DD07T WITH HEADER LINE.

            SELECT *
              FROM DD07T
              INTO CORRESPONDING FIELDS OF TABLE LT_DOMAIN
              WHERE DOMNAME IN ('ZDEPT_05', 'Z_GRADE_05', 'Z_STATUS_05')
                   AND  DDLANGUAGE = SY-LANGU.


            READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'ZDEPT_05'
               DOMVALUE_L = P_ISTR-DEPT.
               IF SY-SUBRC = 0.
                P_ISTR-DEPT_T = LT_DOMAIN-DDTEXT.
               ENDIF.

            READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_GRADE_05'
               DOMVALUE_L = P_ISTR-GRADE.
               IF SY-SUBRC = 0.
                P_ISTR-GRADE_T = LT_DOMAIN-DDTEXT.
               ENDIF.

            READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_STATUS_05'
               DOMVALUE_L = P_ISTR-STATUS.
               IF SY-SUBRC = 0.
                P_ISTR-STATUS_T = LT_DOMAIN-DDTEXT.
               ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_SELECTED_ROWS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_SELECTED_ROWS .
           DATA: LT_ROW TYPE LVC_T_ROID, "Assignment of Line Number to Line ID
                      LS_ROW TYPE LVC_S_ROID. "Assignment of Row Number to Row ID

           "선택한 라인 확인
           CALL METHOD GO_ALV->GET_SELECTED_ROWS
             IMPORTING
               ET_ROW_NO     = LT_ROW .

           IF LT_ROW IS INITIAL.
               MESSAGE S003 DISPLAY LIKE 'E'. "LINE SELECT ERROR
               EXIT.
           ENDIF.

           READ TABLE LT_ROW INTO LS_ROW INDEX 1.
           READ TABLE  ITAB INTO ISTR INDEX LS_ROW-ROW_ID.

           CLEAR GS_DISP_0150 .
           MOVE-CORRESPONDING ISTR TO GS_DISP_0150.

           GS_DISP_0150-MODE = GC_MODE_UPDATE.
           GS_DISP_0150-INDEX = LS_ROW-ROW_ID.

           CALL SCREEN '0150' STARTING AT 5 5.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form UPDATE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM UPDATE_DATA .
            DATA: LV_ANSWER.

          "USER CONFIRM
           PERFORM USER_CONFIRM USING TEXT-Q01 TEXT-Q03
           CHANGING LV_ANSWER.

          CHECK LV_ANSWER EQ '1'. "LV_ANSER가 1인지 아닌지 확인 해 EXIT.


          "저장할 WA 로  DATA 이관
           MOVE-CORRESPONDING GS_DISP_0150 TO ISTR.


          ISTR-AEDAT = SY-DATUM.
          ISTR-AEZET = SY-UZEIT.
          ISTR-AENAM = SY-UNAME.

          "DATA 지정
          UPDATE ZT05_0010 FROM ISTR.

          IF SY-SUBRC = 0.

            "성공처리
             COMMIT WORK.
             MESSAGE S001.

             CLEAR ISTR .
             MOVE-CORRESPONDING GS_DISP_0150 TO ISTR.



             "DOMAIN 내역 조회
              PERFORM DOMAIN_TEXT_SINGLE_LINE  CHANGING ISTR.

              "ALV TABLE 변경
              MODIFY  ITAB  FROM ISTR INDEX GS_DISP_0150-INDEX.
              "화면 종료
              LEAVE TO SCREEN 0.

          ELSE.
              "실패 처리
              ROLLBACK WORK.
              MESSAGE S002 DISPLAY LIKE 'E' .
             "최후의 수단... I002..
          ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form BYE_RETIRE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM BYE_RETIRE .
           DATA: LT_ROW TYPE LVC_T_ROID, "Assignment of Line Number to Line ID
                      LS_ROW TYPE LVC_S_ROID. "Assignment of Row Number to Row ID

           "선택한 라인 확인
           CALL METHOD GO_ALV->GET_SELECTED_ROWS
             IMPORTING
               ET_ROW_NO     = LT_ROW .

           IF LT_ROW IS INITIAL.
               MESSAGE S003 DISPLAY LIKE 'E'. "LINE SELECT ERROR
               EXIT.
           ENDIF.

           READ TABLE LT_ROW INTO LS_ROW INDEX 1.
           READ TABLE  ITAB INTO ISTR INDEX LS_ROW-ROW_ID.

           CLEAR GS_DISP_0150 .
           MOVE-CORRESPONDING ISTR TO GS_DISP_0150.

           GS_DISP_0150-RETDT = SY-DATUM.
           GS_DISP_0150-STATUS = GC_RETIRE_DEFAULT.

           GS_DISP_0150-MODE = GC_MODE_RETIRE.
           GS_DISP_0150-INDEX = LS_ROW-ROW_ID.

           CALL SCREEN '0150' STARTING AT 5 5.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form RETIRE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM RETIRE_DATA .
            DATA: LV_ANSWER.

            IF GS_DISP_0150-ENTDT > GS_DISP_0150-RETDT.
                 MESSAGE S005 DISPLAY LIKE 'E'.
                 EXIT.
            ENDIF.

           PERFORM USER_CONFIRM USING TEXT-Q01 TEXT-Q03
           CHANGING LV_ANSWER.

          CHECK LV_ANSWER EQ '1'. "LV_ANSER가 1인지 아닌지 확인 해 EXIT.


          "저장할 WA 로  DATA 이관
           MOVE-CORRESPONDING GS_DISP_0150 TO ISTR.

          "레코드 생성 정보 적용
          ISTR-AEDAT = SY-DATUM.
          ISTR-AEZET = SY-UZEIT.
          ISTR-AENAM = SY-UNAME.

          "DATA 지정
          UPDATE ZT05_0010 FROM ISTR.

          IF SY-SUBRC = 0.

            "성공처리
             COMMIT WORK AND WAIT.
             MESSAGE S001.

             CLEAR ISTR .
             MOVE-CORRESPONDING GS_DISP_0150 TO ISTR.

             "DOMAIN 내역 조회
              PERFORM DOMAIN_TEXT_SINGLE_LINE  CHANGING ISTR.

              "ALV TABLE 변경
              MODIFY  ITAB  FROM ISTR INDEX GS_DISP_0150-INDEX.
              "화면 종료
              LEAVE TO SCREEN 0.

          ELSE.
              "실패 처리
              ROLLBACK WORK.
              MESSAGE S002 DISPLAY LIKE 'E' .
             "최후의 수단... I002..
          ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_ALV_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV_0100 .

    IF GO_CONT IS INITIAL.
* INSTANCE 생성
    PERFORM CREATE_OBJECT.

* 출력필드 셋팅
    PERFORM MAKE_CATALOG .

* LAYOUT 셋팅
    PERFORM MAKE_LAYOUT .

* ALV 출력
    PERFORM DISPLAY_ALV.

  ELSE.
    "REFRESH
    PERFORM REFRESH_0100.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_OBJECT .
  CREATE OBJECT GO_CONT
    EXPORTING
      CONTAINER_NAME              = 'CC1'.

   CREATE OBJECT GO_ALV
     EXPORTING
       I_PARENT          = GO_CONT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY_ALV .
   CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
     EXPORTING
       IS_LAYOUT                     = GS_LAYOUT

     CHANGING
       IT_OUTTAB                     = ITAB
       IT_FIELDCATALOG               = GT_FCAT.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_0100 .
  CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY
    EXPORTING

      IS_STABLE      = LS_STBL
      I_SOFT_REFRESH = 'X'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALL_CREATE_SCREEN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CALL_CREATE_SCREEN .
              CLEAR GS_DISP_0150.
              GS_DISP_0150-STATUS = GC_STATUS_DEFAULT.
              GS_DISP_0150-WAERS = GC_WARES_DEFAULT.
              GS_DISP_0150-ENTDT = SY-DATUM.
              GS_DISP_0150-MODE = GC_MODE_INSERT.
              CALL SCREEN '0150'  STARTING AT 5 5.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form USER_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_TEXT_Q01  text
*      -->P_TEXT_Q03  text
*      <--P_LV_ANSWER  text
*&---------------------------------------------------------------------*
FORM USER_CONFIRM  USING    P_TITLE    P_QUEST
           CHANGING P_ANSWER.

           CLEAR: P_ANSWER.

           CALL FUNCTION 'POPUP_TO_CONFIRM'
             EXPORTING
              TITLEBAR                    = P_TITLE
               TEXT_QUESTION               = P_QUEST
              TEXT_BUTTON_1               = 'YES'
              ICON_BUTTON_1               = 'NO'

            IMPORTING
              ANSWER                      = P_ANSWER.


ENDFORM.
