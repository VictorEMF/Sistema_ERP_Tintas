begin;
merge into core.dm_servico ds
using(
    select distinct on(nk_cod_servico)
    nk_cod_servico,
	valor_servico,
	data_servico
    from stage.stg_servico
    order by nk_cod_servico
) MERGE_SUBQUERY

on ( ds.nk_cod_servico = MERGE_SUBQUERY.nk_cod_servico )

when not matched then

insert(
    nk_cod_servico,
	valor_servico,
	data_servico 
)

values(
    MERGE_SUBQUERY.nk_cod_servico,
	MERGE_SUBQUERY.valor_servico,
	MERGE_SUBQUERY.data_servico
)

when matched and(
	ds.valor_servico       is distinct from    MERGE_SUBQUERY.valor_servico
	or ds.data_servico     is distinct from    MERGE_SUBQUERY.data_servico
)

then update set

	valor_servico       =   MERGE_SUBQUERY.valor_servico,
	data_servico        =   MERGE_SUBQUERY.data_servico,
    etl_ultimo_dado     =   current_timestamp,
    etl_versao          =   etl_versao + 1;
commit;
