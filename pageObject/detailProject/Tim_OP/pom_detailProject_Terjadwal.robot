*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ../pageObject/detailProject/Tim_OP/pom_detailProject_MenungguPersetujuan.robot

*** Variables ***

*** Keywords ***
user on detail Terjadwal page
    Element Should Be Visible    ${buttonRiwayat}
    ${textStatus}    Get Text    ${statusProject}
    Set Global Variable    ${textStatus}    ${textStatus}

    # Verify Status detail Project
    Should Be Equal    ${textStatus}    Terjadwal
