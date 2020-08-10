*&---------------------------------------------------------------------*
*& Report Z_PTJ01_052
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PTJ01_0500 MESSAGE-ID ZM05.

*ALV SPLIT
INCLUDE Z_PTJ01_0500_TOP.
INCLUDE Z_PTJ01_0500_SEL.
INCLUDE Z_PTJ01_0500_C01.
INCLUDE Z_PTJ01_0500_FO1.
INCLUDE Z_PTJ01_0500_OO1.
INCLUDE Z_PTJ01_0500_IO1.




AT SELECTION-SCREEN.

START-OF-SELECTION.
PERFORM GET_DATA.
*PERFORM DOMAIN_TEXT.



CALL SCREEN 100.
