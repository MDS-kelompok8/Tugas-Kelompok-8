library(shiny)
library(shinydashboard)
library(DT)
library(RPostgreSQL)
library(DBI)

--------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------

tahun <- dbGetQuery(connectDB(), "SELECT tahun FROM judul;")

#Title Web Page
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
        text = "Release Year",
        tabName = "tab_kfa4noo5fz",
        icon = icon("calendar")
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
      ),
      menuItem(
        text = "Year Release Distribution",
        tabName = "tab_iq8h44dk",
        icon = icon("chart-line")
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
          inputId = "tahun_rilis",
          label = "Tahun Rilis",
          choices = tahun
        ),
        h2(
          "Judul Film Berdasarkan Tahun Rilis"
        ),
        dataTableOutput(
          outputId = "tblRilis"
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
      ),
    )
  )
)
