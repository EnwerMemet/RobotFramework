*** Settings ***
Library    SeleniumLibrary    run_on_failure=None

*** Keywords ***
Open Browser In Incognito
    [Arguments]    ${URL}    ${BROWSER}=chrome
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    