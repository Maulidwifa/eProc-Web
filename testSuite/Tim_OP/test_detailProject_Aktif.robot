*** Settings ***
# Resource            ../config/${ENV}.robot
Resource            ../../config/web_eProc.robot       # untuk keperluan GitAction
Resource            ../../testScenario/Tim_OP/detailProject_MenungguPersetujuan.robot
Resource            ../../testScenario/Tim_OP/detailProject_EvaluasiAnggaran.robot
Resource            ../../testScenario/Tim_OP/detailProject_Aktif.robot
Test Setup            Begin Web Test
Test Teardown         End Web Test

*** Test Cases ***
Tim OP can Changes Data Estimasi Tanggal Berakhir Project
    [Documentation]            This scenario test User can change data tanggal berakhir project before tanggal mulai project
    [Tags]                     1000s    detail_project    test
    User change data End Date before the start date

Tim OP can Changes Data PIC same to each other
    [Documentation]            This scenario test User can change data pic same to each other
    [Tags]                     1000s    detail_project    test
    User change PIC to same each other

Tim OP can Change Data Anggaran Maksimal
    [Documentation]            This scenario test User can change data Anggaran Maksimal
    [Tags]                     1000s    detail_project    test
    User change Anggaran Maksimal

Tim OP click button Kembali on PopUp dialog
    [Documentation]            This scenario test User can click button batalkan on detail persetujuan anggaran
    [Tags]                     1000s    detail_project    test
    user click button kembali on popUp