*** Settings ***
Library           SeleniumLibrary


*** Variables ***
${URL}            https://automationplayground.com/crm/login.html

*** Keywords ***
Incognito Mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    ${prefs}=    Create Dictionary    credentials_enable_service=${False}    password_manager_enabled=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Open Browser       ${URL}    chrome    options=${options}
Login
    Click Link         Sign In
    Wait Until Element Is Visible    id=email-id    10s
    Input Text    id=email-id    salam@email.com
    Input Text    id=password    salam123
    Click Button    css:button[type="submit"]
    Wait Until Page Contains    Our Happy Customers    10s