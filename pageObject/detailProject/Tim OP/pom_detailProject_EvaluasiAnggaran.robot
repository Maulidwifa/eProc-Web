*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ../pageObject/detailProject/Tim OP/pom_detailProject_MenungguPersetujuan.robot
Resource        pom_detailProject_PersetujuanAnggaran.robot


*** Variables ***


*** Keywords ***
user on detail page Evaluasi Anggaran
    general Wait Until    ${notes_perubahanAnggaran}
    FOR    ${counter}    IN RANGE    1    3
        ${res}    general return status    xpath=//div[contains(@class,'UpdateNoteBudget mb-24px')]//p
        ${textNotes}    Run Keyword If    ${res}
        ...    Get Text    xpath=//div[contains(@class,'UpdateNoteBudget mb-24px')]//p[${counter}]   
        ...  ELSE
        ...    Exit For Loop
    END
    Set Global Variable    ${notes_onDetailPage}    xpath=//div[contains(@class,'UpdateNoteBudget mb-24px')]//p[${counter}]
    Element Should Be Visible    ${buttonBatalkan_onNotes}
    Element Should Be Visible    ${buttonRiwayat}
    ${textStatus}    Get Text    ${statusProject}
    Set Global Variable    ${textStatus}    ${textStatus}

    # Verify Status detail Project
    Should Be Equal    ${textStatus}    Evaluasi anggaran

