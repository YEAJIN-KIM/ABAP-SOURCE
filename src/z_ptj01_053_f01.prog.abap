*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_053_F01
*&---------------------------------------------------------------------*


FORM SET_ALV_0100 .

IF GO_CONT IS INITIAL.

*INSTANCE 생성
   PERFORM CREATE_OBJECT.

*출력 필드 생성
   PERFORM MAKE_CATALOG.

*LAYOUT 세팅
   PERFORM SET_LAYOUT.

*EVEVNT 등록
   PERFORM SET_EVENT.

*ALV 호출
  PERFORM DISPLY_ALV.

ELSE.
  "G_GRID가 초기값이 아닐 경우에는 REFRESH를 해주어라
   PERFORM REFRESH_DATA.

ENDIF.
*-------------------필드 카탈로그에서 제어될수도 있고 아래 구문처럼 수행해주어도됨----------------------------"
DATA : LV_INPUT TYPE INT4. "-> TOP에 선언해주기 또는 서브루틴 최상단에 선언해주기"

  IF SY-TCODE = 'Z_PTJ01_053_D'.
    LV_INPUT = 0. "닫기"
  ELSE.
    LV_INPUT = 1. "열기"
  ENDIF.

  CALL METHOD GO_ALV->SET_READY_FOR_INPUT
  EXPORTING
    I_READY_FOR_INPUT = LV_INPUT. "T-CODE에 따라서 열고 닫기를 제어하는 METHOD를 실행


ENDFORM.


FORM CREATE_OBJECT.

*CONTAINER 생성
*INSTANCE : CC1
*CLASS : CL_GUI_CUSTOM_CONTAINER.

   CREATE OBJECT GO_CONT
     EXPORTING
       CONTAINER_NAME              = 'CC1'.

*GRID 생성
*INSTANCE : GO_ALV
*CLASS : Cl_GUI_ALV_GRID.

   CREATE OBJECT GO_ALV
     EXPORTING
       I_PARENT          = GO_CONT.
ENDFORM.

FORM MAKE_CATALOG.

*I_STRUCUTRE_NAME을 쓰는 것보다는 CATALOG를 사용하는 것이 더 편할 수 있음.

*T-CODE 에 따라 열고 닫기 하기 위해 사용하는 구문

 DATA: LV_CODE TYPE C.

 IF SY-TCODE = 'Z_PTJ01_053_D'.
     LV_CODE = ''.
 ELSE.
     LV_CODE = 'X'.
 ENDIF.


           "먼저 CLEAR 해주기
           CLEAR GS_FCAT.
           CLEAR GT_FCAT.

           GS_FCAT-FIELDNAME = 'STAT'.
           GS_FCAT-REF_TABLE = 'STAT'.
           GS_FCAT-COLTEXT = '상태'.
           GS_FCAT-KEY = 'X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.


           GS_FCAT-FIELDNAME = 'EMPNO'.
           GS_FCAT-REF_FIELD = 'EMPNO'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '사원'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'NAME'.
           GS_FCAT-REF_FIELD = 'NAME'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '이름'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'DEPT'.
           GS_FCAT-REF_FIELD = 'DEPT'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '부서'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'DEPT_T'.
*           GS_FCAT-REF_FIELD = 'DEPT'.
*           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '부서설명'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'ENTDT'.
           GS_FCAT-REF_FIELD = 'ENTDT'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '입사일'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'GRADE'.
           GS_FCAT-REF_FIELD = 'GRADE'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '직급'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'GRADE_T'.
*           GS_FCAT-REF_FIELD = 'GRADE'.
*           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '직급설명'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'RETDT'.
           GS_FCAT-REF_FIELD = 'RETDT'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '퇴사일'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'STATUS'.
           GS_FCAT-REF_FIELD = 'STATUS'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '재직여부'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'STATUS_T'.
