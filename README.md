# *DATABASE RATING FILM BERDASARKAN IMDB* 
![gambar film review](https://user-images.githubusercontent.com/125889903/221736359-49976bea-fa63-47e5-99fc-5f4e006d204d.png)

```sql
Tim:
Data manager: Sofia Octaviana (G1501221036)
Shiny developer: Adzkar Adlu (G1501211033)
Technical Writer: Nurzatil Aqmar (G1501222044)
```
## :bookmark_tabs: Menu

- [Rating Film](#scroll-overview)
- [Screenshot](#rice_scene-screenshot)
- [Demo](#dvd-demo)
- [Dokumentasi](#blue_book-documentation)
- [Requirements](#exclamation-requirements)
- [Skema Database](#floppy_disk-skema-database)
- [ERD](#rotating_light-erd)
- [Deskripsi Data](#heavy_check_mark-deskripsi-data)
- [Struktur Folder](#open_file_folder-stuktur-folder)
- [Tim Pengembang](#smiley_cat-tim-pengembang)

## :scroll: Rating Film

Dalam projek ini kelompok kami akan mengembangkan database yang memuat film dengan rekomendasi terbaik berdasarkan IMDB. Internet Movie Database alias IMDB merupakan web yang berisi tentang informasi yang berkaitan film, video rumahan, acara televisi, serta sebagai situs pengulas dan rating film dan serial TV dengan mekanisme rating berdasarkan voting dari penonton. Website IMDB berisi tentang rekomendasi film terbaik atau populer yang terdiri dari 250 film. IMDb Top 250 adalah daftar dari 250 film berperingkat teratas, berdasarkan peringkat oleh pengguna terdaftar dari situs web menggunakan suatu metode. 
Database yang diperoleh menggunakan teknik Web Scraping di web IMDB. Web Scraping merupakan teknik pengambilan suatu data atau informasi tertentu dengan jumlah besar untuk nantinya digunakan dalam berbagai keperluan seperti riset, analisis dan lainnya. 
Berdasarkan database yang akan kami kembangkan, nantinya pengguna dapat mencari film yang diinginkan berdasarkan kategori pemain film, tahun rilis, dan sebagainya.
***

## :floppy_disk: Skema Database

<img width="462" alt="ERD" src="https://user-images.githubusercontent.com/125889903/221746683-1524b2ab-479a-48e2-ab31-569a27cdcbb2.png">


## :rotating_light: ERD

![rating_new](https://user-images.githubusercontent.com/125889903/221503018-4e6b78bb-15ab-4a35-8803-2d90f8cec8d6.png)


## 1. Tabel Judul Film
Tabel judul terdiri dari 4 atribut yaitu `movie_id`, `judul`, `tahun` dan `durasi_film`. Adapun yang menjadi primary key dalam tabel ini adalah `movie_id`.

| Attribute          | Type                  | Description                                    |
|:-------------------|:----------------------|:-----------------------------------------------|
| movie_id           | text                  | id dari masing-masing film yang bersifat unik  |
| judul              | text                  | judul dari 250 film                            |
| tahun              | integer               | tahun rilis film                               |
| durasi_film        | integer               | durasi dari film(menit)                        |

### Create Table Judul Film
```sql 
CREATE TABLE IF NOT EXISTS public.judul (
    movie_id text COLLATE pg_catalog."default" NOT NULL,
    judul text COLLATE pg_catalog."default" NOT NULL,
    tahun integer NOT NULL,
    durasi_film integer NOT NULL,
    CONSTRAINT judul_pkey PRIMARY KEY (movie_id)
);
```
Data dalam tabel ini diperoleh dari hasil scrapping website IMDB sebanyak 250 film. Adapun data dari tabel judul film akan membentuk tampilan seperti di bawah ini setelah diimport ke PostgreSQL.

![WhatsApp Image 2023-02-28 at 08 49 08](https://user-images.githubusercontent.com/125889903/221732554-5c5fe591-8c1d-4938-9bc1-fa08363b19ba.jpeg)

## 2. Tabel *Rating Film*
Tabel rating terdiri dari 4 atribut yaitu `movie_id`, `imdb_rating`, dan `vote`.

| Attribute          | Type                  | Description                                    |
|:-------------------|:----------------------|:-----------------------------------------------|
| movie_id           | text                  | id dari masing-masing film yang bersifat unik  |
| imdb_rating        | integer               | rata-rata penilaian dari reviewer              |
| vote               | integer               | banyaknya penilai film                         |

### Create Table Rating Film

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
Data dalam tabel ini diperoleh dari hasil scrapping website IMDB sebanyak 250 film. Adapun data dari tabel rating film akan membentuk tampilan seperti di bawah ini setelah diimport ke PostgreSQL.
![rating](https://user-images.githubusercontent.com/125889903/221735741-1ebf0b9a-8a87-400b-854f-dd9a9f58429a.jpeg)


## 3. Tabel *Genre Film*
Tabel genre terdiri dari 3 atribut yaitu `director_id`, `movie_id`, `genre`.

| Attribute          | Type                  | Description                                                 |
|:-------------------|:----------------------|:------------------------------------------------------------|
| director           | character varying(10) | sutradara film                                              |
| movie_id           | character varying(10) | id dari masing-masing film yang bersifat unik               |
| genre              | text                  | klasifikasi atau jenis dari film yang dibuat seperti triller|

### Create Table Genre Film
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
Data dalam tabel ini diperoleh dari hasil scrapping website IMDB sebanyak 250 film. Adapun data dari tabel genre film akan membentuk tampilan seperti di bawah ini setelah diimport ke PostgreSQL.
![WhatsApp Image 2023-02-28 at 09 50 01](https://user-images.githubusercontent.com/125889903/221741239-234cc827-847a-4d6e-b4be-d9616af78042.jpeg)


## 4. Tabel *Daftar Pemain Film*
Tabel daftar pemain film terdiri dari 2 atribut yaitu `movie_id`, dan `pemain_film`.

| Attribute          | Type       | Description                                  |
|:-------------------|:-----------|:---------------------------------------------|
| movie_id           | text       | id dari masing-masing film yang bersifat unik|
| pemain_film        | text       | aktor/aktris yang memerankan film            |

### Create Table Daftar Pemain Film
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
Data dalam tabel ini diperoleh dari hasil scrapping website IMDB sebanyak 250 film. Adapun data dari tabel pemain film akan membentuk tampilan seperti di bawah ini setelah diimport ke PostgreSQL.
![pemain_film](https://user-images.githubusercontent.com/125889903/221735678-5c2ce9f4-6ad2-4849-9566-84e8bde28409.jpeg)


## 5. Tabel *Sutradara*
Tabel penulis naskah terdiri dari 3 atribut yaitu `director_id`, `first_name`, dan `last_name`.

| Attribute          | Type       | Description                           |
|:-------------------|:-----------|:--------------------------------------|
| director           | text       | sutradara film                        |
| first_name         | text       | nama depan dari sutradara film        |
| last_name          | text       | nama belakang dari sutradara film     |

### Create Table Sutradara
```sql
CREATE TABLE IF NOT EXISTS public.director (
    director_id text COLLATE pg_catalog."default" NOT NULL,
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT director_pkey PRIMARY KEY (director_id)
);
```
Data dalam tabel ini diperoleh dari hasil scrapping website IMDB sebanyak 250 film. Adapun data dari tabel director akan membentuk tampilan seperti di bawah ini setelah diimport ke PostgreSQL.
![director](https://user-images.githubusercontent.com/125889903/221735871-f67623ff-4c19-41d7-b339-aeafa432288c.jpeg)
