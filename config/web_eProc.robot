*** Settings ***
Library    SeleniumLibrary        timeout=100        run_on_failure=Capture Page Screenshot
Library    String
Library    BuiltIn
Library    OperatingSystem
Library    browserUtils.py

*** Variables ***
# ${BROWSER}                  chrome
${BROWSER}                  headlesschrome
${URL_DEV}                  https://developer.1000saudara.com/project1000s
${URL_BETA}                 https://beta.1000saudara.com/project1000s
${ZOOM}                     0.75

*** Keywords ***
Begin Web Test
    ${options}=    Create Chrome Options With Scale    ${ZOOM}
    Open Browser    ${URL_DEV}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Wait Until Page Contains Element    tag:body
    Sleep    2

Remove file Report PNG
   @{png_file}=    List Directory    report/    *.png    absolute=${True}
    Remove Files    @{png_file}

End Web Test
    [Documentation]    Closes the browser after all tests in the suite have run
    Log    Suite teardown initiated
    Close Browser
    # Remove file Report PNG
