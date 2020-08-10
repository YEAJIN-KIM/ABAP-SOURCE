*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_053_I01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT INPUT.
    CASE OK_CODE.
     WHEN 'BACK'.
        LEAVE TO SCREEN 0.
     WHEN 'EXIT' OR 'CANC'.
        LEAVE PROGRAM.
    ENDCASE.
ENDMODULE.

MODULE USER_COMMAND_0100 INPUT.
      CASE OK_CODE.
         WHEN 'SAVE'.
*ALV GRID 상에서  변경하고 클릭 시  DATA_CHANGED 가 발생
*= ALV 변경 내역이 담긴 INTERNAL TABLE이 존재
*만약 ALV GRID에서 클릭하지 않고 SAVE를 하면 변경된 정보가 반영되지 않음
*이는 변경사항이 반영되지 않고 REFRESH가  발생해
*INTERNAL TABLE 에 존재하는 변경되지 않은 기존의 DATA가 바로 ALV에 반영되기 때문

*따라서 USE_COMMAND에서  위와 같은 상황을 방지하기 위해 CHECK_CHANGED_DATA 를 실행

*CTRL + F6
*INSTRANCE  : GO_ALV
*CLASS : Cl_GUI_ALV_GRID
*METHOD :CHECK_CHANGED_DATA.
*REFRESH와 CHECK_CHANGED_DATA를 구분지어 사용하기.
          PERFORM SAVE_DATA.

        ENDCASE.

          CLEAR OK_CODE.

ENDMODULE.
