*&---------------------------------------------------------------------*
*& Include          Z_R05_0040_TOP
*&---------------------------------------------------------------------*

DATA OK_CODE TYPE SY-UCOMM.

DATA: BEGIN OF GS_DISP,
           STATUS TYPE ICON-ID,
           MATNR TYPE MARA-MATNR,
           MAKTX TYPE MAKT-MAKTX,
           MTART TYPE MARA-MTART,
           MBRSH TYPE MARA-MBRSH,
           MEINS TYPE  MARA-MEINS,
           RESULT TYPE CHAR200,
           END OF GS_DISP.


DATA GT_DISP LIKE TABLE OF GS_DISP.

*----------임시데이터 선언---------------------------------
*단 길이는 DB를 참고해도 되고 적당한 길이로 직접 선언해주어도 됨.
*단, 날짜의 경우에는 반드시 최소10자리 이상으로는 선언해주어야함.

DATA: BEGIN OF GS_EXCEL,
           MATNR TYPE CHAR40,
           MAKTX TYPE CHAR40,
           MTART TYPE CHAR4,
           MBRSH TYPE CHAR200,
           MEINS TYPE  CHAR3,
            END OF GS_EXCEL.

DATA GT_EXCEL LIKE TABLE OF GS_EXCEL.

*----BDC를 위한 선언-----------------------------------
DATA : GT_BDC TYPE TABLE OF BDCDATA,
       GS_BDC TYPE          BDCDATA,
       GS_OPT TYPE          CTU_PARAMS,
       GT_MSG TYPE TABLE OF BDCMSGCOLL,
       GS_MSG TYPE          BDCMSGCOLL.



DATA: GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
           GO_ALV TYPE REF TO CL_GUI_ALV_GRID.

DATA: GT_FCAT TYPE LVC_T_FCAT,
           GS_FCAT TYPE LVC_S_FCAT.

DATA: GS_LAYOUT TYPE LVC_S_LAYO.
