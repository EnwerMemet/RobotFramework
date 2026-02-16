*** Settings ***
Documentation     This is a test suite for the CRM application.    
Library           SeleniumLibrary

# run this code to execute the test suite:
#robot -d Results Tests/Crm.robot
*** Variables ***

*** Test Cases ***
Should be able to add new customer
    [Documentation]    This test case verifies that a new customer can be added successfully.    
    [Tags]             001    Smoke    Contacts
    log                Starting test case: Should be able to add new customer
    Open Browser       https://automationplayground.com/crm/login.html   gc
    Click Link         Sign In
    Sleep              2s
    Input Text    id=email-id    salam@email.com
    Close All Browsers
*** Keywords ***

