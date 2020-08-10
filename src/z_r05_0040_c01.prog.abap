*&---------------------------------------------------------------------*
*& Include          Z_R05_0040_C01
*&---------------------------------------------------------------------*


CLASS LCL_EVENT_RECEIVER DEFINITION.

        PUBLIC SECTION .
  "CL_GUI_ALV_GRID SE24에서 확인하면서
  "CL_GUI_ALV_GRUD의 이벤트 중 하나인 DATA_CHANGED에 대해서는 HANDLE_DATA_CHANGED로 받겠다는 의미.

              METHODS: HANDLE_DATA_CHANGED
                                 FOR EVENT DATA_CHANGED  OF CL_GUI_ALV_GRID
              IMPORTING ER_DATA_CHANGED. "DATA_CHANGED의 파라미터중 보통 이것만을 사용함"

ENDCLASS.

CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.
             METHOD: HANDLE_DATA_CHANGED.
                PERFORM HANDLE_DATA_CHNGED USING ER_DATA_CHANGED. "DEFINITION의 IMPORTING 사용
             ENDMETHOD.

ENDCLASS.

*위의 클래스를 참조하는 변수 선언.
DATA: GO_EVENT_RECEIVER TYPE REF TO LCL_EVENT_RECEIVER.

*여기까지 해주었으면 CREATE OBJECT를 사용해야함. -> PBO의 스크린 세팅 (SETTING_ALV_100)에서 진행.
