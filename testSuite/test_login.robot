*** Settings ***
Resource            ../config/web_eProc.robot
Resource            ../testScenario/login.robot
# Suite Setup         Begin Web Test
# Suite Teardown       End Web Test
Test Setup    Begin Web Test
Test Teardown    End Web Test

*** Test Cases ***
Test Login Success
    [Documentation]            This scenario test User can access URL Home Page
    [Tags]                     1000s    home    test
    User can access Home Login 1000s

Test Login Without fill No Handphone and Password
    [Documentation]            This scenario test User login without fill no handphone and password
    [Tags]                     1000s    login invalid    test
    User login without fill no handphone and password

Test Login Without fill Password
    [Documentation]            This scenario test User login without fill password
    [Tags]                     1000s    login invalid    test
    User login without fill password

Test Login Without fill No Handphone
    [Documentation]            This scenario test User login without fill no handphone
    [Tags]                     1000s    login invalid    test
    User login without fill no handphone

Test Login With invalid No Handphone
    [Documentation]            This scenario test User login with invalid no handphone
    [Tags]                     1000s    login invalid    test
    User login with invalid no handphone

Test Login With No Handphone not Listed
    [Documentation]            This scenario test User login with no handphone not listed
    [Tags]                     1000s    login invalid    test
    User login with no handphone not listed