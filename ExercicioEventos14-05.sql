use sistemaeventos;

select id_evento, count(*) as qtd 
FROM inscricoes 
GROUP BY id_evento HAVING qtd >= 1; 

/* 1. Crie uma consulta SQL que exiba o nome do participante, o nome do evento e uma
-- coluna chamada status_descricao que deve exibir:
● 'Pago' se o status_pagamento for 'pago'
● 'Pendente' se o status_pagamento for 'pendente'
● 'Cancelado' se o status_pagamento for 'cancelado'
● 'Desconhecido' para quaisquer outros valores
*/ 

SELECT 
    p.nome AS nome_participante,
    e.nome_evento,
    CASE (i.status_pagamento)
        WHEN 'pago' THEN 'Pago'
        WHEN 'pendente' THEN 'Pendente'
        WHEN 'cancelado' THEN 'Cancelado'
        ELSE 'Desconhecido'
    END AS status_descricao
FROM 
    Inscricoes i
JOIN 
    Participantes p ON i.id_participante = p.id
JOIN 
    Eventos e ON i.id_evento = e.id;

/*2. Escreva uma consulta que exiba o nome do evento, as datas de início e fim e uma
-- nova coluna chamada classificacao_evento, com base na duração do evento:
● 'Evento de 1 dia' se data_inicio for igual a data_fim
● 'Evento de Curta Duração' se a diferença for de até 3 dias
● 'Evento de Longa Duração' se for mais que 3 dias
Use DATEDIFF() junto com CASE*

SELECT nome_evento, data_fim, data_inicio,
CASE 
	WHEN data_inicio = data_fim THEN 'Evento por 1 dia'
    WHEN DATEDIFF(data_fim, data_inicio) <= 3 THEN 'Evento de curta duração'
    ELSE 'Evento de Longa duração'
    END as classificacao_evento
    FROM Eventos;
    
-- 3. Liste todos os participantes com uma coluna extra chamada tipo_participante, que
-- deve conter:
-- ● 'Veterano' se a data de inscrição for anterior a 2024
-- ● 'Novo' se a inscrição for em 2024 ou posterior
-- Use YEAR() e CASE

SELECT nome,
CASE 
	WHEN YEAR(data_inscricao) >= 2024 THEN 'Novo'
    ELSE 'Veterano'
    END as tipo_participante
    
    FROM participantes;
    
-- 4. Crie uma consulta que retorne o nome dos organizadores, seus cargos e uma nova
-- coluna chamada funcao, com:
-- ● 'Gestor Principal' se o cargo for igual a 'Diretor'
-- ● 'Coordenação' se o cargo for 'Coordenador' ou 'Supervisor'
-- ● 'Apoio' para todos os outros cargos

SELECT o.nome, o.cargo,
CASE (o.cargo)
	WHEN 'Diretor' THEN 'Gestor Principal' 
    WHEN 'Coordenador' THEN 'Coordenação'
    WHEN 'Supervisor' THEN 'Coordenação'
    ELSE 'Apoio'
    END as funcao
    
    FROM Organizadores as o;
   
/*
5. Crie uma consulta que exiba o nome dos participantes e uma coluna chamada
 prioridade_contato, que deve mostrar:
● 'WhatsApp' se o telefone estiver preenchido (telefone IS NOT NULL)
 ● 'E-mail' se o telefone for NULL e o e-mail estiver preenchido
● 'Sem contato disponível' se ambos forem NULL
*/

SELECT nome,
CASE 
	WHEN (telefone IS NOT NULL) THEN 'WhatsApp'
    WHEN (telefone IS NULL and email IS NOT NULL) THEN 'E-mail'
    WHEN (telefone is NULL and email is NULL) THEN 'Sem contato disponível'
    END as prioridade_contato
    FROM Participantes; 

    
/*  6. Liste todos os eventos com nome, tipo e uma nova coluna chamada
classificacao_tipo, que mostre:
● 'Competição' se o tipo de evento for 'Campeonato', 'Corrida' ou 'Torneio'
● 'Formativo' se for 'Oficina', 'Curso' ou 'Palestra'
● 'Outro' para qualquer outro tipo
Use CASE com múltiplos valores por WHEN* */

SELECT nome_evento, tipo_evento,
CASE 
	WHEN tipo_evento IN ('Campeonato', 'Corrida', 'Torneio') THEN 'Competição'
    WHEN tipo_evento IN ('Oficina', 'Curso', 'Palestra') THEN 'Formativo'
    ELSE 'Outro'
    END as classificacao_tipo
        FROM Eventos; 