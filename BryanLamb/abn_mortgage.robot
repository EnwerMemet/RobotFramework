*** Settings ***
Documentation     A script to calculate maximum mortgage on the ABN AMRO site.
Library           SeleniumLibrary

*** Variables ***
${URL}               https://www.abnamro.nl/en/personal/mortgages/mortgage-calculator/index.html
${BROWSER}           chrome
# Professional Tip: Use CSS or XPath for elements without stable IDs
${COOKIE_ACCEPT}     id:onetrust-accept-btn-handler
${INCOME_FIELD}      css:input[name="income_1"]
${CALCULATE_BTN}     xpath://button[contains(., 'Calculate')]

*** Test Cases ***
Calculate Mortgage Scenario
    [Setup]    Open Browser To Calculator
    Accept Cookies
    Fill Income Data    65000
    Trigger Calculation
    Verify Results Appear
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Calculator
    # Opens browser and ensures we can see the elements
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5 seconds

Accept Cookies
    # Wait for the overlay to appear before clicking
    Wait Until Element Is Visible    ${COOKIE_ACCEPT}    15s
    Click Element    ${COOKIE_ACCEPT}
    # Wait for the cookie overlay to actually disappear
    Wait Until Element Is Not Visible    ${COOKIE_ACCEPT}

Fill Income Data
    [Arguments]    ${amount}
    # Using Clear Element Text first to ensure the field is empty
    Wait Until Element Is Visible    ${INCOME_FIELD}
    Input Text    ${INCOME_FIELD}    ${amount}

Trigger Calculation
    Click Element    ${CALCULATE_BTN}

Verify Results Appear
    # We check if the result container becomes visible
    Wait Until Page Contains    Maximum mortgage    10s
    Capture Page Screenshot    mortgage_result.png