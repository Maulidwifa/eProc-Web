*** Settings ***
Library        SeleniumLibrary
Library        String
Library        Collections


*** Variables ***
# Users
${ROLE_ADMIN}    085210758864
${ROLE_SCM}      085210758865
${PASSWORD}      123456

# Landing Page
${textNomorTelpon_onLogin}        xpath=//div[@class='mb-20px']//parent::div/label[contains(text(), 'Nomor')]

${buttonNextPage}          xpath=//a[contains(@aria-label,'Go to next page.')]
${listFilter_Menunggu}     xpath=//div[@id='listFilter']/span[contains(.,'Menunggu')]
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
${detail_project_header}                 xpath=//span[normalize-space()='Detail Project']
${namaProject_onDetailPage}              xpath=//span[@class='ttlMdSemiBold']
${statusProject}                         xpath=//div[@class='d-flex align-items-center justify-content-between mb-2px']//div[@class='d-flex align-items-center']/span[2]

# Form Ubah / Buat Project
${field_searchPIC}                       xpath=//input[@id='searchUser']
${buttonBatal}                           xpath=//span[contains(text(),'Batal')]/parent::span/parent::button

# Search in PIC list
${pencarianTidakDiTemukan}               xpath=//p[normalize-space()='Pencarian tidak ditemukan']

# Detail PopUp Riyawat
${popUP_titleRiwayat}                    xpath=//p[normalize-space()='Riwayat']
${popUp_titleAktif_onDetailRiwayat}      xpath=//div[@class='dvHistory ']/div[contains(.,'Aktif')]
*** Keywords ***
# General Function
user input text
    [Arguments]    ${locator}    ${text}
    general Wait Until    ${locator}
    Input Text    ${locator}    ${text}
    Tunggu Sampai Kondisi Terpenuhi    Cek Field Sudah Terisi    ${locator}

user input password
    [Arguments]    ${locator}    ${text}
    # Wait Until Element Is Visible    ${locator}
    general Wait Until   ${locator}
    Input Password    ${locator}    ${text}
    Tunggu Sampai Kondisi Terpenuhi    Cek Field Sudah Terisi    ${locator}

user click element
    [Arguments]    ${element}
    general Wait Until    ${element}
    Click When Element Ready    ${element}
    
user scroll element
    [Arguments]    ${locator}    ${durasi}=2s
    general delay
    Scroll Element Into View    ${locator}
    general Wait Until    ${locator}

scroll ke atas
    Execute Javascript    window.scrollTo(0, 0);

general Wait Until
    [Arguments]    ${locator}    ${durasi}=3    ${max_retries}=5
    ${interval}=    Set Variable    1
    ${total_checks}=    Evaluate    int(${durasi} / ${interval})
    Wait Until Keyword Succeeds    ${max_retries} times    0s    Elemen Harus Stabil Terlihat    ${locator}    ${total_checks}    ${interval}
    general delay    1s

# Tunggu Sampai Load element
#     [Arguments]    ${locator}    ${durasi}=3    ${max_retries}=5
#     ${interval}=    Set Variable    1
#     ${total_checks}=    Evaluate    int(${durasi} / ${interval})
#     Wait Until Keyword Succeeds    ${max_retries} times    0s    Elemen Harus Stabil Terlihat    ${locator}    ${total_checks}    ${interval}

Elemen Harus Stabil Terlihat
    [Arguments]    ${locator}    ${ulang}    ${interval}
    Wait Until Element Is Visible    ${locator}    timeout=5s
    FOR    ${i}    IN RANGE    ${ulang}
        Element Should Be Visible    ${locator}
        Wait Until Element Is Visible    ${locator}    timeout=${interval}
    END

general wait until enable
    [Arguments]    ${locator}
    Wait Until Element Is Enabled     ${locator}    timeout=55s
    Tunggu Sampai Kondisi Terpenuhi    Cek Visible    ${locator}

general return status
    [Arguments]    ${locator}    ${timeout}=2s
    ${res}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${timeout}
    RETURN    ${res}

Tunggu Sampai Kondisi Terpenuhi
    [Arguments]    ${keyword}    ${locator}    ${timeout}=15s    ${interval}=1s
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    Run Keyword    ${keyword}    ${locator}

Cek Field Sudah Terisi
    [Arguments]    ${value_element}
    ${value}=    Get Value    ${value_element}
    Should Not Be Empty    ${value}

Cek Visible
    [Arguments]    ${element_visible}
    Wait Until Element Is Visible    ${element_visible}    timeout=30s

Click When Element Ready
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    5 times    3s     Click Element    ${locator}

general delay
    [Arguments]    ${durasi}=2s
    Run Keyword And Ignore Error    Wait Until Keyword Succeeds    2 times    ${durasi}    Fail    Delay paksa tanpa Sleep

# Error General for no handphone or password not filled    
show message error    
    ${label}    general return status    ${textNomorTelpon_onLogin}
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
# Error Field (saat ini untuk kebutuhan PIC)
show message error field
    [Arguments]    ${field_error}
    ${labelErr}    Get Text    xpath=//div[contains(@class, 'btnBetween')][1]/label
    Should Be Equal    ${labelErr}    ${field_error}
    Log To Console    Error State: ${labelErr}

