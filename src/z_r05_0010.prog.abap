*&---------------------------------------------------------------------*
*& Report Z_R05_0010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_R05_0010.

INCLUDE Z_R05_0010_TOP.
INCLUDE Z_R05_0010_SEL.
INCLUDE Z_R05_0010_F01.

*< ME23N > STANDARD PO 입력 후
*COMMUNICATION TAP에서 변경하는 BAPI FUNCTION 수행

START-OF-SELECTION.

PERFORM CHANGE_SALES_PERSON.
