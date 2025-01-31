*** Settings ***
Resource                ../pageObject/generalFunct.robot
Resource                ../pageObject/API_listKecamatan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_Aktif.robot
Resource                ../pageObject/detailProject/Tim_OP/pom_detailProject_MenungguPersetujuan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_EvaluasiAnggaran.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_ProsesEvaluasi.robot
Resource                ./login.robot

*** Keywords ***
User go to detail Project Page
    Given User can access Home Login 1000s
    When user click Detail on Project    Aktif
    And detail information on detail page
    And user on detail Aktif page

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
    And button accept on dialog form ubah    Ajukan
    And verify status after change data    Persetujuan anggaran
    
User change data End Date before the start date
    Given User go to detail Project Page
    When click button ubah
    And user scroll element    ${PICfinance}
    And user ubah tanggal akhir
    And user click element    ${buttonSimpan}
    Then error for startDate and endDate

User change PIC to same each other
    Given User go to detail Project Page
    When click button ubah
    And user ubah pic yang sama satu sama lain
    And Sleep    4

user click button kembali on popUp
    Given User go to detail Project Page
    When click button ubah
    And user clear text Anggaran Maksimal
    Then user input anggaranMax
    And user click element    ${buttonSimpan}
    And show pop up dialog    ${popUp_UbahAnggaran}
    And button accept on dialog form ubah    Kembali