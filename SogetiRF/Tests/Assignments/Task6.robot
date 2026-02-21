*** Settings ***
Documentation     Assignment 6 
Resource          ./Common.robot
Suite Setup       Log     Test Suite Has Started.         
Suite Teardown    Log     Test Suite Has Stopt.
Test Setup        Test Setup 
Test Teardown     Test Teardown

*** Variables ***
${BROWSER}           chrome
${URL}               https://www.saucedemo.com/
${L_USERNAME}        id:user-name
${L_PASSWORD}        id:password
${L_LOGIN_BTN}       id:login-button

*** Test Cases ***
Test Login Functionality
    [Tags]    Smoke    Functionality
    Login 

*** Keywords ***
Test Setup
    Open Browser In Incognito    ${URL}    ${BROWSER}   
    Maximize Browser Window
    Log To Console    Test Has Started.

Login      
    Input Text      ${L_USERNAME}    standard_user    
    Input Text      ${L_PASSWORD}    secret_sauce 
    Click Button    ${L_LOGIN_BTN}
    Page Should Contain    Sauce Labs Bike Light
    Location Should Be     ${URL}inventory.html
    Log  To Console        Login Successful.

Test Teardown
    Log To Console    Test Has Ended.
    Close All Browsers