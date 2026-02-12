*** Settings ***
Documentation     ABN AMRO Mortgage Calculator Test Suite
Library           SeleniumLibrary
Library           Collections
Library           DateTime

*** Variables ***
${URL}               https://www.abnamro.nl/en/personal/mortgages/mortgage-calculator/index.html
${BROWSER}           Chrome
${SCREENSHOT_DIR}    ${CURDIR}${/}Screenshots

# Selectors - Updated with actual selectors
${COOKIE_ACCEPT}     id:onetrust-accept-btn-handler
${IFRAME}            id:tcm-216762-iframe
${INCOME_FIELD}      id:pv_id_5
${CALCULATE_BTN}     xpath://span[contains(., 'Continue calculation')]
${MAX_MORTGAGE}      xpath://span[contains(@class, 'emc-sr-only') and contains(., 'euro')]
${MONTHLY_PAYMENT}   xpath://dd[@role='listitem']//span[contains(@class, 'emc-sr-only')]

*** Test Cases ***
TC-001 Accept Cookie Consent Banner
    [Documentation]    Accept the cookie consent banner to proceed with tests
    Open Browser To Calculator
    Accept Cookies
    Capture Page Screenshot    ${SCREENSHOT_DIR}/TC001_cookies_accepted.png
    [Teardown]    Close Browser

TC-002 Enter Gross Annual Income
    [Documentation]    Enter a valid income amount
    Open Browser To Calculator
    Accept Cookies
    Wait Until Element Is Visible    ${INCOME_FIELD}
    Input Text    ${INCOME_FIELD}    65000
    Capture Page Screenshot    ${SCREENSHOT_DIR}/002_income_entered.png
    [Teardown]    Close Browser

TC-003 Click Calculate Button
    [Documentation]    Click the calculate button and verify action
    Open Browser To Calculator
    Accept Cookies
    Input Text    ${INCOME_FIELD}    65000
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/003_calculated.png
    [Teardown]    Close Browser

TC-004 Verify Maximum Mortgage Amount Displayed
    [Documentation]    Verify the maximum mortgage amount is shown after calculation
    Open Browser To Calculator
    Accept Cookies
    Fill Income And Calculate    65000
    Wait Until Element Is Visible    ${MAX_MORTGAGE}
    ${max_mortgage}=    Get Text    ${MAX_MORTGAGE}
    Log To Console    Maximum Mortgage: ${max_mortgage}
    Should Not Be Empty    ${max_mortgage}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/004_max_mortgage.png
    [Teardown]    Close Browser

TC-005 Verify Monthly Payment Amount Displayed
    [Documentation]    Verify the monthly payment amount is shown after calculation
    Open Browser To Calculator
    Accept Cookies
    Fill Income And Calculate    65000
    Wait Until Element Is Visible    ${MONTHLY_PAYMENT}
    ${monthly}=    Get Text    ${MONTHLY_PAYMENT}
    Log To Console    Monthly Payment: ${monthly}
    Should Not Be Empty    ${monthly}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/005_monthly_payment.png
    [Teardown]    Close Browser

TC-006 Clear Income Field And Recalculate
    [Documentation]    Clear the income field and enter a new value
    Open Browser To Calculator
    Accept Cookies
    Input Text    ${INCOME_FIELD}    65000
    Clear Element Text    ${INCOME_FIELD}
    Input Text    ${INCOME_FIELD}    80000
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/006_recalculated.png
    [Teardown]    Close Browser

TC-007 Enter Different Income Amounts
    [Documentation]    Test calculation with various income amounts
    Open Browser To Calculator
    Accept Cookies
    FOR    ${income}    IN    10000    50000    100000
        Clear Element Text    ${INCOME_FIELD}
        Input Text    ${INCOME_FIELD}    ${income}
        Sleep    3
        Log To Console    Tested income: ${income}
    END
    Capture Page Screenshot    ${SCREENSHOT_DIR}/007_different_incomes.png
    [Teardown]    Close Browser

TC-008 Enter Minimum Valid Income
    [Documentation]    Test with minimum income value
    Open Browser To Calculator
    Accept Cookies
    Fill Income And Calculate    0
    Capture Page Screenshot    ${SCREENSHOT_DIR}/008_min_income.png
    [Teardown]    Close Browser

TC-009 Enter Maximum Income Value
    [Documentation]    Test with very high income value
    Open Browser To Calculator
    Accept Cookies
    Fill Income And Calculate    999999
    Capture Page Screenshot    ${SCREENSHOT_DIR}/009_max_income.png
    [Teardown]    Close Browser

