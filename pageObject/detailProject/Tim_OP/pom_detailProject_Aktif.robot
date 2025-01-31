*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ../pageObject/detailProject/Tim_OP/pom_detailProject_MenungguPersetujuan.robot


*** Variables ***
${popUp_UbahAnggaran}            xpath=//p[contains(.,'Perubahan Anggaran')]

*** Keywords ***
user on detail Aktif page
    Element Should Be Visible    ${buttonRiwayat}
    ${textStatus}    Get Text    ${statusProject}
    Set Global Variable    ${textStatus}    ${textStatus}

    # Verify Status detail Project
    Should Be Equal    ${textStatus}    Aktif

user clear text Anggaran Maksimal
    Sleep    3
    general Wait Until    ${anggaranMax}
    Clear Element Text    ${anggaranMax}

user ubah tanggal akhir
    Sleep    3
    general Wait Until    ${fieldPICfinance}
    Wait Until Element Is Visible    ${fieldPICfinance}
    user scroll element    ${PICfinance}
    tanggal berakhir    ${prevMonth}