*           GS_FCAT-REF_FIELD = 'STATUS'.
*           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '재직여부설명'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'PHONE'.
           GS_FCAT-REF_FIELD = 'PHONE'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '전화번호'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'ADDR_H'.
           GS_FCAT-REF_FIELD = 'ADDR_H'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '자택주소'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'ADDR_W'.
           GS_FCAT-REF_FIELD = 'ADDR_W'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-COLTEXT = '근무지 주소'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'SALARY'.
           GS_FCAT-REF_FIELD = 'SALARY'.
           GS_FCAT-REF_TABLE = 'ZT05_0010'.
           GS_FCAT-CFIELDNAME = 'WAERS'.
           GS_FCAT-COLTEXT = '기본급'.
           GS_FCAT-EDIT ='X'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'WAERS'.
           GS_FCAT-COLTEXT = '통화'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

           GS_FCAT-FIELDNAME = 'RESULT'.
           GS_FCAT-COLTEXT = '처리 결과'.
           APPEND GS_FCAT TO GT_FCAT.
           CLEAR GS_FCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_LAYOUT .

              CLEAR GS_LAYOUT.
              GS_LAYOUT-ZEBRA = 'X'.
              GS_LAYOUT-CWIDTH_OPT = 'A'.
              GS_LAYOUT-SEL_MODE = 'D'. "LAYOUT의 셀모드 중 D의 의미 - GRID 상에서 DRAG가 가능하기 때문에 사용"
              GS_LAYOUT-NO_ROWINS = 'X'."DATA 복사 시 자동으로 행을 넓히는 것을 방지 하고 BUTTON으로만 ROW 생성
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLY_ALV .
*CTRL + F6 / CALL_METHOD 클릭
*INSTANCE : GO_ALV
*CLASS : Cl_GUI_ALV_GRID.
*METHOD : SET_TABLE_FOR_FIRST_DISPLAY

            CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
            EXPORTING
                  IS_LAYOUT = GS_LAYOUT

            CHANGING
                   IT_OUTTAB = ITAB
                   IT_FIELDCATALOG = GT_FCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .

*인사 DATA 조회
  PERFORM GET_EMPLOYEE_MASTER.

*DOMAIN DATA 조회
  PERFORM DOMAIN_TEXT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_DATA .
*INSTANCE  : G_GRID
*CLASS : Cl_GUI_ALV_GRID.
*METHOD : REFRESH_TABLE_DISPLAY.

            CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DOMAIN_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DOMAIN_TEXT .
          FIELD-SYMBOLS: <FS_ISTR> LIKE ISTR.
              DATA LV_LINE TYPE I.

            SELECT *
              FROM DD07T
              INTO CORRESPONDING FIELDS OF TABLE LT_DOMAIN
              WHERE DOMNAME IN ('ZDEPT_05', 'Z_GRADE_05', 'Z_STATUS_05')
                   AND  DDLANGUAGE = SY-LANGU.

              LOOP AT  ITAB  ASSIGNING <FS_ISTR> . "필드심볼없을때 사용가능한 구문"

                LV_LINE = SY-TABIX.

              READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'ZDEPT_05'
                 DOMVALUE_L = <FS_ISTR>-DEPT.
                 IF SY-SUBRC = 0.
                  <FS_ISTR>-DEPT_T = LT_DOMAIN-DDTEXT.
                 ENDIF.

              READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_GRADE_05'
                 DOMVALUE_L = <FS_ISTR>-GRADE.
                 IF SY-SUBRC = 0.
                  <FS_ISTR>-GRADE_T = LT_DOMAIN-DDTEXT.
                 ENDIF.

              READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_STATUS_05'
                 DOMVALUE_L = <FS_ISTR>-STATUS.
                 IF SY-SUBRC = 0.
                  <FS_ISTR>-STATUS_T = LT_DOMAIN-DDTEXT.
                 ENDIF.



           ENDLOOP.


ENDFORM.


FORM SET_EVENT.

