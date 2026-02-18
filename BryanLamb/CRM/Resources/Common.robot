*** Settings ***
Resource          ../Resources/Main.robot
Library           OperatingSystem

*** Variables ***
${URL}            ${EMPTY}
${EMAIL}          ${EMPTY}
${PASSWORD}       ${EMPTY}

*** Keywords ***
Incognito Mode
    ${env_path}=    Join Path    ${CURDIR}    ..    .env
    ${env_path}=    Normalize Path    ${env_path}
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