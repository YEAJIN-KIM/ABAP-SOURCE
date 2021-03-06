*&---------------------------------------------------------------------*
*& Include          Z_R05_0020_TOP
*&---------------------------------------------------------------------*

TABLES: EKKO.

DATA OK_CODE TYPE SY-UCOMM.
DATA: LV_ANSWER TYPE C.

DATA: BEGIN OF GS_DISP,
           STATUS TYPE ICON-ID,
           EBELN TYPE EKKO-EBELN,
           BUKRS TYPE EKKO-BUKRS,
           BSART TYPE EKKO-BSART,
           ERNAM TYPE EKKO-ERNAM,
           LIFNR TYPE EKKO-LIFNR,
           ZTERM TYPE EKKO-ZTERM,
           VERKF TYPE EKKO-VERKF,
           TELF1 TYPE EKKO-TELF1,
           RESULT TYPE CHAR200 ,
           END OF GS_DISP.

DATA GT_DISP LIKE TABLE OF GS_DISP.


DATA: GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
           GO_ALV TYPE REF TO CL_GUI_ALV_GRID.

*FIELD CATALOG
DATA: GT_FCAT TYPE LVC_T_FCAT,
           GS_FCAT TYPE LVC_S_FCAT.

*LAYOUT 선언
DATA: GS_LAYOUT TYPE LVC_S_LAYO.

*EVENT BLOCK
SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
    SELECT-OPTIONS: EBELN FOR EKKO-EBELN,
                                    BUKRS FOR EKKO-BUKRS,
                                    BSART FOR EKKO-BSART.
SELECTION-SCREEN: END OF BLOCK B1.
