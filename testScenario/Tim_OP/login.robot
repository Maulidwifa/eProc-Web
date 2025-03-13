*** Settings ***
Resource        ../../pageObject/detailProject/Tim_OP/pom_login_eProc.robot
Resource        ../../pageObject/generalFunct.robot
Library         OperatingSystem

*** Keywords ***
# Login Success
User can access Home Login 1000s
    Then user go to home page E-Proc1000s

# Login Without fill No Handphone and Password
User login without fill no handphone and password
    Given user visit E-Proc1000s Login Page
    When without fill no handphone and password
    Then show message error

# Login Without fill password
User login without fill password
    Given user visit E-Proc1000s Login Page
    When without filling any of them    ${inputUsername}    ${ROLE_ADMIN}
    Then show message error
    And Should Be Equal    ${err_text}    Password harus diisi
        
# Login Without fill no handphone
User login without fill no handphone
    Given user visit E-Proc1000s Login Page
    When without filling any of them    ${inputPassword}    ${PASSWORD}
    Then show message error
    And Should Be Equal    ${err_text}    No. Handphone harus diisi
    
# Login With invalid no handphone
User login with invalid no handphone
    Given user visit E-Proc1000s Login Page
    When input error no telp    ${inputUsername}    12345    ${inputPassword}    ${PASSWORD}
    Then show message error
    And Should Be Equal    ${err_text}    No. handphone harus diawali dengan 08
    
# Login With no handphone not listed
User login with no handphone not listed
    Given user visit E-Proc1000s Login Page
    When input error no telp    ${inputUsername}    08983186457345    ${inputPassword}    ${PASSWORD}
    Then show message error
    And Should Be Equal    ${err_text}    No. handphone tidak terdaftar