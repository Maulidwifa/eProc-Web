*** Settings ***
Resource                ../pageObject/detailProject/Tim_OP/pom_createProject.robot
Resource                ../pageObject/generalFunct.robot
Resource                ../pageObject/API_listKecamatan.robot
Resource                ./login.robot

*** Keywords ***
User click Buat Project
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user pilih PIC
    # And user click element    ${buttonSimpan}

User create project without fill Name Project
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user pilih PIC
    Then user click element    ${buttonSimpan}
    And show message error project

User create project without fill Alamat Project
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose address detail without fill kecamatan
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user pilih PIC
    Then user click element    ${buttonSimpan}
    And show message error project

User create project without fill detail Alamat Project
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user pilih PIC
    Then user click element    ${buttonSimpan}
    And show message error project

User create project without choose Start Date
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user pilih PIC
    Then user click element    ${buttonSimpan}
    And show message error project

User create project without choose PIC Admin
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user without selecting one of the PICs    ${fieldPICmanager}    ${fieldPICfinance}    ${2}    ${3}
    Then user click element    ${buttonSimpan}
    And show message error project

User create project without choose PIC Manager
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user without selecting one of the PICs    ${fieldPICadmin}    ${fieldPICfinance}    ${1}    ${3}
    Then user click element    ${buttonSimpan}
    And show message error project

User create project without choose PIC Finance
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user without selecting one of the PICs    ${fieldPICadmin}    ${fieldPICmanager}    ${1}    ${2}
    Then user click element    ${buttonSimpan}
    And show message error project

User Create project with name has been Used
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input with names used
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And user pilih PIC
    Then user click element    ${buttonSimpan}
    And user scroll element    ${inputNamaProject}
    And show message error project

User Create project with the end date must be after the start date
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${prevMonth}
    And user input anggaranMax
    And user pilih PIC
    And user click element    ${buttonSimpan}
    And user scroll element    ${inputNamaProject}
    And error for startDate and endDate

User choose PIC same to each other
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    And user input nama project
    And user choose kecamatan list
    And user choose address detail
    And user scroll element    ${PICfinance}
    And tanggal mulai
    And tanggal berakhir    ${nextMonth}
    And user input anggaranMax
    And choose same PIC

Error State form Buat Project
    Given User can access Home Login 1000s
    When user click element    ${buttonBuatProject}
    Then user click element    ${buttonSimpan}
    And Error validasi form buat project 