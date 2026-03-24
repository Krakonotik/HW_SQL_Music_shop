-- Task 2
-- =============================================

-- 1. Название и продолжительность самого длительного трека
SELECT title, duration
FROM tracks
WHERE duration = (SELECT MAX(duration) FROM tracks);

-- 2. Название треков, продолжительность которых не менее 3,5 минут (210 секунд)
SELECT title
FROM tracks
WHERE duration >= 210;

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT title
FROM compilations
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова (не содержит пробелов)
SELECT name
FROM artists
WHERE name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «мой» или «my» (регистронезависимо)
SELECT title
FROM tracks
WHERE LOWER(title) LIKE '%мой%' OR LOWER(title) LIKE '%my%';


-- =============================================
-- Task 3
-- =============================================

-- 1. Количество исполнителей в каждом жанре
SELECT g.name AS genre, COUNT(DISTINCT ag.artist_id) AS artist_count
FROM genres g
LEFT JOIN artistgenre ag ON g.id = ag.genre_id
GROUP BY g.id, g.name
ORDER BY artist_count DESC;

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id) AS track_count
FROM tracks t
JOIN albums a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому
SELECT a.title AS album, AVG(t.duration) AS avg_duration_seconds
FROM albums a
LEFT JOIN tracks t ON a.id = t.album_id
GROUP BY a.id, a.title
ORDER BY avg_duration_seconds DESC NULLS LAST;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT ar.name AS artist
FROM artists ar
WHERE ar.id NOT IN (
    SELECT DISTINCT aa.artist_id
    FROM artistalbum aa
    JOIN albums al ON aa.album_id = al.id
    WHERE al.release_year = 2020
)
ORDER BY ar.name;

-- 5. Названия сборников, в которых присутствует конкретный исполнитель (например, The Weeknd)
SELECT DISTINCT c.title AS compilation_name
FROM compilations c
JOIN compilationtrack ct ON c.id = ct.compilation_id
JOIN tracks t ON ct.track_id = t.id
JOIN albums a ON t.album_id = a.id
JOIN artistalbum aa ON a.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
WHERE ar.name = 'The Weeknd';