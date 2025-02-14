from flask import Flask, render_template, request, redirect, url_for, jsonify, Response
from database import db
from models import Jogador, Personagem, Raca, Criatura, Classe, PersonagemClasse
import config
from sqlalchemy.exc import IntegrityError
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = config.DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Configurações para upload de imagens
UPLOAD_FOLDER = os.path.join(os.getcwd(), 'uploads')  # Cria uma pasta 'uploads' no diretório atual
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}  # Extensões permitidas
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Certifique-se de que a pasta de uploads existe
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# Função para verificar se a extensão do arquivo é permitida
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

db.init_app(app)

def create_tables():
    """Cria as tabelas no banco de dados."""
    with app.app_context():
        db.create_all()

# Rota principal - lista todos os jogadores
@app.route('/')
def index():
    jogadores = Jogador.query.all()
    return render_template('index.html', jogadores=jogadores)

# Rota para adicionar um jogador
@app.route('/jogador/novo', methods=['GET', 'POST'])
def novo_jogador():
    if request.method == 'POST':
        nome = request.form['nome']
        data_de_nascimento = request.form['data_de_nascimento']
        preferencia = request.form['preferencia_de_campanha']
        novo_jogador = Jogador(
            nome=nome,
            data_de_nascimento=data_de_nascimento,
            preferencia_de_campanha=preferencia
        )
        db.session.add(novo_jogador)
        db.session.commit()
        return redirect(url_for('index'))
    return render_template('novo_jogador.html')

# Rota para editar um jogador
@app.route('/jogador/<string:nome>/editar', methods=['GET', 'POST'])
def editar_jogador(nome):
    jogador = Jogador.query.get(nome)
    if not jogador:
        return "Jogador não encontrado!", 404
    if request.method == 'POST':
        try:
            jogador.data_de_nascimento = request.form['data_de_nascimento']
            jogador.preferencia_de_campanha = request.form['preferencia_de_campanha']
            db.session.commit()
            return redirect(url_for('index'))
        except KeyError as e:
            return f"Campo ausente no formulário: {str(e)}", 400
        except ValueError:
            return "Valor inválido fornecido para um dos campos!", 400
    return render_template('editar_jogador.html', jogador=jogador)

# Rota para excluir um jogador
@app.route('/jogador/<string:nome>/deletar', methods=['POST'])
def deletar_jogador(nome):
    jogador = Jogador.query.get(nome)
    if not jogador:
        return "Jogador não encontrado!", 404

    try:
        # Exclui todos os registros associados na tabela PersonagemClasse
        personagens = Personagem.query.filter_by(nome_jogador=nome).all()
        for personagem in personagens:
            # Exclui todas as classes associadas ao personagem
            PersonagemClasse.query.filter_by(nome_personagem=personagem.nome_personagem).delete()

            # Exclui o personagem
            db.session.delete(personagem)

        # Exclui o jogador
        db.session.delete(jogador)
        db.session.commit()

        return jsonify(success="Jogador excluído com sucesso!")
    except Exception as e:
        db.session.rollback()
        return jsonify(error=f"Ocorreu um erro ao excluir o jogador: {str(e)}"), 500

# Rota para listar personagens de um jogador
@app.route('/jogador/<string:nome>/personagens')
def listar_personagens(nome):
    jogador = Jogador.query.filter_by(nome=nome).first_or_404()
    return render_template('personagens.html', jogador=jogador, personagens=jogador.personagens)

