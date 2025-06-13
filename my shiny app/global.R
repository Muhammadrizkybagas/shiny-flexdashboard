library(shiny)
library(shinydashboard)
library(DT)
library(RSQLite)
library(shinyWidgets)
library(dplyr)
library(lubridate)

# Path database
db_path <- "dataset_daring.sqlite"
conn <- dbConnect(SQLite(), db_path)

# Nama tabel
tabel_survei <- "dataset_daring"

# Hapus tabel lama untuk uji ulang
if (dbExistsTable(conn, tabel_survei)) {
  dbRemoveTable(conn, tabel_survei)
}

# Buat tabel baru yang sesuai dengan input UI
query_buat_tabel <- paste0("CREATE TABLE ", tabel_survei, " (
  Tanggal TEXT,
  ID_Mahasiswa TEXT,
  Jenis_Kelamin TEXT,
  Program_Studi TEXT,
  Semester INTEGER,
  IPK_Terakhir NUMERIC,
  Perangkat_Andal INTEGER,
  Koneksi_Stabil INTEGER,
  Jenis_Perangkat TEXT,
  Platform_Daring TEXT,
  Interaktif_Daring INTEGER,
  Responsivitas_Dosen INTEGER,
  Diskusi_Teman TEXT,
  Fitur_Interaktif TEXT,
  Motivasi_Daring INTEGER,
  Materi_Menarik INTEGER,
  Tujuan_Akademik TEXT,
  Faktor_Motivasi TEXT,
  Gangguan_Teknis TEXT,
  Fokus_Daring INTEGER,
  Tantangan_Utama TEXT,
  Perlu_Ditingkatkan TEXT
)")

# Eksekusi query
dbExecute(conn, query_buat_tabel)

# Daftar opsi untuk beberapa kolom
platform_daring_options <- c("Zoom", "Google Meet", "Google Classroom")
faktor_motivasi_options <- c("Fleksibilitas waktu", "Akses materi daring", "Interaksi dosen", "Tugas yang menarik", "Efisiensi", "Bisa belajar lebih dalam")
tantangan_utama_options <- c("Koneksi internet lambat", "Kurang interaksi", "Sulit fokus", "Gangguan teknis", "Tidak bisa diskusi tatap muka", "Kurang memahami materi sulit", "Sulit bertanya dengan bebas")
perlu_ditingkatkan_options <- c("Koneksi Internet", "Kualitas Perangkat", "Interaksi Dosen", "Interaksi Mahasiswa", "Materi Kuliah", "Lainnya")

# Buat data dummy (114 entri)
set.seed(123)
n <- 500
dummy_data <- data.frame(
  Tanggal = sample(seq(as.Date('2023-01-01'), as.Date('2024-12-31'), by = "day"), n, replace = TRUE),
  ID_Mahasiswa = paste0("M", sprintf("%04d", 1:n)),
  Jenis_Kelamin = sample(c("Laki-laki", "Perempuan", "Tidak ingin menyebutkan"), n, replace = TRUE),
  Program_Studi = sample(c("Sains Data", "Teknik Informatika", "Teknik Perminyakan", "Teknik Pertambangan", "Desain Produk"), n, replace = TRUE),
  Semester = sample(1:8, n, replace = TRUE),
  IPK_Terakhir = round(runif(n, min = 2.0, max = 4.0), 1),
  Perangkat_Andal = sample(1:5, n, replace = TRUE),
  Koneksi_Stabil = sample(1:5, n, replace = TRUE),
  Jenis_Perangkat = sample(c("Laptop", "Smartphone", "Tablet"), n, replace = TRUE),
  Platform_Daring = sample(platform_daring_options, n, replace = TRUE),
  Interaktif_Daring = sample(1:5, n, replace = TRUE),
  Responsivitas_Dosen = sample(1:5, n, replace = TRUE),
  Diskusi_Teman = sample(c("Tidak Pernah", "Jarang", "Kadang-kadang", "Sering", "Selalu"), n, replace = TRUE),
  Fitur_Interaktif = sample(c("Polling", "Breakout Rooms", "Chat", "Tidak Ada"), n, replace = TRUE),
  Motivasi_Daring = sample(1:5, n, replace = TRUE),
  Materi_Menarik = sample(1:5, n, replace = TRUE),
  Tujuan_Akademik = sample(c("Ya", "Tidak"), n, replace = TRUE),
  Faktor_Motivasi = sample(faktor_motivasi_options, n, replace = TRUE),
  Gangguan_Teknis = sample(c("Tidak Pernah", "Jarang", "Kadang-kadang", "Sering", "Selalu"), n, replace = TRUE),
  Fokus_Daring = sample(1:5, n, replace = TRUE),
  Tantangan_Utama = sample(tantangan_utama_options, n, replace = TRUE),
  Perlu_Ditingkatkan = sapply(1:n, function(i) paste(sample(perlu_ditingkatkan_options, sample(1:3, 1)), collapse = ", ")),
  stringsAsFactors = FALSE
)

# Simpan data dummy ke database
dbWriteTable(conn, tabel_survei, dummy_data, append = TRUE)