*EVENT RECEIVER INSTANCE 생성
  CREATE OBJECT GO_EVENT_RECEIVER.  "CLASS에서 선언한 GO_EVENT_RECEIVER라는 변수를 생성

*ALV에 EVENT 등록
  SET HANDLER GO_EVENT_RECEIVER->HANDLE_DOUBLE_CLICK  "HANDLER을 통해 실제 행동이 수행될 수 있도록 하는 SET HANDLER 세팅
                  FOR GO_ALV.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED  "HANDLER를 통해 실제 행동이 수행될 수 있도록 함
                  FOR GO_ALV.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR
                  FOR GO_ALV.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND
                   FOR GO_ALV.

*EVENT 발생
*INSTANCE : GO_ALV
*CLASS : Cl_GUI_ALV_GRID.
*METHOD : REGISTER_EDIT_EVENT
*EVENT 발생 시  캐치 <GRID 에서 데이터 변경 시 인식하는 부분 >

 CALL METHOD GO_ALV->REGISTER_EDIT_EVENT
    EXPORTING
      "MC_EVT_MIDIFIED는 내가 엔터를 눌렀을 때 ALV에서 이벤트를 인식하고 MODIFY를 수행하는 CL_GUI_ALV_GRID의 ATTRIBUTE.
      "I_EVENT_ID = GO_GRID->MC_EVT_MODIFIED. "위아래 다 가능"
       I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED. " ALV에 엔터를 누르면 이벤트가 발생시키도록 세팅하는 역할"


ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDL_DATA_CHNGED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_ER_DATA_CHANGED  text
*&---------------------------------------------------------------------*

*01 ALV에서 변경된 데이터를 ALV로 전달 시
*METHOD : CHECK_CHANGED DATA , EVENT DATA_CHANGED 를 사용해
*ALV GRID 에서 INTERNAL TABLE로 DATA가 전달된다

*02 INTERNAL TABLE에서 변경된 DATA를 ALV로 전달 시
*INTERNAL TABLE 의 DATA를 ALV에 대시 넘겨줄 시 METHOD REFRESH를 사용

*CLASS에서 이용한 DATA_CHANGED의 파라미터인 ER_DATA_CHANGED는
*CL_ALV_CHANGED_DATA_PROTOCOL인  ASSICOATE TYPE을 가지고 있음.
*즉 이는 INSTANCE 형식의 무언가를 도출해주는 역할을 하므로
*P_ER_DATA_CHANGED의 타입을  TYPE REF TO를 통해서 정해주어야한다. (왜? 인스턴스 형식이니까! )

FORM HANDLE_DATA_CHNGED  USING    PO_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL .

*P_ER_DATA_CHANGED의  MT_MOD_CELLS 사용시 DEPT GRADE STATUS 가 ALV에서 값이 변화할 시
*변경된 값을 전달해 주며 DEPT_T GRADE_T STATUS_T 의 변경도 가져올 수 있음


*P_ER_DATA_CHANGED를 디버깅하면 그리드에서 변경된 DATA를
*MT_MOD_CELLS , MT_GOOD_CELLS라는 ATTRIBUTE가 가지고 있음을 확인할 수 있음.
*MT_*_CELLS는 INTERNAL TABLE 형식으로  GRID에서 다수의 데이터를 변경해도 이를 다 가지고 있음.
*따라서 변경된 데이터를 처리하려면 LOOP문을 통해서 각각을 처리해주어야하고 같은 형식의 워크에어리어가 필요
*MT_GOOD_CELLS의 타입은 LVC_T_MODI , LVC_S_MODI.

*           "이를 이용해서 WORKAREA
           DATA: LS_CHANGED TYPE LVC_S_MODI,
                      LV_TEXT TYPE DD07T-DDTEXT.