# Rota para adicionar um novo personagem
@app.route('/jogador/<string:nome>/personagem/novo', methods=['GET', 'POST'])
def novo_personagem(nome):
    jogador = Jogador.query.get(nome)
    if not jogador:
        return jsonify(error="Jogador não encontrado!"), 404

    racas = Raca.query.all()
    classes = Classe.query.all()

    if request.method == 'POST':
        try:
            # Dados do personagem
            nome_personagem = request.form['nome_personagem']
            nivel = int(request.form['nivel'])
            moedas = int(request.form['moedas'])
            nome_raca = request.form['nome_raca']
            id_criatura = int(request.form['id_criatura'])

            # Verifica se a criatura existe
            criatura = Criatura.query.get(id_criatura)
            if not criatura:
                return jsonify(error="ID da Criatura inválido!"), 400
            
            # Processar o upload da imagem
            imagem = None
            if 'imagem' in request.files:
                file = request.files['imagem']
                if file and allowed_file(file.filename):
                    imagem = file.read()  # Lê os dados binários da imagem

            # Cria o personagem
            personagem = Personagem(
                nome_personagem=nome_personagem,
                nivel=nivel,
                moedas=moedas,
                nome_jogador=nome,
                nome_raca=nome_raca,
                id_criatura=id_criatura,
                imagem=imagem  # Salva a imagem como BLOB
            )
            db.session.add(personagem)

            # Adiciona as classes ao personagem
            nome_classes = request.form.getlist('nome_classe[]')
            niveis_classes = request.form.getlist('nivel_classe[]')
            for nome_classe, nivel_classe in zip(nome_classes, niveis_classes):
                pc = PersonagemClasse(
                    nome_personagem=nome_personagem,
                    nome_classe=nome_classe,
                    nivel_classe=int(nivel_classe)
                )
                db.session.add(pc)

            db.session.commit()
            return jsonify(success="Personagem criado com sucesso!")

        except ValueError as e:
            db.session.rollback()
            return jsonify(error=f"Valor inválido fornecido para um dos campos: {str(e)}"), 400

        except Exception as e:
            db.session.rollback()
            return jsonify(error=f"Ocorreu um erro ao processar a solicitação: {str(e)}"), 500

    return render_template('novo_personagem.html', jogador=jogador, racas=racas, classes=classes)

# Rota para editar um personagem
@app.route('/jogador/<string:nome>/personagem/editar/<string:nome_personagem>', methods=['GET', 'POST'])
def editar_personagem(nome, nome_personagem):
    personagem = Personagem.query.filter_by(nome_personagem=nome_personagem).first_or_404()
    racas = Raca.query.all()
    classes = Classe.query.all()

    if request.method == 'POST':
        try:
            # Atualiza os campos do personagem
            personagem.nivel = int(request.form.get('nivel', personagem.nivel))
            personagem.moedas = int(request.form.get('moedas', personagem.moedas))
            personagem.nome_raca = request.form.get('nome_raca', personagem.nome_raca)
            personagem.id_criatura = int(request.form.get('id_criatura', personagem.id_criatura))

            # Verifica se a criatura existe
            criatura = Criatura.query.get(personagem.id_criatura)
            if not criatura:
                return jsonify(error="ID da Criatura inválido!"), 400

            # Processar o upload da nova imagem (se fornecida)
            if 'imagem' in request.files:
                file = request.files['imagem']
                if file and allowed_file(file.filename):
                    # Lê os dados binários da imagem e atualiza no banco de dados
                    personagem.imagem = file.read()

            # Remove as classes associadas ao personagem
            PersonagemClasse.query.filter_by(nome_personagem=nome_personagem).delete()

            # Adiciona as novas classes ao personagem
            nome_classes = request.form.getlist('nome_classe[]')
            niveis_classes = request.form.getlist('nivel_classe[]')
            for nome_classe, nivel_classe in zip(nome_classes, niveis_classes):
                pc = PersonagemClasse(
                    nome_personagem=nome_personagem,
                    nome_classe=nome_classe,
                    nivel_classe=int(nivel_classe)
                )
                db.session.add(pc)

            db.session.commit()
            return jsonify(success="Personagem atualizado com sucesso!")

        except ValueError as e:
            db.session.rollback()
            return jsonify(error=f"Valor inválido fornecido para um dos campos: {str(e)}"), 400

        except Exception as e:
            db.session.rollback()
            return jsonify(error=f"Ocorreu um erro ao processar a solicitação: {str(e)}"), 500

    # Se o método for GET, renderiza o template de edição
    classes_associadas = PersonagemClasse.query.filter_by(nome_personagem=nome_personagem).all()
    return render_template(
        'editar_personagem.html',
        personagem=personagem,
        racas=racas,
        classes=classes,
        classes_associadas=classes_associadas,
        jogador_nome=nome  # Passa o nome do jogador para o template
    )

    # Se o método for GET, renderiza o template de edição
    classes_associadas = PersonagemClasse.query.filter_by(nome_personagem=nome_personagem).all()
    return render_template(
        'editar_personagem.html',
        personagem=personagem,
        racas=racas,
        classes=classes,
        classes_associadas=classes_associadas,
        jogador_nome=nome  # Passa o nome do jogador para o template
    )

