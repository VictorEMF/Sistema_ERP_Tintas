begin;
merge into dw.dm_operacao dmo
using(
    select * from link.dm_operacao order by 1
) MERGE_SUBQUERY

on (dmo.sk_cod_operacao = MERGE_SUBQUERY.sk_cod_operacao)

when not matched then

insert(
    sk_cod_operacao,
    operacao,
    fator_saldo,
    etl_primeiro_dado,
    etl_ultimo_dado,
    etl_versao
)

values(
    MERGE_SUBQUERY.sk_cod_operacao,
    MERGE_SUBQUERY.operacao,
    MERGE_SUBQUERY.fator_saldo,
    MERGE_SUBQUERY.etl_primeiro_dado,
    MERGE_SUBQUERY.etl_ultimo_dado,
    MERGE_SUBQUERY.etl_versao
)

when matched and(
    dmo.operacao                    is distinct from     MERGE_SUBQUERY.operacao
    or dmo.fator_saldo              is distinct from     MERGE_SUBQUERY.fator_saldo
    or dmo.etl_primeiro_dado        is distinct from     MERGE_SUBQUERY.etl_primeiro_dado
    or dmo.etl_ultimo_dado          is distinct from     MERGE_SUBQUERY.etl_ultimo_dado
    or dmo.etl_versao               is distinct from     MERGE_SUBQUERY.etl_versao   
)

then update set

    operacao                =        MERGE_SUBQUERY.operacao,
    fator_saldo             =        MERGE_SUBQUERY.fator_saldo,
    etl_primeiro_dado       =        MERGE_SUBQUERY.etl_primeiro_dado,
    etl_ultimo_dado         =        MERGE_SUBQUERY.etl_ultimo_dado,
    etl_versao              =        MERGE_SUBQUERY.etl_versao;
commit;
