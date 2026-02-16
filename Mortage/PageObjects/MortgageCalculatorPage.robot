*** Settings ***
Library           SeleniumLibrary
Library           String
Library           OperatingSystem

*** Variables ***
${URL}               https://www.abnamro.nl/en/personal/mortgages/mortgage-calculator/index.html
${BROWSER}           Chrome
${SCREENSHOT_DIR}    ${CURDIR}${/}Screenshots
${COOKIE_ACCEPT}     id:onetrust-accept-btn-handler
${IFRAME}            id:tcm-216762-iframe
${RADIO_ALONE}       id:is-joint-false
${INCOME_FIELD}      id:pv_id_5
${CALCULATE_BTN}     xpath://span[contains(., 'Continue calculation')]
${MAX_MORTGAGE}      xpath://span[contains(@class, 'emc-sr-only') and contains(., 'euro')]
${MONTHLY_PAYMENT}   xpath://dt[contains(., 'Gross monthly payment')]/following-sibling::dd//span[contains(@class, 'emc-sr-only')]
${ERROR_MESSAGE}     xpath://div[@data-p='error']

*** Keywords ***

Open Calculator Page
    Create Directory    ${SCREENSHOT_DIR}
    ${start_time}=    Get Time    epoch
    Open Browser        ${URL}    ${BROWSER}
    ${end_time}=    Get Time    epoch
    Set Test Variable    ${START_TIME}    ${start_time}
    Set Test Variable    ${LOAD_TIME}    ${end_time}
    Maximize Browser Window
    Set Selenium Speed  0.5 seconds
    Accept Cookies
    Select Borrowing Alone

Accept Cookies
    Wait Until Element Is Visible    ${COOKIE_ACCEPT}    15s
    Click Element                    ${COOKIE_ACCEPT}
    Select Frame                     ${IFRAME}

Select Borrowing Alone
    [Documentation]    Selects the 'Alone' option.
    Wait Until Element Is Visible    ${RADIO_ALONE}    10s
    Sleep    1
    Execute JavaScript    document.querySelector('[id="is-joint-false"]').click()
Fill Income
    [Arguments]    ${income}
    Wait Until Element Is Visible    ${INCOME_FIELD}    30s
    Input Text                       ${INCOME_FIELD}    ${income}
    Sleep                            2

Get Maximum Mortgage Amount
    Wait Until Element Is Visible    ${MAX_MORTGAGE}
    ${res}=    Get Text    ${MAX_MORTGAGE}
    RETURN     ${res}

Get Monthly Payment Amount
    Wait Until Element Is Visible    ${MONTHLY_PAYMENT}
    ${res}=    Get Text    ${MONTHLY_PAYMENT}
    RETURN     ${res}

Calculate Expected Mortgage
    [Arguments]    ${income}
    ${n}=    Set Variable    360
    ${r}=    Evaluate    (3.56 / 100) / 12
    ${f}=    Evaluate    (${r} * (1 + ${r})**${n}) / ((1 + ${r})**${n} - 1)
    ${q}=    Set Variable    0.231
    ${total}=    Evaluate    ((${income} * ${q} / 12) / ${f}) + 27000
    ${max}=      Evaluate    int(round(${total}))
    ${pay}=      Evaluate    int(round(${total} * ${f}))
    ${res}=      Create Dictionary    max_mortgage=${max}    monthly_payment=${pay}
    RETURN       ${res}

Validate Mortgage Calculation
    [Arguments]    ${income}    ${actual_max}    ${actual_pay}
    ${expected}=    Calculate Expected Mortgage    ${income}
    ${clean_max}=    Remove String    ${actual_max}    .    euro    ${SPACE}
    ${val_max}=      Convert To Integer    ${clean_max}
    Should Be True    abs(${val_max} - ${expected['max_mortgage']}) <= (${expected['max_mortgage']} * 0.10)

Verify Invalid Income Error
    [Arguments]    ${input}    ${err}
    Clear Element Text    ${INCOME_FIELD}
    Input Text            ${INCOME_FIELD}    ${input}
    Press Keys            ${INCOME_FIELD}    TAB
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    ${text}=    Get Text    ${ERROR_MESSAGE}
    Should Be Equal As Strings    ${text}    ${err}

Clear Income Field
    Clear Element Text    ${INCOME_FIELD}

Test Income Value
    [Arguments]    ${income}
    Clear Income Field
    Fill Income    ${income}
    ${max_mortgage}=    Get Maximum Mortgage Amount
    Should Not Be Empty    ${max_mortgage}
    Log To Console    Tested income: ${income}, Max mortgage: ${max_mortgage}

Custom Teardown
    Run Keyword If Test Failed    Capture Page Screenshot    ${SCREENSHOT_DIR}/FAIL_${TEST_NAME}.png
    Close Browser
