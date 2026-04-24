CREATE SCHEMA IF NOT EXISTS extensions;
CREATE SCHEMA IF NOT EXISTS link;
CREATE SCHEMA IF NOT EXISTS dw;
CREATE EXTENSION postgres_fdw SCHEMA extensions;

CREATE SERVER serv_dw_dev_pro
FOREIGN DATA WRAPPER postgres_fdw 
OPTIONS (
    host '192.168.0.144', -- Ex: 'localhost' ou IP do TrueNAS
    port '5432', 
    dbname 'dw_desenvolvimento'
);

CREATE USER MAPPING FOR postgres -- O usuário que você usa no dw_pro
SERVER serv_dw_dev_pro 
OPTIONS (
    user 'postgres', 
    password 'postgres'
);

IMPORT FOREIGN SCHEMA core 
LIMIT TO (
	dm_tinta,
	dm_servico,
	dm_operacao,
	dm_data,
	ft_estoque
	) 
FROM SERVER serv_dw_dev_pro 
INTO link;

create table dw.dm_tinta(
	sk_cod_tinta serial,
	nk_cod_tinta varchar(100),
	fabrica varchar(150),
	cod_fabricante varchar(200),
	cor varchar(150),
	acabamento varchar(150),
	resina varchar(150), 
	estoque_inicial numeric(6,2),
	tara_caixa numeric(6,2),
	valor_unitario numeric(6,2),
	valor_estoque numeric(6,2),
	data date,
	etl_primeiro_dado timestamp default current_timestamp,
	etl_ultimo_dado timestamp default current_timestamp,
	etl_versao int default 1,
	CONSTRAINT dm_tinta_pk primary key(sk_cod_tinta)
);

create table dw.dm_servico(
	sk_cod_servico serial,
	nk_cod_servico int,
	valor_servico numeric(8,2),
	data_servico date,
	etl_primeiro_dado timestamp default current_timestamp,
	etl_ultimo_dado timestamp default current_timestamp,
	etl_versao int default 1,
	CONSTRAINT dm_servico_pk primary key(sk_cod_servico)
);

create table dw.dm_operacao(
	sk_cod_operacao serial,
	operacao varchar(7),
	fator_saldo int,
	etl_primeiro_dado timestamp default current_timestamp,
	etl_ultimo_dado timestamp default current_timestamp,
	etl_versao int default 1,
	CONSTRAINT dm_operacao_pk primary key(sk_cod_operacao)
);

create table dw.dm_data (
	sk_cod_data integer not null,
	nk_cod_data date not null,
	desc_data_completa varchar(60) not null,
	nr_ano integer not null,
	nm_trimestre varchar(20) not null,
	nr_ano_trimestre varchar(20) not null,
	nr_mes integer not null,
	nm_mes varchar(20) not null,
	ano_mes varchar(20) not null,
	nr_semana integer not null,
	ano_semana varchar(20) not null,
	nr_dia integer not null,
	nr_dia_ano integer not null,
	nm_dia_semana varchar(20) not null,
	flag_final_semana char(3) not null,
	flag_feriado char(3) not null,
	nm_feriado varchar(60) not null,
	etl_primeiro_dado timestamp not null,
	etl_ultimo_dado timestamp not null,
	etl_versao integer not null,
	constraint sk_cod_data_pk primary key (sk_cod_data)
);

create table dw.ft_estoque(
	nk_cod_estoque int,
	sk_cod_servico int,
	sk_cod_tinta int,
	sk_cod_operacao int,
	sk_cod_data int,
	tipo_produto varchar(200),
	data_servico date,
	pedido varchar(150),
	valor_opercao numeric(6,2),
	saldo_final numeric(6,2),
	obs varchar(500),
	etl_primeiro_dado timestamp default current_timestamp not null,
	etl_ultimo_dado timestamp default current_timestamp not null,
	etl_versao int default 1 not null,
	CONSTRAINT ft_estoque_pk primary key(nk_cod_estoque)
);

alter table dw.ft_estoque add CONSTRAINT ft_estoque_sk_cod_servico FOREIGN key(sk_cod_servico) REFERENCES dw.dm_servico(sk_cod_servico);
alter table dw.ft_estoque add CONSTRAINT ft_estoque_sk_cod_tinta FOREIGN key(sk_cod_tinta) REFERENCES dw.dm_tinta(sk_cod_tinta);
alter table dw.ft_estoque add CONSTRAINT ft_estoque_sk_cod_operacao FOREIGN key(sk_cod_operacao) REFERENCES dw.dm_operacao(sk_cod_operacao);
alter table dw.ft_estoque add CONSTRAINT ft_estoque_sk_cod_data FOREIGN key(sk_cod_data) REFERENCES dw.dm_data(sk_cod_data);
