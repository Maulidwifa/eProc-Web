*** Settings ***
Library    SeleniumLibrary        timeout=100        run_on_failure=Capture Page Screenshot
Library    String
Library    BuiltIn
Library    OperatingSystem

*** Variables ***
# ${BROWSER}                  chrome
${BROWSER}                  headlesschrome
${URL_DEV}                  https://developer.1000saudara.com/project1000s
${URL_BETA}                 https://beta.1000saudara.com/project1000s

*** Keywords ***
Begin Web Test
    Open Browser                    about:blank            ${BROWSER}
    # Execute JavaScript    document.body.style.transform = 'scale(0.67)'; document.body.style.transformOrigin = '0 0';
    Maximize Browser Window
    Go To                           ${URL_DEV}

End Web Test
    # Close Browser
    [Documentation]    Closes the browser after all tests in the suite have run
    Log    Suite teardown initiated
    Close Browser
