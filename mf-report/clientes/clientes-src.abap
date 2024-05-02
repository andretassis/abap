*&---------------------------------------------------------------------*
*& Include          ZMFR_REL_CLIENTES_AL13_SRC
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01. "criar a linha do container em que está o select-options

  SELECT-OPTIONS: s_cpf FOR zmft_cli_al13-cpf,
                  s_nome FOR zmft_cli_al13-nome NO INTERVALS,
                  s_dtnasc FOR zmft_cli_al13-dtnascimento.

SELECTION-SCREEN END OF BLOCK b1.
