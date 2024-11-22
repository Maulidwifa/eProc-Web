*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ./pom_createProject.robot

*** Variables ***
${namaProject_onDetailPage}              xpath=//span[@class='ttlMdSemiBold']
${statusProject}                         xpath=//div[@class='d-flex align-items-center justify-content-between mb-2px']//div[@class='d-flex align-items-center']/span[2]
# ${buttonRiwayat}                         xpath=//div[@class='d-flex align-items-center justify-content-end w-100']/button[1]
# ${buttonUbah}                            xpath=//div[@class='d-flex align-items-center justify-content-end w-100']/button[2]
# ${buttonBatalkan}                        xpath=//div[@class='d-flex align-items-center justify-content-end w-100']/button[3]
${ubahProject_MenungguPersetujuan}       xpath=//p[contains(.,'Perubahan Project')]

${iconDeleteCity}                        xpath=//div[@id='svgdeletecity']

# Paging in List Project
${nextPage}                              xpath=//a[@title="Next page"]

*** Keywords ***
user click Detail on Project
    [Arguments]    ${textStatus}
    ${len}    Get Length    xpath=//tbody/tr/td[5]
    Sleep    3
    FOR    ${counter}    IN RANGE    1    ${len}
        ${res}    general return status    xpath=//tbody/tr/td[5]//div[contains(.,'${textStatus}')]
        IF    ${res}
            check in project list    ${textStatus}
            Exit For Loop
        ELSE
            ${next}    general return status    ${nextPage}
            Run Keyword If    ${next}    user click element    ${nextPage}
        END
    END

check in project list
    [Arguments]    ${textStatusProject}
    FOR    ${counter}    IN RANGE    1    10
        ${res}    general return status    xpath=//tbody/tr[${counter}]/td[5]//div[contains(.,'${textStatusProject}')]
        IF    ${res}
            ${text}    Get Text    xpath=//tbody/tr[${counter}]/td[1]
            ${status}    Get Text    xpath=//tbody/tr[${counter}]/td[5]
            user click element    xpath=//tbody/tr[${counter}]/td[6]
            general Wait Until    xpath=//span[normalize-space()='Detail Project']

            # User in Detail Page
            general Wait Until    ${namaProject_onDetailPage}
            ${nameProject}    Get Text    ${namaProject_onDetailPage}
            ${status_onDetailPage}    Get Text    ${statusProject}
            Log To Console    Nama Project: ${nameProject}
            Log To Console    Status Project: ${status_onDetailPage}
            Set Global Variable    ${nameProject_MenungguPersetujuan}    ${nameProject}

            # Verify Name and Status Project
            Should Be Equal    ${nameProject}    ${text}
            Should Be Equal    ${status_onDetailPage}    ${status}
            Exit For Loop
        END
    END

detail information on detail page
    ${len}    Get Length    xpath=//div[@class='w-100']/div
    FOR    ${counter}    IN RANGE    1    ${len}
        ${res}    general return status    xpath=//div[@class='w-100']/div[${counter}]
        IF    ${res}
            ${text}    Get Text    xpath=//div[@class='w-100']/div[${counter}]/div[1]/span
            ${textName}    Get Text    xpath=//div[@class='w-100']/div[${counter}]/div[2]/span[2]
            Log To Console    ${text}: ${textName}
        
            # Cek Anggaran Maksimal
            ${textBorder}    Get Text    xpath=//div[@class="w-100 borderRight "]/div[${counter}]/div[1]/span
            ${textBorderRight}    Get Text    xpath=//div[@class="w-100 borderRight "]/div[${counter}]/div[2]/span[2]
            Log To Console    ${textBorder}: ${textBorderRight}
        ELSE
            Exit For Loop
        END
    END

user click button Riwayat
    general Wait Until    ${buttonRiwayat}
    user click element    ${buttonRiwayat}
    general Wait Until    xpath=//p[normalize-space()='Riwayat']

    ${len}    Get Length    xpath=//div[contains(@class,'dvHistory')]/div//p
    FOR    ${counter}    IN RANGE    1    ${len}
        ${res}    general return status    xpath=//div[contains(@class,'dvHistory')]/div//p[${counter}]
        IF    ${res}
            ${text}    Get Text    xpath=//div[contains(@class,'dvHistory')]/div//p[${counter}]
            ${text2}    Get Text    xpath=//div[contains(@class,'dvHistory')]/div/div[2]/div/p[${counter}]
            Log To Console    ${text}
            Log To Console    ${text2}
        ELSE
            Exit For Loop
        END
    END

# click button ubah
#     general Wait Until    ${buttonUbah}
#     user click element    ${buttonUbah}

user ubah alamat project
    # Get list city
    user click element    ${iconDeleteCity}
    user choose kecamatan list

user ubah startDate project
    general Wait Until    ${inputNamaProject}
    Scroll Element Into View    ${fieldPICmanager}
    ${a}    Get Text    ${fieldPICmanager}
    user click element    ${fieldPICmanager}
    Sleep    2
    user click element    xpath=//p[normalize-space()='${a}']
    Sleep    2
    tanggal mulai

user ubah tanggal akhir sebelum tanggal mulai
    user ubah startDate project
    tanggal berakhir    ${prevMonth}

user ubah pic yang sama satu sama lain
    general Wait Until    ${inputNamaProject}
    Scroll Element Into View    ${fieldPICmanager}
    ${a}    Get Text    ${fieldPICmanager}
    user click element    ${fieldPICadmin}
    Sleep    2
    user click element    xpath=//p[normalize-space()='${a}']

    # Verify Error State
    Element Should Be Visible    ${labelErr_PICsame}
    ${labelErr}    Get Text    ${labelErr_PICsame}
    Should Be Equal    ${labelErr}    PIC Tidak boleh sama
    Log To Console    Error State: ${labelErr}

user ubah nama project dengan nama yang sudah digunakan
    [Arguments]    ${StatusProject}
    Get list Project Manajemen
    user click Detail on Project    ${StatusProject}
    click button ubah
    general Wait Until    ${inputNamaProject}
    user click element    ${inputNamaProject}
    Run Keyword If    '${nameProject_MenungguPersetujuan}' == '${projectName}'    Get list Project Manajemen
    ${nameUsed}    Replace String    ${nameProject_MenungguPersetujuan}    ${nameProject_MenungguPersetujuan}    ${projectName}
    user input text    ${inputNamaProject}    ${nameUsed}
    detail information on detail page
    