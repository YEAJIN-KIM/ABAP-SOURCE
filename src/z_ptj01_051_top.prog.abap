*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_051_TOP
*&---------------------------------------------------------------------*

TABLES: ZT05_0010.

*CONSTANS 프로그램 내에서 변경할 수 없음
CONSTANTS: GC_STATUS_DEFAULT TYPE ZT05_0010-STATUS VALUE '1',
                       GC_WARES_DEFAULT TYPE ZT05_0010-WAERS VALUE 'JPY',
                       GC_RETIRE_DEFAULT TYPE  ZT05_0010-STATUS VALUE '3',
                       GC_MODE_INSERT     TYPE C                VALUE 'I',  "추가
                       GC_MODE_UPDATE    TYPE C                VALUE 'U', "변경
                       GC_MODE_RETIRE     TYPE C                VALUE 'R'.  "퇴직


DATA: BEGIN OF ISTR.  "DOMAIN TEXT
            INCLUDE STRUCTURE ZT05_0010.
DATA:  DEPT_T TYPE DD07T-DDTEXT,
            GRADE_T TYPE DD07T-DDTEXT,
            STATUS_T TYPE DD07T-DDTEXT,
            END OF ISTR.

DATA: ITAB LIKE TABLE OF ISTR.

*화면 출력 용  SCREEN 150
 DATA: BEGIN OF GS_DISP_0150.
            INCLUDE STRUCTURE ZT05_0010.
DATA: MODE TYPE C,
           INDEX TYPE LVC_S_ROID-ROW_ID,
           END OF GS_DISP_0150.

*DATA: ITAB TYPE TABLE OF ZT05_0010.
*DATA: ISTR LIKE LINE OF ITAB.

DATA: GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
           GO_ALV TYPE REF TO CL_GUI_ALV_GRID.

DATA: OK_CODE TYPE SY-UCOMM.

DATA LS_STBL TYPE LVC_S_STBL .


DATA: GT_FCAT TYPE LVC_T_FCAT,
           GS_FCAT TYPE LVC_S_FCAT.

DATA: GS_LAYOUT TYPE LVC_S_LAYO.

SELECTION-SCREEN : BEGIN OF BLOCK  B1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: EMPNO FOR ZT05_0010-EMPNO,
                               NAME FOR ZT05_0010-NAME,
                               DEPT FOR ZT05_0010-DEPT,
                               ENTDT FOR ZT05_0010-ENTDT,
                               GRADE FOR ZT05_0010-GRADE,
                               RETDT FOR ZT05_0010-RETDT,
                               STATUS FOR ZT05_0010-STATUS.

SELECTION-SCREEN: END OF BLOCK B1.
