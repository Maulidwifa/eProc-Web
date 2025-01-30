*** Settings ***
# Resource            ../config/${ENV}.robot
Resource            ../../config/web_eProc.robot    # Kebutuhan Git Action
Resource            ../../testScenario/Tim OP/createProject.robot
Test Setup            Begin Web Test
Test Teardown         End Web Test


*** Test Cases ***
Tim OP can create Project
    [Documentation]            This scenario test User can access form buat project
    [Tags]                     1000s    buat_project    test
    User click Buat Project

Tim OP create project without fill field Nama Project
    [Documentation]            This scenario test User create project but without fill Nama Project
    [Tags]                     1000s    buat_project    test
    User create project without fill Name Project

Tim OP create project without choose Alamat Project
    [Documentation]            This scenario test User create project but without choose Alamat Project
    [Tags]                     1000s    buat_project    test
    User create project without fill Alamat Project
    
Tim OP create project without choose detail Alamat Project
    [Documentation]            This scenario test User create project but without choose detail Alamat Project
    [Tags]                     1000s    buat_project    test
    User create project without fill detail Alamat Project

Tim OP create project without choose Date Picker Start Date
    [Documentation]            This scenario test User create project but without choose start date
    [Tags]                     1000s    buat_project    test
    User create project without choose Start Date

Tim OP create project without choose PIC Admin
    [Documentation]            This scenario test User create project but without choose PIC Admin
    [Tags]                     1000s    buat_project    test
    User create project without choose PIC Admin

Tim OP create project without choose PIC Manager
    [Documentation]            This scenario test User create project but without choose PIC Manager
    [Tags]                     1000s    buat_project    test
    User create project without choose PIC Manager

Tim OP create project without choose PIC Finance
    [Documentation]            This scenario test User create project but without choose PIC Finance
    [Tags]                     1000s    buat_project    test
    User create project without choose PIC Finance

Tim OP create project with Name Project has Used
    [Documentation]            This scenario test User create project with Name project has been used
    [Tags]                     1000s    buat_project    test
    User Create project with name has been Used

Tim OP create project with End Date is less than Start Date
    [Documentation]            This scenario test User create project with end date is less than start date
    [Tags]                     1000s    buat_project    test
    User Create project with the end date must be after the start date

Tim OP create project with PIC same to Each Other
    [Documentation]            This scenario test User create project with the PIC same
    [Tags]                     1000s    buat_project    test
    User choose PIC same to each other

Show Error State Form Buat Project
    [Documentation]            This scenario test Show error state on form Buat Project
    [Tags]                     1000s    buat_project    test
    Error State form Buat Project

