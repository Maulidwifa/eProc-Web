*** Settings ***
Resource                ../../pageObject/generalFunct.robot
Resource                ../../pageObject/API_listKecamatan.robot
Resource                ../../pageObject/detailProject/Tim_OP/pom_detailProject_MenungguPersetujuan.robot
Resource                ./login.robot


*** Keywords ***
User go to detail Project Page
    Given User can access Home Login 1000s
    When user click Detail on Project    Menunggu persetujuan
    And detail information on detail page

User change data alamat project
    Given User go to detail Project Page
    When user ubah project
    And user ubah alamat project
    And user click element    ${buttonSimpan}
    Then show pop up dialog    ${ubahProject_MenungguPersetujuan}
    # And button accept on dialog form ubah    Simpan

User change data Start Date project
    Given User go to detail Project Page
    When user ubah project
    And user ubah startDate project
    And user click element    ${buttonSimpan}
    Then show pop up dialog    ${ubahProject_MenungguPersetujuan}
    # And button accept on dialog form ubah    Simpan

User change data End Date project before the start date
    Given User go to detail Project Page
    When user ubah project
    And user ubah tanggal akhir sebelum tanggal mulai
    And user click element    ${buttonSimpan}
    Then error for startDate and endDate

User change PIC same to each other
    Given User go to detail Project Page
    When user ubah project
    And user ubah pic yang sama satu sama lain
    And Sleep    4

User change name project with name has been used
    Given User can access Home Login 1000s
    When user ubah nama project dengan nama yang sudah digunakan    Menunggu persetujuan
    And user click element    ${buttonSimpan}
    Then show pop up dialog    ${ubahProject_MenungguPersetujuan}
    And button accept on dialog form ubah    Simpan
    And show message error project


