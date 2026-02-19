*** Settings ***
Resource          ../Resources/Main.robot

*** Keywords ***
Open Website
    [Arguments]    ${URL}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    ${prefs}=      Create Dictionary    credentials_enable_service=${False}    password_manager_enabled=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Open Browser       ${URL}    chrome    options=${options}