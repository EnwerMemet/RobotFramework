*** Settings ***
Library           String
Library           SeleniumLibrary
Library    ../../../.venv/lib/python3.12/site-packages/SeleniumLibrary/__init__.py

#robot -d Results demo.robot
*** Variables ***
${string}        dit is ook een string

*** Test Cases ***
Ik ga een string manupuleren
    VAR  ${string}       Ik ga een string manupuleren
    VAR  ${number}        2
    VAR  @{fruit}         appel    peer   banaan
    VAR  ${auto}          BMW      Audi   Mercedes
    ${new_string}    Convert To Upper Case    string=${string} 
    Should Be Equal    ${new_string}    IK GA EEN STRING MANUPULEREN 

Should be able to load Sogeti homepage
    [Documentation]    This test case verifies that website loaded successfully.    
    [Tags]             001    Smoke    Homepage
    log                Starting test case: Should be able to visit Sogeti homepage
    Open Sogeti Homepage

*** Keywords ***
Open Sogeti Homepage
    Log    Opening Sogeti homepage
    Open Browser    https://www.sogeti.com/    chrome
    Log    Sogeti homepage opened successfully
    Close All Browsers