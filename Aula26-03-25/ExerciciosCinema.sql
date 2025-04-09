use cinema;

-- 1. Liste todos os diretores e os filmes que eles dirigiram 

SELECT *
FROM directors AS d                                  -- tabela de diretores
INNER JOIN movies AS m ON d.id = m.director_id;      -- mostra apenas diretores que dirigiram pelo menos um filme

        
-- 2. Liste todos os filmes e seus tickets vendidos
SELECT *
FROM movies AS m                                     -- tabela de filmes
INNER JOIN tickets AS t ON m.id = t.movie_id;        -- mostra apenas filmes que venderam tickets


-- 3. Liste todos os filmes, seus diretores e os tickets vendidos

SELECT *
FROM movies AS m
JOIN directors AS d ON d.id = m.director_id          -- junta filmes com seus diretores
JOIN tickets AS t ON m.id = t.movie_id;              -- junta filmes com seus tickets vendidos

    
-- 4. Liste todos os diretores, incluindo aqueles que não dirigiram nenhum filme 

SELECT *
FROM directors AS d
LEFT JOIN movies AS m ON d.id = m.director_id;       -- LEFT JOIN inclui diretores sem filmes


-- 5. Liste todos os filmes, incluindo aqueles que não têm um diretor associado

SELECT *
FROM movies AS m
LEFT JOIN directors AS d ON m.director_id = d.id;    -- assim traz todos os filmes, mesmo sem diretor


-- 6. Liste todos os filmes que têm tickets e seus diretores, 
-- incluindo os filmes sem tickets

SELECT *
FROM movies AS m
JOIN directors AS d ON d.id = m.director_id          -- junta filmes com seus diretores
LEFT JOIN tickets AS t ON t.movie_id = m.id;         -- inclui também filmes sem ticket


-- 7. Liste todos os filmes que têm tickets e seus diretores, 
-- incluindo os diretores sem filmes

SELECT *
FROM movies AS m
JOIN tickets AS t ON t.movie_id = m.id               -- pega filmes com tickets
RIGHT JOIN directors AS d ON m.director_id = d.id;   -- inclui diretores mesmo sem filmes

-- 8. Liste todos os filmes que não têm tickets e seus diretores

SELECT *
FROM movies AS m
LEFT JOIN tickets AS t ON m.id = t.movie_id          -- pega todos os filmes, mesmo sem ticket
LEFT JOIN directors AS d ON d.id = m.director_id     -- junta com diretores
WHERE t.id IS NULL;                                  -- filtra só os que não têm tickets


-- 9. Liste todos os diretores, 
-- incluindo aqueles que não dirigiram nenhum filme, e os filmes que têm tickets

SELECT *
FROM directors AS d
LEFT JOIN movies AS m ON d.id = m.director_id        -- inclui diretores sem filmes
JOIN tickets AS t ON t.movie_id = m.id;              -- junta apenas filmes que têm tickets

-- ⚠️ se um diretor não tem filmes, ele será excluído nesse JOIN (pois não há movie_id)
-- solução: mover o JOIN com tickets para LEFT JOIN também

-- 10. Liste todos os filmes que têm tickets e seus diretores

SELECT *
FROM movies AS m
JOIN tickets AS t ON t.movie_id = m.id               -- só filmes com ticket
JOIN directors AS d ON m.director_id = d.id;         -- junta com diretores


-- 11. Liste todos os filmes e seus diretores, incluindo os filmes sem diretores

SELECT *
FROM movies AS m
LEFT JOIN directors AS d ON m.director_id = d.id;    -- inclui filmes sem diretor