-- UNIONES Y FUNCIONES DE AGREGACIÓN

-- Micro desafío - Paso 1
--Consulta 1 : Utilizando la base de datos de películas queremos conocer, por un lado, los títulos y el
--nombre del género de todas las series de la base de datos.
SELECT series.title AS serie, genres.name AS genero
FROM series
INNER JOIN genres ON genre_id = genres.id

--Consulta 2 : Por otro, necesitamos listar los
--títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada uno de ellos.
SELECT title AS titulo_episodio, CONCAT(first_name, ' ', last_name) AS actor_actriz
FROM actors AS a
INNER JOIN actor_episode AS ae ON a.id = ae.actor_id
INNER JOIN episodes AS e ON e.id = ae.episode_id



-- Micro desafío - Paso 2
--Obtener a todos los actores o actrices (mostrar
--nombre y apellido) que han trabajado en cualquier película de la saga de la Guerra de las
--galaxias, pero ¡cuidado!: debemos asegurarnos de que solo se muestre una sola vez cada actor/actriz.
SELECT DISTINCT first_name, last_name
FROM actors AS a
INNER JOIN actor_movie AS am ON a.id = am.actor_id 
INNER JOIN movies AS m ON m.id = am.movie_id 
WHERE m.title LIKE '%Guerra%galaxias%'



-- Micro desafío - Paso 3
--Debemos listar los títulos de cada película con su género correspondiente. En el caso de
--que no tenga género, mostraremos una leyenda que diga "no tiene género".
SELECT movies.title AS titulo, COALESCE(genres.name, 'No tiene género') AS género
FROM movies
LEFT JOIN genres ON movies.genre_id = genres.id



-- Micro desafío - Paso 4
--Necesitamos mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con
--la particularidad de que a la columna que mostrará dicha cantidad la renombraremos: “Duración”.
SELECT title AS Título, DATEDIFF(end_date, release_date) AS Duración
FROM series



--Micro desafío - Paso 5
--Consulta 1: Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres.
SELECT first_name, last_name
FROM actors 
WHERE LENGTH(first_name) > 6
ORDER BY first_name

--Consulta 2: Debemos mostrar la cantidad total de los episodios guardados en la base de datos.
SELECT COUNT(id) AS 'Cantidad de episodios en base de datos'
FROM episodes

--Consulta 3: nos piden que obtengamos el título de todas las series y el total
--de temporadas que tiene cada una de ellas.
SELECT series.title, COUNT(seasons.id) AS 'Cantidad de temporadas'
FROM series
INNER JOIN seasons ON series.id = seasons.serie_id 
GROUP BY series.title

--Consulta 4: Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor
--o igual a 3.
SELECT genres.name AS 'Género' , COUNT(movies.id) AS 'Cantidad de películas'
FROM genres
INNER JOIN movies ON genres.id = movies.genre_id
GROUP BY genres.name
HAVING COUNT(movies.id) >= 3