INSERT INTO core.dm_data
SELECT
    to_number(to_char(datum,'yyyymmdd'), '99999999') AS sk_tempo,
    datum AS nk_cod_data,
    to_char(datum,'dd/mm/yyyy') AS data_completa_formatada,

    extract(year FROM datum) AS nr_ano,

    'T' || to_char(datum, 'q') AS nm_trimestre,
    to_char(datum, '"T"q/yyyy') AS nr_ano_trimestre,

    extract(month FROM datum) AS nr_mes,

    CASE extract(month FROM datum)
        WHEN 1 THEN 'Janeiro'
        WHEN 2 THEN 'Fevereiro'
        WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Maio'
        WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro'
        WHEN 11 THEN 'Novembro'
        WHEN 12 THEN 'Dezembro'
    END AS nm_mes,

    to_char(datum, 'yyyy/mm') AS nr_ano_nr_mes,

    extract(week FROM datum) AS nr_semana,
    to_char(datum, 'iyyy/iw') AS nr_ano_nr_semana,

    extract(day FROM datum) AS nr_dia,
    extract(doy FROM datum) AS nr_dia_ano,

    CASE extract(isodow FROM datum)
        WHEN 1 THEN 'Segunda-feira'
        WHEN 2 THEN 'Terça-feira'
        WHEN 3 THEN 'Quarta-feira'
        WHEN 4 THEN 'Quinta-feira'
        WHEN 5 THEN 'Sexta-feira'
        WHEN 6 THEN 'Sábado'
        WHEN 7 THEN 'Domingo'
    END AS nm_dia_semana,

    CASE 
        WHEN extract(isodow FROM datum) IN (6, 7) THEN 'Sim'
        ELSE 'Não'
    END AS flag_final_semana,

    CASE 
        WHEN to_char(datum, 'mmdd') IN
            ('0101','0421','0501','0907','1012','1102','1115','1120','1225')
        THEN 'Sim'
        ELSE 'Não'
    END AS flag_feriado,

    CASE 
        WHEN to_char(datum, 'mmdd') = '0101' THEN 'Ano Novo'
        WHEN to_char(datum, 'mmdd') = '0421' THEN 'Tiradentes'
        WHEN to_char(datum, 'mmdd') = '0501' THEN 'Dia do Trabalhador'
        WHEN to_char(datum, 'mmdd') = '0907' THEN 'Dia da Pátria'
        WHEN to_char(datum, 'mmdd') = '1012' THEN 'Nossa Senhora Aparecida'
        WHEN to_char(datum, 'mmdd') = '1102' THEN 'Finados'
        WHEN to_char(datum, 'mmdd') = '1115' THEN 'Proclamação da República'
        WHEN to_char(datum, 'mmdd') = '1120' THEN 'Dia da Consciência Negra'
        WHEN to_char(datum, 'mmdd') = '1225' THEN 'Natal'
        ELSE 'Não é Feriado'
    END AS nm_feriado,

    current_timestamp AS data_carga,
    '2199-12-31'::date AS data_fim_vigencia,
    '1' AS flag_ativo

FROM generate_series(
    '2002-01-01'::date,
    '2035-12-31'::date,
    interval '1 day'
) AS dq(datum)

ORDER BY 1;