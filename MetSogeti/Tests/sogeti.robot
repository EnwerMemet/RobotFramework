*** Settings ***
Documentation     This is a test suite for the Sogeti website.    
Library           SeleniumLibrary

# run this code to execute the test suite:
#robot -d Results Tests/sogeti.robot
*** Variables ***

*** Test Cases ***
Should be able to load Sogeti homepage
    [Documentation]    This test case verifies that website loaded successfully.    
    [Tags]             001    Smoke    Homepage
    log                Starting test case: Should be able to add new customer
    Open Sogeti Homepage
*** Keywords ***
Open Sogeti Homepage
    Open Browser       https://www.sogeti.com/   gc
    Sleep              2s
    Close All Browsers
