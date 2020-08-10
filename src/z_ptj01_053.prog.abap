*&---------------------------------------------------------------------*
*& Report Z_PTJ01_053
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PTJ01_053 MESSAGE-ID ZM05.

INCLUDE Z_PTJ01_053_TOP.
INCLUDE Z_PTJ01_053_C01.
INCLUDE Z_PTJ01_053_F01.
INCLUDE Z_PTJ01_053_O01.
INCLUDE Z_PTJ01_053_IO1.


AT SELECTION-SCREEN.

START-OF-SELECTION.


PERFORM GET_DATA.


CALL SCREEN 100.
