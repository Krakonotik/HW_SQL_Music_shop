-- 1. Жанры
INSERT INTO genres (name)
SELECT name FROM (VALUES ('Rock'), ('Pop'), ('Electronic')) AS v(name)
WHERE NOT EXISTS (SELECT 1 FROM genres WHERE genres.name = v.name);

-- 2. Исполнители
INSERT INTO artists (name)
SELECT name FROM (VALUES 
    ('Imagine Dragons'),
    ('Daft Punk'),
    ('Taylor Swift'),
    ('The Weeknd'),
    ('Adele'),
    ('Eminem')
) AS v(name)
WHERE NOT EXISTS (SELECT 1 FROM artists WHERE artists.name = v.name);

-- 3. Связи исполнителей и жанров
-- Imagine Dragons: Rock, Pop
INSERT INTO artistgenre (artist_id, genre_id)
SELECT a.id, g.id
FROM artists a, genres g
WHERE a.name = 'Imagine Dragons' AND g.name IN ('Rock', 'Pop')
AND NOT EXISTS (SELECT 1 FROM artistgenre WHERE artist_id = a.id AND genre_id = g.id);

-- Daft Punk: Electronic, Pop
INSERT INTO artistgenre (artist_id, genre_id)
SELECT a.id, g.id
FROM artists a, genres g
WHERE a.name = 'Daft Punk' AND g.name IN ('Electronic', 'Pop')
AND NOT EXISTS (SELECT 1 FROM artistgenre WHERE artist_id = a.id AND genre_id = g.id);

-- Taylor Swift: Pop
INSERT INTO artistgenre (artist_id, genre_id)
SELECT a.id, g.id
FROM artists a, genres g
WHERE a.name = 'Taylor Swift' AND g.name = 'Pop'
AND NOT EXISTS (SELECT 1 FROM artistgenre WHERE artist_id = a.id AND genre_id = g.id);

-- The Weeknd: Pop, Electronic
INSERT INTO artistgenre (artist_id, genre_id)
SELECT a.id, g.id
FROM artists a, genres g
WHERE a.name = 'The Weeknd' AND g.name IN ('Pop', 'Electronic')
AND NOT EXISTS (SELECT 1 FROM artistgenre WHERE artist_id = a.id AND genre_id = g.id);

-- Adele: Pop
INSERT INTO artistgenre (artist_id, genre_id)
SELECT a.id, g.id
FROM artists a, genres g
WHERE a.name = 'Adele' AND g.name = 'Pop'
AND NOT EXISTS (SELECT 1 FROM artistgenre WHERE artist_id = a.id AND genre_id = g.id);

-- Eminem: Electronic
INSERT INTO artistgenre (artist_id, genre_id)
SELECT a.id, g.id
FROM artists a, genres g
WHERE a.name = 'Eminem' AND g.name = 'Electronic'
AND NOT EXISTS (SELECT 1 FROM artistgenre WHERE artist_id = a.id AND genre_id = g.id);

-- 4. Альбомы
INSERT INTO albums (title, release_year)
SELECT title, year FROM (VALUES 
    ('Evolve', 2017),
    ('Random Access Memories', 2013),
    ('1989', 2014),
    ('After Hours', 2020),
    ('25', 2015),
    ('No.6 Collaborations Project', 2019)
) AS v(title, year)
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE albums.title = v.title);

-- 5. Связи исполнителей и альбомов
-- Evolve: Imagine Dragons
INSERT INTO artistalbum (artist_id, album_id)
SELECT a.id, al.id
FROM artists a, albums al
WHERE a.name = 'Imagine Dragons' AND al.title = 'Evolve'
AND NOT EXISTS (SELECT 1 FROM artistalbum WHERE artist_id = a.id AND album_id = al.id);

-- Random Access Memories: Daft Punk
INSERT INTO artistalbum (artist_id, album_id)
SELECT a.id, al.id
FROM artists a, albums al
WHERE a.name = 'Daft Punk' AND al.title = 'Random Access Memories'
AND NOT EXISTS (SELECT 1 FROM artistalbum WHERE artist_id = a.id AND album_id = al.id);

-- 1989: Taylor Swift
INSERT INTO artistalbum (artist_id, album_id)
SELECT a.id, al.id
FROM artists a, albums al
WHERE a.name = 'Taylor Swift' AND al.title = '1989'
AND NOT EXISTS (SELECT 1 FROM artistalbum WHERE artist_id = a.id AND album_id = al.id);

-- After Hours: The Weeknd
INSERT INTO artistalbum (artist_id, album_id)
SELECT a.id, al.id
FROM artists a, albums al
WHERE a.name = 'The Weeknd' AND al.title = 'After Hours'
AND NOT EXISTS (SELECT 1 FROM artistalbum WHERE artist_id = a.id AND album_id = al.id);

-- 25: Adele
INSERT INTO artistalbum (artist_id, album_id)
SELECT a.id, al.id
FROM artists a, albums al
WHERE a.name = 'Adele' AND al.title = '25'
AND NOT EXISTS (SELECT 1 FROM artistalbum WHERE artist_id = a.id AND album_id = al.id);

