# DATABASE RATING FILM BERDASARKAN IMDB 
![movie](https://user-images.githubusercontent.com/125889903/220244275-5e26e547-c6f1-4e5a-ae71-779bac691ed6.png)

Rating merupakan salah satu acuan kualitas film-film dunia. Internet Movie Database alias IMDB merupakan situs pengulas dan rating film serta serial TV dengan mekanisme rating berdasarkan voting dari penonton. 

```sql
Tim:
Data manager: Sofia Octaviana (G1501221036)
Shiny developer: Adzkar Adlu (G1501211033)
Technical Writer: Nurzatil Aqmar (G1501222044)
```

## Entity Relationship Diagram

![diagram relation](https://user-images.githubusercontent.com/125889903/221397523-24efc735-fa8a-4c7d-921d-489c4e7b9f1f.jpeg)



## 1. Tabel Judul Film
```sql 
CREATE TABLE IF NOT EXISTS public.judul (
    movie_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    judul character varying(255) COLLATE pg_catalog."default" NOT NULL,
    tahun timestamp without time zone NOT NULL,
    CONSTRAINT judul_pkey PRIMARY KEY (movie_id)
);
```

## 2. Tabel Rating Film 
```sql
CREATE TABLE IF NOT EXISTS public.rating (
    movie_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    imdb_rating integer NOT NULL,
    kategori_rating character varying(10) COLLATE pg_catalog."default" NOT NULL,
    metascore integer NOT NULL,
    CONSTRAINT rating_pkey PRIMARY KEY (movie_id),
    CONSTRAINT rating_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.judul (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

);
```

## 3. Tabel Genre Film
```sql
CREATE TABLE IF NOT EXISTS public.genre (
    writer_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    movie_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    genre text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genre_pkey PRIMARY KEY (writer_id, movie_id),
    CONSTRAINT genre_judul_fkey FOREIGN KEY (movie_id)
        REFERENCES public.judul (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT genre_writer_id_fkey FOREIGN KEY (writer_id)
        REFERENCES public.penulis_naskah (writer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
```

## 4. Tabel Daftar Pemain Film
```sql
CREATE TABLE IF NOT EXISTS public.pemain_film (
    movie_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pemain_film_pkey PRIMARY KEY (movie_id),
    CONSTRAINT pemain_film_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.judul (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

);
```

## 5. Tabel Penulis Naskah
```sql
CREATE TABLE IF NOT EXISTS public.penulis_naskah (
    writer_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    writer_name text COLLATE pg_catalog."default" NOT NULL,
    director text COLLATE pg_catalog."default" NOT NULL,
    reviewer character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT penulis_naskah_pkey PRIMARY KEY (writer_id)
);
```
