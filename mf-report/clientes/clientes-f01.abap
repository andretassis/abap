*&---------------------------------------------------------------------*
*& Include          ZMFR_REL_CLIENTES_AL13_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f_select_clientes
*&---------------------------------------------------------------------*

FORM f_select_clientes .

  SELECT * "selecione os campos
     FROM zmft_cli_al13 "dessa tabela
     WHERE cpf IN @s_cpf AND nome IN @s_nome AND dtnascimento IN @s_dtnasc "onde essa clausula seja atendida
     INTO TABLE @gt_clientes ."jogue o valor nesse campo/estrutura/tabela

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_process_info
*&---------------------------------------------------------------------*

FORM f_process_info .

  DATA: ls_clientes_age LIKE LINE OF gt_clientes_age.

  LOOP AT gt_clientes INTO DATA(ls_clientes).
    ls_clientes_age-cpf          = ls_clientes-cpf.
    ls_clientes_age-idcliente    = ls_clientes-idcliente.
    ls_clientes_age-nome         = ls_clientes-nome.
    ls_clientes_age-dtnascimento = ls_clientes-dtnascimento.
    ls_clientes_age-idade        = COND #( WHEN ls_clientes-dtnascimento IS NOT INITIAL THEN |{ ( sy-datum - ls_clientes-dtnascimento ) / 365 }| ELSE '' ).
    ls_clientes_age-inativo      = ls_clientes-inativo.
    ls_clientes_age-dtcriacao    = ls_clientes-dtcriacao.
    ls_clientes_age-hrcriacao    = ls_clientes-hrcriacao.
    ls_clientes_age-usrcriacao   = ls_clientes-usrcriacao.
    ls_clientes_age-dtalteracao  = ls_clientes-dtalteracao.
    ls_clientes_age-hralteracao  = ls_clientes-hralteracao.
    ls_clientes_age-usralteracao = ls_clientes-usralteracao.

    APPEND ls_clientes_age TO gt_clientes_age.

  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_create_fcat
*&---------------------------------------------------------------------*

FORM f_create_fcat .

  gt_fieldcat = VALUE slis_t_fieldcat_alv( ( fieldname = 'CPF' outputlen = 14 reptext_ddic = 'CPF' edit_mask = '___.___.___-__' )
                                           ( fieldname = 'IDCLIENTE' outputlen = 10 reptext_ddic = 'ID do Cliente' )
                                           ( fieldname = 'NOME' outputlen = 255 reptext_ddic = 'Nome' )
                                           ( fieldname = 'DTNASCIMENTO' outputlen = 8 reptext_ddic = 'Data de Nascimento' )
                                           ( fieldname = 'IDADE' outputlen = 3 reptext_ddic = 'Idade' )
                                           ( fieldname = 'INATIVO' outputlen = 1 reptext_ddic = 'Registro Inativo?' checkbox = abap_true )
                                           ( fieldname = 'USRCRIACAO' outputlen = 12 reptext_ddic = 'Usuário de Criação' )
                                           ( fieldname = 'DTCRIACAO' outputlen = 8 reptext_ddic = 'Data de Criação' )
                                           ( fieldname = 'HRCRIACAO' outputlen = 6 reptext_ddic = 'Hora da criação' )
                                           ( fieldname = 'USRALTERACAO' outputlen = 12 reptext_ddic = 'Usuário de Alteração' )
                                           ( fieldname = 'DTALTERACAO' outputlen = 8 reptext_ddic = 'Data de Alteração' )
                                           ( fieldname = 'HRALTERACAO' outputlen = 6 reptext_ddic = 'Hora da alteração' ) ).


ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_display_alv
*&---------------------------------------------------------------------*

FORM f_display_alv .

  DATA: ls_layout TYPE slis_layout_alv.

  "Otimização automática da largura das colunas para melhor ajuste de conteúdo e deixar as linhas zebradas na tabela.
  ls_layout-colwidth_optimize = 'X'.
  ls_layout-zebra = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program     = sy-repid "Nome do programa em execução
      i_callback_top_of_page = 'F_TOP_OF_PAGE' "Qual o form responsavel por montar o nosso cabeçalho
      is_layout              = ls_layout
      it_fieldcat            = gt_fieldcat "Layout do Grid
    TABLES
      t_outtab               = gt_clientes_age "De onde vem a informação renderizada no grid
    EXCEPTIONS
      program_error          = 1
      OTHERS                 = 2.

ENDFORM.

*Criar cabeçalho

FORM f_top_of_page.
***=> alv Header declarations
  DATA: lt_header TYPE slis_t_listheader.

  lt_header = VALUE slis_t_listheader(
         ( typ = 'H' info = 'Relatório de Clientes' )
         ( typ = 'A' info = 'MegaFood' )
         ( typ = 'A' info = |Total de registros: { lines(  gt_clientes ) } | )
         ( typ = 'A' info = |Usuário: { sy-uname } | )
         ( typ = 'A' info = |DATA: { sy-datum+6(2) }/{ sy-datum+4(2) }/{ sy-datum(4) } | )
         ( typ = 'A' info = |Hora: { sy-uzeit(2) }:{ sy-uzeit+2(2) }:{ sy-uzeit+4(2) } | )
         ).

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header
      i_logo             = 'LOGOMFOOD'.
ENDFORM.
