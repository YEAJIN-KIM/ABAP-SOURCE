*&---------------------------------------------------------------------*
*& Report Z_R05_0040
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_R05_0040 MESSAGE-ID ZM05.

*파일의 개요. 엑셀파일을 받아서 자료를 올릴 것이기 때문에 조회조건과 GET_DATA부분을 지우고
*ALV를 '깡통'으로 표현만 가능하게 세팅해놓기.

INCLUDE Z_R05_0040_TOP.
INCLUDE Z_R05_0040_SEL.
INCLUDE Z_R05_0040_F01.
INCLUDE Z_R05_0040_O01.
INCLUDE Z_R05_0040_I01.


INITIALIZATION.
*SELECTION-SCREEN  출력 이전에 수행되며 초기값 SETTING


AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_PATH.
*SELECTION-SCREEN 의 PBO
*OUTPUT 출력화면 모드 제어 < INPUT , DISPLAY >
  PERFORM GET_FILE_PATH.

START-OF-SELECTION.

PERFORM UPLOAD_FROM_EXCEL. "경로를 가져온것에서 엑셀파일을 진짜로 가져오는 작업"
PERFORM CONVERT_TO_DISPLAY_FORMAT.

CALL SCREEN 100.
