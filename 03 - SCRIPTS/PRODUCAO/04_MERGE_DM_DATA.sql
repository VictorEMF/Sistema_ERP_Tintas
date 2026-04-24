begin;
merge into dw.dm_data dmd
using(
    select * from link.dm_data order by 1
) MERGE_SUBQUERY

on (dmd.nk_cod_data = MERGE_SUBQUERY.nk_cod_data)

when not matched then

insert(
    sk_cod_data,
	nk_cod_data,
	desc_data_completa,
	nr_ano,
	nm_trimestre,
	nr_ano_trimestre,
	nr_mes,
	nm_mes,
	ano_mes,
	nr_semana,
	ano_semana,
	nr_dia,
	nr_dia_ano,
	nm_dia_semana,
	flag_final_semana,
	flag_feriado,
	nm_feriado,
	etl_primeiro_dado,
	etl_ultimo_dado,
	etl_versao
)

values(
    MERGE_SUBQUERY.sk_cod_data,
	MERGE_SUBQUERY.nk_cod_data,
	MERGE_SUBQUERY.desc_data_completa,
	MERGE_SUBQUERY.nr_ano,
	MERGE_SUBQUERY.nm_trimestre,
	MERGE_SUBQUERY.nr_ano_trimestre,
	MERGE_SUBQUERY.nr_mes,
	MERGE_SUBQUERY.nm_mes,
	MERGE_SUBQUERY.ano_mes,
	MERGE_SUBQUERY.nr_semana,
	MERGE_SUBQUERY.ano_semana,
	MERGE_SUBQUERY.nr_dia,
	MERGE_SUBQUERY.nr_dia_ano,
	MERGE_SUBQUERY.nm_dia_semana,
	MERGE_SUBQUERY.flag_final_semana,
	MERGE_SUBQUERY.flag_feriado,
	MERGE_SUBQUERY.nm_feriado,
	MERGE_SUBQUERY.etl_primeiro_dado,
	MERGE_SUBQUERY.etl_ultimo_dado,
	MERGE_SUBQUERY.etl_versao
)

when matched and(
    dmd.desc_data_completa          is distinct from 	MERGE_SUBQUERY.desc_data_completa
	or dmd.nr_ano                   is distinct from 	MERGE_SUBQUERY.nr_ano
	or dmd.nm_trimestre             is distinct from 	MERGE_SUBQUERY.nm_trimestre
	or dmd.nr_ano_trimestre         is distinct from 	MERGE_SUBQUERY.nr_ano_trimestre
	or dmd.nr_mes                   is distinct from 	MERGE_SUBQUERY.nr_mes
	or dmd.nm_mes                   is distinct from 	MERGE_SUBQUERY.nm_mes
	or dmd.ano_mes                  is distinct from 	MERGE_SUBQUERY.ano_mes
	or dmd.nr_semana                is distinct from 	MERGE_SUBQUERY.nr_semana
	or dmd.ano_semana               is distinct from 	MERGE_SUBQUERY.ano_semana
	or dmd.nr_dia                   is distinct from 	MERGE_SUBQUERY.nr_dia
	or dmd.nr_dia_ano               is distinct from 	MERGE_SUBQUERY.nr_dia_ano
	or dmd.nm_dia_semana            is distinct from 	MERGE_SUBQUERY.nm_dia_semana
	or dmd.flag_final_semana        is distinct from 	MERGE_SUBQUERY.flag_final_semana
	or dmd.flag_feriado             is distinct from 	MERGE_SUBQUERY.flag_feriado
	or dmd.nm_feriado               is distinct from 	MERGE_SUBQUERY.nm_feriado
	or dmd.etl_primeiro_dado        is distinct from 	MERGE_SUBQUERY.etl_primeiro_dado
	or dmd.etl_ultimo_dado          is distinct from 	MERGE_SUBQUERY.etl_ultimo_dado
	or dmd.etl_versao               is distinct from 	MERGE_SUBQUERY.etl_versao
)

then update set

	desc_data_completa      =    	MERGE_SUBQUERY.desc_data_completa,           
	nr_ano                  =    	MERGE_SUBQUERY.nr_ano,
	nm_trimestre            =    	MERGE_SUBQUERY.nm_trimestre,       
	nr_ano_trimestre        =    	MERGE_SUBQUERY.nr_ano_trimestre,           
	nr_mes                  =    	MERGE_SUBQUERY.nr_mes,
	nm_mes                  =    	MERGE_SUBQUERY.nm_mes,
	ano_mes                 =    	MERGE_SUBQUERY.ano_mes,
	nr_semana               =    	MERGE_SUBQUERY.nr_semana,   
	ano_semana              =    	MERGE_SUBQUERY.ano_semana,   
	nr_dia                  =    	MERGE_SUBQUERY.nr_dia,
	nr_dia_ano              =    	MERGE_SUBQUERY.nr_dia_ano,   
	nm_dia_semana           =    	MERGE_SUBQUERY.nm_dia_semana,       
	flag_final_semana       =    	MERGE_SUBQUERY.flag_final_semana,      
	flag_feriado            =    	MERGE_SUBQUERY.flag_feriado,      
	nm_feriado              =    	MERGE_SUBQUERY.nm_feriado,  
	etl_primeiro_dado       =    	MERGE_SUBQUERY.etl_primeiro_dado,      
	etl_ultimo_dado         =    	MERGE_SUBQUERY.etl_ultimo_dado,  
	etl_versao              =    	MERGE_SUBQUERY.etl_versao; 
commit; 