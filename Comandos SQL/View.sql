CREATE VIEW estatisticas_jogadores AS
SELECT 
    j.nome AS nome_jogador,
    COUNT(p.nome_personagem) AS total_personagens,
    AVG(p.nivel) AS nivel_medio_personagens,
    SUM(p.moedas) AS total_moedas
FROM 
    jogador j
LEFT JOIN 
    personagem p ON j.nome = p.nome_jogador
GROUP BY 
    j.nome;