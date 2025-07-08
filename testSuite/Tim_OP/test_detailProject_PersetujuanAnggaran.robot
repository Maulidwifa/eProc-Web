*** Settings ***
# Resource            ../config/${ENV}.robot
Resource            ../../config/web_eProc.robot       # untuk keperluan GitAction
Resource            ../../testScenario/Tim_OP/detailProject_PersetujuanAnggaran.robot
Test Setup            Begin Web Test
Test Teardown         End Web Test


*** Test Cases ***
Tim OP can Go To Detail Project
    [Documentation]            This scenario test User can access detail project page
    [Tags]                     1000s    detail_project    test
    User go to detail Project Page

Tim OP check content Riyawat Persetujuan Anggaran
    [Documentation]            This scenario test User can check content riwayat on detail persetujuan anggaran
    [Tags]                     1000s    detail_project    test
    user click button riwayat on detail project page

Tim OP click button Batalkan (Tidak)
    [Documentation]            This scenario test User can click button batalkan on detail persetujuan anggaran
    [Tags]                     1000s    detail_project    test
    user click button batalkan (Tidak)

Tim OP click button Batalkan (Ya)
    [Documentation]            This scenario test User can click button batalkan on detail persetujuan anggaran
    [Tags]                     1000s    detail_project    test
    user click button batalkan (Ya)