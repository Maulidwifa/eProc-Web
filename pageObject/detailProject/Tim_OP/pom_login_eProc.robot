*** Settings ***
Library        SeleniumLibrary
Resource       ../../generalFunct.robot

*** Variables ***
${headerLogin}          xpath=//p[contains(text(), 'Log')]
${inputPassword}        xpath=//input[@id='pwd']
${inputUsername}        xpath=//input[@id='TxtPhone']
${listFilter}           xpath=//div[@id='listFilter']
${titleProject}         xpath=//div[@class='d-flex align-items-center mb-18px']/p[contains(text(), 'Manajemen')]
${buttonMasuk}          xpath=//button[@type='button']//span[contains(text(), 'Masuk')]//ancestor::button

*** Keywords ***
## Login Success
user visit E-Proc1000s Login Page
    ${current_url}        Get Location
    Log  Current Path: ${current_url}
    ${res}    general return status    ${headerLogin}
    WHILE    ${res} == $False
        Reload Page
        Sleep    2s
        ${res}    general return status    ${headerLogin}
    END

user login E-Proc1000s Page
    general Wait Until    ${inputPassword}
    user input text    ${inputUsername}    ${ROLE_ADMIN}
    ${res}    general return status    ${inputPassword}
    IF    ${res}
        Sleep    4
        user input text    ${inputUsername}    ${ROLE_ADMIN}
        Tunggu Sampai Kondisi Terpenuhi    Cek Visible    ${inputPassword}    50s    3s
        user input password    ${inputPassword}    ${PASSWORD}
        Cek Field Sudah Terisi    ${inputPassword}
        Tunggu Sampai Kondisi Terpenuhi    Cek Field Sudah Terisi    ${inputPassword}    20s    1s
        Press Key    ${inputPassword}    \\13
        Sleep    5
        ${res_list}    general return status    ${listFilter}
        WHILE    ${res_list} == $False
            Press Key    ${inputPassword}    \\13
            Sleep    5
            ${res_err}    general return status    xpath=//div[@class='mb-20px']//parent::div/label[contains(text(), 'Nomor')]
            IF    ${res_err}
                without filling any of them    ${inputUsername}    ${ROLE_ADMIN}
            ELSE
                Exit For Loop
            END
        END
        Wait Until Element Is Visible    ${listFilter}
    ELSE
        Exit For Loop
    END

without fill no handphone and password
    general Wait Until    ${buttonMasuk}
    Sleep    4
    user click element    ${buttonMasuk}
    ${res}    general return status    ${inputPassword}
    IF    ${res}
        general Wait Until    ${buttonMasuk}
        Sleep    4
        user click element    ${buttonMasuk}
    ELSE
        user visit E-Proc1000s Login Page
    END

without filling any of them
    [Arguments]    ${loc_text}    ${text}
    general Wait Until    ${loc_text}
    reload_pages       ${loc_text}
    ${res}    general return status    ${inputPassword}
    IF    ${res}
        general Wait Until    ${loc_text}
        Sleep    4
        user input text       ${loc_text}    ${text}
        Sleep    4
        general wait until enable    ${buttonMasuk}
        user click element    ${buttonMasuk}
    ELSE
        user visit E-Proc1000s Login Page
    END
    
input error no telp
    [Arguments]    ${id}    ${text_id}    ${pass}    ${text_pass}
    general Wait Until    ${id}
    reload_pages       ${id}
    ${res}    general return status    ${inputPassword}
    IF    ${res}
        general Wait Until     ${id}
        Sleep    4
        user input text        ${id}    ${text_id}
        user input password    ${pass}    ${text_pass}
        Sleep    4
        user click element     ${buttonMasuk}
    ELSE
        user visit E-Proc1000s Login Page
    END

user go to home page E-Proc1000s
    user visit E-Proc1000s Login Page
    user login E-Proc1000s Page
    Wait Until Element Is Visible    ${listFilter}
    Wait Until Element Is Visible    ${titleProject}
    ${title}    Get Text    ${titleProject}
    Log To Console    ${\n}${title}