-- No.6 Collaborations Project: Eminem
INSERT INTO artistalbum (artist_id, album_id)
SELECT a.id, al.id
FROM artists a, albums al
WHERE a.name = 'Eminem' AND al.title = 'No.6 Collaborations Project'
AND NOT EXISTS (SELECT 1 FROM artistalbum WHERE artist_id = a.id AND album_id = al.id);

-- 6. Треки
INSERT INTO tracks (title, duration, album_id)
SELECT t.title, t.duration, al.id
FROM albums al
CROSS JOIN (VALUES 
    -- Evolve
    ('Believer', 204),
    ('Thunder', 187),
    -- Random Access Memories
    ('Get Lucky', 368),
    ('Lose Yourself to Dance', 353),
    -- 1989
    ('Shake It Off', 219),
    ('Blank Space', 231),
    -- After Hours
    ('Blinding Lights', 200),
    ('Save Your Tears', 215),
    -- 25
    ('Hello', 295),
    ('When We Were Young', 287),
    -- No.6 Collaborations Project (2019)
    ('Homicide', 270),
    ('My Band', 210),
    ('Мой путь', 240)
) AS t(title, duration)
WHERE al.title IN ('Evolve', 'Random Access Memories', '1989', 'After Hours', '25', 'No.6 Collaborations Project')
  AND (
      (al.title = 'Evolve' AND t.title IN ('Believer', 'Thunder'))
      OR (al.title = 'Random Access Memories' AND t.title IN ('Get Lucky', 'Lose Yourself to Dance'))
      OR (al.title = '1989' AND t.title IN ('Shake It Off', 'Blank Space'))
      OR (al.title = 'After Hours' AND t.title IN ('Blinding Lights', 'Save Your Tears'))
      OR (al.title = '25' AND t.title IN ('Hello', 'When We Were Young'))
      OR (al.title = 'No.6 Collaborations Project' AND t.title IN ('Homicide', 'My Band', 'Мой путь'))
  )
AND NOT EXISTS (
    SELECT 1 FROM tracks 
    WHERE tracks.album_id = al.id AND tracks.title = t.title
);

-- 7. Сборники
INSERT INTO compilations (title, release_year)
SELECT title, year FROM (VALUES 
    ('Best of 2017', 2017),
    ('Electronic Vibes', 2018),
    ('Pop Hits', 2019),
    ('Dance Party', 2020),
    ('Summer Jams 2020', 2020)
) AS v(title, year)
WHERE NOT EXISTS (SELECT 1 FROM compilations WHERE compilations.title = v.title);

-- 8. Связи треков и сборников
-- Добавляем связи для всех треков, включая новые
WITH
    track_ids AS (SELECT id, title FROM tracks),
    compilation_ids AS (SELECT id, title FROM compilations)
INSERT INTO compilationtrack (compilation_id, track_id)
SELECT c.id, t.id
FROM compilation_ids c
CROSS JOIN track_ids t
WHERE
    (
        (c.title = 'Best of 2017' AND t.title IN ('Believer', 'Shake It Off', 'Blinding Lights'))
        OR (c.title = 'Electronic Vibes' AND t.title IN ('Get Lucky', 'Lose Yourself to Dance', 'Blinding Lights'))
        OR (c.title = 'Pop Hits' AND t.title IN ('Shake It Off', 'Blank Space', 'Thunder', 'Save Your Tears', 'Hello', 'When We Were Young', 'My Band', 'Мой путь'))
        OR (c.title = 'Dance Party' AND t.title IN ('Get Lucky', 'Believer', 'Blinding Lights', 'My Band'))
        OR (c.title = 'Summer Jams 2020' AND t.title IN ('Blinding Lights', 'Save Your Tears', 'My Band', 'Мой путь'))
    )
    AND NOT EXISTS (
        SELECT 1 FROM compilationtrack ct
        WHERE ct.compilation_id = c.id AND ct.track_id = t.id
    );

-- Добавляем тестовый альбом
INSERT INTO albums (title, release_year)
SELECT 'Test Vocabulary', 2023
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title = 'Test Vocabulary');

-- Добавляем тестовые треки
INSERT INTO tracks (title, duration, album_id)
SELECT v.title, v.duration, a.id
FROM (VALUES
    -- Правильные (должны найтись)
    ('my own', 180),
    ('own my', 180),
    ('my', 180),
    ('oh my god', 180),
    ('мой друг', 180),
    ('это мой', 180),
    ('мой', 180),
    ('вот мой дом', 180),
    -- Неправильные (НЕ должны найтись)
    ('myself', 180),
    ('by myself', 180),
    ('bemy self', 180),
    ('myself by', 180),
    ('by myself by', 180),
    ('beemy', 180),
    ('premyne', 180)
) AS v(title, duration)
CROSS JOIN albums a
WHERE a.title = 'Test Vocabulary'
  AND NOT EXISTS (
      SELECT 1 FROM tracks t2
      WHERE t2.album_id = a.id AND t2.title = v.title
  );
