begin;
merge into dw.dm_servico ds
using(
    select * from link.dm_servico order by 1
) MERGE_SUBQUERY

on ( ds.nk_cod_servico = MERGE_SUBQUERY.nk_cod_servico )

when not matched then

insert(
    sk_cod_servico,
    nk_cod_servico,
	valor_servico,
	data_servico,
    etl_primeiro_dado,
    etl_ultimo_dado,
    etl_versao
)

values(
    MERGE_SUBQUERY.sk_cod_servico,
    MERGE_SUBQUERY.nk_cod_servico,
	MERGE_SUBQUERY.valor_servico,
	MERGE_SUBQUERY.data_servico,
    MERGE_SUBQUERY.etl_primeiro_dado,
    MERGE_SUBQUERY.etl_ultimo_dado,
    MERGE_SUBQUERY.etl_versao 
)

when matched and(
	ds.valor_servico            is distinct from     MERGE_SUBQUERY.valor_servico
	or ds.data_servico          is distinct from     MERGE_SUBQUERY.data_servico
    or ds.etl_primeiro_dado     is distinct from     MERGE_SUBQUERY.etl_primeiro_dado
    or ds.etl_ultimo_dado       is distinct from     MERGE_SUBQUERY.etl_ultimo_dado
    or ds.etl_versao            is distinct from     MERGE_SUBQUERY.etl_versao
)

then update set

	valor_servico        =   MERGE_SUBQUERY.valor_servico,
	data_servico         =   MERGE_SUBQUERY.data_servico,
    etl_primeiro_dado    =   MERGE_SUBQUERY.etl_primeiro_dado,
    etl_ultimo_dado      =   MERGE_SUBQUERY.etl_ultimo_dado,
    etl_versao           =   MERGE_SUBQUERY.etl_versao;
commit;