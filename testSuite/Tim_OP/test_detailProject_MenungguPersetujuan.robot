*** Settings ***
# Resource            ../config/${ENV}.robot
Resource            ../../config/web_eProc.robot       # untuk keperluan GitAction
Resource            ../../testScenario/Tim_OP/detailProject_MenungguPersetujuan.robot
Test Setup            Begin Web Test
Test Teardown         End Web Test


*** Test Cases ***
Tim OP can Go To Detail Project
    [Documentation]            This scenario test User can access detail project page
    [Tags]                     1000s    detail_project    test
    User go to detail Project Page

Tim OP can Changes Data Alamat Project
    [Documentation]            This scenario test User can change data alamat project
    [Tags]                     1000s    detail_project    test
    User change data alamat project

Tim OP can Changes Data Estimasi Tanggal Mulai Project
    [Documentation]            This scenario test User can change data tanggal mulai project
    [Tags]                     1000s    detail_project    test
    User change data Start Date project

Tim OP can Changes Data Estimasi Tanggal Berakhir Project
    [Documentation]            This scenario test User can change data tanggal berakhir project before tanggal mulai project
    [Tags]                     1000s    detail_project    test
    User change data End Date project before the start date

# Ini Fitur penjagaan nya udah dilepas, (gaada lagi)
# Tim OP can Changes Data PIC same to each other
#     [Documentation]            This scenario test User can change data pic same to each other
#     [Tags]                     1000s    detail_project    test
#     User change PIC same to each other

Tim OP can Changes Data Name Project with name has been used
    [Documentation]            This scenario test User can change data name project with name has been used
    [Tags]                     1000s    detail_project    test
    User change name project with name has been used
