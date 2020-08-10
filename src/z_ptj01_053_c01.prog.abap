*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_053_C01
*&---------------------------------------------------------------------*

*이 프로그램에서는 이벤트는 ALV에서 발생시키고 이를 받는 리시버가 필요함.
*SE24는 글로벌 클래스이고 여기서 만드는 것은 LOCAL CLASS.
*CLASS는 DEFINITION과 IMPLEMENTATION 쌍으로 움직임.

*이름은 ABAP에서 제공하는 클래스인 CL/ 내가 전역으로 사용하력 만드는 ZCL/ 로컬 프로그램에서만 사용하는 LCL로 보통 구분을 함.

CLASS LCL_EVENT_RECEIVER DEFINITION.
        PUBLIC SECTION .
  "CL_GUI_ALV_GRID SE24에서 확인하면서
  "CL_GUI_ALV_GRUD의 이벤트 중 하나인 DATA_CHANGED에 대해서는 HANDLE_DATA_CHANGED로 받겠다는 의미.

              METHODS: HANDLE_DATA_CHANGED
                                 FOR EVENT DATA_CHANGED  OF CL_GUI_ALV_GRID
              IMPORTING ER_DATA_CHANGED. "DATA_CHANGED의 파라미터중 보통 이것만을 사용함"


              METHODS: HANDLE_DOUBLE_CLICK
                                 FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
              IMPORTING E_ROW
                                  E_COLUMN
                                  ES_ROW_NO. "한줄 전체를 가지고 처리할 경우에는 이것을 사용 (파라미터가 ROW_ID)

*SE 24 에서 CL_GUI_ALV_GRID -TOOLBAR을 찾아 사용

              METHODS: HANDLE_TOOLBAR FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
                                 IMPORTING E_OBJECT.

              METHODS: HANDLE_USER_COMMAND
                                 FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
               IMPORTING E_UCOMM.


ENDCLASS.

CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.
             METHOD: HANDLE_DATA_CHANGED.
                PERFORM HANDLE_DATA_CHNGED USING ER_DATA_CHANGED. "DEFINITION의 IMPORTING 사용
             ENDMETHOD.

             METHOD : HANDLE_DOUBLE_CLICK.
             ENDMETHOD.

              METHOD: HANDLE_TOOLBAR.
                  PERFORM HANDLE_TOOLBAR USING E_OBJECT.
                  "TOOLBAR에 버튼 생성 후 이를 처리할 수 있는USER COMMAND를 생성
                  "ALV에서 기본적으로 제공하는 버튼은 PBO PAI를 타지않고 ALV 상에서만 구현 됨
                  "즉, 내가 TOOLBAR에서 생성한 버튼도 PBO를 타지 않기 때문에
                  "USER_COMMAND에서 임의로 버튼에 REFRESH 를 넣어 PBO를 탈 수 있게 해줌
               ENDMETHOD.

               METHOD: HANDLE_USER_COMMAND. "GRID 상에서 BUTTON을 누르는 것을 감지하는 EVENT
                  PERFORM HANDLE_USER_COMMAND USING E_UCOMM.
               ENDMETHOD.

ENDCLASS.

*위의 클래스를 참조하는 변수 선언.
DATA: GO_EVENT_RECEIVER TYPE REF TO LCL_EVENT_RECEIVER.

*여기까지 해주었으면 CREATE OBJECT를 사용해야함. -> PBO의 스크린 세팅 (SETTING_ALV_100)에서 진행.
