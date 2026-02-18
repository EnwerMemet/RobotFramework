*** Settings ***
Resource          ../Resources/Main.robot
Library           OperatingSystem

*** Variables ***
${URL}            ${EMPTY}
${EMAIL}          ${EMPTY}
${PASSWORD}       ${EMPTY}

*** Keywords ***
Incognito Mode
    ${env_path}=    Set Variable    ${CURDIR}/../.env
    Evaluate    __import__('dotenv').load_dotenv(r'${env_path}')
    
    ${URL}=         Get Environment Variable    CRM_APP_URL
    ${EMAIL}=       Get Environment Variable    CRM_LOGIN_EMAIL
    ${PASSWORD}=    Get Environment Variable    CRM_LOGIN_PASSWORD
    
    Set Global Variable    ${URL}
    Set Global Variable    ${EMAIL}
    Set Global Variable    ${PASSWORD}

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    ${prefs}=    Create Dictionary    credentials_enable_service=${False}    password_manager_enabled=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Open Browser       ${URL}    chrome    options=${options}

Login With Credentials
    [Arguments]    ${user_email}    ${user_password}
    Click Link         ${NAV_SIGN_IN}
    Wait Until Element Is Visible    ${INPUT_LOGIN_EMAIL}    10s
    Input Text         ${INPUT_LOGIN_EMAIL}       ${user_email}
    Input Text         ${INPUT_LOGIN_PASSWORD}    ${user_password}
    Click Button       ${BTN_LOGIN_SUBMIT}
    Wait Until Page Contains    ${MSG_DASHBOARD_CHECK}    10s