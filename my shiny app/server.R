library(shiny)
library(RSQLite)
library(dplyr)

function(input, output, session) {
  
  data_survei <- reactiveVal({
    if ("dataset_daring" %in% dbListTables(conn)) {
      dbReadTable(conn, "dataset_daring")
    } else {
      data.frame()
    }
  })
  
  observeEvent(input$submit, {
    id_mahasiswa <- paste0("M", format(Sys.time(), "%Y%m%d%H%M%S"))
    aspek_perlu <- if (length(input$perlu_ditingkatkan)) paste(input$perlu_ditingkatkan, collapse = ", ") else ""
    
    entri <- data.frame(
      Tanggal = as.character(input$tanggal),
      ID_Mahasiswa = id_mahasiswa,
      Jenis_Kelamin = input$jenis_kelamin,
      Program_Studi = input$program_studi,
      Semester = input$semester,
      IPK_Terakhir = input$ipk_terakhir,
      Perangkat_Andal = input$perangkat_andal,
      Koneksi_Stabil = input$koneksi_stabil,
      Jenis_Perangkat = input$jenis_perangkat,
      Platform_Daring = input$platform_daring,
      Interaktif_Daring = input$interaktif_daring,
      Responsivitas_Dosen = input$responsivitas_dosen,
      Diskusi_Teman = input$diskusi_teman,
      Fitur_Interaktif = input$fitur_interaktif,
      Motivasi_Daring = input$motivasi_daring,
      Materi_Menarik = input$materi_menarik,
      Tujuan_Akademik = input$tujuan_akademik,
      Faktor_Motivasi = input$faktor_motivasi,
      Gangguan_Teknis = input$gangguan_teknis,
      Fokus_Daring = input$fokus_daring,
      Tantangan_Utama = input$tantangan_utama,
      Perlu_Ditingkatkan = aspek_perlu,
      stringsAsFactors = FALSE
    )
    
    dbWriteTable(conn, "dataset_daring", entri, append = TRUE)
    data_survei(dbReadTable(conn, "dataset_daring"))
    showModal(modalDialog("Terima kasih, data berhasil dikirim!", easyClose = TRUE))
  })
  
  observeEvent(input$reset, {
    updateDateInput(session, "tanggal", value = Sys.Date())
    updateSelectInput(session, "jenis_kelamin", selected = "Laki-laki")
    updateSelectInput(session, "program_studi", selected = "Sains Data")
    updateSelectInput(session, "semester", selected = 4)
    updateNumericInput(session, "ipk_terakhir", value = 3.0)
    updateSliderInput(session, "perangkat_andal", value = 3)
    updateSliderInput(session, "koneksi_stabil", value = 3)
    updateSelectInput(session, "jenis_perangkat", selected = "Laptop")
    updateTextAreaInput(session, "platform_daring", value = "")
    updateSliderInput(session, "interaktif_daring", value = 3)
    updateSliderInput(session, "responsivitas_dosen", value = 3)
    updateSelectInput(session, "diskusi_teman", selected = "Kadang-kadang")
    updateSelectInput(session, "fitur_interaktif", selected = "Tidak Ada")
    updateSliderInput(session, "motivasi_daring", value = 3)
    updateSliderInput(session, "materi_menarik", value = 3)
    updateRadioButtons(session, "tujuan_akademik", selected = "Ya")
    updateTextAreaInput(session, "faktor_motivasi", value = "")
    updateSelectInput(session, "gangguan_teknis", selected = "Kadang-kadang")
    updateSliderInput(session, "fokus_daring", value = 3)
    updateTextAreaInput(session, "tantangan_utama", value = "")
    updateCheckboxGroupButtons(session, "perlu_ditingkatkan", selected = character(0))
  })
  
  output$tabel_survei <- renderDT({
    datatable(data_survei(), options = list(pageLength = 10, scrollX = TRUE))
  })
  
  output$download_csv <- downloadHandler(
    filename = function() {
      paste0("dataset_daring_", Sys.Date(), ".csv")
    },
    content = function(file) {
      write.csv(data_survei(), file, row.names = FALSE)
    }
  )
  
  output$download_sqlite <- downloadHandler(
    filename = function() {
      paste0("dataset_daring_", Sys.Date(), ".sqlite")
    },
    content = function(file) {
      file.copy(db_path, file, overwrite = TRUE)
    }
  )
  
  session$onSessionEnded(function() {
    dbDisconnect(conn)
  })
}