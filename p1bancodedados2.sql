-- 1 - Liste os cursos e suas ofertas que têm data de início entre 2023-01-01 e 2023-06-30

SELECT c.nome as nome_do_curso, o.id_oferta as oferta, o.data_inicio as data_inicio
FROM curso c
JOIN oferta o ON c.id_curso = o.id_curso
WHERE data_inicio between '2023-01-01' and '2023-06-30';

-- 2 - Qual é o total de inscrições por tipo de público alvo?


SELECT o.publico_alvo AS publico_alvo, count(i.id_inscricao) AS total_de_inscricoes
FROM inscricao i
JOIN oferta o ON i.id_oferta = o.id_oferta
GROUP BY o.publico_alvo
ORDER BY total_de_inscricoes DESC;


-- 3 - Quantas inscrições existem por curso? 

SELECT c.nome AS curso, count(i.id_inscricao) AS total_de_inscricao
FROM inscricao i
JOIN oferta o ON i.id_oferta = o.id_oferta
JOIN curso c ON o.id_curso = c.id_curso
GROUP BY c.nome
ORDER BY total_de_inscricao DESC;


-- 4 - Liste os 10 usuários mais recentes que se inscreveram em ofertas. 

SELECT u.nome AS nome_usuario, 
       o.id_oferta AS oferta, 
       i.data_inscricao AS data_inscricao
FROM inscricao i
JOIN usuario u ON i.id_usuario = u.id_usuario
JOIN oferta o ON i.id_oferta = o.id_oferta
ORDER BY i.data_inscricao DESC 
LIMIT 10;


-- 5. Liste os cursos que têm ofertas com inscrições de usuários que
-- nasceram entre 1980 e 2000, e calcule a média de carga horária desses cursos.
-- Além disso, ordene os resultados pela média de carga horária em
-- ordem decrescente e limite a lista aos 5 primeiros cursos.

SELECT  c.nome as curso, 
        avg(c.carga_horaria) as media_carga_horaria
        FROM curso c
        JOIN inscricao i ON c.id_curso = i.id_oferta
        JOIN oferta o ON i.id_inscricao = o.id_oferta
        JOIN usuario u ON o.id_oferta = u.id_usuario
        WHERE u.data_nascimento between '1980-01-01' AND '2000-12-31'
        GROUP BY c.nome
        ORDER BY media_carga_horaria DESC
        LIMIT 5;

-- 6 - Gere o CROSS JOIN das tabelas cursos e ofertas
SELECT*
FROM curso c
CROSS JOIN oferta o ON o.id_curso = c.id_curso;

