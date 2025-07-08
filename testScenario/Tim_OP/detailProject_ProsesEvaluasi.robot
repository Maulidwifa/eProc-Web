*** Settings ***
Resource                ../../pageObject/generalFunct.robot
Resource                ../../pageObject/API_listKecamatan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_ProsesEvaluasi.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_PersetujuanAnggaran.robot
Resource                ./login.robot


*** Keywords ***
User go to detail Project Page
    Given User can access Home Login 1000s
    When user click filter status    Proses evaluasi    Menunggu persetujuan
    Then detail information on detail page
    And user on detail page Proses Evaluasi

User change data alamat project
    Given User go to detail Project Page
    When click button ubah
    And user on form ubah project
    And user ubah alamat project
    And show pop up alert    ${ubahProject_ProsesEvaluasi}
    # And button accept on dialog form ubah    Kirim
    # And verify status after change data    Menunggu persetujuan

User change data End Date project before the start date
    Given User go to detail Project Page
    When click button ubah
    And user on form ubah project
    Then user ubah tanggal akhir sebelum tanggal mulai
    And user click element    ${buttonSimpan}
    And error for startDate and endDate

# Ini fitur penjagaan nya dilepas (udah gaada lagi PIC tidak boleh sama)
User change PIC same to each other
    Given User go to detail Project Page
    When click button ubah
    And user ubah pic yang sama satu sama lain
    And user click element    ${buttonSimpan}
    And show pop up alert    ${ubahProject_ProsesEvaluasi}
    And show message error field    PIC Tidak boleh sama

User change name project with name has been used
    Given User can access Home Login 1000s
    When user ubah nama project dengan nama yang sudah digunakan    Proses evaluasi
    And user click element    ${buttonSimpan}
    And button accept on dialog form ubah    Kirim
    And show message error project

User cancel change data project
    Given User go to detail Project Page
    When click button ubah
    And user on form ubah project
    And user ubah alamat project
    Then user click element    ${buttonSimpan}
    And button accept on dialog form ubah    Kembali
    And user click button batalkan    ${buttonBatal}    Batal Ubah Project
    Then user click button    ${btnYa_onPopUp}