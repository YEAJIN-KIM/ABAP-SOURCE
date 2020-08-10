*&---------------------------------------------------------------------*
*& Include          Z_R05_0040_F01
*&---------------------------------------------------------------------*


FORM SET_ALV_0100.

IF GO_CONT IS INITIAL.

*INSTANCE 생성
   PERFORM CREATE_OBJECT.

*출력 필드 생성
   PERFORM MAKE_CATALOG.

*LAYOUT 세팅
   PERFORM SET_LAYOUT.


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

           GS_FCAT-FIELDNAME = 'MATNR'.
           GS_FCAT-COLTEXT = '자재코드'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'MAKTX'.
           GS_FCAT-COLTEXT = '자재내역'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'MTART'.
          GS_FCAT-COLTEXT = '자재유형'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'MBRSH'.
          GS_FCAT-COLTEXT = '산업군'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'MEINS'.
          GS_FCAT-COLTEXT = '기본단위'.
          APPEND GS_FCAT TO GT_FCAT.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'RESULT'.
          GS_FCAT-COLTEXT = '처리결과'.
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
*& Form GET_FILE_PATH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_FILE_PATH .

  DATA: LT_FILE TYPE FILETABLE,
             LS_FILE TYPE FILE_TABLE,
             LV_RC TYPE I.

"파일선택하는 다이얼로그 띄어주기"
  "클래스명 : CL_GUI_FRONTEND_SERVICES" -> 윈도우 기반의 제어할수있는 기능의 메소들이 많음.
  "이중 FILE_OPEN_DIALOG 메소드를 실행시켜야됨 : 이것은 STATIC METHOD -> 즉 바로 사용할 수 있음.

"CTRL + F6 /CLASS : CL_GUI_FRONTEND_SERVICES / METHOD : FILE_OPEN_DIALOG 사용
"STATIC이므로 인스턴스 필요없음"

"항상 불러왔을 때 주석처리가 안되있는 항목들은 MANDATORY로 입력해야되는 항목인 것을 숙지해야함!

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG
    CHANGING
      FILE_TABLE              = LT_FILE "경로에서 불러올 excel 파일을 담는 곳"
    "FILE TABLE의 타입은 FILETABLE타입이므로 로컬변수로 이를 참조하는 변수를  선언해주어서 이 곳에 넣어주여야함.

      RC                      = LV_RC. "rc는 선택한 파일의 개수 - P_PATH를 통해 하나의 파일을 가져올 것"
    "FILE TABLE의 속성은 I 타입이므로 로컬변수로 인터널 테이블 하나를 선언해주어서 이 곳에 넣어주여야함.

    READ TABLE LT_FILE  INTO LS_FILE INDEX 1. "하나만 존재하는  파일을 가지고 올 것이므로 INDEX 1를 사용"
      IF SY-SUBRC = 0.
          P_PATH = LS_FILE. " READ TABLE과 이 작업을 통해 파일의 경로까지 가져옴.
      ENDIF.

    "현재 FILE_TABLE과 RC만 존재하면 라인을 다 읽어오지 못하는 등의 문제가 있음. 깡통에 무언가를 담는 작업이 필요.
    "LT_FILE의 WA만들어주기. 상단.

****여기까지는 경로까지만 가져오는 부분. 실행버튼을 눌러야지 파일의 내용을 가져올 것이므로 이것은 START OF SELETCION에서 실행할 것.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form UPLOAD_FROM_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM UPLOAD_FROM_EXCEL .

*실행버튼을 눌렀으니 파일 자료를 가지고 올 과정

DATA: LT_INTERN TYPE TABLE OF ALSMEX_TABLINE,
           LS_INTERN TYPE ALSMEX_TABLINE.