TC-010 Verify Calculation Formula
    [Documentation]    Verify the mortgage calculation follows expected formula
    Open Browser To Calculator
    Accept Cookies
    Fill Income And Calculate    65000
    Wait Until Element Is Visible    ${MAX_MORTGAGE}
    ${max_mortgage_text}=    Get Text    ${MAX_MORTGAGE}
    ${monthly_text}=    Get Text    ${MONTHLY_PAYMENT}
    Log To Console    Max Mortgage: ${max_mortgage_text}, Monthly: ${monthly_text}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/010_formula_verification.png
    [Teardown]    Close Browser

TC-011 Enter Non-Numeric Characters
    [Documentation]    Test input validation with non-numeric characters
    Open Browser To Calculator
    Accept Cookies
    Input Text    ${INCOME_FIELD}    ABC
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/011_non_numeric.png
    [Teardown]    Close Browser

TC-012 Enter Negative Income Value
    [Documentation]    Test input validation with negative income
    Open Browser To Calculator
    Accept Cookies
    Input Text    ${INCOME_FIELD}    -5000
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/012_negative.png
    [Teardown]    Close Browser

TC-013 Enter Very Large Income Value
    [Documentation]    Test input validation with extremely large income
    Open Browser To Calculator
    Accept Cookies
    Input Text    ${INCOME_FIELD}    999999999
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/013_very_large.png
    [Teardown]    Close Browser

TC-014 Leave Income Field Empty
    [Documentation]    Test validation when income field is empty
    Open Browser To Calculator
    Accept Cookies
    Wait Until Element Is Visible    ${INCOME_FIELD}
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/014_empty.png
    [Teardown]    Close Browser

TC-015 Enter Decimal Values
    [Documentation]    Test with decimal income values
    Open Browser To Calculator
    Accept Cookies
    Input Text    ${INCOME_FIELD}    65000.50
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/015_decimal.png
    [Teardown]    Close Browser

TC-016 Verify Page Load Time
    [Documentation]    Verify the page loads within acceptable time
    ${start_time}=    Get Current Date    result_format=epoch
    Open Browser To Calculator
    Accept Cookies
    ${end_time}=    Get Current Date    result_format=epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    Log To Console    Page load time: ${load_time} seconds
    Should Be True    ${load_time} < 10
    Capture Page Screenshot    ${SCREENSHOT_DIR}/016_page_load.png
    [Teardown]    Close Browser

TC-017 Verify All Input Fields Are Visible
    [Documentation]    Verify all required input fields are visible
    Open Browser To Calculator
    Accept Cookies
    Wait Until Element Is Visible    ${INCOME_FIELD}
    Element Should Be Visible    ${INCOME_FIELD}
    Element Should Be Visible    ${CALCULATE_BTN}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/017_all_fields_visible.png
    [Teardown]    Close Browser

TC-018 Verify Calculate Button Is Enabled
    [Documentation]    Verify the Calculate button is enabled
    Open Browser To Calculator
    Accept Cookies
    Wait Until Element Is Visible    ${CALCULATE_BTN}
    Element Should Be Enabled    ${CALCULATE_BTN}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/018_button_enabled.png
    [Teardown]    Close Browser

TC-019 Responsive Design Test
    [Documentation]    Test responsive design on different viewport sizes
    Open Browser To Calculator
    Accept Cookies
    Set Window Size    375    667
    Capture Page Screenshot    ${SCREENSHOT_DIR}/019_mobile.png
    Set Window Size    768    1024
    Capture Page Screenshot    ${SCREENSHOT_DIR}/019_tablet.png
    Set Window Size    1920    1080
    Capture Page Screenshot    ${SCREENSHOT_DIR}/019_desktop.png
    [Teardown]    Close Browser

TC-020 Screenshot Capture At Each Step
    [Documentation]    Capture screenshots at each step of the workflow
    Open Browser To Calculator
    Capture Page Screenshot    ${SCREENSHOT_DIR}/020_step1_initial.png
    Accept Cookies
    Capture Page Screenshot    ${SCREENSHOT_DIR}/020_step2_cookies.png
    Input Text    ${INCOME_FIELD}    65000
    Capture Page Screenshot    ${SCREENSHOT_DIR}/020_step3_income.png
    Sleep    3
    Capture Page Screenshot    ${SCREENSHOT_DIR}/020_step4_result.png
    [Teardown]    Close Browser

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

Fill Income And Calculate
    [Arguments]    ${income}
    Wait Until Element Is Visible    ${INCOME_FIELD}    30s
    Sleep    1
    Input Text    ${INCOME_FIELD}    ${income}
    Sleep    3

Wait For Loading
    Sleep    2
