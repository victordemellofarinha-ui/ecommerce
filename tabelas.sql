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