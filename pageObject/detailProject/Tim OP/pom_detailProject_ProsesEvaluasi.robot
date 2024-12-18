*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ./pom_detailProject_MenungguPersetujuan.robot

*** Variables ***
${notesOnDetail_ProsesEvaluasi}                xpath=//div[contains(@class,'UpdateNoteBudget mb-24px')]//p
${ubahProject_ProsesEvaluasi}                  xpath=//p[contains(.,'Evaluasi Project')]

# Form Ubah Project
${titleUbahProject}                            xpath=//p[normalize-space()='Ubah Project']
${notesOn_FormUbah}                            xpath=//div[contains(@role,'dialog')]//div[contains(@class,'UpdateNoteBudget mb-24px')]//p


*** Keywords ***
user on detail page Proses Evaluasi
    ${notesProsesEvaluasi}    Get Text    ${notesOnDetail_ProsesEvaluasi}
    Set Global Variable    ${notesProsesEvaluasi}    ${notesProsesEvaluasi}
    Log To Console    ${notesProsesEvaluasi}

user on form ubah project
    general Wait Until    ${titleUbahProject}
    
    # Verify Notes in Detail Page with Notes in Form Ubah Project
    ${notesOnForm}    Get Text    ${notesOn_FormUbah}
    Should Be Equal    ${notesProsesEvaluasi}    ${notesOnForm}

verify status after change data
    [Arguments]    ${StatusProj}
    Sleep    3
    general Wait Until    ${statusProject}
    ${textStatus}    Get Text    ${statusProject}
    Should Be Equal    ${textStatus}    ${StatusProj}