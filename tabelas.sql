create table clientes(
	id serial primary key,
	nome varchar(150) not null, 
	email varchar(150) not null,
	cpf varchar(11) unique not NULL,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table categorias(
id serial primary key,
nome varchar(150) unique not null
);

create table produtos(
id serial primary key,
categoria_id int not null,
nome varchar(100) not null,
preco numeric(10,2) not null check(preco > 0),
quantidade_estoque int not null default 0 check (quantidade_estoque >=0),


constraint fk_produto_categoria
	FOREIGN key (categoria_id)
	REFERENCES categorias(id)
	on delete restrict
)


create table pedidos(
id serial primary key,
clientes_id int not null,
data_pedido TIMESTAMP DEFAULT current_TIMESTAMP,
status varchar(20) default 'pendente' check (status in ('pendente', 'pago', 'enviado', 'cancelado')),

constraint fk_pedidos_clientes
FOREIGN key (clientes_id)
REFERENCES clientes(id)
on delete cascade
)

create table itens_pedidos(
pedido_id int not NULL,
produto_id int not null,
quantidade int not null check(quantidade > 0),
preco_unitario numeric(10,2) not null check (preco_unitario > 0 ),

primary key(pedido_id, produto_id),
constraint fk_item_pedidos
foreign key(pedido_id)
references pedidos(id)
on delete cascade,

constraint fk_item_produto
FOREIGN key (produto_id)
references produtos(id)
on delete restrict
)

insert into clientes(nome, email, cpf) VALUES
('Noah', 'noah@teste', 22233311100)
('Vitor', 'vitor@teste', 00011122233)
('Mateus', 'mateus@teste', 00011133322)

insert into categorias(nome) VALUES
('Perifericos'),
('Monitores'),
('Hardware')

insert into produtos(categoria_id, nome, preco, quantidade_estoque ) VALUES
(1, 'Teclado LogiTech', 120.00, 300),
(1, 'MousePad Philips', 39.99, 500),
(2, 'Monitor Philips 24p 244hz', 899.99, 10),
(2, 'Monitor AOC 27p 75hz', 999.99, 150),
(2, 'Monitor Mancer 17p 240hz', 500.00, 600),
(3, 'Placa Mae Asus A520', 450.90, 300),
(3, 'Memoria Ram DDR4 Redragon 8GB', 500.00, 700),
(3, 'SSD 1TB Mancer', 800.50, 49)


insert into pedidos(clientes_id, status) VALUES
(1, 'pago'),
(1, 'enviado'),
(2, 'cancelado'),
(2, 'pago'),
(2, 'pendente'),
(3, 'cancelado'),
(3, 'pendente'),
(3, 'enviado')


insert into itens_pedidos(pedido_id, produto_id, quantidade, preco_unitario) VALUES
(3, 1, 3, 200)
(23, 2, 2, 1500),
(24, 3, 4, 1000),
(25, 1, 3, 750.50),
(26, 2, 3, 597),
(27, 3, 3, 300),
(28, 1, 3, 497),
(29, 2, 3, 111.99),
(30, 3, 3, 601)

SELECT 
p.nome as produto,
c.nome as categorias,
p.preco, 
p.quantidade_estoque
from 
produtos p 
join categorias c on c.id = p.categoria_id
order by p.preco desc;



SELECT
pedidos.id,
clientes.nome,
SUM(item.quantidade * item.preco_unitario) as valor_total_pedido
FROM

pedidos

JOIN 
clientes on pedidos.clientes_id = clientes.id
join
itens_pedidos item on pedidos.id = item.pedido_id

group by pedidos.id, clientes.nome
order by pedidos.id;



SELECT
nome as produtos,
quantidade_estoque
from produtos
where (quantidade_estoque <10)
order by quantidade_estoque;



----------------------------------------------------------------------------------------------------

MEDCARE ATIVIDADE

CREATE TABLE pacientes(
id serial primary key,
nome VARCHAR(150) not NULL,
email VARCHAR(150) unique not null,
cpf varchar(11) unique not null,
data_nascimento varchar(10) not null,
data_cadrastro TIMESTAMP default current_timestamp

);



CREATE TABLE especialidades(
id serial primary key,
nome VARCHAR(150) check (nome not like '% %') not NULL
);



CREATE TABLE medicos(
id serial primary key,
especialidade_id int not null,
nome VARCHAR(150) not null,
crm varchar(100) unique not null,
valor_consulta numeric (10,2) check(valor_consulta > 0),

constraint fk_especialidade_id
foreign key (especialidade_id)
REFERENCES especialidades(id)
on delete cascade
);



CREATE TABLE consultas(
id serial primary key,
medico_id int not null,
paciente_id int not null,
data_hora TIMESTAMP default current_timestamp,
status varchar(20) default 'Agendada' check (status in ('Agendada', 'Realizada', 'Cancelada')),

constraint medico_id
FOREIGN key (medico_id)
REFERENCES medicos(id)
on delete cascade,

constraint paciente_id
FOREIGN key (paciente_id)
references pacientes(id)
on delete restrict
);



CREATE TABLE exames_consulta(
id serial primary key,
consulta_id int not null,
nome_exame varchar(100) not null,
valor_exame numeric (10,2) not null check(valor_exame >= 0),

constraint consultas_id
FOREIGN key (consulta_id)
REFERENCES consultas(id)
on delete restrict
);




insert into especialidades(nome) values
('Cardiologia')
('Pediatria')
('Dermatologia')


insert into medicos(especialidade_id, nome, crm, valor_consulta) values
(1,'Ronaldo', 17, 200.00),
(1,'Juliano', 17, 200.00),
(1,'Daniel', 9, 200.00)


insert into pacientes(nome, email, cpf, data_nascimento) values
('Tatiane', 'tatiane@teste.com', 11122233344, 20/06/2000),
('Priscila', 'priscila@teste.com', 22233344455, 21/09/1989),
('Sandra', 'sandra@teste.com', 33344455566, 22/08/1999)

