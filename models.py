from database import db

class Jogador(db.Model):
    __tablename__ = 'jogador'
    nome = db.Column(db.String(30), primary_key=True)
    data_de_nascimento = db.Column(db.Date)  # Nome corrigido
    preferencia_de_campanha = db.Column(db.String(30))  # Nome corrigido

    personagens = db.relationship('Personagem', back_populates='jogador', cascade="all, delete-orphan")


class Personagem(db.Model):
    __tablename__ = 'personagem'

    nome_personagem = db.Column(db.String(50), primary_key=True)
    nivel = db.Column(db.Integer, nullable=False)
    moedas = db.Column(db.Integer, nullable=False)
    nome_jogador = db.Column(db.String(30), db.ForeignKey('jogador.nome', name='fk_personagem_jogador'))
    nome_raca = db.Column(db.String(30), db.ForeignKey('raca.nome', name='fk_personagem_raca'))
    id_criatura = db.Column(db.Integer, db.ForeignKey('criatura.id_criatura', name='fk_personagem_criatura'))
    imagem = db.Column(db.LargeBinary)  # Armazena a imagem como BLOB

    jogador = db.relationship('Jogador', back_populates='personagens')
    raca = db.relationship('Raca', backref='personagens')
    criatura = db.relationship('Criatura', backref='personagens')
    classes = db.relationship('PersonagemClasse', back_populates='personagem')


class Raca(db.Model):
    __tablename__ = 'raca'
    nome = db.Column(db.String(30), primary_key=True)
    tamanho = db.Column(db.String(30))
    categoria = db.Column(db.String(30))
    descricao = db.Column(db.String(100))
    velocidade = db.Column(db.Integer)


class Criatura(db.Model):
    __tablename__ = 'criatura'

    id_criatura = db.Column(db.Integer, primary_key=True)
    tamanho = db.Column(db.String(30))
    categoria = db.Column(db.String(30))
    velocidade = db.Column(db.Integer)
    armadura = db.Column(db.Integer)
    vida = db.Column(db.Integer)


class Classe(db.Model):
    __tablename__ = 'classe'

    nome = db.Column(db.String(30), primary_key=True)
    dado_de_vida = db.Column(db.String(30), nullable=False)
    descricao = db.Column(db.String(100), nullable=True)
    personagens = db.relationship('PersonagemClasse', back_populates='classe')


class PersonagemClasse(db.Model):
    __tablename__ = 'e'  # Ajuste para corresponder ao nome da tabela no banco

    nivel_classe = db.Column(db.Integer, nullable=False)
    nome_personagem = db.Column(
    db.String(50),  # Ajuste para refletir o mesmo tamanho que em Personagem
    db.ForeignKey('personagem.nome_personagem', name='fk_personagem_classe_personagem'),
    primary_key=True
)
    nome_classe = db.Column(
        db.String(30),
        db.ForeignKey('classe.nome', name='fk_personagem_classe_classe'),
        primary_key=True
    )

    personagem = db.relationship("Personagem", back_populates="classes")
    classe = db.relationship("Classe", back_populates="personagens")
