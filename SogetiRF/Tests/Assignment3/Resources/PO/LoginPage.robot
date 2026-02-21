*** Settings ***
Documentation     Login Page - Page Object
Resource          ../Main.robot

*** Keywords ***
Login As Standard User
    Maximize Browser Window
    Title Should Be    ${HEADER_TITLE}
    Input Text    ${USER_NAME}    standard_user
    Input Text    ${PASSWORD}    secret_sauce
    Click Button    ${LOGIN_BUTTON}
    Page Should Contain    ${TITLE}
    Log    Successfully logged in as standard_user