*P_ER_DATA_CHANGED->MT_GOOD_CELLS가 인터널 테이블
*인스턴스의 어트리뷰트를 나타내주는 것이므로 아래 구문처럼 -> 을 사용
*만약 앞이 클래스 형식이라면 CLASS=>MY_GOOD_CELLS를 사용.

           LOOP AT PO_DATA_CHANGED->MT_GOOD_CELLS INTO LS_CHANGED.

*LVC_S_MODI 의 COMPONENT 중 FIELDNAME(타입 : LVC_FNAME)과 VALUE(타입 : LVC_VALUE)가 있음.
*이 중 VALUE는  GRID에서 새로 입력한 DATA (VALUE)를 포함함
*CL_ALV_CHANGED_DATA_PROTOCOL라는 CLASS 중
*MODIFY_CELL이라는 METHOD는 양 방향으로 수정 가능

               CASE LS_CHANGED-FIELDNAME.

                   WHEN 'DEPT'."부서 변경"
                      "부서 명 조회
                      PERFORM GET_DOM_TEXT USING LS_CHANGED-VALUE
                      CHANGING LV_TEXT.

                       "ALV 및 INTERNAL TABLE에 반영
                       CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
                          EXPORTING
                            I_ROW_ID    = LS_CHANGED-ROW_ID
                            I_FIELDNAME = 'DEPT_T'
                            I_VALUE     =  LV_TEXT.


                        WHEN 'GRADE'.
                          "직급 명 조회
                      PERFORM GET_DOM_TEXT USING LS_CHANGED-VALUE
                      CHANGING LV_TEXT.

                          "ALV 및 INTERNAL TABLE에 반영
                          CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
                            EXPORTING
                              I_ROW_ID    = LS_CHANGED-ROW_ID
                              I_FIELDNAME = 'GRADE_T'
                              I_VALUE     =  LV_TEXT.


                        WHEN 'STATUS'.
                          "재작 구분 내역 조회
                      PERFORM GET_DOM_TEXT USING LS_CHANGED-VALUE
                      CHANGING LV_TEXT.

                          "ALV 및 INTERNAL TABLE에 반영
                          CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
                            EXPORTING
                              I_ROW_ID    = LS_CHANGED-ROW_ID
                              I_FIELDNAME = 'STATUS_T'
                              I_VALUE     =  LV_TEXT. "I_VALUE에서 요구하는 타입은 ANY이므로 무엇이든 넣을 수 있다.

                       ENDCASE.

                            CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
                              EXPORTING
                              I_ROW_ID    = LS_CHANGED-ROW_ID
                              I_FIELDNAME = 'STAT'
                              I_VALUE     =  ICON_LED_YELLOW. "신규 DATA 생성시 YELLOW ICON

           ENDLOOP.

            CLEAR LT_DOMAIN.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SELECT_DOMAIN_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SELECT_DOMAIN_TEXT .

           SELECT * FROM DD07T
                 INTO CORRESPONDING FIELDS OF TABLE LT_DOMAIN
                       WHERE DOMNAME IN (  'ZDEPT_05', 'Z_GRADE_05', 'Z_STATUS_05' )
                        AND DDLANGUAGE = SY-LANGU.

                        READ TABLE LT_DOMAIN
                        WITH KEY DOMVALUE_L = LS_CHANGED-VALUE.

                        IF SY-SUBRC = 0.
                              LV_TEXT = LT_DOMAIN-DDTEXT.
                        ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_EMPLOYEE_MASTER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_EMPLOYEE_MASTER .
           SELECT *
             FROM ZT05_0010
             INTO CORRESPONDING FIELDS OF TABLE ITAB
             WHERE EMPNO IN EMPNO
                     AND NAME IN NAME
                     AND DEPT IN DEPT
                     AND ENTDT IN ENTDT
                     AND GRADE IN GRADE
                     AND RETDT IN RETDT
                     AND STATUS IN STATUS.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_OBJECT  text
