# DATABASE RATING FILM BERDASARKAN IMDB 
![movie](https://user-images.githubusercontent.com/125889903/220244275-5e26e547-c6f1-4e5a-ae71-779bac691ed6.png)

```sql
Tim:
Data manager: Nurzatil 
Shiny developer: Adzkar Adlu 
Technical Writer: 
```

## Entity Relationship Diagram

![rating](https://user-images.githubusercontent.com/125889903/220243151-8edb3b13-5a3f-4362-871e-053fc1255282.png)


## 1. Tabel Judul Film
```sql 
CREATE TABLE IF NOT EXISTS public.judul (
    movie_id character varying(10) NOT NULL,
    judul character varying(255) NOT NULL,
    tahun timestamp NOT NULL,
    metascore integer NOT NULL,
    reviewer character varying(20) NOT NULL,
    PRIMARY KEY (movie_id)
);
```

## 2. Tabel Rating Film 
```sql
CREATE TABLE IF NOT EXISTS public.rating (
    judul character varying(255) NOT NULL,
    IMDB_rating integer NOT NULL,
    Kategori_rating character varying(10) NOT NULL,
    reviewer character varying(20) NOT NULL,
    PRIMARY KEY (judul)
);
```

## 3. Tabel Genre Film
```sql
CREATE TABLE IF NOT EXISTS public.genre (
    judul character varying(255) NOT NULL,
    kategori_rating character varying(10) NOT NULL,
    genre character varying(10) NOT NULL,
    movie_id character varying(10) NOT NULL,
    PRIMARY KEY (movie_id)
);
```

## 4. Tabel Daftar Pemain Film
```sql
CREATE TABLE IF NOT EXISTS public.pemain_film(
    movie_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    cast_movie text NOT NULL,
    writer text NOT NULL,
    directur text NOT NULL,
	judul character varying(255) NOT NULL,
    CONSTRAINT pemain_film_pkey PRIMARY KEY (movie_id, judul),
    CONSTRAINT pemain_film_tahun_fkey FOREIGN KEY (judul)
        REFERENCES public.rating (judul) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT pemain_film_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.judul (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
```
