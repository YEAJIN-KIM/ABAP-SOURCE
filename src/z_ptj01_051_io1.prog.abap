*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_051_IO1
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
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
        CASE OK_CODE.
          WHEN 'HELLO'.
              PERFORM CALL_CREATE_SCREEN.

          WHEN 'MODIFY'.
              PERFORM GET_SELECTED_ROWS.
*
          WHEN 'GOODBYE'.
              PERFORM BYE_RETIRE.
        ENDCASE.

        CLEAR OK_CODE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXITS  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXITS INPUT.
          CASE OK_CODE.
            WHEN 'BACK'.
              LEAVE TO SCREEN 0.
            WHEN 'EXIT' OR 'CANC'.
              LEAVE PROGRAM.
           ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0150  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0150 INPUT.
            CASE OK_CODE.
              WHEN 'SAVE'.
                CASE GS_DISP_0150-MODE.
                    WHEN GC_MODE_INSERT.
                           PERFORM GET_DATA.

                     WHEN GC_MODE_UPDATE.
                            PERFORM UPDATE_DATA.

                     WHEN GC_MODE_RETIRE.
                            PERFORM RETIRE_DATA.
                  ENDCASE.
              WHEN 'CANC1'.
                   LEAVE TO SCREEN 0.
            ENDCASE.
ENDMODULE.
