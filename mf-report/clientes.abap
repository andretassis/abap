*&---------------------------------------------------------------------*
*& Report ZMFR_REL_CLIENTES_AL13
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*Informaçõe adicionais de regras da implementação                      *
*----------------------------------------------------------------------*

REPORT zmfr_rel_clientes_al13.

INCLUDE zmfr_rel_clientes_al13_top.
INCLUDE zmfr_rel_clientes_al13_src.
INCLUDE zmfr_rel_clientes_al13_f01.


*----------------------------------------------------------------------*
* START-OF-SELECTION(Comando)                                          *
*----------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM f_select_clientes.
  PERFORM f_process_info. "processar as informações
  PERFORM f_create_fcat.
  PERFORM f_display_alv.
