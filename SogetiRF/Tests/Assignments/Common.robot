*** Settings ***
Library    SeleniumLibrary    run_on_failure=None


*** Variables ***
${SauceDemo_URL}    https://www.saucedemo.com/
${chrome}           chrome
*** Keywords ***
Open Browser In Incognito
    [Arguments]    ${URL}    ${BROWSER}=chrome
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Log To Console    Test Has Started.

Test Setup
    [Arguments]    ${URL}    ${BROWSER} 
    Open Browser In Incognito    ${URL}    ${BROWSER}   
    Maximize Browser Window
    Log To Console    Test Has Started.

Test Teardown
    Log To Console    Test Has Ended.
    Close All Browsers

Login SauceDemo
    [Arguments]    ${L_USERNAME}    ${L_PASSWORD}    ${LOGIN_BTN}      ${URL}
    Input Text      ${L_USERNAME}    standard_user    
    Input Text      ${L_PASSWORD}    secret_sauce 
    Click Button    ${LOGIN_BTN}
    Location Should Be    ${URL}inventory.html
    Log To Console    Login Successful.
