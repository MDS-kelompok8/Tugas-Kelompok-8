library(shiny)
library(shinydashboard)
library(DT)
library(RPostgreSQL)
library(DBI)

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

judul_film <- dbGetQuery(connectDB(), "SELECT judul FROM judul;")
genre_film <- dbGetQuery(connectDB(), "SELECT genre FROM genre;") 

dashboardPage(
  title = "World Rating Movie",
  dashboardHeader(
    title = "World Rating Movie"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        text = "Beranda",
        tabName = "beranda",
        icon = icon("house")
      ),
      menuItem(
        text = "Movie List",
        tabName = "tab_iq8h44dkce",
        icon = icon("film")
      ),
      menuItem(
        text = "Actor and Actress",
        tabName = "tab_9oud9ac3yp",
        icon = icon("person")
      ),
      menuItem(
        text = "Genre",
        tabName = "tab_kfa4noo5fz",
        icon = icon("mask")
      ),
      menuItem(
        text = "Most Popular Movie",
        tabName = "tab_7lbhhwdq4f",
        icon = icon("ranking-star")
      ),
      menuItem(
        text = "Director",
        tabName = "tab_xi0zslveui",
        icon = icon("pen")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "tab_iq8h44dkce",
        h1(
          "Movie List"
        ),
        dataTableOutput(
          outputId = "tblJudul"
        )
      ),
      tabItem(
        tabName = "tab_9oud9ac3yp",
        h2(
          "Daftar Pemain Film"
        ),
        dataTableOutput(
          outputId = "tblPemain"
        )
      ),
      tabItem(
        tabName = "tab_kfa4noo5fz",
        selectInput(
          inputId = "listGenre",
          label = "Genre",
          choices = NULL
        ),
        h2(
          "Movie List by Genre"
        ),
        dataTableOutput(
          outputId = "tblGenre"
        )
      ),
      tabItem(
        tabName = "tab_7lbhhwdq4f",
        h2(
          "Daftar Film Teratas Berdasarkan Rating"
        ),
        dataTableOutput(
          outputId = "tblRating"
        )
      ),
      tabItem(
        tabName = "tab_xi0zslveui",
        h2(
          "Daftar Sutradara"
        ),
        dataTableOutput(
          outputId = "tblDirector"
        )
      )  
    )
    
  )
)
