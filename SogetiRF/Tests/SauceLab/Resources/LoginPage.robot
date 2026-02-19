*** Settings ***
Resource    ../Resources/Main.robot

*** Variables ***


*** Keywords ***
Login As standard_user
    Maximize Browser Window
    Title Should Be    ${header_title}
    Input Text    ${user_name}    standard_user
    Input Text    ${password}    secret_sauce
    Click Button    ${login_button}
    Page Should Contain    ${title}
    Log    Successfully logged in as standard_user






