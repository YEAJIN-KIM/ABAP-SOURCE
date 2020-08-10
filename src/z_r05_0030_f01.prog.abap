*&---------------------------------------------------------------------*
*& Include          Z_R05_0030_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form CREATE_MATERIAL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_MATERIAL .
*GT_BDC를 채우는 것이 목적 - BDC를 위한 INTERNAL TABLE이기 때문
*GT_BDC의 구조 PROGRAM DYNPRO DYNBEGIN FNAM FVAL
*녹화구조와 동일하며 이를 채워주는 과정이 필요
*02
  CLEAR GT_BDC.

  PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0060' 'X' '' '',
                             '' '' '' 'BDC_OKCODE' '=ENTR',
                             '' '' '' 'RMMG1-MATNR' P_MATNR,
                             '' '' '' 'RMMG1-MBRSH' 'M',
                             '' '' '' 'RMMG1-MTART' 'FERT'.

PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0070' 'X' '' '',
                             '' '' '' 'BDC_OKCODE' '=ENTR',
                             '' '' '' 'MSICHTAUSW-KZSEL(01)' 'X'.

PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '4004' 'X' '' '',
                             '' '' '' 'BDC_OKCODE' '=BU',
                             '' '' '' 'MAKT-MAKTX' P_MAKTX,
                             '' '' '' 'MARA-MEINS' 'EA'.
**01
*CLEAR GS_BDC.
*GS_BDC-PROGRAM = 'SAPLMGMM'.
*GS_BDC-DYNPRO = '0060'.
*GS_BDC-DYNBEGIN = 'X'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'BDC_OKCODE'.
*GS_BDC-FVAL = '=ENTR'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'RMMG1-MATNR'.
*GS_BDC-FVAL = P_MATNR.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'RMMG1-MBRSH'.
*GS_BDC-FVAL = 'M'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'RMMG1-MTART'.
*GS_BDC-FVAL = 'FERT'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-PROGRAM = 'SAPLMGMM'.
*GS_BDC-DYNPRO = '0070'.
*GS_BDC-DYNBEGIN = 'X'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'BDC_OKCODE'.
*GS_BDC-FVAL = '=ENTR'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'MSICHTAUSW-KZSEL(01)'.
*GS_BDC-FVAL = 'X'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-PROGRAM = 'SAPLMGMM'.
*GS_BDC-DYNPRO = '4004'.
*GS_BDC-DYNBEGIN = 'X'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'BDC_OKCODE'.
*GS_BDC-FVAL = '=BU'.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'MAKT-MAKTX'.
*GS_BDC-FVAL = P_MAKTX. "'김학준 자재'를 파라미터로 변환.
*APPEND GS_BDC TO GT_BDC.
*
*CLEAR GS_BDC.
*GS_BDC-FNAM = 'MARA-MEINS'.
*GS_BDC-FVAL = 'EA'.
*APPEND GS_BDC TO GT_BDC.



CLEAR GS_OPT.
GS_OPT-DISMODE = 'N'. "A모드, -  BDC의 화면을 다 띄어주는 모드
                      "N모드-실행했을 때 성공했다고 메시지만 제시(백그라운드에서 작업)
                      "E모드 - 백그라운드에서 작업하지만 에러발생시 에러창을 띄워줌"
                      "보통 코딩상 모드를 제시하지만 N모드로 디플트로 설정, 에러발생시 A,E로 수행"
GS_OPT-UPDMODE = 'S'.


"CALL TRANSACTION에 대한 KEY워드 설명에 들어가서 보면 OPTIONS FROM/MESSAGE INTO에 대한
*설명과 필요한 변수가 제시되어 있다. 이에 맞추어서 TOP에서 변수 선언해줌.


CALL TRANSACTION 'MM01' USING GT_BDC
                        OPTIONS FROM GS_OPT
                        MESSAGES INTO GT_MSG.

READ TABLE GT_MSG INTO GS_MSG WITH KEY MSGID = 'M3' "Batch input message ID
                                                                                MSGNR = '800'. "Batch input message number

IF SY-SUBRC  = 0.
*성공 처리
   MESSAGE S009 WITH P_MATNR. " 자재코드 & 가 생성되었습니다.
ELSE.
*실패처리

ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_BDC_TAB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*&---------------------------------------------------------------------*
FORM SET_BDC_TAB  USING  P_PROGRAM
                                                  P_DYNPRO
                                                  P_DYNGEGIN
                                                  P_FNAME
                                                  P_EVAL.

  CLEAR GS_BDC.
  GS_BDC-PROGRAM = P_PROGRAM.
  GS_BDC-DYNPRO = P_DYNPRO.
  GS_BDC-DYNBEGIN = P_DYNGEGIN.
  GS_BDC-FNAM = P_FNAME.
  GS_BDC-FVAL = P_EVAL.

    APPEND GS_BDC TO GT_BDC.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form MESSAGE_TEST
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM MESSAGE_TEST .
*
*   MESSAGE S000 WITH 'AAA' 'BBB' 'CCC' 'DDD'.
*   MESSAGE S008 WITH P_MATNR.
*
*ENDFORM.
