*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ../pageObject/detailProject/Tim OP/pom_detailProject_MenungguPersetujuan.robot


*** Variables ***
${notes_perubahanAnggaran}        xpath=//div[contains(@class,'UpdateNoteBudget mb-24px')]//p
# ${statusProject}                  xpath=//span[@class='statusReview']
${popUp_riwayat}                  xpath=//div[@class='dvHistory ']
${recentHistory}                  xpath=//div[contains(@class,'dvHistory')]/div[1]/div[2]/div/p[1]
${dateOnRiwayatPopUp}             xpath=//div[contains(@class,'dvHistory')]/div[1]/div[1]/p[1]    
${notesOn_RiwayatPopUp}           xpath=//div[contains(@class,'dvHistory')]/div[1]/div[2]/div/div/p

*** Keywords ***
user on detail page Persetujuan Anggaran
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
    Should Be Equal    ${textStatus}    Persetujuan anggaran

user click button Riwayats
    [Arguments]    ${loc_btn}
    general Wait Until    ${buttonRiwayat}
    user click element    ${buttonRiwayat}

show content in riwayat detail
    # Fungsi ini berbeda karna ada Notes nya di Riwayat
    general Wait Until    ${dateOnRiwayatPopUp}
    Element Should Be Visible    xpath=//div[@class='dvHistory ']/div[contains(.,'Aktif')]
    ${textDate}    Get Text    ${dateOnRiwayatPopUp}
    Log To Console    Date History: ${textDate}
    FOR    ${counter}    IN RANGE    1    4
        ${res}    general return status    ${popUp_riwayat}
        ${textRiwayat}    Run Keyword If    ${res}
        ...    Get Text    xpath=//div[contains(@class,'dvHistory')]/div[1]/div[2]/div/p[${counter}]
        ...  ELSE
        ...    Exit For Loop
        Log To Console    ${textRiwayat}
        Log    ${textRiwayat}
    END
    ${history}    Get Text    ${recentHistory}
    ${notesPerubahanAnggaran_onRiwayat}    Get Text    ${notesOn_RiwayatPopUp}
    ${notesPerubahanAnggaran_onDetailProject}    Get Text    ${notes_onDetailPage}

    # Verify Content on Riwayat
    Should Be Equal    ${history}    Anggaran Project Diubah
    Should Be Equal    ${notesPerubahanAnggaran_onDetailProject}    ${notesPerubahanAnggaran_onRiwayat}


user click button batalkan
    [Arguments]    ${btn_loc}    ${titleText_popUp}
    general Wait Until    ${btn_loc}
    user click element    ${btn_loc}

    Wait Until Element Is Visible    ${titlePopUp}
    
    # Verify Content PopUp Alert
    ${textTitlePopUp}        Get Text     ${titlePopUp}
    Log To Console    PopUp Batalkan : ${textTitlePopUp}
    Should Be Equal    ${textTitlePopUp}    ${titleText_popUp}
    Sleep    3
    
verify batalkan (Ya)
    [Arguments]    ${text_status}
    Sleep    3
    general Wait Until    ${statusProject}
    ${text}    Get Text    ${statusProject}

    # Verify Status has been change
    Should Not Be Equal    ${text}    ${text_status}
    Log To Console    Before Change : ${text_status}
    Log To Console    Status Change : ${text}
