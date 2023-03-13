library(shiny)
library(shinydashboard)
library(DT)
library(RPostgreSQL)
library(DBI)

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
        text = "Pemain Film",
        tabName = "tab_9oud9ac3yp",
        icon = icon("person")
      ),
      menuItem(
        text = "Genre",
        tabName = "tab_kfa4noo5fz",
        icon = icon("mask")
      ),
      menuItem(
        text = "Rating",
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
        selectInput(
          inputId = "listJudul",
          label = "Masukkan judul film",
          choices = NULL
        ),
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
          "Genre"
        ),
        dataTableOutput(
          outputId = "tblGenre"
        )
      ),
      tabItem(
        tabName = "tab_7lbhhwdq4f",
        selectInput(
          inputId = "ListRating",
          label = "Rating",
          choices = NULL
        ),
        h2(
          "Rating"
        ),
        dataTableOutput(
          outputId = "tblRating"
        )
      ),
      tabItem(
        tabName = "tab_xi0zslveui",
        selectInput(
          inputId = "listDirector",
          label = "Director",
          choices = NULL
        ),
        h2(
          "Daftar Director"
        ),
        dataTableOutput(
          outputId = "tblDirector"
        )
      )  
    )
    
  )
)