*&---------------------------------------------------------------------*
FORM HANDLE_TOOLBAR  USING    PO_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET.

        DATA: LS_TOOLBAR TYPE STB_BUTTON.

    IF SY-TCODE NE 'Z_PTJ01_053_D'.
        LS_TOOLBAR-FUNCTION = 'CREATE'.
        LS_TOOLBAR-ICON = ICON_CREATE.
        LS_TOOLBAR-TEXT = '사원 등록'.
        APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.

    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_UCOMM  text
*&---------------------------------------------------------------------*
FORM HANDLE_USER_COMMAND  USING    P_E_UCOMM. "UCOMM은 단일 변수로 따로 타입을 적지 않아도 됨
        CASE P_E_UCOMM.
          WHEN 'CREATE'. "아이콘 입사일 직위 통화를 DEFAULT로 입력
            CLEAR ISTR.
            ISTR-STAT = ICON_LED_YELLOW.
            ISTR-ENTDT = SY-DATUM.
            ISTR-STATUS = '1'.
            ISTR-WAERS = 'JPY'.

            READ TABLE LT_DOMAIN WITH KEY DOMNAME = 'Z_STATUS_05'
                                  DOMVALUE_L = ISTR-STATUS.

            IF SY-SUBRC = 0.
              ISTR-STATUS_T = LT_DOMAIN-DDTEXT.
            ENDIF.

            APPEND ISTR TO ITAB.

            PERFORM REFRESH_DATA. "REFRESH 수행하여 추가된 줄이 ALV GRID에 뜸

ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SAVE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SAVE_DATA .
      DATA: LT_SAVE_I TYPE TABLE OF ZT05_0010, "신규 등록 사번에 대한 INTERNALTABLE
                 LT_SAVE_U TYPE TABLE OF ZT05_0010, "변경 사번에 대한 INTERNAL TABLE
                 LS_SAVE TYPE ZT05_0010. " 두 테이블에 값을 넣기 위해 사용하는 임시 WORKAREA

      DATA: LV_EMPNO TYPE ZT05_0010-EMPNO, "신규 사번 채번을 위한 DATA선언
                 LV_ERR TYPE C, "ERROR 처리 DATA
                 LV_ANSWER TYPE C.

      FIELD-SYMBOLS: <FS_ISTR> LIKE ISTR.

* < ALV에서 변경한 데이터 반영 >
  CALL METHOD GO_ALV->CHECK_CHANGED_DATA. "->여기까지는 화면과 인터널 테이블과는 동기화가 된 상황 ( =동일한 상태 )"
                                                                                       "-> 그러므로 추후 데이터는 인터널 테이블만 가지고 핸들링하면 됨"
* <변경데이터 유무 검증 - 없으면 에러>
  READ TABLE ITAB INTO ISTR
                     WITH KEY STAT = ICON_LED_YELLOW.

  IF SY-SUBRC NE 0.
    MESSAGE S006.
    EXIT.
  ENDIF.

* < 필수 필드 입력여부 검증 + 입력데이터에 대한 유효성 검증 + 저장데이터 구성 (변경, 생성 ) >
*이름 ,부서, 입사일, 직급, 재직구분은 필수 입력으로 하되 (상시필수), 재직구분이 3이면 반드시 퇴사일이 존재하도록 로직을 구성해보자.

*라인별로 체크해야되므로 LOOP이 필요
*이때 다 LOOP하는 것이 아니라 아이콘이 노란색만 !
LOOP AT ITAB ASSIGNING <FS_ISTR>
                    WHERE STAT = ICON_LED_YELLOW.


*=위 구문이랑 동일
*  IF <FS_DISP>-STAT NE ICON_LED_YELLOW.
*    CONTINUE.
*  ENDIF.


*< 유효성 검증 >
  PERFORM CHECK_LINE CHANGING <FS_ISTR>  LV_ERR.

*<저장 DATA 구성 ( 변경, 생성 ) + 신규 사원 번호 채번 >
*< 신규 사번 채번 >
  IF <FS_ISTR>-EMPNO IS INITIAL.

