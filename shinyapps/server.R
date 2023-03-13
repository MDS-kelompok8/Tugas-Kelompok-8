connectDB <- function(){
  driver <- dbDriver('PostgreSQL')
  DB <- dbConnect(
    driver,
    dbname="qnimzcgc", #User & Default database
    host="topsy.db.elephantsql.com",  #Server
    user="qnimzcgc", # User & Default database
    password="pGEDSp-s-V32WqGMpzXLnPgMfcBfPXRz" #Password
  )
}

function(input, output, session) {
    output$tblJudul <- renderDataTable({
    DB <- connectDB()
    q1 <- "SELECT judul, tahun FROM judul;"
    judul<-dbGetQuery(DB, q1)
    dbDisconnect(DB)
    
    judul
  })
  
  output$tblRating <- renderDataTable({
    DB <- connectDB()
    rating<-dbReadTable(DB, 'rating')
    dbDisconnect(DB)
    
    rating
  })
  
  output$tblPemain <- renderDataTable({
    DB <- connectDB()
    pemain_film<-dbReadTable(DB, 'pemain_film')
    dbDisconnect(DB)
    
    pemain_film
  })
  
  output$tblDirector <- renderDataTable({
    DB <- connectDB()
    director<-dbReadTable(DB, 'director')
    dbDisconnect(DB)
    
    director
  })
  
  output$tblGenre <- renderDataTable({
    DB <- connectDB()
    genre<-dbReadTable(DB, 'genre')
    dbDisconnect(DB)
    
    genre
  })
  
  listJudul <- reactive({
    DB <- connectDB()
    judul<-dbReadTable(DB, 'judul')
    dbDisconnect(DB)
    
    judul$judul
  })
  
  output$loadJudul <- renderUI({
    selectInput("listJudul", "judul", choices = listJudul())
  })
  
  listGenre <- reactive({
    DB <- connectDB()
    genre<-dbReadTable(DB, 'genre')
    dbDisconnect(DB)
    
    genre$movie_id
  })
  
  output$loadGenre <- renderUI({
    selectInput("listGenre", "genre", choices = listGenre())
  })
  
}

