create table stage.stg_tinta(
	nk_cod_tinta varchar(50),
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
	CONSTRAINT stg_tinta_pk primary key(nk_cod_tinta)
);

create table stage.stg_servico(
	nk_cod_servico int,
	valor_servico numeric(8,2),
	data_servico date,
	CONSTRAINT stg_servico_pk primary key(nk_cod_servico)

);

create table stage.stg_estoque(
	nk_cod_estoque int,
	nk_cod_servico varchar(10),
	nk_cod_tinta varchar(50),
	tipo_produto varchar(300),
	data_servico date,
	operacao varchar(7),
	pedido varchar(150),
	valor_opercao numeric(6,2),
	saldo_final numeric(6,2),
	obs varchar(500),
	CONSTRAINT stg_estoque_pk primary key(nk_cod_estoque)
);

--- DM ---


create table core.dm_tinta(
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

create table core.dm_servico(
	sk_cod_servico serial,
	nk_cod_servico int,
	valor_servico numeric(8,2),
	data_servico date,
	etl_primeiro_dado timestamp default current_timestamp,
	etl_ultimo_dado timestamp default current_timestamp,
	etl_versao int default 1,
	CONSTRAINT dm_servico_pk primary key(sk_cod_servico)
);

create table core.dm_operacao(
	sk_cod_operacao serial,
	operacao varchar(7),
	fator_saldo int,
	etl_primeiro_dado timestamp default current_timestamp,
	etl_ultimo_dado timestamp default current_timestamp,
	etl_versao int default 1,
	CONSTRAINT dm_operacao_pk primary key(sk_cod_operacao)
);

create table core.dm_data (
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
	etl_dt_inicio timestamp not null,
	etl_dt_fim timestamp not null,
	versao integer not null,
	constraint sk_cod_data_pk primary key (sk_cod_data)
);

create table core.ft_estoque(
	sk_cod_estoque serial,
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
	CONSTRAINT ft_estoque_pk primary key(sk_cod_estoque)
);

alter table core.ft_estoque add CONSTRAINT ft_estoque_sk_cod_servico FOREIGN key(sk_cod_servico) REFERENCES core.dm_servico(sk_cod_servico);
alter table core.ft_estoque add CONSTRAINT ft_estoque_sk_cod_tinta FOREIGN key(sk_cod_tinta) REFERENCES core.dm_tinta(sk_cod_tinta);
alter table core.ft_estoque add CONSTRAINT ft_estoque_sk_cod_operacao FOREIGN key(sk_cod_operacao) REFERENCES core.dm_operacao(sk_cod_operacao);
alter table core.ft_estoque add CONSTRAINT ft_estoque_sk_cod_data FOREIGN key(sk_cod_data) REFERENCES core.dm_data(sk_cod_data);

insert into core.dm_tinta values(-1,'N/A','N/A','N/A','N/A','N/A','N/A',-1,-1,-1,-1, '1900-01-01','1900-01-01 00:00:00', '1900-01-01 00:00:00', -1);
insert into core.dm_servico values(-1,-1,-1,'1900-01-01','1900-01-01 00:00:00', '1900-01-01 00:00:00', -1);
insert into core.dm_operacao values(-1,'N/A',-1,'1900-01-01 00:00:00', '1900-01-01 00:00:00', -1);
insert into core.dm_data values(19000101, '1900-01-01', 'N/A', -1, 'N/A', 'N/A', -1, 'N/A', 'N/A', -1, 'N/A', -1, -1, 'N/A', 'N/A', 'N/A', 'N/A','1900-01-01 00:00:00', '1900-01-01 00:00:00', -1);
