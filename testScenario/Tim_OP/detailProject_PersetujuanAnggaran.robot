*** Settings ***
Resource                ../../pageObject/generalFunct.robot
Resource                ../../pageObject/API_listKecamatan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_MenungguPersetujuan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_PersetujuanAnggaran.robot
Resource                ./login.robot

*** Keywords ***
User go to detail Project Page
    Given User can access Home Login 1000s
    When user click filter status    Persetujuan anggaran    Menunggu persetujuan
    And detail information on detail page
    And user on detail page Persetujuan Anggaran

user click button riwayat on detail project page
    Given User go to detail Project Page
    When user click button Riwayats    ${buttonRiwayat}
    Then show content in riwayat detail    Anggaran Project Diubah

user click button batalkan (Tidak)
    Given User go to detail Project Page
    When user click button batalkan    ${buttonBatalkan_onNotes}    Batal Pengajuan Ubah Anggaran
    And user click button    ${btnTidak_onPopUp}

user click button batalkan (Ya)
    Given User go to detail Project Page
    When user click button batalkan    ${buttonBatalkan_onNotes}    Batal Pengajuan Ubah Anggaran
    # Then user click button    ${btnYa_onPopUp}