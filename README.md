# 1. Shiny Web App

Silahkan download folder `my shiny app` lalu buka foldernya. Terdapat 3 file yaitu `ui.R` `server.R` dan `global.R`

## Cara Menjalankan Aplkasi

**1. Install R Package**

  **Copy Paste syntax di bawah ini di `Console`**
  
  `install.packages(c("shiny", "shinydashboard", "shinyWidgets", "DT", "RSQLite", "dplyr", "lubridate"))`

**2. Struktur File**

  Aplikasi terdiri dari 3 file utama:

  - `ui.R` — user interface (formulir & tampilan data)
  - `server.R` — logika server (penyimpanan)
  - `global.R` — koneksi dan inisialisasi database SQLite

**3. Run Aplikasi di RStudio**

  Kalian bisa menjalankan aplikasi dengan mengklik tombol **Run App**, maka secara otomatis RStudio akan menampilkan formulir di **Panel Viewer**.

# Flex Dashboard Dengan 7 QC Tools

  Jika kalian ingin menggunakan flexdashboard untuk bagian analisis data, silahkan download folder `flex dashboard` lalu buka filenya. Bagian ini kalian akan menampilkan visualisasi dashboard interaktif yang sudah kami lakukan analisis 7 QC Tools. Analisis di tampilkan sesuai
  data respoenden yang telah dikumpulkan melalui form **Shiny**.

**1. Struktur File**
     
  - `dashboard.Rmd` → file utama flexdashboard
  - `dataset_daring.csv` → dataset utama yang akan kita analisis
  - `dataset_daring.sqlite` → database hasil input survei (sudah dibuat oleh Shiny App sebelumnya)
    
**2. Cara Menjalankan Dashboard**

  - Download terlebih dahulu foldernya kemudian ekstrak folder
  - Buka file `dashboard.Rmd` di RStudio
  - Klik tombol **Knit** di pojok kiri atas editor atau pakai shortcut **Ctrl + shift + k**
  - RStudio akan merender file menjadi HTML interaktif
  - Secara otomatis, hasil akan ditampilkan di **Panel Viewer** (atau browser, tergantung selera kamu)

**3. Package Yang Digunakan**

  **Copy Paste syntax di bawah ini di `Console`**
  
  `install.packages(c("flexdashboard", "dplyr", "tidyverse", "tidyr", "highcharter", "gt", "htmltools", "viridis", "DT", "readr", "stringr", "qcc", "DiagrammeR", "moments", "forcats", "stats19"))`

   
  
