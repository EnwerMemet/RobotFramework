*** Settings ***
Documentation     RF-Levle 1 - Section 5
Library           SeleniumLibrary
Test Teardown     Close Browser

*** Variables ***
${URL}            https://automationplayground.com/crm/login.html

*** Test Cases ***
Should be able to login
    [Tags]             001    Smoke
    Login 

Should be able to add new customer
    [Tags]             002    Contacts
    Login
    Add New Customers


*** Keywords ***
Login
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    ${prefs}=    Create Dictionary    credentials_enable_service=${False}    password_manager_enabled=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    
    Open Browser       ${URL}    chrome    options=${options}
    Click Link         Sign In
    Wait Until Element Is Visible    id=email-id    10s
    Input Text    id=email-id    salam@email.com
    Input Text    id=password    salam123
    Click Button    css:button[type="submit"]
    Wait Until Page Contains    Our Happy Customers    10s

Add New Customers
        Click Link         id=new-customer
    Wait Until Element Is Visible    xpath=//h2[text()='Add Customer']
    Input Text    css:input[type='email']    bryan.sogeti@example.com
    Input Text    id=FirstName    Bryan
    Input Text    id=LastName     Lamb
    Input Text    id=City         Sogeti
    Select From List By Value    id=StateOrRegion    AK
    Select Radio Button    gender    female
    Select Checkbox    name=promos-name
    Click Button       Submit
    Wait Until Page Contains     New customer added.     10s
    Sleep    2s