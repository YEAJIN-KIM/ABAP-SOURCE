*&---------------------------------------------------------------------*
*& Report Z_PTJ01_052
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PTJ01_050 MESSAGE-ID ZM05.

*DOCKING CONTAINER 이용 ALV TEMPLATE
INCLUDE Z_PTJ01_050_TOP.
INCLUDE Z_PTJ01_050_FO1.
INCLUDE Z_PTJ01_050_OO1.
INCLUDE Z_PTJ01_050_IO1.




AT SELECTION-SCREEN.

START-OF-SELECTION.
PERFORM GET_DATA.
*PERFORM DOMAIN_TEXT.



CALL SCREEN 100.
