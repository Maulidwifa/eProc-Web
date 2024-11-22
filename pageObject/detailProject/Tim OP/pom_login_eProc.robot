*** Settings ***
Library        SeleniumLibrary
Resource       ../../generalFunct.robot

*** Variables ***
# ${id_user}              085210758864    # Administrator
# ${pass_user}            123456
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
        Sleep    1.5s
        ${res}    general return status    ${headerLogin}
    END

user login E-Proc1000s Page
    Wait Until Element Is Visible    ${inputPassword}
    Input Text    ${inputUsername}    ${ROLE_ADMIN}
    Input Password    ${inputPassword}    ${PASSWORD}
    # Click Element        ${buttonMasuk}
    Press Key    ${inputPassword}    \\13
    Wait Until Element Is Visible    ${listFilter}
    Sleep    3

user go to home page E-Proc1000s
    user visit E-Proc1000s Login Page
    user login E-Proc1000s Page
    Wait Until Element Is Visible    ${listFilter}
    Wait Until Element Is Visible    ${titleProject}
    ${title}    Get Text    ${titleProject}
    Log To Console    ${\n}${title}
