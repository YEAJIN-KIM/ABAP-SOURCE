
*&---------------------------------------------------------------------*
*& Include          Z_PTJ01_051_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
 SET PF-STATUS '0100'.
 SET TITLEBAR '0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_ALV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE CREATE_ALV OUTPUT.

      PERFORM SET_ALV_0100.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0150 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0150 OUTPUT.
 SET PF-STATUS '0150'.
 SET TITLEBAR '0150'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_SCREEN_MODE_0150 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE SET_SCREEN_MODE_0150 OUTPUT.
      LOOP AT SCREEN INTO SCREEN.

        "수행 모드에 따른 INPUT 필드 제어
            CASE GS_DISP_0150-MODE.
                  WHEN GC_MODE_INSERT.
                     IF SCREEN-NAME = 'GS_DISP_0150-RETDT'.
                          SCREEN-INPUT = 0.
                     ENDIF.

                   WHEN GC_MODE_UPDATE.
                     IF SCREEN-NAME = 'GS_DISP_0150-EMPNO'.
                          SCREEN-INPUT = 0.
                     ENDIF.

                     IF SCREEN-NAME = 'GS_DISP_0150-RETDT'.
                          SCREEN-INPUT = 0.
                     ENDIF.

                    WHEN GC_MODE_RETIRE.
                      IF SCREEN-NAME = 'GS_DISP_0150-RETDT'.
                          SCREEN-INPUT = 1.
                      ELSE.
                           SCREEN-INPUT = 0.
                      ENDIF.
               ENDCASE.

            "수행 모드에 따른 IREQUIRED 필드 제어
             "등록/변경 시 입사일
             "퇴직 시 퇴사일
               CASE GS_DISP_0150-MODE.
                  WHEN GC_MODE_INSERT OR GC_MODE_UPDATE.
                     IF SCREEN-NAME = 'GS_DISP_0150-ENTDT'.
                          SCREEN-REQUIRED = 1.
                     ENDIF.

                    WHEN GC_MODE_RETIRE.
                      IF SCREEN-NAME = 'GS_DISP_0150-RETDT'.
                          SCREEN-REQUIRED = 1.
                      ENDIF.
               ENDCASE.

         MODIFY SCREEN FROM SCREEN.
      ENDLOOP.
ENDMODULE.
