*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}               https://www.abnamro.nl/en/personal/mortgages/mortgage-calculator/index.html
${BROWSER}           Chrome
${SCREENSHOT_DIR}    ${CURDIR}${/}Screenshots

# Selectors
${COOKIE_ACCEPT}     id:onetrust-accept-btn-handler
${IFRAME}            id:tcm-216762-iframe
${INCOME_FIELD}      id:pv_id_5
${CALCULATE_BTN}     xpath://span[contains(., 'Continue calculation')]
${MAX_MORTGAGE}      xpath://span[contains(@class, 'emc-sr-only') and contains(., 'euro')]
${MONTHLY_PAYMENT}   xpath://dd[@role='listitem']//span[contains(@class, 'emc-sr-only')]

*** Keywords ***
Open Browser To Calculator
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5 seconds

Accept Cookies
    Wait Until Element Is Visible    ${COOKIE_ACCEPT}    15s
    Click Element    ${COOKIE_ACCEPT}
    Wait Until Element Is Not Visible    ${COOKIE_ACCEPT}
    Select Frame    ${IFRAME}

Fill Income
    [Arguments]    ${income}
    Wait Until Element Is Visible    ${INCOME_FIELD}    30s
    Sleep    1
    Input Text    ${INCOME_FIELD}    ${income}
    Sleep    3

Get Maximum Mortgage Amount
    Wait Until Element Is Visible    ${MAX_MORTGAGE}
    ${amount}=    Get Text    ${MAX_MORTGAGE}
    RETURN    ${amount}

Get Monthly Payment Amount
    Wait Until Element Is Visible    ${MONTHLY_PAYMENT}
    ${amount}=    Get Text    ${MONTHLY_PAYMENT}
    RETURN    ${amount}

Clear Income Field
    Clear Element Text    ${INCOME_FIELD}

Take Screenshot
    [Arguments]    ${filename}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/${filename}
