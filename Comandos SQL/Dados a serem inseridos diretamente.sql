INSERT INTO RPG.itens_artefatos (nome_artefato) VALUES
('Espada Flamejante'),
('Cajado Arcano'),
('Escudo Divino'),
('Amuleto da Invisibilidade'),
('Botas Velozes');

INSERT INTO RPG.propriedade1 (nome_artefato, propriedade) VALUES
('Espada Flamejante', 'Causa queimaduras'),
('Cajado Arcano', 'Aumenta poder mágico'),
('Escudo Divino', 'Proteção contra mal'),
('Amuleto da Invisibilidade', 'Torna o usuário invisível'),
('Botas Velozes', 'Aumenta velocidade');

-- Inserção na tabela mestre
INSERT INTO RPG.mestre (preferencia_de_campanha, data_de_nascimento, nome) VALUES
('Fantasia Épica', '1980-05-15', 'Gandalf'),
('Terror Gótico', '1975-12-22', 'Dumbledore'),
('Aventura Medieval', '1990-08-30', 'Elminster'),
('Mistério Sobrenatural', '1985-03-10', 'Merlin'),
('Ficção Científica', '1978-11-25', 'Raistlin');


INSERT INTO RPG.local (nome, descricao, terreno, clima) VALUES
('Floresta Negra', 'Uma floresta densa e sombria', 'Floresta', 'Úmido'),
('Montanha Solitária', 'Uma montanha imponente', 'Montanhoso', 'Frio'),
('Deserto de Areia', 'Um deserto vasto e quente', 'Deserto', 'Árido'),
('Cidade dos Anões', 'Uma cidade subterrânea', 'Subterrâneo', 'Temperado'),
('Vale dos Elfos', 'Um vale mágico e sereno', 'Vale', 'Ameno');

INSERT INTO RPG.parte_de (nome_local_parte, nome_local_todo) VALUES
('Floresta Negra', 'Vale dos Elfos'),
('Montanha Solitária', 'Cidade dos Anões'),
('Deserto de Areia', 'Vale dos Elfos'),
('Cidade dos Anões', 'Montanha Solitária'),
('Vale dos Elfos', 'Floresta Negra');

INSERT INTO RPG.missao (numero, estado, recompensa_monetaria, participantes_maximos, data_abertura, data_comeco, data_fim, nome_mestre, nome_local) VALUES
(1, 'Ativa', '1000 moedas', '5', '2023-10-01', '2023-10-05', '2023-10-10', 'Gandalf', 'Floresta Negra'),
(2, 'Concluída', '500 moedas', '3', '2023-09-15', '2023-09-20', '2023-09-25', 'Dumbledore', 'Montanha Solitária'),
(3, 'Cancelada', '200 moedas', '4', '2023-08-01', '2023-08-05', '2023-08-10', 'Elminster', 'Deserto de Areia'),
(4, 'Ativa', '1500 moedas', '6', '2023-10-10', '2023-10-15', '2023-10-20', 'Merlin', 'Cidade dos Anões'),
(5, 'Pendente', '800 moedas', '2', '2023-11-01', '2023-11-05', '2023-11-10', 'Raistlin', 'Vale dos Elfos');

INSERT INTO RPG.recompensa_de (nome_artefato, numero_missao) VALUES
('Espada Flamejante', 1),
('Cajado Arcano', 2),
('Escudo Divino', 3),
('Amuleto da Invisibilidade', 4),
('Botas Velozes', 5);

INSERT INTO RPG.jogador (preferencia_de_campanha, data_de_nascimento, nome) VALUES
('Fantasia Épica', '1995-07-20', 'Aragorn'),
('Aventura Medieval', '1992-04-12', 'Legolas'),
('Terror Gótico', '1988-09-05', 'Gimli'),
('Mistério Sobrenatural', '1998-01-18', 'Frodo'),
('Ficção Científica', '1990-06-30', 'Bilbo');

INSERT INTO RPG.raca (nome, tamanho, categoria, descricao, velocidade) VALUES
('Humano', 'Médio', 'Humanóide', 'Versátil e adaptável', 30),
('Elfo', 'Médio', 'Humanóide', 'Ágil e mágico', 35),
('Anão', 'Baixo', 'Humanóide', 'Resistente e forte', 25),
('Orc', 'Médio', 'Humanóide', 'Agressivo e poderoso', 30),
('Halfling', 'Pequeno', 'Humanóide', 'Ágil e sortudo', 25);	

INSERT INTO RPG.criatura (tamanho, categoria, velocidade, armadura, vida) VALUES
('Grande', 'Monstro', 40, 15, 100),
('Médio', 'Humanóide', 30, 10, 80),
('Pequeno', 'Animal', 20, 5, 50),
('Enorme', 'Monstro', 25, 20, 150),
('Médio', 'Humanóide', 35, 12, 90);

INSERT INTO RPG.proficiencia (nome, id_criatura) VALUES
('Espadas', 1),
('Arcos', 2),
('Machados', 3),
('Magia', 4),
('Furtividade', 5);

INSERT INTO RPG.habilidade (sabedoria, carisma, inteligencia, forca, destreza, constituicao, id_criatura) VALUES
(12, 'Alto', 14, 16, 10, 15, 1),
(14, 'Médio', 16, 12, 18, 13, 2),
(10, 'Baixo', 8, 18, 10, 16, 3),
(16, 'Alto', 18, 10, 14, 12, 4),
(13, 'Médio', 15, 14, 16, 14, 5);	

