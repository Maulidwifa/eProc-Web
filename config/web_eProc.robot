*** Settings ***
Library    SeleniumLibrary        timeout=100        run_on_failure=Capture Page Screenshot
Library    String
Library    BuiltIn
Library    OperatingSystem

*** Variables ***
# ${BROWSER}                  chrome
${BROWSER}                  headlesschrome
${URL}                  https://dev-proyek.1000saudara.com/Login

*** Keywords ***
Begin Web Test
    Open Browser                    about:blank            ${BROWSER}
    # Maximize Browser Window
    Execute JavaScript    document.body.style.transform = 'scale(0.67)'; document.body.style.transformOrigin = '0 0'; # untuk keperluan headless
    Go To                           ${URL}

End Web Test
    # Close Browser
    [Documentation]    Closes the browser after all tests in the suite have run
    Log    Suite teardown initiated
    Close Browser
