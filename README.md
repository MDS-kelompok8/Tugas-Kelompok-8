# *DATABASE RATING FILM BERDASARKAN IMDB* 
![gambar film review](https://user-images.githubusercontent.com/125889903/221512667-6f595242-8ff4-4280-b7bf-0cfb1192f9ba.png)

```sql
Tim:
Data manager: Sofia Octaviana (G1501221036)
Shiny developer: Adzkar Adlu (G1501211033)
Technical Writer: Nurzatil Aqmar (G1501222044)
```
Dalam projek ini kelompok kami akan mengembangkan database yang memuat film dengan rekomendasi terbaik berdasarkan IMDB. Internet Movie Database alias IMDB merupakan situs pengulas dan rating film serta serial TV dengan mekanisme rating berdasarkan voting dari penonton. Website IMDB berisi tentang rekomendasi film terbaik atau populer yang terdiri dari 250 film. IMDB 
Berdasarkan database yang kami kembangkan, nantinya pengguna dapat mencari film yang diinginkan berdasarkan kategori pemain film, tahun rilis, dan sebagainya.
***

## Entity Relationship Diagram

![rating_new](https://user-images.githubusercontent.com/125889903/221503018-4e6b78bb-15ab-4a35-8803-2d90f8cec8d6.png)

## 1. Tabel Judul Film
Tabel judul terdiri dari 4 atribut yaitu `movie_id`, `judul`, `tahun` dan `durasi_film`.

`movie_id` = id dari masing-masing film yang bersifat unik <br /> 
`judul` = judul dari 250 film <br /> 
`tahun` = tahun rilis film <br /> 
`durasi_film` = durasi dari film(menit) <br /> 

```sql 
CREATE TABLE IF NOT EXISTS public.judul (
    movie_id text COLLATE pg_catalog."default" NOT NULL,
    judul text COLLATE pg_catalog."default" NOT NULL,
    tahun integer NOT NULL,
    durasi_film integer NOT NULL,
    CONSTRAINT judul_pkey PRIMARY KEY (movie_id)
);
```

## 2. Tabel Rating Film 
Tabel rating terdiri dari 4 atribut yaitu `movie_id`, `imdb_rating`, dan `vote`.

`movie_id` = id dari masing-masing film yang bersifat unik <br /> 
`imdb_rating` = rata-rata penilaian dari reviewer <br /> 
`vote` = banyaknya penilai film <br /> 

```sql
CREATE TABLE IF NOT EXISTS public.rating (
    movie_id text COLLATE pg_catalog."default" NOT NULL,
    imdb_rating integer NOT NULL,
    vote integer NOT NULL,
    CONSTRAINT rating_pkey PRIMARY KEY (movie_id),
    CONSTRAINT rating_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.judul (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

);
```

## 3. Tabel Genre Film
Tabel genre terdiri dari 3 atribut yaitu `director_id`, `movie_id`, `genre`.

`director` = sutradara film <br />
`movie_id` = id dari masing-masing film yang bersifat unik <br />
`genre` = klasifikasi atau jenis dari film yang dibuat seperti triller <br />
```sql
CREATE TABLE IF NOT EXISTS public.genre (
    director_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    movie_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    genre text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genre_pkey PRIMARY KEY (director_id, movie_id),
    CONSTRAINT genre_judul_fkey FOREIGN KEY (movie_id)
        REFERENCES public.judul (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT genre_director_id_fkey FOREIGN KEY (director_id)
        REFERENCES public.director (director_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
```

## 4. Tabel Daftar Pemain Film
Tabel daftar pemain film terdiri dari 2 atribut yaitu `movie_id`, dan `pemain_film`.

`movie_id` = id dari masing-masing film yang bersifat unik <br />
`pemain_film` = aktor/aktris yang memerankan film <br />
```sql
CREATE TABLE IF NOT EXISTS public.pemain_film (
    movie_id text COLLATE pg_catalog."default" NOT NULL,
    pemain_film text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pemain_film_pkey PRIMARY KEY (movie_id),
    CONSTRAINT pemain_film_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.judul (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

);
```

## 5. Tabel Sutradara
Tabel penulis naskah terdiri dari 3 atribut yaitu `director_id`, `first_name`, dan `last_name`.

`director` = sutradara film <br />
`first_name` = nama depan dari sutradara film <br />
`last_name` = nama belakang dari sutradara film <br />
```sql
CREATE TABLE IF NOT EXISTS public.director (
    director_id text COLLATE pg_catalog."default" NOT NULL,
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT director_pkey PRIMARY KEY (director_id)
);
```