reload_pages
    [Arguments]    ${location}
     FOR    ${counter}    IN RANGE    1    3
        ${res}    general return status    ${location}
        IF    ${res}
            BREAK
        ELSE
            Reload Page
            general delay    5s
            ${res}    general return status    ${location}
        END
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

 user click filter status
    [Arguments]    ${filter_status}    ${filter_list}    ${durasi}=2s
    Random Number    10
    general Wait Until    xpath=//div[@id='listFilter']/span[contains(.,'${filter_list}')]
    user click element    xpath=//div[@id='listFilter']/span[contains(.,'${filter_list}')]
    general delay    1s

    # ${res}    general return status    xpath=//tbody/tr[${randomAngka}]/td[contains(.,'${filter_status}')]    timeout=1s
    # IF    ${res}
    #     general delay    1s
    #     Get Information Project    ${randomAngka}
    # ELSE
    #     general delay    1s
    #     FOR    ${counter}    IN RANGE    1    10
    #     ${res}    general return status    xpath=//div[@id='listFilter']/span[contains(.,'${filter_list}')]    timeout=1s
    #         Run Keyword If    ${res}
    #         ...    Loop For Search Project    ${filter_status}
    #         ...  ELSE
    #         ...    Exit For Loop
    #     END
    # END
    
    # coba coba yang baru fungsi 
    search project    ${filter_status}
    FOR    ${page_counter}    IN RANGE    2    10
        # Cek jika ada tombol Next
        ${next_button}    Run Keyword And Return Status    general Wait Until    ${buttonNextPage}
        IF    ${next_button}
            Click Element    ${buttonNextPage}
            general delay    1s
            # Mulai pencarian lagi di halaman baru
            search project    ${filter_status}    ${page_counter}
        ELSE
            Log    Tidak ada tombol "Next", pencarian selesai.
            Exit For Loop
        END
    END

# Fungsi ini untuk loop mencari status project tertentu
search project
    [Arguments]    ${filter_status}    @{keyword}
    FOR    ${counter}    IN RANGE    1    11
        ${res_list}    general return status    xpath=//tbody/tr[${counter}]/td[contains(.,'${filter_status}')]    timeout=1s
        IF    ${res_list}
            Log    Proyek ditemukan di halaman ${keyword} pada baris ${counter}
            general delay    1s
            Get Information Project    ${counter}
            Exit For Loop
        END
    END
Loop For Search Project
    [Arguments]    ${filter_status}
    FOR    ${counter}    IN RANGE    1    12
        ${res_list}    general return status    xpath=//tbody/tr[${counter}]/td[contains(.,'${filter_status}')]    timeout=1s
        IF    ${res_list}
            search project    ${filter_status}
        ELSE IF    '${counter}' == '11'
            user click element    ${buttonNextPage}
            search project    ${filter_status}
        END
    END

# ini fungsi untuk Proses Evaluasi, Persetujuan Anggaran, Evaluasi Anggaran
Filter Status 
    [Arguments]    ${filter_status}    ${durasi}=2s
    Random Number    10
    general Wait Until    ${listFilter_Menunggu}
    user click element    ${listFilter_Menunggu}
    general Wait Until    xpath=//tbody//tr

    ${res}    general return status    xpath=//tbody/tr[${randomAngka}]/td[contains(.,'${filter_status}')]
    IF    ${res}
        general delay    1s
        Get Information Project    ${randomAngka}
    ELSE
        general delay
        FOR    ${counter}    IN RANGE    1    10
            ${res_list}    general return status    xpath=//tbody/tr[${counter}]/td[contains(.,'${filter_status}')]    timeout=1s
            IF    ${res_list}
                general delay
                Get Information Project    ${counter}
                BREAK
            END
        END
    END

Get Information Project
    [Arguments]    ${randomNumber}
    general Wait Until    xpath=//tbody//tr
    ${text}    Get Text          xpath=//tbody/tr[${randomNumber}]/td[1]
    ${status}    Get Text        xpath=//tbody/tr[${randomNumber}]/td[5]
    user click element           xpath=//tbody/tr[${randomNumber}]/td[6]/span/span
    general Wait Until    ${detail_project_header}
    ${res_detail}    general return status    ${detail_project_header}
    WHILE    ${res_detail} == $False
        user click element    xpath=//tbody/tr[${randomNumber}]/td[contains(., 'Detail')]
        ${res_detail}    general return status    ${detail_project_header}
    END
    Log    ${text}
    
    # User in Detail Page
    general Wait Until    ${namaProject_onDetailPage}
    ${res}    general return status    ${text}    timeout=1s    # Ini Selalu ke FALSE
    IF    ${res}
        Log    ERROR (DETAIL PROJECT)
    ELSE
        ${nameProject}    Get Text    ${namaProject_onDetailPage}
        ${status_onDetailPage}    Get Text    ${statusProject}
        Log To Console    Nama Project: ${nameProject}
        Log To Console    Status Project: ${status_onDetailPage}
        Set Global Variable    ${Project_Name}    ${nameProject}

        # Verify Name and Status Project
        Should Be Equal    ${nameProject}    ${text}
        Should Be Equal    ${status_onDetailPage}    ${status}
    END

# Pop Up Dialog
show pop up dialog
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5s
    ${textDesc}    Get Text    xpath=//div[@class='text-center']/p[2]
    user input text    xpath=//div[@class='text-center']/textarea    Ubah Data - By RF
    Log To Console    Desc: ${textDesc}
# Pop Up Alert
show pop up alert
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=3s
    ${textDesc}    Get Text    xpath=//div[@class='text-center']/p[2]
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
    