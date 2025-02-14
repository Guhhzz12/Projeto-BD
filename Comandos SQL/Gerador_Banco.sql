create database RPG
default character set utf8  #Definição de caracteres
default collate utf8_general_ci;  #Definição de caracteres
use rpg;

create table RPG.itens_artefatos(
nome_artefato varchar(30) primary key
) engine = InnoDB;

create table RPG.propriedade1(
nome_artefato varchar(30),
propriedade varchar(50),
 primary key(nome_artefato, propriedade),
 foreign key(nome_artefato) references itens_artefatos(nome_artefato)
) engine = InnoDB;

create table RPG.mestre(
preferencia_de_campanha varchar(30),
data_de_nascimento date,
nome varchar(30),
primary key(nome)
) engine = InnoDB;

create table RPG.local(
nome varchar(30) primary key,
descricao varchar(100),
terreno varchar(50),
clima varchar(50)
) engine = InnoDB;

create table parte_de(
nome_local_parte varchar(30),
nome_local_todo varchar(30),
primary key(nome_local_parte, nome_local_todo),
foreign key(nome_local_parte) references rpg.local(nome),
foreign key(nome_local_todo) references rpg.local(nome)
) engine = InnoDB;

create table RPG.missao(
numero int,
estado varchar(30),
recompensa_monetaria varchar(30),
participantes_maximos varchar(30),
data_abertura date,
data_comeco date,
data_fim date,
nome_mestre varchar(30),
nome_local varchar(30),
primary key(numero),
foreign key(nome_mestre) references mestre(nome),
foreign key(nome_local) references rpg.local(nome)
) engine = InnoDB;

create table RPG.recompensa_de(
 nome_artefato varchar(30),
 numero_missao int,
 primary key(nome_artefato, numero_missao),
 foreign key(nome_artefato) references itens_artefatos(nome_artefato),
 foreign key(numero_missao) references missao(numero)
) engine = InnoDB;

create table RPG.jogador(
preferencia_de_campanha varchar(30),
data_de_nascimento date,
nome varchar(30) primary key
) engine = InnoDB;

create table RPG.raca(
nome varchar(30) primary key,
tamanho varchar(30),
categoria varchar(30),
descricao varchar(100),
velocidade int
) engine = InnoDB;

create table RPG.criatura(
id_criatura int not null auto_increment,
tamanho varchar(30),
categoria varchar(30),
velocidade int,
armadura int,
vida int,
primary key(id_criatura)
) engine = InnoDB;

create table RPG.proficiencia(
nome varchar(30),
id_criatura int,
primary key(nome),
foreign key(id_criatura) references criatura(id_criatura)
) engine = InnoDB;

create table RPG.habilidade(
sabedoria int,
carisma varchar(30),
inteligencia int,
forca int,
destreza int,
constituicao int,
id_criatura int,
foreign key(id_criatura) references criatura(id_criatura)
) engine = InnoDB;

create table RPG.monstro(
nome varchar(30),
tipo varchar(30),
nivel_desafio int,
categoria varchar(30),
id_criatura int,
primary key(nome, tipo),
foreign key(id_criatura) references criatura(id_criatura)
) engine = InnoDB;

create table RPG.alvo(
numero_missao int,
nome_monstro varchar(30),
tipo_monstro varchar(30),
primary key(numero_missao, nome_monstro, tipo_monstro),
foreign key(numero_missao) references missao(numero),
foreign key(nome_monstro,tipo_monstro) references monstro(nome, tipo)
) engine = InnoDB;

create table RPG.personagem(
nome_personagem varchar(30) not null primary key,
moedas int,
nivel int ,
nome_jogador varchar(30) not null,
nome_raca varchar(30) not null,
id_criatura int not null,
foreign key(nome_jogador) references jogador(nome),
foreign key(nome_raca) references raca(nome),
foreign key(id_criatura) references criatura(id_criatura),
imagem BLOB
) engine = InnoDB;

create table RPG.morto_por(
data_morte date,
nome_personagem varchar(30),
nome_monstro varchar(30),
tipo_monstro varchar(30),
primary key(nome_monstro, nome_personagem, tipo_monstro),
foreign key(nome_monstro, tipo_monstro) references monstro(nome, tipo),
foreign key(nome_personagem) references personagem(nome_personagem)
) engine = InnoDB;

create table RPG.matou(
data_morte date,
nome_personagem varchar(30),
nome_monstro varchar(30),
tipo_monstro varchar(30),
primary key(nome_monstro, nome_personagem, tipo_monstro),
foreign key(nome_monstro, tipo_monstro) references monstro(nome, tipo),
foreign key(nome_personagem) references personagem(nome_personagem)
) engine = InnoDB;

create table RPG.inclui(
numero_missao int,
nome_personagem varchar(30),
primary key(numero_missao, nome_personagem),
foreign key(numero_missao) references missao(numero),
foreign key(nome_personagem) references personagem(nome_personagem)
) engine = InnoDB;

create table RPG.posse_de(
nome_artefato varchar(30),
nome_personagem varchar(30),
primary key(nome_artefato, nome_personagem),
foreign key(nome_artefato) references itens_artefatos(nome_artefato),
foreign key(nome_personagem) references personagem(nome_personagem)
) engine = InnoDB;

###
create table RPG.classe(
nome varchar(30) primary key,
dado_de_vida varchar(30) not null,
descricao varchar(100)
) engine = InnoDB;

create table RPG.e(
nome_personagem varchar(30),
nome_classe varchar(30),
nivel_classe int,
primary key (nome_personagem,nome_classe),
foreign key (nome_classe) references classe(nome),
foreign key(nome_personagem) references personagem(nome_personagem)
) engine = InnoDB;

#alter table e
#add foreign key(nome_personagem) references personagem(nome_personagem);

create table RPG.habilidade_feiticos(
nome_habilidade varchar(30) primary key,
descricao varchar(100)
) engine = InnoDB;

create table RPG.confere(
nivel_desbloqueio int,
nome_raca varchar(30),
nome_habilidade varchar(30),
primary key(nome_raca,nome_habilidade),
foreign key(nome_raca) references raca(nome),
foreign key(nome_habilidade) references habilidade_feiticos(nome_habilidade)
) engine = InnoDB;

create table RPG.confere1(
nome_classe varchar(30),
nome_habilidade varchar(30) ,
nivel_desbloqueio int not null,
primary key (nome_classe, nome_habilidade),
foreign key (nome_classe) references classe(nome),
foreign key (nome_habilidade) references habilidade_feiticos(nome_habilidade)
) engine = InnoDB;

create table RPG.propriedades(
propriedade varchar(30),
nome_habilidade varchar(30) ,
primary key (propriedade, nome_habilidade),
foreign key(nome_habilidade) references habilidade_feiticos(nome_habilidade)
) engine = InnoDB;

create table RPG.conhecido_por(
id_criatura int,
nome_habilidade varchar(30),
primary key(id_criatura, nome_habilidade),
foreign key(id_criatura) references criatura(id_criatura),
foreign key(nome_habilidade) references habilidade_feiticos(nome_habilidade)
#### entender
) engine = InnoDB;

#drop database rpg;

