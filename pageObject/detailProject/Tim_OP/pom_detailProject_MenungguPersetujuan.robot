*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ../../detailProject/Tim_OP/pom_createProject.robot

*** Variables ***
${ubahProject_MenungguPersetujuan}       xpath=//p[contains(.,'Perubahan Project')]

${iconDeleteCity}                        xpath=//div[@id='svgdeletecity']

# Paging in List Project
${nextPage}                              xpath=//a[@title="Next page"]

*** Keywords ***
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
    general Wait Until    ${popUP_titleRiwayat}

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

user ubah project
    click button ubah
    ${res}    general return status    ${iconDeleteCity}
    IF    ${res}
        Element Should Be Visible    ${iconDeleteCity}
    ELSE
        reload_thePage    ${iconDeleteCity}
        general delay    5s
        click button ubah
    END  

user ubah alamat project
    user click element    ${iconDeleteCity}
    user choose kecamatan list
    user click element    ${buttonSimpan}

    # ${res}    general return status    ${ubahProject_MenungguPersetujuan}
    # WHILE    ${res} == $False
    #     user click element    ${buttonSimpan}
    #     show pop up dialog    ${ubahProject_MenungguPersetujuan}
    #     ${res}    general return status    ${ubahProject_MenungguPersetujuan}
    # END
    

reload_thePage
    [Arguments]    ${location}
    FOR    ${counter}    IN RANGE    1    3
        ${res}    general return status    ${location}
        IF    ${res}
            BREAK
        ELSE
            Reload Page
            ${res}    general return status    ${location}
        END
        
    END

user ubah startDate project
    [Arguments]    ${for_tanggal}
    general Wait Until    ${inputNamaProject}
    Scroll Element Into View    ${fieldPICmanager}
    ${a}    Get Text    ${fieldPICmanager}
    user click element    ${fieldPICmanager}
    general delay
    pilih PIC    ${a}
    general delay
    tanggal mulai    ${for_tanggal}

pilih PIC
    [Arguments]    ${location}
    ${res}    general return status    ${listPIC}
    IF    ${res}
        general return status   ${field_searchPIC}
        user input text       ${field_searchPIC}    ${location}
        user click element    xpath=//p[normalize-space()='${location}']
    ELSE
        user click element    ${fieldPICmanager}
    END

user ubah tanggal akhir sebelum tanggal mulai
    user ubah startDate project    ${nextMonth}
    # tanggal berakhir    ${prevMonth}    #di comment dulu

user ubah pic yang sama satu sama lain
    general Wait Until    ${inputNamaProject}
    Scroll Element Into View    ${fieldPICfinance}
    general Wait Until    ${fieldPICfinance}
    ${a}    Get Text    ${fieldPICmanager}
    user click element    ${fieldPICadmin}
    pilih PIC    ${a}

    # Verify Error State
    # Element Should Be Enabled    ${labelErr_PICsame}
    # ${labelErr}    Get Text    ${labelErr_PICsame}
    general delay    3s
    ${labelErr}    Get Text    xpath=//div[contains(@class, 'btnBetween')][1]/label
    Should Be Equal    ${labelErr}    PIC Tidak boleh sama
    Log To Console    Error State: ${labelErr}

user ubah nama project dengan nama yang sudah digunakan
    [Arguments]    ${StatusProject}
    user click filter status    ${StatusProject}   Menunggu persetujuan 
    user ubah project
    Get list Project Manajemen
    general Wait Until    ${inputNamaProject}
    user click element    ${inputNamaProject}
    Run Keyword If    '${Project_Name}' == '${projectName}'    Get list Project Manajemen
    ${nameUsed}    Replace String    ${Project_Name}    ${Project_Name}    ${projectName}
    user input text    ${inputNamaProject}    ${nameUsed}
    ${textName}    Get Text    ${inputNamaProject}
    IF    "${textName}" == "${nameUsed}" 
        Exit For Loop    # ini gimmik aja
    ELSE
        user input text    ${inputNamaProject}    ${nameUsed}
    END
    detail information on detail page
    