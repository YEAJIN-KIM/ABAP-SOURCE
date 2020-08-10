*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_052_F01
*&---------------------------------------------------------------------*


FORM SET_ALV_0100.

IF GO_DOCK IS INITIAL.

*MAIN CONTAINER 생성
*MAIN CONTAINER 영역 분할
*분할된 CONTAINER를 개별 CONTAINER에 할당
*개별 CONTAINER에 ALV 생성
   PERFORM CREATE_OBJECT.

*출력 필드 생성
   PERFORM MAKE_CATALOG.

*LAYOUT 세팅
   PERFORM SET_LAYOUT.

*EVEVNT 등록
   PERFORM SET_EVENT.

*ALV 호출
  PERFORM DISPLY_ALV.

ELSE.
   PERFORM REFRESH_DATA.

ENDIF.

ENDFORM.


FORM CREATE_OBJECT.

*MAIN CONTAINER 생성
CREATE OBJECT GO_DOCK
  EXPORTING
    SIDE                        = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT
    EXTENSION                   = 2000.

*MAIN CONTAINER 영역 분할
CREATE OBJECT GO_SPLITTER
  EXPORTING
    PARENT            = GO_DOCK
    ROWS              = 2
    COLUMNS           = 1.

*분할된 CONTAINER를 개별 CONTAINER에 할당
CALL METHOD GO_SPLITTER->GET_CONTAINER
  EXPORTING
    ROW       = 1
    COLUMN    = 1
  RECEIVING
    CONTAINER =  GO_CONT1.

CALL METHOD GO_SPLITTER->GET_CONTAINER
  EXPORTING
    ROW       = 2
    COLUMN    = 1
  RECEIVING
    CONTAINER =  GO_CONT2.

*개별 CONTAINER에 ALV 생성
CREATE OBJECT GO_ALV
     EXPORTING
       I_PARENT          = GO_CONT1.

CREATE OBJECT GO_ALV2
     EXPORTING
       I_PARENT          = GO_CONT2.


ENDFORM.

FORM MAKE_CATALOG.

           CLEAR GS_FCAT.
           CLEAR: GT_FCAT1, GT_FCAT2.

           GS_FCAT-FIELDNAME = 'EBELN'.
           GS_FCAT-COLTEXT = '구매문서'.
           GS_FCAT-KEY = 'X'.
           APPEND GS_FCAT TO GT_FCAT1.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'BUKRS'.
           GS_FCAT-COLTEXT = '회사코드'.
           APPEND GS_FCAT TO GT_FCAT1.
           CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'LIFNR'.
          GS_FCAT-COLTEXT = '공급업체'.
          APPEND GS_FCAT TO GT_FCAT1.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'EBELN'.
          GS_FCAT-COLTEXT = '구매문서'.
          APPEND GS_FCAT TO GT_FCAT2.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'EBELP'.
          GS_FCAT-COLTEXT = '아이템'.
          APPEND GS_FCAT TO GT_FCAT2.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'MATNR'.
          GS_FCAT-COLTEXT = '자재코드'.
          APPEND GS_FCAT TO GT_FCAT2.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'MENGE'.
          GS_FCAT-COLTEXT = '수량'.
          APPEND GS_FCAT TO GT_FCAT2.
          CLEAR GS_FCAT.

          GS_FCAT-FIELDNAME = 'MEINS'.
          GS_FCAT-COLTEXT = '단위'.
          APPEND GS_FCAT TO GT_FCAT2.
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

              CLEAR: GS_LAYOUT1, GS_LAYOUT2.
              GS_LAYOUT1-ZEBRA = 'X'.
              GS_LAYOUT1-CWIDTH_OPT = 'A'.
              GS_LAYOUT1-SEL_MODE = 'D'. "D의 의미"

              GS_LAYOUT2-ZEBRA = 'X'.
              GS_LAYOUT2-CWIDTH_OPT = 'A'.
              GS_LAYOUT2-SEL_MODE = 'D'. "D의 의미"

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
                  IS_LAYOUT = GS_LAYOUT1

            CHANGING
                   IT_OUTTAB = GT_DISP_T
                   IT_FIELDCATALOG = GT_FCAT1.

            CALL METHOD GO_ALV2->SET_TABLE_FOR_FIRST_DISPLAY
            EXPORTING
                  IS_LAYOUT = GS_LAYOUT2

            CHANGING
                   IT_OUTTAB = GT_DISP_B
                   IT_FIELDCATALOG = GT_FCAT2.

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

      CLEAR: GS_DISP_T, GS_DISP_B.
      SELECT EBELN BUKRS LIFNR
            INTO CORRESPONDING FIELDS OF TABLE GT_DISP_T
            FROM EKKO
            WHERE BSART IN S_BSART.


*      SELECT EBELN EBELP MATNR MENGE MEINS
*            INTO CORRESPONDING FIELDS OF TABLE GT_DISP_B
*            FROM EKPO
*            WHERE BSART IN S_BSART.

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
            CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY.
*              EXPORTING
*                IS_STABLE      =
*                I_SOFT_REFRESH =
*              EXCEPTIONS
*                FINISHED       = 1
*                OTHERS         = 2.


                    .

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

*EVENT RECEIVER INSTANCE 생성
  CREATE OBJECT GO_EVENT_RECEIVER.  "CLASS에서 선언한 GO_EVENT_RECEIVER라는 변수를 생성

*ALV에 EVENT 등록
  SET HANDLER GO_EVENT_RECEIVER->HANDLE_DOUBLE_CLICK  "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_HOTSPOT_CLICK  "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR  "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND  "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV.


  SET HANDLER GO_EVENT_RECEIVER->HANDLE_DOUBLE_CLICK  "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV2.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_HOTSPOT_CLICK  "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV2.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV2.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_ROW  text
*      -->P_E_COLUMN  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
FORM HANDLE_DOUBLE_CLICK  USING    PS_ROW TYPE LVC_S_ROW
                                                                     PS_COL TYPE LVC_S_COL
                                                                     P_SENDER.

           CASE P_SENDER.
                 WHEN GO_ALV.
                      READ TABLE GT_DISP_T INTO GS_DISP_T INDEX PS_ROW-INDEX.
                      IF SY-SUBRC = 0.
                          CLEAR GT_DISP_B.
                          SELECT EBELN EBELP MATNR MENGE MEINS
                                INTO CORRESPONDING FIELDS OF TABLE GT_DISP_B
                                    FROM EKPO
                                        WHERE EBELN = GS_DISP_T-EBELN.
                       ENDIF.

                       CALL METHOD GO_ALV2->REFRESH_TABLE_DISPLAY.

                  WHEN GO_ALV2.

            ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_HOTSPOT_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_ROW  text
*      -->P_E_COLUMN  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
FORM HANDLE_HOTSPOT_CLICK  USING    P_E_ROW TYPE LVC_S_ROW
                                                                       P_E_COLUMN  TYPE LVC_S_COL
                                                                       P_SENDER.

          CASE P_SENDER.
              WHEN GO_ALV.

              WHEN GO_ALV2.

           ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_OBJECT  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
FORM HANDLE_TOOLBAR  USING    P_E_OBJECT
                              P_SENDER.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_UCOMM  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
FORM HANDLE_USER_COMMAND  USING    P_E_UCOMM
                                                                         P_SENDER.

          CASE P_SENDER.
              WHEN GO_ALV.
                   CASE P_E_UCOMM.
                     WHEN 'SAVE'.

                    ENDCASE.

              WHEN GO_ALV2.
                   CASE P_E_UCOMM.
                     WHEN 'SAVE'.

                    ENDCASE.
           ENDCASE.
ENDFORM.
