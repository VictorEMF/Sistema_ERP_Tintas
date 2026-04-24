begin;
merge into core.dm_operacao dp
using(
    select distinct operacao,
    case 
        when operacao = 'ENTRADA' then +1
        when operacao = 'SAÍDA' then -1
        else 0
    end as fator_saldo
    from stage.stg_estoque order by operacao
) MERGE_SUBQUERY

on (dp.operacao = MERGE_SUBQUERY.operacao)

when not matched then

insert(
    operacao,
    fator_saldo
)

values(
    MERGE_SUBQUERY.operacao,
    MERGE_SUBQUERY.fator_saldo    
);

commit;
