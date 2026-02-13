*** Settings ***
Documentation     ABN AMRO Mortgage Calculator Test Suite
Library           SeleniumLibrary
Library           Collections
Library           DateTime
Library           AllureLibrary
Resource          ../PageObjects/MortgageCalculatorPage.robot
Test Setup        Open Calculator Page

*** Keywords ***
Open Calculator Page
    Open Browser To Calculator
    Accept Cookies

*** Test Cases ***
TC-001 Accept Cookie Consent Banner
    [Documentation]    Accept the cookie consent banner to proceed with tests
    [Tags]    smoke    cookie
    Take Screenshot    TC001_cookies_accepted.png
    [Teardown]    Close Browser

TC-002 Enter Gross Annual Income
    [Documentation]    Enter a valid income amount
    [Tags]    functional    input
    Fill Income    65000
    Take Screenshot    TC002_income_entered.png
    [Teardown]    Close Browser

TC-003 Verify Maximum Mortgage Amount Displayed
    [Documentation]    Verify the maximum mortgage amount is shown after calculation
    Fill Income    65000
    ${max_mortgage}=    Get Maximum Mortgage Amount
    ${monthly}=    Get Monthly Payment Amount
    Log To Console    Maximum Mortgage: ${max_mortgage}
    Validate Mortgage Calculation    65000    ${max_mortgage}    ${monthly}
    Take Screenshot    TC003_max_mortgage.png

TC-004 Verify Monthly Payment Amount Displayed
    [Documentation]    Verify the monthly payment amount is shown after calculation
    Fill Income    65000
    ${max_mortgage}=    Get Maximum Mortgage Amount
    ${monthly}=    Get Monthly Payment Amount
    Log To Console    Monthly Payment: ${monthly}
    Validate Mortgage Calculation    65000    ${max_mortgage}    ${monthly}
    Take Screenshot    TC004_monthly_payment.png
    [Teardown]    Close Browser

TC-005 Clear Income Field And Recalculate
    [Documentation]    Clear the income field and enter a new value
    Fill Income    65000
    Clear Income Field
    Fill Income    80000
    Take Screenshot    TC005_recalculated.png
    [Teardown]    Close Browser

TC-006 Enter Different Income Amounts
    [Documentation]    Test calculation with various income amounts
    FOR    ${income}    IN    10000    50000    100000
        Clear Income Field
        Fill Income    ${income}
        Log To Console    Tested income: ${income}
    END
    Take Screenshot    TC006_different_incomes.png
    [Teardown]    Close Browser

TC-007 Enter Minimum Valid Income
    [Documentation]    Test with minimum income value
    Fill Income    0
    Take Screenshot    TC007_min_income.png
    [Teardown]    Close Browser

TC-008 Enter Maximum Income Value
    [Documentation]    Test with very high income value
    Fill Income    999999
    Take Screenshot    TC008_max_income.png
    [Teardown]    Close Browser

TC-009 Verify Calculation Formula
    [Documentation]    Verify the mortgage calculation follows expected formula
    Fill Income    65000
    ${max_mortgage_text}=    Get Maximum Mortgage Amount
    ${monthly_text}=    Get Monthly Payment Amount
    Log To Console    Max Mortgage: ${max_mortgage_text}, Monthly: ${monthly_text}
    Validate Mortgage Calculation    65000    ${max_mortgage_text}    ${monthly_text}
    Take Screenshot    TC009_formula_verification.png
    [Teardown]    Close Browser
    Take Screenshot    TC009_formula_verification.png

TC-010 Enter Non-Numeric Characters
    [Documentation]    Test input validation with non-numeric characters
    Fill Income    ABC
    Take Screenshot    TC010_non_numeric.png
    [Teardown]    Close Browser

TC-011 Enter Negative Income Value
    [Documentation]    Test input validation with negative income
    Fill Income    -5000
    Take Screenshot    TC011_negative.png
    [Teardown]    Close Browser

TC-012 Enter Very Large Income Value
    [Documentation]    Test input validation with extremely large income
    Fill Income    999999999
    Take Screenshot    TC012_very_large.png
    [Teardown]    Close Browser

TC-013 Leave Income Field Empty
    [Documentation]    Test validation when income field is empty
    Wait Until Element Is Visible    ${INCOME_FIELD}
    Sleep    3
    Take Screenshot    TC013_empty.png
    [Teardown]    Close Browser

TC-014 Enter Decimal Values
    [Documentation]    Test with decimal income values
    Fill Income    65000.50
    Take Screenshot    TC014_decimal.png
    [Teardown]    Close Browser

TC-015 Verify Page Load Time
    [Documentation]    Verify the page loads within acceptable time
    ${start_time}=    Get Current Date    result_format=epoch
    ${end_time}=    Get Current Date    result_format=epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    Log To Console    Page load time: ${load_time} seconds
    Should Be True    ${load_time} < 10
    Take Screenshot    TC015_page_load.png
    [Teardown]    Close Browser

TC-016 Verify All Input Fields Are Visible
    [Documentation]    Verify all required input fields are visible
    Wait Until Element Is Visible    ${INCOME_FIELD}
    Element Should Be Visible    ${INCOME_FIELD}
    Element Should Be Visible    ${CALCULATE_BTN}
    Take Screenshot    TC016_all_fields_visible.png
    [Teardown]    Close Browser

TC-017 Verify Calculate Button Is Enabled
    [Documentation]    Verify the Calculate button is enabled
    Wait Until Element Is Visible    ${CALCULATE_BTN}
    Element Should Be Enabled    ${CALCULATE_BTN}
    Take Screenshot    TC017_button_enabled.png
    [Teardown]    Close Browser

TC-018 Responsive Design Test
    [Documentation]    Test responsive design on different viewport sizes
    Set Window Size    375    667
    Take Screenshot    TC018_mobile.png
    Set Window Size    768    1024
    Take Screenshot    TC018_tablet.png
    Set Window Size    1920    1080
    Take Screenshot    TC018_desktop.png
    [Teardown]    Close Browser

