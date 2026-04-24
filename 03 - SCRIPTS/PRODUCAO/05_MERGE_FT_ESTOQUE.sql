begin;
merge into dw.ft_estoque fe
using(
    select * from link.ft_estoque order by 1
) MERGE_SUBQUERY 

on (fe.nk_cod_estoque = MERGE_SUBQUERY.nk_cod_estoque)

when not matched then
insert (
    nk_cod_estoque,
    sk_cod_servico,
    sk_cod_tinta,
    sk_cod_operacao,
    sk_cod_data,
    tipo_produto,
    data_servico,
    pedido,
    valor_opercao,
    saldo_final,
    obs,
    etl_primeiro_dado,
    etl_ultimo_dado,
    etl_versao
)
values(
    MERGE_SUBQUERY.nk_cod_estoque,
    MERGE_SUBQUERY.sk_cod_servico,
    MERGE_SUBQUERY.sk_cod_tinta,
    MERGE_SUBQUERY.sk_cod_operacao,
    MERGE_SUBQUERY.sk_cod_data,
    MERGE_SUBQUERY.tipo_produto,
    MERGE_SUBQUERY.data_servico,
    MERGE_SUBQUERY.pedido,
    MERGE_SUBQUERY.valor_opercao,
    MERGE_SUBQUERY.saldo_final,
    MERGE_SUBQUERY.obs,
    MERGE_SUBQUERY.etl_primeiro_dado,
    MERGE_SUBQUERY.etl_ultimo_dado,
    MERGE_SUBQUERY.etl_versao 
)

when matched and
(
    fe.sk_cod_servico           is distinct from  MERGE_SUBQUERY.sk_cod_servico
    or fe.sk_cod_tinta          is distinct from  MERGE_SUBQUERY.sk_cod_tinta
    or fe.sk_cod_operacao       is distinct from  MERGE_SUBQUERY.sk_cod_operacao
    or fe.sk_cod_data           is distinct from  MERGE_SUBQUERY.sk_cod_data
    or fe.tipo_produto          is distinct from  MERGE_SUBQUERY.tipo_produto
    or fe.data_servico          is distinct from  MERGE_SUBQUERY.data_servico
    or fe.pedido                is distinct from  MERGE_SUBQUERY.pedido
    or fe.valor_opercao         is distinct from  MERGE_SUBQUERY.valor_opercao
    or fe.saldo_final           is distinct from  MERGE_SUBQUERY.saldo_final
    or fe.obs                   is distinct from  MERGE_SUBQUERY.obs
    or fe.etl_primeiro_dado     is distinct from  MERGE_SUBQUERY.etl_primeiro_dado
    or fe.etl_ultimo_dado       is distinct from  MERGE_SUBQUERY.etl_ultimo_dado
    or fe.etl_versao            is distinct from  MERGE_SUBQUERY.etl_versao  
)

then update set

    sk_cod_servico          =   MERGE_SUBQUERY.sk_cod_servico,
    sk_cod_tinta            =   MERGE_SUBQUERY.sk_cod_tinta,
    sk_cod_operacao         =   MERGE_SUBQUERY.sk_cod_operacao,
    sk_cod_data             =   MERGE_SUBQUERY.sk_cod_data,
    tipo_produto            =   MERGE_SUBQUERY.tipo_produto,
    data_servico            =   MERGE_SUBQUERY.data_servico,
    pedido                  =   MERGE_SUBQUERY.pedido,
    valor_opercao           =   MERGE_SUBQUERY.valor_opercao,
    saldo_final             =   MERGE_SUBQUERY.saldo_final,
    obs                     =   MERGE_SUBQUERY.obs,
    etl_primeiro_dado       =   MERGE_SUBQUERY.etl_primeiro_dado,
    etl_ultimo_dado         =   MERGE_SUBQUERY.etl_ultimo_dado,
    etl_versao              =   MERGE_SUBQUERY.etl_versao;
commit;