# Rota para excluir um personagem
@app.route('/jogador/<string:nome>/personagem/deletar/<string:nome_personagem>', methods=['POST'])
def deletar_personagem(nome, nome_personagem):
    personagem = Personagem.query.filter_by(nome_personagem=nome_personagem).first_or_404()

    try:
        # Exclui todos os registros associados na tabela "e" (PersonagemClasse)
        PersonagemClasse.query.filter_by(nome_personagem=nome_personagem).delete()

        # Exclui o personagem
        db.session.delete(personagem)

        # Salva as alterações no banco de dados
        db.session.commit()

        return jsonify(success="Personagem excluído com sucesso!")

    except Exception as e:
        db.session.rollback()
        return jsonify(error=f"Ocorreu um erro ao excluir o personagem: {str(e)}"), 500

# Rota para exibir imagens
@app.route('/imagem_personagem/<string:nome_personagem>')
def imagem_personagem(nome_personagem):
    personagem = Personagem.query.filter_by(nome_personagem=nome_personagem).first_or_404()
    if personagem.imagem:
        return Response(personagem.imagem, mimetype='image/jpeg')  # Ajuste o mimetype conforme o tipo da imagem
    else:
        return "Imagem não encontrada", 404
    
from sqlalchemy.sql import text

@app.route('/estatisticas_jogadores')
def estatisticas_jogadores():
    # Consulta a view no banco de dados
    resultados = db.session.execute(text("SELECT * FROM estatisticas_jogadores")).fetchall()

    # Renderiza os resultados em um template
    return render_template('estatisticas_jogadores.html', resultados=resultados)


@app.route('/transferir_moedas/<string:nome>', methods=['GET'])
def pagina_transferir_moedas(nome):
    # Busca o jogador pelo nome no banco de dados
    jogador = Jogador.query.filter_by(nome=nome).first()

    print(jogador)  # Verifique se é o objeto ou apenas o nome


    if not jogador:
        return "Jogador não encontrado!", 404

    # Renderiza a página passando o nome do jogador para o template
    return render_template('transferir_moedas.html', jogador=jogador)




@app.route('/api/transferir_moedas', methods=['POST'])
def executar_transferir_moedas():
    # Obtém os dados do formulário no formato JSON
    data = request.json
    origem = data.get('origem')
    destino = data.get('destino')
    quantidade = data.get('quantidade')

    if not origem or not destino or not quantidade:
        return jsonify(error="Todos os campos são obrigatórios!"), 400

    try:
        # Chama a procedure no banco de dados
        db.session.execute(
            text("CALL transferir_moedas(:origem, :destino, :quantidade)"),
            {"origem": origem, "destino": destino, "quantidade": quantidade}
        )
        db.session.commit()
        return jsonify(success="Transferência realizada com sucesso!")
    except Exception as e:
        db.session.rollback()
        return jsonify(error=f"Ocorreu um erro ao transferir moedas: {str(e)}"), 500



if __name__ == '__main__':
    create_tables()
    app.run(debug=True)