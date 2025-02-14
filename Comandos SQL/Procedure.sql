DELIMITER //

CREATE PROCEDURE transferir_moedas(
    IN origem_nome VARCHAR(50),
    IN destino_nome VARCHAR(50),
    IN quantidade INT
)
BEGIN
    DECLARE origem_moedas INT;

    -- Verifica se o personagem de origem tem moedas suficientes
    SELECT moedas INTO origem_moedas
    FROM personagem
    WHERE nome_personagem = origem_nome;

    IF origem_moedas < quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Moedas insuficientes para transferência';
    END IF;

    -- Atualiza as moedas do personagem de origem
    UPDATE personagem
    SET moedas = moedas - quantidade
    WHERE nome_personagem = origem_nome;

    -- Atualiza as moedas do personagem de destino
    UPDATE personagem
    SET moedas = moedas + quantidade
    WHERE nome_personagem = destino_nome;
END //

DELIMITER ;