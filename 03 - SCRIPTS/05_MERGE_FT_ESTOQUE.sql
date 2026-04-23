begin;
merge into core.ft_estoque fe
using(
    select se.nk_cod_estoque,
        COALESCE(dms.sk_cod_servico, 0) as sk_cod_servico,
        COALESCE(dmt.sk_cod_tinta, -1) as sk_cod_tinta,
        COALESCE(dmo.sk_cod_operacao, -1) as sk_cod_operacao,
        COALESCE(dmd.sk_cod_data, -1) as sk_cod_data,
        se.tipo_produto,
        se.data_servico,
        se.pedido,
        se.valor_opercao,
        se.saldo_final,
        se.obs
    from stage.stg_estoque se
    left join core.dm_servico dms
    on NULLIF(se.nk_cod_servico, '#')::int = dms.nk_cod_servico
    left join core.dm_tinta dmt
    on se.nk_cod_tinta = dmt.nk_cod_tinta
    left join core.dm_operacao dmo
    on se.operacao = dmo.operacao
    left join core.dm_data dmd
    on se.data_servico = dmd.nk_cod_data
    order by 1
) MERGE_SUBQUERY 

on (fe.sk_cod_estoque = MERGE_SUBQUERY.nk_cod_estoque)

when not matched then
insert (
    sk_cod_estoque,
    sk_cod_servico,
    sk_cod_tinta,
    sk_cod_operacao,
    sk_cod_data,
    tipo_produto,
    data_servico,
    pedido,
    valor_opercao,
    saldo_final,
    obs
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
    MERGE_SUBQUERY.obs 
)

when matched and
(
    fe.sk_cod_estoque       is distinct from  MERGE_SUBQUERY.nk_cod_estoque
    or fe.sk_cod_servico    is distinct from  MERGE_SUBQUERY.sk_cod_servico
    or fe.sk_cod_tinta      is distinct from  MERGE_SUBQUERY.sk_cod_tinta
    or fe.sk_cod_operacao   is distinct from  MERGE_SUBQUERY.sk_cod_operacao
    or fe.sk_cod_data       is distinct from  MERGE_SUBQUERY.sk_cod_data
    or fe.tipo_produto      is distinct from  MERGE_SUBQUERY.tipo_produto
    or fe.data_servico      is distinct from  MERGE_SUBQUERY.data_servico
    or fe.pedido            is distinct from  MERGE_SUBQUERY.pedido
    or fe.valor_opercao     is distinct from  MERGE_SUBQUERY.valor_opercao
    or fe.saldo_final       is distinct from  MERGE_SUBQUERY.saldo_final
    or fe.obs               is distinct from  MERGE_SUBQUERY.obs
)

then update set

    sk_cod_estoque          =   MERGE_SUBQUERY.nk_cod_estoque,
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
    etl_ultimo_dado         =   current_timestamp,
    etl_versao              =   fe.etl_versao + 1;
commit;

select se.nk_cod_estoque,
        COALESCE(dms.sk_cod_servico, 0) as sk_cod_servico,
        COALESCE(dmt.sk_cod_tinta, -1) as sk_cod_tinta,
        COALESCE(dmo.sk_cod_operacao, -1) as sk_cod_operacao,
        COALESCE(dmd.sk_cod_data, -1) as sk_cod_data,
        se.tipo_produto,
        se.data_servico,
        se.pedido,
        se.valor_opercao,
        se.saldo_final,
        se.obs
from stage.stg_estoque se
left join core.dm_servico dms
on NULLIF(se.nk_cod_servico, '#')::int = dms.nk_cod_servico
left join core.dm_tinta dmt
on se.nk_cod_tinta = dmt.nk_cod_tinta
left join core.dm_operacao dmo
on se.operacao = dmo.operacao
left join core.dm_data dmd
on se.data_servico = dmd.nk_cod_data
order by 1

colocar em servico o 0