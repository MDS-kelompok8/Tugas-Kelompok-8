connectDB <- function(){
  driver <- dbDriver('PostgreSQL')
  DB <- dbConnect(
    driver,
    dbname="rating", #User & Default database
    host="localhost",  #Server
    port= 5432,
    user="postgres", # User & Default database
    password="Sofia123" #Password
  )
}

function(input, output, session) {
  output$tblJudul <- renderDataTable({
    DB <- connectDB()
    q1 <- "SELECT judul, tahun as Tahun_Rilis FROM judul;"
    judul<-dbGetQuery(DB, q1)
    dbDisconnect(DB)
    
    judul
  })
  
  
  output$tblPemain <- renderDataTable({
    DB <- connectDB()
    q2 <- "SELECT j.judul as Judul_Film,
    j.tahun as Tahun_Rilis,
    p.pemain_film as Pemain_Film
      FROM judul as j
      INNER JOIN pemain_film as p
      ON j.movie_id = p.movie_id;"
    pemain_film<-dbGetQuery(DB, q2)
    dbDisconnect(DB)
    
    pemain_film
  })
  
  output$tblRilis <- renderDataTable({
    DB <- connectDB()
    q3 <- paste0("SELECT * FROM judul
                 WHERE tahun = '", input$tahun_rilis,"';")
    tahun<-dbGetQuery(DB, q3)
    dbDisconnect(DB)
    
    tahun
  })
  
  output$tblRating <- renderDataTable({
    DB <- connectDB()
    q4 <- "SELECT j.judul as Judul_Film,
    r.imdb_rating as rating
      FROM judul as j
      INNER JOIN rating as r
      ON j.movie_id = r.movie_id
        ORDER BY rating DESC;"
    rating<-dbGetQuery(DB, q4)
    dbDisconnect(DB)
    
    rating
  })
  
  output$tblDirector <- renderDataTable({
    DB <- connectDB()
    q5 <- "SELECT j.judul as judul_film, j.tahun as tahun_rilis,
    CONCAT(d.first_name, ' ', d.last_name) as Sutradara, g.genre
    FROM judul as j
      INNER JOIN genre as g
        ON j.movie_id = g.movie_id
      INNER JOIN director as d
        ON d.director_id = g.director_id
        ORDER BY j.tahun DESC;"
    director<-dbGetQuery(DB, q5)
    dbDisconnect(DB)
    
    director
  })
}
