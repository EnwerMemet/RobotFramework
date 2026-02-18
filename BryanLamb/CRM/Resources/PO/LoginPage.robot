*** Settings ***
Documentation     Login Page - Page Object
Resource          ../Main.robot

*** Keywords ***
Login With Credentials
    [Arguments]    ${user_email}    ${user_password}
    Enter Login Credentials    ${user_email}    ${user_password}
    Submit Login

Enter Login Credentials
    [Arguments]    ${email}    ${password}
    Click Link         ${NAV_SIGN_IN}
    Wait Until Element Is Visible    ${INPUT_LOGIN_EMAIL}    10s
    Input Text         ${INPUT_LOGIN_EMAIL}       ${email}
    Input Text         ${INPUT_LOGIN_PASSWORD}    ${password}

Submit Login
    Click Button       ${BTN_LOGIN_SUBMIT}
    Wait Until Page Contains    ${MSG_DASHBOARD_CHECK}    10s