*01 방법
**  IF LV_EMPNO IS INITIAL. "LV_EMPNO가 DATA가 없다면
**    먼저 DB에서 채번
**
**    SELECT MAX( EMPNO )
**      INTO LV_EMPNO
**      FROM ZT00_0010
**      WHERE EMPNO LIKE '2020%'.  "해마다 년도가 바뀌므로 이것은 일회성일 수 있음 그래서 아래 방법 2로 실행"
**  LV_EMPNO = LV_EMPNO + 1. "2020으로 시작하는 번호를 가져와서 1을 더해줘서 신규 사원번호 사용"
** ( = ADD 1 TO LV_EMPNO 위에 구문이랑 같은 개념 )

*02 방법
      IF LV_EMPNO IS INITIAL.
          PERFORM GET_MAX_EMPNO CHANGING LV_EMPNO.
      ENDIF.

* ADD 1 TO LV_EMPNO 위에 구문이랑 같은 개념
      LV_EMPNO = LV_EMPNO + 1.

*EMPNO_BACKUP은 TABLE의 보이지 않는 필드에 작업 후 사용하기 위해 선언
*TOP 에서 선언한 EMPNO_BACKUP에 LV_EMPNO를 삽입
      <FS_ISTR>-EMPNO_BACKUP  = LV_EMPNO. "EMPNO_BACKUP

      CLEAR LS_SAVE.
      MOVE-CORRESPONDING <FS_ISTR> TO LS_SAVE.
      LS_SAVE-EMPNO = LV_EMPNO. "위에서 찾은 사원번호인 EMPNO
      LS_SAVE-ERDAT = SY-DATUM.  "신규생성일자
      LS_SAVE-ERZET = SY-UZEIT.
      LS_SAVE-ERNAM = SY-UNAME. "신규생성자명
      APPEND LS_SAVE TO LT_SAVE_I. "EMPNO가 INITIAL 이므로 신규생성 테이블에 등록

    ELSE.
      CLEAR LS_SAVE.
      MOVE-CORRESPONDING <FS_ISTR> TO LS_SAVE.
      LS_SAVE-AEDAT = SY-DATUM. "변경일자
      LS_SAVE-AEZET = SY-UZEIT.
      LS_SAVE-AENAM = SY-UNAME. "변경자이름
      APPEND LS_SAVE TO LT_SAVE_U. "변경 테이블에 반영
    ENDIF.

  ENDLOOP.

*< DATA 저장 >
IF LV_ERR EQ 'X'. "에러가 한건이라도 있으면 나감
  MESSAGE S007 DISPLAY LIKE 'E'.
  EXIT.
ENDIF.

*< 신규 생성 확인 MESSAGE 출력 >
PERFORM USER_CONFIRM USING TEXT-Q01
                   TEXT-Q02 CHANGING LV_ANSWER.
CHECK LV_ANSWER EQ '1'.

*< 신규 DATA 생성 >
*신규 : 위의 LV_EMPNO = LV_EMPNO + 1 등의 로직을 통해 사번을 넣어주는게 가장 중요한 로직
*따라서 ITAB에는 새로운 사번에 대한 정보가 아직 존재하지 않음.
INSERT ZT05_0010 FROM TABLE LT_SAVE_I
                 ACCEPTING DUPLICATE KEYS. "KEY가 중복 안되는 DATA 가 삽입

  IF SY-SUBRC = 0.
      COMMIT WORK.

      LOOP AT ITAB ASSIGNING <FS_ISTR>
                 WHERE STAT = ICON_LED_YELLOW
                  AND EMPNO = ''. "생성 시  노란색 + 사번이 없는 친구들만 LOOP 돌면서 작업을 진행
                          <FS_ISTR>-STAT = ICON_LED_GREEN.
                          <FS_ISTR>-EMPNO = <FS_ISTR>-EMPNO_BACKUP.
                          <FS_ISTR>-ERDAT = LS_SAVE-ERDAT. "미처리 시  생성정보를 DB와 인터널 데이블 간 연동 X  ERROR 발생
                          <FS_ISTR>-ERZET = LS_SAVE-ERZET. "미처리 시  생성정보를 DB와 인터널 데이블 간 연동 X  ERROR 발생
                          <FS_ISTR>-ERNAM = LS_SAVE-ERNAM. "미처리 시  생성정보를 DB와 인터널 데이블 간 연동 X  ERROR 발생

    ENDLOOP.
  ELSE.
    ROLLBACK WORK.
