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
            Get Information Project    ${counter}
            BREAK
        END
    END
