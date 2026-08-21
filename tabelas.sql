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