*< 실패 시 >
    ISTR-STAT = ICON_LED_RED.
    ISTR-RESULT = TEXT-M05. "신규 사원 생성 정보 저장 중 오류가 발생하였습니다 !
    MODIFY ITAB FROM ISTR TRANSPORTING STAT RESULT
                           WHERE STAT = ICON_LED_YELLOW
                           AND EMPNO = ''.
    ENDIF.

*< 변경 시 >
    UPDATE ZT05_0010 FROM TABLE LT_SAVE_U.
        IF SY-SUBRC = 0.
          COMMIT WORK.

          CLEAR ISTR.
          ISTR-STAT = ICON_LED_GREEN.
          MODIFY ITAB FROM ISTR
          "LOOP를 써 ITAB INTO ISTR 를 + INDEX를  써도 되지만 TRANSPORTING을 써서 간단히 변경 가능

                   TRANSPORTING STAT "TRANSPORTIONG + 바꾸고자 하는 필드
                          WHERE STAT = ICON_LED_YELLOW "필드 = 노란불
                                AND EMPNO NE ''. "EMPNO != NULL

          ELSE.
            ROLLBACK WORK.
            ISTR-STAT = ICON_LED_RED.
            ISTR-RESULT = TEXT-M06. "사원 정보 변경 저장 중 오류가 발생하였습니다 !
            MODIFY ITAB FROM ISTR TRANSPORTING STAT RESULT
                                 WHERE STAT = ICON_LED_YELLOW "노랑색이며 NULL이 아닌 경우
                                 AND EMPNO <> ''.
            ENDIF.

*< 처리 결과 ALV에 반영 >


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_RESULT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_TEXT_M01  text
*      <--P_<FS_ISTR>_RESULT  text
*&---------------------------------------------------------------------*
FORM SET_RESULT  USING    P_TEXT
                 CHANGING P_RESULT.

  IF P_RESULT IS INITIAL.
      P_RESULT = P_TEXT.
    ELSE.

*아래와 같이 처리를 하지 않으면 각각의 큰 IF 문 내에서 MESSAGE가 연결되지 않는 경우가 발생할 수 있음
*따라서 중복 또는 누락 방지 처리를 해줘야 함
   CONCATENATE P_RESULT P_TEXT "이름 부서 입사일 직급 재직구분은 필수 입력 필드 입니다 !
        INTO P_RESULT
        SEPARATED BY '#'. "두 개의 메시지가 합쳐져서 나옴 ( = 다수 처리에 있어 MESSAGE가 중복 또는 누락을 방지  )
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CHECK_LINE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_<FS_ISTR>  text
*      <--P_LV_ERR  text
*&---------------------------------------------------------------------*
FORM CHECK_LINE  CHANGING PS_ISTR LIKE ISTR P_ERR.

     CLEAR PS_ISTR-RESULT. "반복되서 출력되기 때문에 이후에도 남아있을 수 있어 중간에 CLEAR

*< 필수 필드 검증 >
*필수 필드 상시 처리
      IF PS_ISTR-NAME IS INITIAL OR
          PS_ISTR-DEPT IS INITIAL OR
          PS_ISTR-ENTDT IS INITIAL OR
          PS_ISTR-GRADE IS INITIAL OR
          PS_ISTR-STATUS IS INITIAL.
          PS_ISTR-STAT = ICON_LED_RED. "필수 필드를 입력하지 않고 저장을 누를 시 빨간 아이콘을 출력하며 MESSAGE를 생성

          P_ERR = 'X'.
        PERFORM SET_RESULT USING TEXT-M01
                          CHANGING PS_ISTR-RESULT.

