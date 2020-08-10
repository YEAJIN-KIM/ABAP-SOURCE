*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_052_F01
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

           GS_FCAT-FIELDNAME = 'MATNR'.
           GS_FCAT-COLTEXT = '자재번호'.
           GS_FCAT-KEY = 'X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'ERSDA'.
           GS_FCAT-COLTEXT = '생성일'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'ERNAM'.
          GS_FCAT-COLTEXT = '생성자'.
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
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .

      CLEAR GS_DISP.
      SELECT MATNR ERSDA ERNAM
            INTO CORRESPONDING FIELDS OF TABLE GT_DISP
            FROM MARA
            UP TO 10 ROWS. "최대 10개 까지만 가져오기

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
