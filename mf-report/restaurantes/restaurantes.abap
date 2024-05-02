*&---------------------------------------------------------------------*
*& Report ZMFR_REL_RESTAURANTES_AL13                                   *
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*Informaçõe adicionais de regras da implementação                      *
*----------------------------------------------------------------------*

REPORT ZMFR_REL_RESTAURANTES_AL13.

INCLUDE zmfr_rel_restaurantes_al13_top.
INCLUDE zmfr_rel_restaurantes_al13_src.
INCLUDE zmfr_rel_restaurantes_al13_f01.

*----------------------------------------------------------------------*
* START-OF-SELECTION(Comando)                                          *
*----------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM f_select_restaurantes.
  PERFORM f_process_info.
  PERFORM f_create_fcat.
  PERFORM f_display_alv.