ENDIF.

*< 퇴사 처리 >
IF PS_ISTR-STATUS = '3' AND
    PS_ISTR-RETDT IS INITIAL.

    PS_ISTR-STAT = ICON_LED_RED.
    P_ERR = 'X'.
    PERFORM SET_RESULT USING TEXT-M02 "퇴사 일자가 없습니다 !
                      CHANGING PS_ISTR-RESULT.

*< 퇴직 상태가 아니나 퇴직 일자가 있는 경우 >
ELSEIF PS_ISTR-STATUS <> '3' AND
             PS_ISTR-RETDT IS NOT INITIAL.

             P_ERR = 'X'.
         PERFORM SET_RESULT USING TEXT-M03 " 퇴사 일자는 퇴사자인 경우에만 입력 가능합니다!
                           CHANGING PS_ISTR-RESULT.
ENDIF.

*<입력데이터에 대한 유효성 검증>
*퇴사일이 존재하면서 입사일보다 빠를경우 - 퇴사일이 존재하지 않는 값들을 설정하지 않을 시 입사일보다 빠르다고 인식
IF PS_ISTR-RETDT IS NOT INITIAL AND
    PS_ISTR-RETDT < PS_ISTR-ENTDT.

    P_ERR = 'X'.
    PS_ISTR-STAT = ICON_LED_RED.

    PERFORM SET_RESULT USING TEXT-M04 "퇴사일이 입사일 이전 입니다 !
                      CHANGING PS_ISTR-RESULT.

ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_MAX_EMPNO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_LV_EMPNO  text
*&---------------------------------------------------------------------*
FORM GET_MAX_EMPNO  CHANGING P_EMPNO.

      DATA:  LV_YEAR TYPE ZT05_0010-EMPNO.    "매년 증가될  사번 앞자리 DATA를 예상한 선언

*20200804라는 예시에서 앞에 0은 시작점을 잡아줌 0번자리에서 시작해서 4번째 자리까지 선택해라
*= 즉 맨 앞인  2보다 앞에  0을 넣어 시작점으로 하며 앞에서 2020 자리까지 취하는 로직
      CONCATENATE SY-DATUM+0(4) '%' INTO LV_YEAR.

      SELECT MAX( EMPNO )
            INTO P_EMPNO
            FROM ZT05_0010
            WHERE EMPNO LIKE LV_YEAR.

            IF P_EMPNO IS INITIAL.
                CONCATENATE SY-DATUM+0(4) '000000' INTO P_EMPNO. "신규 사원번호 생성일때 뒤에 000000를 추가해줌
            ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form USER_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_TEXT_Q01  text
*      -->P_TEXT_Q02  text
*      <--P_LV_ANSWER  text
*&---------------------------------------------------------------------*
FORM USER_CONFIRM  USING    P_TITLE P_QUEST
                   CHANGING P_ANSWER.

      CLEAR: P_ANSWER.

      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
            TITLEBAR      = P_TITLE
            TEXT_QUESTION = P_QUEST
            TEXT_BUTTON_1 = 'YES'
            TEXT_BUTTON_2 = 'NO'
        IMPORTING
            ANSWER        = P_ANSWER.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DOM_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LS_CHANGED_VALUE  text
*      <--P_LV_TEXT  text
*&---------------------------------------------------------------------*
FORM GET_DOM_TEXT  USING    P_CODE
           CHANGING P_TEXT.

            CLEAR P_TEXT.
            READ TABLE LT_DOMAIN WITH KEY DOMVALUE_L = P_CODE.

            IF SY-SUBRC = 0.
                  P_TEXT = LT_DOMAIN-DDTEXT.
            ENDIF.

ENDFORM.
