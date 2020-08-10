*&---------------------------------------------------------------------*
*& Report Z_PTJ01_052
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PTJ01_052 MESSAGE-ID ZM05.

INCLUDE Z_PTJ01_052_TOP.

INCLUDE Z_PTJ01_052_F01.
INCLUDE Z_PTJ01_052_O01.
INCLUDE Z_PTJ01_052_IO1.



AT SELECTION-SCREEN.

START-OF-SELECTION.
PERFORM GET_DATA.
*PERFORM DOMAIN_TEXT.



CALL SCREEN 100.
