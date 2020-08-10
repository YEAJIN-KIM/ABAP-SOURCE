*&---------------------------------------------------------------------*
*& Include          Z_R05_0030_TOP
*&---------------------------------------------------------------------*

*ABAP DICTIONARY BDC DATA 라는 것이 저장되어 있음
DATA: GT_BDC TYPE TABLE OF BDCDATA,
           GS_BDC TYPE BDCDATA.

DATA: GS_OPT TYPE CTU_PARAMS, "OPTIONS FROM OPT
           GT_MSG TYPE TABLE OF BDCMSGCOLL,
           GS_MSG TYPE BDCMSGCOLL.