INSERT INTO RPG.monstro (nome, tipo, nivel_desafio, categoria, id_criatura) VALUES
('Dragão', 'Réptil', 10, 'Monstro', 1),
('Orc', 'Humanóide', 3, 'Humanóide', 2),
('Goblin', 'Humanóide', 1, 'Humanóide', 3),
('Gigante', 'Humanóide', 8, 'Monstro', 4),
('Lobo', 'Animal', 2, 'Animal', 5);

INSERT INTO RPG.alvo (numero_missao, nome_monstro, tipo_monstro) VALUES
(1, 'Dragão', 'Réptil'),
(2, 'Orc', 'Humanóide'),
(3, 'Goblin', 'Humanóide'),
(4, 'Gigante', 'Humanóide'),
(5, 'Lobo', 'Animal');

INSERT INTO RPG.personagem (nome_personagem, moedas, nivel, nome_jogador, nome_raca, id_criatura, imagem) VALUES
('Aragorn II', 500, 5, 'Aragorn', 'Humano', 1, NULL),
('Legolas', 300, 6, 'Legolas', 'Elfo', 2, NULL),
('Gimli', 400, 4, 'Gimli', 'Anão', 3, NULL),
('Frodo', 200, 3, 'Frodo', 'Halfling', 4, NULL),
('Bilbo', 100, 2, 'Bilbo', 'Halfling', 5, NULL);

INSERT INTO RPG.morto_por (data_morte, nome_personagem, nome_monstro, tipo_monstro) VALUES
('2023-10-05', 'Aragorn II', 'Dragão', 'Réptil'),
('2023-09-20', 'Legolas', 'Orc', 'Humanóide'),
('2023-08-05', 'Gimli', 'Goblin', 'Humanóide'),
('2023-10-15', 'Frodo', 'Gigante', 'Humanóide'),
('2023-11-05', 'Bilbo', 'Lobo', 'Animal');

INSERT INTO RPG.matou (data_morte, nome_personagem, nome_monstro, tipo_monstro) VALUES
('2023-10-05', 'Aragorn II', 'Dragão', 'Réptil'),
('2023-09-20', 'Legolas', 'Orc', 'Humanóide'),
('2023-08-05', 'Gimli', 'Goblin', 'Humanóide'),
('2023-10-15', 'Frodo', 'Gigante', 'Humanóide'),
('2023-11-05', 'Bilbo', 'Lobo', 'Animal');

INSERT INTO RPG.inclui (numero_missao, nome_personagem) VALUES
(1, 'Aragorn II'),
(2, 'Legolas'),
(3, 'Gimli'),
(4, 'Frodo'),
(5, 'Bilbo');

INSERT INTO RPG.posse_de (nome_artefato, nome_personagem) VALUES
('Espada Flamejante', 'Aragorn II'),
('Cajado Arcano', 'Legolas'),
('Escudo Divino', 'Gimli'),
('Amuleto da Invisibilidade', 'Frodo'),
('Botas Velozes', 'Bilbo');

INSERT INTO RPG.classe (nome, dado_de_vida, descricao) VALUES
('Guerreiro', 'd10', 'Especialista em combate corpo a corpo'),
('Mago', 'd6', 'Usuário de magia arcana'),
('Ladino', 'd8', 'Especialista em furtividade e armadilhas'),
('Clérigo', 'd8', 'Usuário de magia divina'),
('Bárbaro', 'd12', 'Especialista em força bruta');

INSERT INTO RPG.e (nome_personagem, nome_classe, nivel_classe) VALUES
('Aragorn II', 'Guerreiro', 5),
('Legolas', 'Mago', 6),
('Gimli', 'Bárbaro', 4),
('Frodo', 'Ladino', 3),
('Bilbo', 'Clérigo', 2);

INSERT INTO RPG.habilidade_feiticos (nome_habilidade, descricao) VALUES
('Bola de Fogo', 'Conjura uma bola de fogo que causa dano em área'),
('Cura', 'Restaura pontos de vida'),
('Invisibilidade', 'Torna o alvo invisível'),
('Teletransporte', 'Transporta o alvo para outro local'),
('Escudo Mágico', 'Protege o alvo contra ataques');

INSERT INTO RPG.confere (nivel_desbloqueio, nome_raca, nome_habilidade) VALUES
(3, 'Humano', 'Bola de Fogo'),
(5, 'Elfo', 'Cura'),
(2, 'Anão', 'Invisibilidade'),
(4, 'Orc', 'Teletransporte'),
(1, 'Halfling', 'Escudo Mágico');

INSERT INTO RPG.confere1 (nome_classe, nome_habilidade, nivel_desbloqueio) VALUES
('Guerreiro', 'Bola de Fogo', 3),
('Mago', 'Cura', 5),
('Ladino', 'Invisibilidade', 2),
('Clérigo', 'Teletransporte', 4),
('Bárbaro', 'Escudo Mágico', 1);

INSERT INTO RPG.propriedades (propriedade, nome_habilidade) VALUES
('Fogo', 'Bola de Fogo'),
('Cura', 'Cura'),
('Invisibilidade', 'Invisibilidade'),
('Teletransporte', 'Teletransporte'),
('Proteção', 'Escudo Mágico');

INSERT INTO RPG.conhecido_por (id_criatura, nome_habilidade) VALUES
(1, 'Bola de Fogo'),
(2, 'Cura'),
(3, 'Invisibilidade'),
(4, 'Teletransporte'),
(5, 'Escudo Mágico');
