-- Create Full Movie Database
-- CREATE DATABASE yourLastNameMoviesFull;
-- Use yourLastNameMoviesFull;

CREATE DATABASE MiddaughMoviesFull;
Use MiddaughMoviesFull;

-- Create Genre Table
CREATE TABLE genre
(
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	gen_title VARCHAR(10) NOT NULL
);

-- Create Director Table 
CREATE TABLE director
(
	id  INT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
	dir_firstName VARCHAR(30) NOT NULL,
	dir_lastName VARCHAR(30) NOT NULL
);

-- Create Director Table 
CREATE TABLE reviewer
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	rev_name VARCHAR(45)
);

-- Create Movie Table 
CREATE TABLE movie
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	mov_title VARCHAR(35) NOT NULL,
	mov_year INT NOT NULL,
	mov_time INT NOT NULL,
	mov_lang VARCHAR(15) NOT NULL,
	mov_dt_rel DATE,
	mov_rel_country VARCHAR(5) NOT NULL,
	gen_id INT NOT NULL,
	dir_id INT NOT NULL,
	CONSTRAINT fk_dir_movie FOREIGN KEY (dir_id) REFERENCES director (id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_genre_movie FOREIGN KEY (gen_id) REFERENCES genre(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- Create Rating Table 
CREATE TABLE rating
(
	rev_id INT NOT NULL, 
	mov_id INT NOT NULL,
	rev_rating DECIMAL(6,1) NOT NULL,
	CONSTRAINT fk_rev_rating FOREIGN KEY(rev_id) REFERENCES reviewer (id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_mov_rating FOREIGN KEY(mov_id) REFERENCES movie(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
-- Alter rating rating adding Composite Primary Key 
ALTER TABLE rating ADD PRIMARY KEY (rev_id, mov_id);
