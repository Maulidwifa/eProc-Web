*** Settings ***
Resource        ../pageObject/detailProject/Tim_OP/pom_login_eProc.robot
Resource        ../pageObject/generalFunct.robot
Library         OperatingSystem

*** Keywords ***
# Login Success
User can access Home Login 1000s
    Then user go to home page E-Proc1000s

# Login Without fill No Handphone and Password
User login without fill no handphone and password
    Given user visit E-Proc1000s Login Page
    When user input text    ${inputUsername}    ${EMPTY}
    And user input password    ${inputPassword}    ${EMPTY}
    Then user click element    ${buttonMasuk}
    And show message error

# Login Without fill password
User login without fill password
    Given user visit E-Proc1000s Login Page
    When user input text    ${inputUsername}    ${ROLE_ADMIN}
    And user input password    ${inputPassword}    ${EMPTY}
    Then user click element    ${buttonMasuk}
    And show message error
        
# Login Without fill no handphone
User login without fill no handphone
    Given user visit E-Proc1000s Login Page
    When user input text    ${inputUsername}    ${EMPTY}
    And user input password    ${inputPassword}    ${PASSWORD}
    Then Click Element    ${buttonMasuk}
    And show message error
    
# Login With invalid no handphone
User login with invalid no handphone
    Given user visit E-Proc1000s Login Page
    When user input text    ${inputUsername}    12345
    And user input password    ${inputPassword}    ${PASSWORD}
    Then user click element    ${buttonMasuk}
    And show message error
    
# Login With no handphone not listed
User login with no handphone not listed
    Given user visit E-Proc1000s Login Page
    When user input text    ${inputUsername}    08983186457345
    And user input password    ${inputPassword}    ${PASSWORD}
    Then user click element    ${buttonMasuk}
    And show message error
    