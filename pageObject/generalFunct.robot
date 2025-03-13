*** Settings ***
Library        SeleniumLibrary
Library        String
Library        Collections


*** Variables ***
# Users
${ROLE_ADMIN}    085210758864
${ROLE_SCM}      085210758865
${PASSWORD}      123456

${errMessage_mandatory}    xpath=//label[contains(text(), 'harus')]
${errMessage_notListed}    xpath=//label[contains(text(), 'terdaftar')]
${errMessageLabel}         xpath=//div[@class='mb-20px']/label[@class='txt-danger txtMdMedium mt-6px ']

# Error State Form Buat Project
${errMessageFormProject}    xpath=//label[contains(.,'Wajib')]
${errLabel_formProject}     xpath=//div[@class='mb-20px']/label[@class='txt-danger txtMdMedium mt-6px d-block ']

# Content Pop Up
${btn_simpanPopUP}          xpath=//div[@class='d-flex']/button[contains(.,'Simpan')]
${popUp_alert}              xpath=//div[@role='dialog']
${titlePopUp}               xpath=//div[@role='dialog']//div[@class='text-center']/p[1]
${btnTidak_onPopUp}         xpath=//div[@role='dialog']//div[2]/button[contains(.,'Tidak')]
${btnYa_onPopUp}            xpath=//div[@role='dialog']//div[2]/button[contains(.,'Ya')]

# Button on Detail Project
${buttonRiwayat}                         xpath=//div[@class='d-flex align-items-center justify-content-end w-100']/button[1]
${buttonUbah}                            xpath=//div[@class='d-flex align-items-center justify-content-end w-100']/button[2]
${buttonBatalkan}                        xpath=//div[@class='d-flex align-items-center justify-content-end w-100']/button[3]
${buttonBatalkan_onNotes}                xpath=//div[contains(@class,'UpdateNoteBudget')]//button

*** Keywords ***
# General Function
user input text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    ${text}
    Sleep    5

user input password
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Input Password    ${locator}    ${text}
    Sleep    5

user click element
    [Arguments]    ${element}
    Sleep    5
    Wait Until Element Is Visible    ${element}
    ${clickElement}    Click Element    ${element}
    RETURN    ${clickElement}
    
user scroll element
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}

scroll ke atas
    Execute Javascript    window.scrollTo(0, 0);

general Wait Until
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5s
    Sleep    5

general return status
    [Arguments]    ${locator}
    ${res}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    timeout=5s
    RETURN    ${res}

# Error General for no handphone or password not filled    
show message error    
    ${label}    general return status    xpath=//div[@class='mb-20px']//parent::div/label[contains(text(), 'Nomor')]
    IF    ${label}
        general Wait Until    ${errMessageLabel}
        ${err}    Get Text    ${errMessageLabel}
        Set Global Variable    ${err_text}     ${err}
        Log To Console    ${\n}Error Message : ${err}
    ELSE
        general Wait Until    ${errMessageLabel}
        ${err}    Get Text    ${errMessageLabel}
        Set Global Variable    ${err_text}     ${err}
        Log To Console    ${\n}Error Message : ${err}
    END

reload_pages
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

# Error State General for Buat Project
show message error project
    ${label}    general return status    ${errMessageFormProject}
    IF    ${label}
        general Wait Until    ${errMessageFormProject}
        ${err}    Get Text    ${errMessageFormProject}
        Log To Console   ${\n}Error State: ${err}
        Scroll Element Into View    ${errMessageFormProject}
    ELSE
        general Wait Until    ${errLabel_formProject}
        ${err}    Get Text    ${errLabel_formProject}
        Log To Console   ${\n}Error State: ${err}
    END

error for startDate and endDate
    ${label}    general return status    xpath=//div[@class='col-md-6']/div/label
    FOR    ${counter}    IN RANGE    1    3
        ${text}    Run Keyword If    ${label}    Get Text    xpath=//div[@class='col-md-6'][${counter}]/div/label
        ...    ELSE
        ...    Exit For Loop
        Log To Console    ${\n}Error State: ${text}
    END

# Button Ubah on Detail Page
click button ubah
    general Wait Until    ${buttonUbah}
    user click element    ${buttonUbah} 

user click button
    [Arguments]    ${loc_btn}
    general Wait Until    ${loc_btn}
    user click element    ${loc_btn}    

# Bisa Kirim / Simpan
button accept on dialog form ubah
    [Arguments]    ${textPopUP}
    general Wait Until    xpath=//div[@class='d-flex']/button[contains(.,'${textPopUP}')]
    user click element    xpath=//div[@class='d-flex']/button[contains(.,'${textPopUP}')]

# Pop Up Dialog
show pop up dialog
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5s
    ${textDesc}    Get Text    xpath=//div[@class='text-center']/p[2]
    user input text    xpath=//div[@class='text-center']/textarea    Ubah Data
    Log To Console    Desc: ${textDesc}

# Random Company Name
Generate Random Comp
    ${name_part1}    Evaluate    ''.join(chr(random.randint(65, 90)) for _ in range(5))    modules=random
    ${name_part2}    Evaluate    ''.join(chr(random.randint(65, 90)) for _ in range(3)) + ' Corp'    modules=random
    ${company_name}    Set Variable    ${name_part1} ${name_part2}
    Log    Random Company Name: ${company_name}
    Set Global Variable    ${company_name}    ${company_name}
    Random angka
    RETURN    ${company_name}

Tanggal Hari ini
    ${today}=    Evaluate    (datetime.datetime.now()).strftime('%Y-%m-%d')    modules=datetime
    ${date_parts}=    Split String    ${today}    -
    ${year}=    Get From List    ${date_parts}    0
    ${month}=    Get From List    ${date_parts}    1
    ${day}=    Get From List    ${date_parts}    2
    Set Global Variable    ${day}    ${day}
    Set Global Variable    ${month}    ${month}
    Set Global Variable    ${year}    ${year}
    Log To Console    ${\n}${today}
    Log    Tahun: ${year}
    Log    Bulan: ${month}
    Log    Hari: ${day}

Random angka
    ${angka_acak}=    Evaluate    random.randint(1000000, 5000000)    modules=random
    Log To Console    Random Angka: ${angka_acak}
    Set Global Variable    ${angka_acak}    ${angka_acak}

Get Random Angka
    [Arguments]    ${angka}
    ${randomAngka}=    Evaluate    random.randint(1, ${angka} - 1)    random
    IF    ${randomAngka} < 10
        # ini untuk format tanggal kurang dari 10 (contoh : 06)
        ${randomAngka}=    Evaluate    str(${randomAngka}).zfill(2)
        
        Set Global Variable    ${randomAngka}    ${randomAngka}
        Log     ${randomAngka}
    ELSE
        Set Global Variable    ${randomAngka}    ${randomAngka}
    END
    
    RETURN    ${randomAngka}

Random Number
    [Arguments]    ${angka}
    ${randomAngka}=    Evaluate    random.randint(1, ${angka} - 1)    random
    Set Global Variable    ${randomAngka}    ${randomAngka}
    