*펑션 명 : ALSM_EXCEL_TO_INTERNAL_TABLE 사용. 처음보는 펑션, 메소드는 반드시 파라미터를 살펴봐야함.
*파라미터 확인 : FIELNAME (타입으로는 TYPE : RLGRAP_FILENAME인데 이곳에다가 파일명을 담아주면 된다고 생각"
*펑션의 테이블 확인 : Intern (인터널 테이블로 선언해주기/ associate type으로는 ALSMEX_TABLINE을 가지고 있음")

*CTRL + F6 FUNCION명  : ALSM_EXCEL_TO_INTERNAL_TABLE
CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
  EXPORTING
    filename                      = P_PATH "앞선 작업에서 파일명을 받아왔음"
    "그냥 FILENAME = P_PATH를 입력하면 덤프가 남. P_PATH와 FILENAME에서 원하는 RLGRAP-FILENAME의 형식과 충돌.
    "그렇기 때문에 SELECTION-OPTION에서 파라미터의 형식을 RLGRAP-FILENAME로 맞춰주기.
    i_begin_col                   = 1
    i_begin_row                   = 2
    i_end_col                     = 5
    i_end_row                     = 10
  TABLES
    intern                        = LT_INTERN
  EXCEPTIONS
    INCONSISTENT_PARAMETERS = 1
    UPLOAD_OLE                             = 2 "파일명을 줬는데 그 파일명이 없을때 사용하는 것"
  OTHERS                                        = 3.

IF SY-SUBRC <> 0.
    MESSAGE S010 DISPLAY LIKE 'E'. "업로드중 오류가 발생하였습니다.
*    EXIT을 쓰면 안됨 -> EXIT이 SUBROUTINE 안에 있으면 EXIT을 통해
*    이  서브루틴을 종료하지만 이후 서브루틴은 진행하게 됨.

* 그래서 아래 구문을 사용함.
    LEAVE LIST-PROCESSING. "이것을 사용하면 다시 처리중인 PROCESSING을 종료시킴"
    "위 구문이 생각나지 않는 경우에는 새로운 변수를 사용해서 에러를 핸들링하는 방법도 있음.

ENDIF.

*이것의 결과를 디버깅해보면 엑셀처럼 파일이 들어가는 것이 아니라 ROW / COL / VALUE 형식으로 값이 변형되어서 들어가므로
*이것에 대해서 처리를 해주는 과정이 필요하다.
*엑셀의 첫번째 줄이 아래 예시와 같이 들어간다.
*예시 ROW / COL /VALUE
*     1 /   1  /  CLSAP05-F16
*     1 /   2  /  예지니16
*     1 /   3  /  FERT
*     1 /   4  /  M
*     1 /   5  /  EA

*인터널 테이블을 만들어서 똑같은 필드를 만들어주고 들어올 내역을 CHAR로 선언해주어서
*위의 SAP에서 변형되어온 값들을 다시 재정리하는 과정이 필요하다.
*이를 위해서 TOP문에다가 우리가 뿌려줄것과 유사한 인터널테이블을 선언해준다.

*아래는 LT_INTERN의 데이터를 GT_INTERN에 담아주는 과정.

CLEAR: GT_EXCEL, GS_EXCEL.

LOOP AT LT_INTERN INTO  LS_INTERN.

      CASE LS_INTERN-COL.
            WHEN 1.
              GS_EXCEL-MATNR = LS_INTERN-VALUE.
            WHEN 2.
              GS_EXCEL-MAKTX = LS_INTERN-VALUE.
             WHEN 3.
               GS_EXCEL-MTART = LS_INTERN-VALUE.
              WHEN 4.
                GS_EXCEL-MBRSH = LS_INTERN-VALUE.
              WHEN 5.
                GS_EXCEL-MEINS = LS_INTERN-VALUE.
         ENDCASE.

         AT END OF ROW.
               APPEND GS_EXCEL TO GT_EXCEL.
               CLEAR GS_EXCEL.
          ENDAT.

  ENDLOOP.

*BEGIN ROW는 2번 : 엑셀파일에 COLUMN명을 제외하고 가져올것이므로, END ROW는 MAX를 사용해서 추후에도 지속적으로 사용할 수 있도록 세팅


ENDFORM.
*&---------------------------------------------------------------------*
*& Form CONVERT_TO_DISPLAY_FORMAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CONVERT_TO_DISPLAY_FORMAT .

  CLEAR: GT_DISP, GS_DISP.

  LOOP AT GT_EXCEL INTO GS_EXCEL.

    CLEAR GS_DISP.
    MOVE-CORRESPONDING GS_EXCEL TO GS_DISP.
    GS_DISP-STATUS = ICON_LED_YELLOW.

    APPEND GS_DISP TO GT_DISP.

   ENDLOOP.


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

      DATA: LV_MSG TYPE CHAR100.

      LOOP AT GT_DISP INTO GS_DISP WHERE STATUS = ICON_LED_YELLOW.


  CLEAR GT_BDC.



  PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0060' 'X' '' '',
                             '' '' '' 'BDC_OKCODE' '=ENTR',
                             '' '' '' 'RMMG1-MATNR' GS_DISP-MATNR,
                             '' '' '' 'RMMG1-MBRSH' GS_DISP-MBRSH,
                             '' '' '' 'RMMG1-MTART' GS_DISP-MTART.

PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0070' 'X' '' '',
                             '' '' '' 'BDC_OKCODE' '=ENTR',
                             '' '' '' 'MSICHTAUSW-KZSEL(01)' 'X'.

PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '4004' 'X' '' '',
                             '' '' '' 'BDC_OKCODE' '=BU', "SAVE
                             '' '' '' 'MAKT-MAKTX' GS_DISP-MAKTX,
                             '' '' '' 'MARA-MEINS' GS_DISP-MEINS.

CLEAR GS_OPT.
GS_OPT-DISMODE = 'N'. "A모드, -  BDC의 화면을 다 띄어주는 모드
                      "N모드-실행했을 때 성공했다고 메시지만 제시(백그라운드에서 작업)
                      "E모드 - 백그라운드에서 작업하지만 에러발생시 에러창을 띄워줌"
                      "보통 코딩상 모드를 제시하지만 N모드로 디플트로 설정, 에러발생시 A,E로 수행"
GS_OPT-UPDMODE = 'S'. "COMMIT WORK & WAIT


"CALL TRANSACTION에 대한 KEY워드 설명에 들어가서 보면 OPTIONS FROM/MESSAGE INTO에 대한
*설명과 필요한 변수가 제시되어 있다. 이에 맞추어서 TOP에서 변수 선언해줌.

CLEAR GT_MSG.
CALL TRANSACTION 'MM01' USING GT_BDC
                        OPTIONS FROM GS_OPT
                        MESSAGES INTO GT_MSG.

READ TABLE GT_MSG INTO GS_MSG WITH KEY MSGID = 'M3'
                                                                                MSGNR = '800'.

IF SY-SUBRC  = 0.
*성공 처리
  GS_DISP-STATUS = ICON_LED_GREEN.
  GS_DISP-RESULT = ''.
   MESSAGE S009 WITH GS_DISP-MATNR. " 자재코드 & 가 생성되었습니다.
ELSE.
*실패처리
  LOOP AT GT_MSG INTO GS_MSG.
  CALL FUNCTION 'MESSAGE_TEXT_BUILD'
    EXPORTING
      MSGID                     = GS_MSG-MSGID
      MSGNR                     = GS_MSG-MSGNR
     MSGV1                     = GS_MSG-MSGV1
     MSGV2                     = GS_MSG-MSGV2
     MSGV3                     = GS_MSG-MSGV3
     MSGV4                     = GS_MSG-MSGV4
   IMPORTING
     MESSAGE_TEXT_OUTPUT       = LV_MSG.

    IF GS_DISP-RESULT IS INITIAL.
         GS_DISP-RESULT = LV_MSG.
     ELSE.
          CONCATENATE GS_DISP-RESULT LV_MSG
                INTO  GS_DISP-RESULT
                SEPARATED BY '#'.
      ENDIF.
    ENDLOOP.

        GS_DISP-STATUS = ICON_LED_RED.
   ENDIF.

  MODIFY GT_DISP FROM GS_DISP.

 ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_BDC_TAB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*&---------------------------------------------------------------------*
FORM SET_BDC_TAB  USING    P_PROGRAM
                           P_DYNPRO
                           P_DYNBEGIN
                           P_FNAM
                           P_FVAL.

  CLEAR GS_BDC.
  GS_BDC-PROGRAM  = P_PROGRAM.
  GS_BDC-DYNPRO   = P_DYNPRO.
  GS_BDC-DYNBEGIN = P_DYNBEGIN.
  GS_BDC-FNAM     = P_FNAM.
  GS_BDC-FVAL     = P_FVAL.

  APPEND GS_BDC TO GT_BDC.

ENDFORM.
