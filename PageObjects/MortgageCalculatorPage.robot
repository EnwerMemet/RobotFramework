*** Settings ***
Library    SeleniumLibrary
Library    String

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
${MONTHLY_PAYMENT}   xpath://dt[contains(., 'Gross monthly payment')]/following-sibling::dd//span[contains(@class, 'emc-sr-only')]

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

Calculate Expected Mortgage
    [Arguments]    ${income}    ${rate}=3.56    ${supp}=17000    ${energy}=10000
    ${n}=    Set Variable    360
    ${r}=    Evaluate    (${rate} / 100) / 12
    ${f}=    Evaluate    (${r} * (1 + ${r})**${n}) / ((1 + ${r})**${n} - 1)
    ${q}=    Set Variable    0.231
    ${total}=    Evaluate    ((${income} * ${q} / 12) / ${f}) + ${supp} + ${energy}
    ${max_mortgage}=    Evaluate    int(round(${total}))
    ${monthly_payment}=    Evaluate    int(round(${total} * ${f}))
    ${result}=    Create Dictionary    max_mortgage=${max_mortgage}    monthly_payment=${monthly_payment}
    RETURN    ${result}

Validate Mortgage Calculation
    [Arguments]    ${income}    ${actual_max_mortgage}    ${actual_monthly}
    ${expected}=    Calculate Expected Mortgage    ${income}
    ${actual_max}=    Remove String    ${actual_max_mortgage}    .
    ${actual_max}=    Remove String    ${actual_max}    euro
    ${actual_max}=    Convert To Integer    ${actual_max}
    ${actual_monthly}=    Remove String    ${actual_monthly}    .
    ${actual_monthly}=    Remove String    ${actual_monthly}    euro
    ${actual_monthly}=    Convert To Integer    ${actual_monthly}
    ${diff_max}=    Evaluate    abs(${actual_max} - ${expected['max_mortgage']})
    ${diff_monthly}=    Evaluate    abs(${actual_monthly} - ${expected['monthly_payment']})
    ${max_diff}=    Evaluate    ${expected['max_mortgage']} * 0.10
    ${monthly_diff}=    Evaluate    max(50, ${expected['monthly_payment']} * 0.20)
    Log To Console    Expected: Max=${expected['max_mortgage']}, Monthly=${expected['monthly_payment']}
    Log To Console    Actual: Max=${actual_max}, Monthly=${actual_monthly}
    Should Be True    ${diff_max} <= ${max_diff}    Max mortgage mismatch: expected ${expected['max_mortgage']}, got ${actual_max}
    Should Be True    ${diff_monthly} <= ${monthly_diff}    Monthly payment mismatch: expected ${expected['monthly_payment']}, got ${actual_monthly}
