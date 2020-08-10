*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_052_TOP
*&---------------------------------------------------------------------*

DATA OK_CODE TYPE SY-UCOMM.

DATA: BEGIN OF GS_DISP,
           MATNR TYPE MARA-MATNR,
           ERSDA TYPE MARA-ERSDA,
           ERNAM TYPE MARA-ERNAM,
           END OF GS_DISP.

DATA GT_DISP LIKE TABLE OF GS_DISP.


DATA: GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
           GO_ALV TYPE REF TO CL_GUI_ALV_GRID.

DATA: GT_FCAT TYPE LVC_T_FCAT,
           GS_FCAT TYPE LVC_S_FCAT.

DATA: GS_LAYOUT TYPE LVC_S_LAYO.
