*** Settings ***
Resource          ./Common.robot
Suite Setup       Start Suite         
Suite Teardown    Stop Test Suite
Test Setup        Login 
Test Teardown     Log    Test is completed. Closing the browser.

*** Variables ***
${BROWSER}           chrome
${URL}               https://www.saucedemo.com/
${L_USERNAME}        id:user-name
${L_PASSWORD}        id:password
${L_LOGIN_BTN}       id:login-button
${L_ADD_CART_BIKE}   id:add-to-cart-sauce-labs-bike-light

*** Test Cases ***
Test Login Functionality
    Page Should Contain    Sauce Labs Bike Light
    Click Button           ${L_ADD_CART_BIKE}

*** Keywords ***
Start Suite
    Open Browser In Incognito    ${URL}    ${BROWSER}   
    Maximize Browser Window
    Log To Console    message: Test Suite Has Started.

Login      
    Go To           ${URL}
    Input Text      ${L_USERNAME}    standard_user    
    Input Text      ${L_PASSWORD}    secret_sauce 
    Click Button    ${L_LOGIN_BTN}

Stop Test Suite
    Log To Console    Test Suite Has Ended.
    Close All Browsers