*** Settings ***
Library                SeleniumLibrary
Resource        ../../generalFunct.robot
Resource        ../../API_listKecamatan.robot
Resource        ../../detailProject/Tim_OP/pom_detailProject_MenungguPersetujuan.robot


*** Variables ***
${popUp_UbahAnggaran}            xpath=//p[contains(.,'Perubahan Anggaran')]
${list_filterAktif}              xpath=//div[@id='listFilter']/span[contains(.,'Aktif')]

*** Keywords ***
user on detail Aktif page
    Element Should Be Visible    ${buttonRiwayat}
    ${textStatus}    Get Text    ${statusProject}
    Set Global Variable    ${textStatus}    ${textStatus}

    # Verify Status detail Project
    Should Be Equal    ${textStatus}    Aktif

user clear text Anggaran Maksimal
    general delay
    general Wait Until    ${anggaranMax}
    Clear Element Text    ${anggaranMax}

user ubah tanggal akhir
    general delay
    general Wait Until    ${fieldPICfinance}
    Wait Until Element Is Visible    ${fieldPICfinance}
    user scroll element    ${PICfinance}
    tanggal berakhir    ${prevMonth}

pilih project aktif total pembelian (0)
    [Arguments]    ${filter_status}    ${durasi}=2s
    general Wait Until    ${list_filterAktif}
    user click element    ${list_filterAktif}
    general Wait Until    xpath=//tbody//tr
    
    FOR    ${counter}    IN RANGE    1    10
        ${res}    general return status    xpath=//tbody/tr[${counter}]/td[contains(.,'Rp 0')]
        IF    ${res}
            general delay
            ${btn_detail}    general return status    xpath=//tbody/tr[${counter}]/td[6]/span[1]/span[contains(.,'Detail')]
            Run Keyword If    ${btn_detail}    Get Information Project    ${counter}
            # Exit For Loop
        END
    END


Get load on popUp form project
    general Wait Until    xpath=//p[normalize-space()='Nama Project']
    #//input[@id='projectName']
    Reload Page
    ${res_btnUbah}    Run Keyword And Return Status    Wait Until Element Is Visible    ${buttonUbah}
    Run Keyword If    ${res_btnUbah}    click button ubah    ELSE    general Wait Until    ${buttonUbah}    timeout=50s
    general wait until enable    xpath=//input[@placeholder='Masukkan anggaran maksimal pembelian...']