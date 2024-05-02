*&---------------------------------------------------------------------*
*& Include          ZMFR_REL_CLIENTES_AL13_TOP                         *
*&---------------------------------------------------------------------*

TABLES: zmft_cli_al13.

TYPES: BEGIN OF ty_clientes_age,
         cpf              TYPE stcd2,
         idcliente(10)    TYPE c,
         nome(255)        TYPE c,
         dtnascimento     TYPE dats,
         idade(3)         TYPE i,
         inativo(1)       TYPE c,
         usrcriacao(12)   TYPE c,
         dtcriacao        TYPE dats,
         hrcriacao        TYPE tims,
         usralteracao(12) TYPE c,
         dtalteracao      TYPE dats,
         hralteracao      TYPE tims,
       END OF ty_clientes_age.

DATA: gt_clientes     TYPE TABLE OF zmft_cli_al13,
      gt_clientes_age TYPE TABLE OF ty_clientes_age,
      gt_fieldcat     TYPE slis_t_fieldcat_alv.
