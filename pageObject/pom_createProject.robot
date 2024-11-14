*** Settings ***
Library                SeleniumLibrary
Resource               ./API_listKecamatan.robot
Resource               ./generalFunct.robot

*** Variables ***
${buttonBuatProject}        xpath=//span[contains(text(), 'Buat Project')]//ancestor::button
${textBuatProject_form}     xpath=//p[contains(text(), 'Buat Project')]
${inputNamaProject}         xpath=//input[@id='projectName']
${inputKecamatan}           xpath=//input[@id='textCityName']
${listKecamatan}            xpath=//div[@id='listcity_0']
${alamatDetail}             xpath=//textarea[@id='frmUpdtAlamatDetail']
${headerCalendar}           xpath=//div[@class='mud-picker-calendar-header-switch']/button[2]
${buttonSimpan}             xpath=//span[contains(text(),'Simpan')]/parent::span/parent::button

# Date Picker
${tanggalMulai_datePicker}       xpath=//p[normalize-space()='Estimasi tanggal mulai']/parent::div//input[@placeholder="-Select-"]
${tanggalBerakhir_datePicker}    xpath=//p[contains(text(), 'Estimasi tanggal berakhir')]/parent::div//input[@placeholder="-Select-"]
${nextMonth}                     xpath=//div[@class='mud-picker-calendar-header-switch']/button[3]
${tanggalHariIni}                xpath=//div[@class='mud-picker-calendar']/button
${prevMonth}                     xpath=//div[@class='mud-picker-calendar-header-switch']/button[1]

# PIC
${PICfinance}                    xpath=//p[normalize-space()='PIC Finance']
${listPIC}                       xpath=//div[@class='dvContentSearch']
${fieldPICadmin}                 xpath=//p[contains(text(), 'Admin')]/following-sibling::div[1]/button
${fieldPICmanager}               xpath=//p[contains(text(), 'Manager')]/following-sibling::div[1]/button
${fieldPICfinance}               xpath=//p[contains(text(), 'Finance')]/following-sibling::div[1]/button
${labelErr_PICsame}              xpath=//div[contains(@class, 'btnBetween')][1]/label[contains(.,'PIC')]

# Anggaran Maximum
${anggaranMax}                   xpath=//input[@placeholder='Masukkan anggaran maksimal pembelian...']

# Error State
${wajibDiPilih}                  xpath=//div[@class='mb-20px']//label[contains(@class,'txt-danger')][normalize-space()='Wajib dipilih']

*** Keywords ***
user click button Buat Project
    general Wait Until    ${buttonBuatProject}
    Click Element    ${buttonBuatProject}
    general Wait Until    ${textBuatProject_form}

user input nama project
    Generate Random Comp
    user input text    ${inputNamaProject}      ${company_name}
    Log To Console    Name Project: ${company_name}

user choose kecamatan list
    Get list city
    user input text    ${inputKecamatan}    ${kecamatan_name}
    Sleep    2
    user click element    ${listKecamatan}

user choose address detail
    user click element    ${alamatDetail}
    ${a}    Split String From Right    ${kecamatan_name}
    user input text    ${alamatDetail}    ${kecamatan_name}
    # Click Element    css=div:nth-child(8) > div > .pac-item-query

user choose address detail without fill kecamatan
    Get list city
    user click element    ${alamatDetail}
    ${a}    Split String From Right    ${kecamatan_name}
    user input text    ${alamatDetail}    ${kecamatan_name}

tanggal mulai
    user click element    ${tanggalMulai_datePicker}
    user click element    ${nextMonth}
    Get Random Angka    30
    ${textHeaderCalendar}    Get Text    ${headerCalendar}
    user click element    xpath=//button[contains(@aria-label, '${randomAngka} ${textHeaderCalendar}')]

Pilih tanggal hari ini
    Tanggal Hari ini
    ${textHeaderCalendar}    Get Text    ${headerCalendar}
    general Wait Until    xpath=//button[contains(@aria-label, '${day} ${textHeaderCalendar}')]
    Click Element    xpath=//button[contains(@aria-label, '${day} ${textHeaderCalendar}')]

# ini untuk status nya bisa ke Aktif / Terjadwal
tanggal berakhir
    [Arguments]    ${loc}
    user click element    ${tanggalBerakhir_datePicker}
    # user click element    ${loc}
    user click element    ${loc}
    ${textHeaderCalendar}    Get Text    ${headerCalendar}
    Get Random Angka    30
    user click element    xpath=//button[contains(@aria-label, '${randomAngka} ${textHeaderCalendar}')]


user input anggaranMax
    Random angka
    user input text    ${anggaranMax}    ${angka_acak}

user pilih PIC
    user pilih seluruh pic

user pilih seluruh pic
    Get list User Management (SITE)
    FOR    ${counter}    IN RANGE    1    4
        IF    '${counter}' == '1'
            user click element    ${fieldPICadmin}
            Random Number    ${totalUser}
            func PIC    ${False}
            varif func PIC    ${counter}
            Log To Console    PIC Admim : ${namePICtext}
        ELSE IF    '${counter}' == '2'
            Scroll Element Into View    ${fieldPICfinance}
            user click element    ${fieldPICmanager}
            Random Number    ${totalUser}
            ${res}    general return status    xpath=//div[@class='dvContentSearch'][${randomAngka}]/p[@style='color:#4C4DDC']

            func PIC    ${res}
            varif func PIC    ${counter}
            Log To Console    PIC Manager : ${namePICtext}
        ELSE IF    '${counter}' == '3'
            user click element    ${fieldPICfinance} 
            Random Number    ${totalUser}
            ${res}    general return status    xpath=//div[@class='dvContentSearch'][${randomAngka}]/p[@style='color:#4C4DDC']
            IF    ${res}
                Random Number    ${totalUser}
                ${res}    general return status    xpath=//div[@class='dvContentSearch'][${randomAngka}]/p[@style='color:#4C4DDC']
        
                func PIC    ${res}
                varif func PIC    ${counter}
                Log To Console    PIC Finance : ${namePICtext}
            ELSE
                Scroll Element Into View    xpath=//div[@class='dvContentSearch'][${randomAngka}]
                ${namePICtext}    Get Text    xpath=//div[@class='dvContentSearch'][${randomAngka}]/p[contains(@class,'txtLgMedium')]
                Set Global Variable    ${namePICtext}    ${namePICtext}
                user click element    xpath=//div[@class='dvContentSearch'][${randomAngka}]
                varif func PIC    ${counter}
                Log To Console    PIC Finance : ${namePICtext}
            END
        END
    END

