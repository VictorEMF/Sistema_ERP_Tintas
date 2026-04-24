begin;
merge into core.dm_tinta dt
using
    (
        select distinct on(nk_cod_tinta)
        nk_cod_tinta,
        fabrica,
        cod_fabricante,
        cor,
        acabamento,
        resina,
        estoque_inicial,
        tara_caixa,
        valor_unitario,
        valor_estoque,
        data
        from stage.stg_tinta
        order by nk_cod_tinta
    ) MERGE_SUBQUERY

on ( dt.nk_cod_tinta = MERGE_SUBQUERY.nk_cod_tinta )

when not matched then

insert(
    nk_cod_tinta,
    fabrica,
    cod_fabricante,
    cor,
    acabamento,
    resina,
    estoque_inicial,
    tara_caixa,
    valor_unitario,
    valor_estoque,
    data    
)

values(
    MERGE_SUBQUERY.nk_cod_tinta,
    MERGE_SUBQUERY.fabrica,
    MERGE_SUBQUERY.cod_fabricante,
    MERGE_SUBQUERY.cor,
    MERGE_SUBQUERY.acabamento,
    MERGE_SUBQUERY.resina,
    MERGE_SUBQUERY.estoque_inicial,
    MERGE_SUBQUERY.tara_caixa,
    MERGE_SUBQUERY.valor_unitario,
    MERGE_SUBQUERY.valor_estoque,
    MERGE_SUBQUERY.data     
)

when matched and(
    dt.fabrica                 is distinct from     MERGE_SUBQUERY.fabrica
    or dt.cod_fabricante       is distinct from     MERGE_SUBQUERY.cod_fabricante
    or dt.cor                  is distinct from     MERGE_SUBQUERY.cor
    or dt.acabamento           is distinct from     MERGE_SUBQUERY.acabamento
    or dt.resina               is distinct from     MERGE_SUBQUERY.resina
    or dt.estoque_inicial      is distinct from     MERGE_SUBQUERY.estoque_inicial
    or dt.tara_caixa           is distinct from     MERGE_SUBQUERY.tara_caixa
    or dt.valor_unitario       is distinct from     MERGE_SUBQUERY.valor_unitario
    or dt.valor_estoque        is distinct from     MERGE_SUBQUERY.valor_estoque
    or dt.data                 is distinct from     MERGE_SUBQUERY.data   
)

then update set 

    fabrica             =   MERGE_SUBQUERY.fabrica,
    cod_fabricante      =   MERGE_SUBQUERY.cod_fabricante,
    cor                 =   MERGE_SUBQUERY.cor,
    acabamento          =   MERGE_SUBQUERY.acabamento,
    resina              =   MERGE_SUBQUERY.resina,
    estoque_inicial     =   MERGE_SUBQUERY.estoque_inicial,
    tara_caixa          =   MERGE_SUBQUERY.tara_caixa,
    valor_unitario      =   MERGE_SUBQUERY.valor_unitario,
    valor_estoque       =   MERGE_SUBQUERY.valor_estoque,
    data                =   MERGE_SUBQUERY.data, 
    etl_ultimo_dado     =   current_timestamp,
    etl_versao          =   etl_versao + 1;
commit;