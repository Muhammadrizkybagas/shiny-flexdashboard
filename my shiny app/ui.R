library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)

dashboardPage(
  dashboardHeader(title = "Survei Pengalaman Belajar Daring"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Formulir Survei", tabName = "form", icon = icon("edit")),
      menuItem("Data Survei", tabName = "data", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("form",
              fluidRow(
                box(title = "Formulir Survei Belajar Daring", width = 12, solidHeader = TRUE, status = "primary",
                    dateInput("tanggal", "Tanggal Pengisian:", value = Sys.Date()),
                    selectInput("jenis_kelamin", "Jenis Kelamin:", c("Laki-laki", "Perempuan", "Tidak ingin menyebutkan")),
                    selectInput("program_studi", "Program Studi:", c("Sains Data", "Teknik Informatika", "Teknik Perminyakan", "Teknik Pertambangan", "Desain Produk")),
                    selectInput("semester", "Semester Saat Ini:", choices = 1:8, selected = 4),
                    numericInput("ipk_terakhir", "IPK Terakhir:", value = 3.0, min = 0.0, max = 4.0, step = 0.1),
                    sliderInput("perangkat_andal", "Keandalan Perangkat (1-5):", min = 1, max = 5, value = 3),
                    sliderInput("koneksi_stabil", "Stabilitas Koneksi Internet (1-5):", min = 1, max = 5, value = 3),
                    selectInput("jenis_perangkat", "Jenis Perangkat Utama:", c("Laptop", "Smartphone", "Tablet", "Lainnya")),
                    textAreaInput("platform_daring", "Platform Daring yang Sering Digunakan (misalnya, Zoom):"),
                    sliderInput("interaktif_daring", "Keinteraktifan Kuliah Daring (1-5):", min = 1, max = 5, value = 3),
                    sliderInput("responsivitas_dosen", "Responsivitas Dosen (1-5):", min = 1, max = 5, value = 3),
                    selectInput("diskusi_teman", "Frekuensi Diskusi dengan Teman Sekelas:", c("Tidak Pernah", "Jarang", "Kadang-kadang", "Sering", "Selalu")),
                    selectInput("fitur_interaktif", "Fitur Interaktif Paling Membantu:", c("Polling", "Breakout Rooms", "Chat", "Tidak Ada", "Lainnya")),
                    sliderInput("motivasi_daring", "Motivasi Belajar Daring (1-5):", min = 1, max = 5, value = 3),
                    sliderInput("materi_menarik", "Daya Tarik Materi Kuliah Daring (1-5):", min = 1, max = 5, value = 3),
                    radioButtons("tujuan_akademik", "Kuliah Daring Membantu Tujuan Akademik:", c("Ya", "Tidak")),
                    textAreaInput("faktor_motivasi", "Apa yang Paling Memotivasi Anda Belajar Daring?:"),
                    selectInput("gangguan_teknis", "Frekuensi Gangguan Teknis:", c("Tidak Pernah", "Jarang", "Kadang-kadang", "Sering", "Selalu")),
                    sliderInput("fokus_daring", "Kesulitan Tetap Fokus (1-5, 1=Mudah, 5=Sulit):", min = 1, max = 5, value = 3),
                    textAreaInput("tantangan_utama", "Tantangan Utama Belajar Daring:"),
                    checkboxGroupButtons("perlu_ditingkatkan", "Aspek yang Perlu Ditingkatkan:",
                                         choices = c("Koneksi Internet", "Kualitas Perangkat", "Interaksi Dosen", "Interaksi Mahasiswa", "Materi Kuliah", "Lainnya"),
                                         status = "primary",
                                         checkIcon = list(yes = icon("check-square"), no = icon("square"))),
                    actionButton("submit", "Kirim", icon = icon("paper-plane")),
                    actionButton("reset", "Reset", icon = icon("redo"))
                )
              )),
      tabItem("data",
              fluidRow(
                box(title = "Unduh Data", width = 12, status = "success", solidHeader = TRUE,
                    downloadButton("download_csv", "Unduh CSV"),
                    downloadButton("download_sqlite", "Unduh SQLite")
                )
              ),
              fluidRow(
                box(title = "Data Survei", width = 12, status = "info", solidHeader = TRUE,
                    DTOutput("tabel_survei"))
              )
      )
    )
  )
)