user without selecting one of the PICs
    [Arguments]    ${pic1}    ${pic2}    ${start1}    ${start2}
    Get list User Management (SITE)
    FOR    ${counter}    IN RANGE    ${start1}    4
        IF    '${counter}' == '${start1}'
            user click element    ${pic1}
            Random Number    ${totalUser}
            func PIC    ${False}
            varif func PIC    ${counter}
            Log To Console    Nama PIC : ${namePICtext}
        ELSE IF    '${counter}' == '${start2}'
            Scroll Element Into View    ${fieldPICfinance}
            user click element    ${pic2}
            Random Number    ${totalUser}
            ${res}    general return status    xpath=//div[@class='dvContentSearch'][${randomAngka}]/p[@style='color:#4C4DDC']
            func PIC    ${res}
            varif func PIC    ${counter}
            Log To Console    Nama PIC : ${namePICtext}
        ELSE
            Get Text    ${fieldPICadmin}
        
        END
    END

func PIC
    [Arguments]    ${res}
    
    general Wait Until    ${listPIC}
    Scroll Element Into View    xpath=//div[@class='dvContentSearch'][${randomAngka}]
    IF    ${res}
        Random Number    ${totalUser}
        Scroll Element Into View    xpath=//div[@class='dvContentSearch'][${randomAngka}]
        ${namePICtext}    Get Text    xpath=//div[@class='dvContentSearch'][${randomAngka}]/p[contains(@class,'txtLgMedium')]
        Set Global Variable    ${namePICtext}    ${namePICtext}
        user click element    xpath=//div[@class='dvContentSearch'][${randomAngka}]
    ELSE
        Scroll Element Into View    xpath=//div[@class='dvContentSearch'][${randomAngka}]
        ${namePICtext}    Get Text    xpath=//div[@class='dvContentSearch'][${randomAngka}]/p[contains(@class,'txtLgMedium')]
        Set Global Variable    ${namePICtext}    ${namePICtext}
        user click element    xpath=//div[@class='dvContentSearch'][${randomAngka}]
    END

varif func PIC
    [Arguments]    ${counter}
    IF    '${counter}' == '1'
        ${textPICadmin}    Get Text        xpath=//p[contains(text(), 'Admin')]/following-sibling::div[${counter}]/button/span//span
        Should Be Equal    ${namePICtext}    ${textPICadmin}
    ELSE IF    '${counter}' == '2'
        ${textPICmanager}    Get Text        xpath=//p[contains(text(), 'Admin')]/following-sibling::div[${counter}]/button/span//span
        Should Be Equal    ${namePICtext}    ${textPICmanager}
    ELSE IF    '${counter}' == '3' 
        ${textPICfinance}    Get Text        xpath=//p[contains(text(), 'Admin')]/following-sibling::div[${counter}]/button/span//span
        Should Be Equal    ${namePICtext}    ${textPICfinance}
    END

Error validasi form buat project
    FOR    ${counter}    IN RANGE    1    10    
        ${res}    general return status    xpath=//p[contains(@class,'txtLgReguler')]/parent::div[contains(@style, 'max-height')]/div[${counter}]/label
        IF    ${res}
            ${textErr}    Get Text    xpath=//p[contains(@class,'txtLgReguler')]/parent::div[contains(@style, 'max-height')]/div[${counter}]/label
            Scroll Element Into View    xpath=//p[contains(@class,'txtLgReguler')]/parent::div[contains(@style, 'max-height')]/div[${counter}]/label
            Log To Console    Error State : ${textErr}

        ELSE IF    '${counter}' == '4'
            ${textErr}    Get Text    ${wajibDiPilih}
            Scroll Element Into View    ${wajibDiPilih}
            Log To Console    Error State : ${textErr}
        END
    END

user input with names used
    Get list Project Manajemen
    user input text    ${inputNamaProject}    ${projectName}

# error for startDate and endDate
#     ${label}    general return status    xpath=//div[@class='col-md-6']/div/label
#     FOR    ${counter}    IN RANGE    1    3
#         ${text}    Run Keyword If    ${label}    Get Text    xpath=//div[@class='col-md-6'][${counter}]/div/label
#         ...    ELSE
#         ...    Exit For Loop
#         Log To Console    ${\n}Error State: ${text}
#     END

choose same PIC
    # Pilih PIC Admin
    user click element    ${fieldPICadmin}
    user click element    xpath=//div[@class='dvContentSearch'][1]
    
    # Pilih PIC Manager
    user click element    ${fieldPICmanager}
    user click element    xpath=//div[@class='dvContentSearch'][1]
    
    # Verify Error State
    Element Should Be Visible    ${labelErr_PICsame}
    ${labelErr}    Get Text    ${labelErr_PICsame}
    Should Be Equal    ${labelErr}    PIC Tidak boleh sama
    Log To Console    Error State: ${labelErr}