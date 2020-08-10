*&---------------------------------------------------------------------*
*& Report Z_PTJ01_051
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PTJ01_051 MESSAGE-ID ZM05.

INCLUDE Z_PTJ01_051_TOP.
INCLUDE Z_PTJ01_051_C01.
INCLUDE Z_PTJ01_051_F01.
INCLUDE Z_PTJ01_051_O01.
INCLUDE Z_PTJ01_051_IO1.



AT SELECTION-SCREEN.

START-OF-SELECTION.
PERFORM SELECT_DATA.
PERFORM DOMAIN_TEXT.



CALL SCREEN 100.
