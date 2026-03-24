-- Таблица жанров
CREATE TABLE IF NOT EXISTS Genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Таблица исполнителей
CREATE TABLE IF NOT EXISTS Artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);

-- Связь исполнителей и жанров (многие ко многим)
CREATE TABLE IF NOT EXISTS ArtistGenre (
    artist_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (artist_id, genre_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genres(id) ON DELETE CASCADE
);

-- Таблица альбомов (без прямой ссылки на исполнителя)
CREATE TABLE IF NOT EXISTS Albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INTEGER CHECK (release_year > 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Связь исполнителей и альбомов (многие ко многим)
CREATE TABLE IF NOT EXISTS ArtistAlbum (
    artist_id INTEGER NOT NULL,
    album_id INTEGER NOT NULL,
    PRIMARY KEY (artist_id, album_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES Albums(id) ON DELETE CASCADE
);

-- Таблица треков
CREATE TABLE IF NOT EXISTS Tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    duration INTEGER CHECK (duration > 0),
    album_id INTEGER NOT NULL,
    FOREIGN KEY (album_id) REFERENCES Albums(id) ON DELETE CASCADE
);

-- Таблица сборников
CREATE TABLE IF NOT EXISTS Compilations (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INTEGER CHECK (release_year > 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Связь треков и сборников (многие ко многим)
CREATE TABLE IF NOT EXISTS CompilationTrack (
    compilation_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    PRIMARY KEY (compilation_id, track_id),
    FOREIGN KEY (compilation_id) REFERENCES Compilations(id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES Tracks(id) ON DELETE CASCADE
);