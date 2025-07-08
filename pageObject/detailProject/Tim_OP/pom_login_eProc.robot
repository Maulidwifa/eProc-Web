*** Settings ***
Library        SeleniumLibrary
Resource       ../../generalFunct.robot

*** Variables ***
${headerLogin}          xpath=//p[contains(text(), 'Log')]
${inputPassword}        xpath=//input[@id='pwd']
${inputUsername}        xpath=//input[@id='TxtPhone']
${listFilter}           xpath=//div[@id='listFilter']
${titleProject}         xpath=//p[.='Manajemen Project']
${buttonMasuk}          xpath=//button[@type='button']//span[contains(text(), 'Masuk')]//ancestor::button

*** Keywords ***
## Login Success
user visit E-Proc1000s Login Page
    ${current_url}        Get Location
    Log  Current Path: ${current_url}
    general delay
    ${res}    general return status    ${headerLogin}
    WHILE    ${res} == $False
        Reload Page
        general delay
        ${res}    general return status    ${headerLogin}
    END

user login E-Proc1000s Page
    general Wait Until    ${inputPassword}
    user input text    ${inputUsername}    ${ROLE_ADMIN}
    ${res}    general return status    ${inputPassword}
    IF    ${res}
        general delay
        user input text    ${inputUsername}    ${ROLE_ADMIN}
        Tunggu Sampai Kondisi Terpenuhi    Cek Visible    ${inputPassword}    50s    3s
        user input password    ${inputPassword}    ${PASSWORD}
        Cek Field Sudah Terisi    ${inputPassword}
        Tunggu Sampai Kondisi Terpenuhi    Cek Field Sudah Terisi    ${inputPassword}    20s    1s
        Press Key    ${inputPassword}    \\13
        general delay    3s
        ${res_list}    general return status    ${titleProject}    timeout=5s
        WHILE    ${res_list} == $False
            Press Key    ${inputPassword}    \\13
            general delay    3s
            ${res_err}    general return status    ${textNomorTelpon_onLogin}
            IF    ${res_err}
                # without filling any of them    ${inputUsername}    ${ROLE_ADMIN}
                user input text    ${inputUsername}    ${ROLE_ADMIN}
                user input password    ${inputPassword}    ${PASSWORD}
                user click element    ${buttonMasuk}
            ELSE
                Exit For Loop
            END
        END
        general Wait Until    ${listFilter}
    ELSE
        Exit For Loop
    END

without fill no handphone and password
    general Wait Until    ${buttonMasuk}
    general delay
    user click element    ${buttonMasuk}
    ${res}    general return status    ${inputPassword}
    IF    ${res}
        general Wait Until    ${buttonMasuk}
        general delay
        user click element    ${buttonMasuk}
    ELSE
        user visit E-Proc1000s Login Page
    END

without filling any of them
    [Arguments]    ${loc_text}    ${text}
    reload_pages       ${loc_text}
    general Wait Until    ${loc_text}
    ${res}    general return status    ${inputPassword}
    IF    ${res}
        general Wait Until    ${loc_text}
        general delay
        user input text       ${loc_text}    ${text}
        general delay
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
        general delay
        user input text        ${id}    ${text_id}
        user input password    ${pass}    ${text_pass}
        general delay
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
