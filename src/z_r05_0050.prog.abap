*&---------------------------------------------------------------------*
*& Report Z_R05_0050
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_R05_0050.

**기존 아밥
*DATA : BEGIN OF LS_DATA2,
*  EBELN TYPE EKKO-EBELN,
*  LIFNR TYPE EKKO-LIFNR,
*       END OF LS_DATA2.
*
* SELECT EBELN LIFNR
*   INTO CORRESPONDING FIELDS OF TABLE LT_DATA2
*   FROM EKKO
*   UP TO 10 ROWS.
*
*
*
*
**NEW ABAP
*
*SELECT EBELN, LIFNR
*  FROM EKKO
*  INTO TABLE @DATA(LT_DATA)"단, 이경우에는 CORRESPONDING은 사용 못함"
*  UP TO 10 ROWS.
*
*LOOP AT LT_DATA INTO DATA(LS_DATA)."SQL에서만 @사용. 이곳에선 사용 X"
*  LS_DATA-EBELN = 'ABC'.
*ENDLOOP.

"----------------------------------------------------------------"

*<필드심볼 사용법 1>

*DATA : BEGIN OF LS_DATA,
*  EBELN TYPE EKKO-EBELN,
*  LIFNR TYPE EKKO-LIFNR,
*       END OF LS_DATA.
*
*DATA : LT_DATA LIKE TABLE OF LS_DATA.
*
*FIELD-SYMBOLS <FS_DATA> LIKE LS_DATA.
*
*LOOP AT LT_DATA ASSIGNING <FS_DATA>.
*
*  ENDLOOP.

"필드심볼을 사용하면 작업에서 MODIFY를 사용하지 않아도 된다.


"----------------------------------------------------------------"

**<필드심볼 사용법 2>
*
*DATA : LV_DATA1 TYPE C,
*       LV_DATA2 TYPE C.
*
*FIELD-SYMBOLS <FS_DATA> TYPE C. "이렇게 선언하면 LV_DATA1, LV_DATA2에 선택해서 ASSING할 수 있음.
*
*ASSIGN LV_DATA1 TO <FS_DATA>.
*<FS_DATA> = 'A'.
*ASSIGN LV_DATA2 TO <FS_DATA>.
*<FS_DATA> = B. "같은 필드심볼을 사용하더라도 시점마다 바라보는 것이 달라짐"
*
*"위와 같이는 거의 안씀"
*
*DATA : LV_DATA1 TYPE C,
*       LV_DATA2 TYPE C.
*       LV_FNAME TYPE CHAR100.
*
*FIELD-SYMBOLS <FS_DATA> TYPE C.
*
*ASSIGN LV_DATA1 TO <FS_DATA>.
*<FS_DATA> = 'A'.
*ASSIGN LV_DATA2 TO <FS_DATA>.
*
*LV_FNAME = 'LV_DATA1'.
*ASSIGN (LV_FNAME) TO <FS_DATA> "(변수)로 표현하면 'LV_DATA1'이라는 값을 찾고 찾았으면 이것은 LV_DATA1을 바라봄.
*"동적 프로그래밍 할때 많이 사용"


"-------------------------------------------------------------------"

DATA : BEGIN OF LS_DATA,
  WTG001 TYPE WTGXXX, "COSP라는 뷰를 참고하고 가져온 데이터"
  WTG002 TYPE WTGXXX,
  WTG003 TYPE WTGXXX,
  WTG004 TYPE WTGXXX,
  WTG005 TYPE WTGXXX,
  WTG006 TYPE WTGXXX,
  WTG007 TYPE WTGXXX,
  WTG008 TYPE WTGXXX,
  WTG009 TYPE WTGXXX,
  WTG010 TYPE WTGXXX,
  WTG011 TYPE WTGXXX,
  WTG012 TYPE WTGXXX,
  WTGTOT TYPE WTGXXX, "위 1부터 12까지 합을 여기에 넣어주는 것이 목표"
        END OF LS_DATA.

DATA : LT_DATA LIKE TABLE OF LS_DATA.

SELECT *
  INTO CORRESPONDING FIELDS OF TABLE LT_DATA
  FROM COSP
 WHERE WTG007 NE 0. "그냥 임의의 값을 정해서 넣은ㄴ것"

LOOP AT LT_DATA INTO LS_DATA.

  LS_DATA-WTGTOT = LS_DATA-WTGTOT + LS_DATA-wtg001
                                + LS_DATA-wtg002
                                + LS_DATA-wtg003
                                + LS_DATA-wtg004
                                + LS_DATA-wtg005
                                + LS_DATA-wtg006
                                + LS_DATA-wtg007
                                + LS_DATA-wtg008
                                + LS_DATA-wtg009
                                + LS_DATA-wtg010
                                + LS_DATA-wtg011
                                + LS_DATA-wtg012.


  MODIFY LT_DATA FROM LS_DATA.

 ENDLOOP.

 "위처럼 해도 되지만 아래 필드심볼로 할 수 있음"
 DATA : BEGIN OF LS_DATA,
  WTG001 TYPE WTGXXX, "COSP라는 뷰를 참고하고 가져온 데이터"
  WTG002 TYPE WTGXXX,
  WTG003 TYPE WTGXXX,
  WTG004 TYPE WTGXXX,
  WTG005 TYPE WTGXXX,
  WTG006 TYPE WTGXXX,
  WTG007 TYPE WTGXXX,
  WTG008 TYPE WTGXXX,
  WTG009 TYPE WTGXXX,
  WTG010 TYPE WTGXXX,
  WTG011 TYPE WTGXXX,
  WTG012 TYPE WTGXXX,
  WTGTOT TYPE WTGXXX, "위 1부터 12까지 합을 여기에 넣어주는 것이 목표"
        END OF LS_DATA.


DATA : LT_DATA LIKE TABLE OF LS_DATA.

SELECT *
  INTO CORRESPONDING FIELDS OF TABLE LT_DATA
  FROM COSP
 WHERE WTG007 NE 0.

DATA : LV_FNAME TYPE CHAR100,
       LV_MONTH TYPE N LENGTH 2.

FIELD-SYMBOLS <FS_VALUE> TYPE WTGXXX.
LOOP AT LT_dATA INTO LS_DATA.

  DO 12 TIMES.

    LV_MONTH = LV_MONTH + 1.
    CONCATENATE 'LS_DATA-WTG0' LV_MONTH
           INTO LV_FNAME.

    ASSIGN (LV_FNAME) TO <FS_VALUE>. "DO 돌때마다 숫자가 변화해서 가르키게 됨"
    LS_DATA-WTGTOT = LS_DATA-WTGTOT + <FS_VALUE>.

  ENDDO.
ENDLOOP.
