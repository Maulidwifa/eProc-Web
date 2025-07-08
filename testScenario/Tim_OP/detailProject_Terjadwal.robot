*** Settings ***
Resource                ../../pageObject/generalFunct.robot
Resource                ../../pageObject/API_listKecamatan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_Aktif.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_MenungguPersetujuan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_Terjadwal.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_ProsesEvaluasi.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_EvaluasiAnggaran.robot
Resource                ./login.robot

*** Keywords ***
User go to detail Project Page
    Given User can access Home Login 1000s
    When user click filter status    Terjadwal    Terjadwal
    And detail information on detail page
    And user on detail Terjadwal page

User change data End Date project
    Given User go to detail Project Page
    When click button ubah
    And tanggal berakhir    ${nextMonth}
    And user click element    ${buttonSimpan}
    Then show pop up dialog    ${ubahProject_MenungguPersetujuan}
    And button accept on dialog form ubah    Simpan

User change Anggaran Maksimal
    Given User go to detail Project Page
    When click button ubah
    And user clear text Anggaran Maksimal
    Then user input anggaranMax
    And user click element    ${buttonSimpan}
    And show pop up dialog    ${popUp_UbahAnggaran}
    # And button accept on dialog form ubah    Ajukan
    # And verify status after change data    Persetujuan anggaran
    
User change data End Date before the start date
    Given User go to detail Project Page
    When click button ubah
    And user scroll element    ${PICfinance}
    And user ubah tanggal akhir
    And user click element    ${buttonSimpan}
    Then error for startDate and endDate

# Ini fitur penjagaan nya dilepas (udah gaada lagi PIC tidak boleh sama)
User change PIC to same each other
    Given User go to detail Project Page
    And Sleep    3
    When click button ubah
    And user ubah pic yang sama satu sama lain

user click button kembali on popUp
    Given User go to detail Project Page
    When click button ubah
    And user clear text Anggaran Maksimal
    Then user input anggaranMax
    And user click element    ${buttonSimpan}
    And show pop up dialog    ${popUp_UbahAnggaran}
    And button accept on dialog form ubah    Kembali

User cancel change data project
    Given User go to detail Project Page
    When click button ubah
    And user on form ubah project
    And user ubah alamat project
    Then user click element    ${buttonSimpan}

user click button batalkan (Tidak)
    Given User go to detail Project Page
    When user click button batalkan    ${buttonBatalkan_onNotes}    Batal Pengajuan Ubah Anggaran
    And user click button    ${btnTidak_onPopUp}

user click button batalkan (Ya)
    Given User go to detail Project Page
    When user click button batalkan    ${buttonBatalkan_onNotes}    Batal Pengajuan Ubah Anggaran
    Then user click button    ${btnYa_onPopUp}
    And verify batalkan (Ya)    ${textStatus}