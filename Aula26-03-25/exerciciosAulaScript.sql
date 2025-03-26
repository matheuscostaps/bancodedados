-- INNER JOIN

SELECT *
FROM directors as d
	INNER JOIN movies as m
		ON d.id = m.director_id;
        
-- LEFT JOIN

SELECT *
FROM movies as m
	 LEFT JOIN directors as d 
		ON m.director_id = d.id;
        
-- RIGHT JOIN
        
SELECT *
FROM movies as m
	 RIGHT JOIN directors as d 
		ON m.director_id = d.id;
	
-- Liste todos os diretores e os filmes que eles dirigiram 

SELECT *
FROM directors as d
	INNER JOIN movies as m 
		ON d.id = m.director_id;
        
-- Liste todos os filmes e seus tickets vendidos
SELECT *
FROM movies as m
	INNER JOIN tickets as t
    ON m.id = t.movie_id;
        
-- Liste todos os filmes, seus diretores e os tickets vendidos

SELECT *
FROM movies as m 
	JOIN directors as d ON d.id = m.director_id
    JOIN tickets as t ON m.id = t.movie_id;
    
-- Liste todos os diretores, incluindo aqueles que não dirigiram nenhum filme 

SELECT *
FROM directors as d
		LEFT JOIN movies as m ON d.id = m.director_id;

-- Liste todos os filmes, incluindo aqueles que não têm um diretor associado

SELECT *
FROM movies as m 
		right JOIN directors as d ON d.id = m.director_id;

-- Liste todos os filmes que têm tickets e seus diretores, 
-- incluindo os filmes sem tickets

SELECT * 
FROM movies as m 
	JOIN directors as d ON d.id = m.director_id = d.id
    LEFT JOIN tickets as t ON t.movie_id = m.id;

-- Liste todos os filmes que têm tickets e seus diretores, 
-- incluindo os diretores sem filmes

SELECT * 
FROM movies as m 
	JOIN tickets as t ON t.movie_id = m.id
	RIGHT JOIN directors as d ON m.director_id = d.id;

-- Liste todos os filmes que não têm tickets e seus diretores

SELECT *
FROM movies as m 
	LEFT JOIN tickets as t ON m.id = t.movie_id
    LEFT JOIN directors as d ON d.id = m.director_id 
	WHERE t.id is NULL; 

-- Liste todos os diretores, 
-- incluindo aqueles que não dirigiram nenhum filme, e os filmes que têm tickets

SELECT *
FROM directors as d 
	 LEFT JOIN movies as m ON d.id = m.director_id
	 JOIN tickets as t ON t.movie_id = m.id;

-- Liste todos os filmes que têm tickets e seus diretores

SELECT *
FROM movies as m 
	JOIN tickets as t ON t.movie_id = m.id
    JOIN directors as d ON m.director_id = d.id;

-- Liste todos os filmes e seus diretores, incluindo os filmes sem diretores

SELECT *
FROM movies as m 
	LEFT JOIN directors as d ON m.director_id = d.id;

    


