*** Settings ***
Documentation     Full ABN AMRO Mortgage Calculator Test Suite for Single person
Library           SeleniumLibrary
Library           Collections
Library           DateTime
Resource          ../PageObjects/MortgageCalculatorPage.robot

Test Setup        Open Calculator Page
Test Teardown     Custom Teardown

*** Test Cases ***

TC-001 UI Elements Test
    [Documentation]    Technique: Smoke Testing. 
    ...                Verifies UI element visibility and measures page load performance.
    [Tags]    ui    smoke
    ${load_time}=    Evaluate    ${LOAD_TIME} - ${START_TIME}
    Log To Console    Page load time: ${load_time} seconds
    Element Should Be Visible    ${INCOME_FIELD}
    Element Should Be Visible    ${CALCULATE_BTN}
    Element Should Be Enabled    ${CALCULATE_BTN}

TC-002 Verify Mortgage Calculation Formula
    [Documentation]    Technique: Functional Validation. 
    ...                Ensures output matches the expected Dutch mortgage formula.
    [Tags]    functional    validation
    Fill Income    65000
    ${max_mortgage}=    Get Maximum Mortgage Amount
    ${monthly}=    Get Monthly Payment Amount
    Log To Console    Max Mortgage: ${max_mortgage}, Monthly: ${monthly}
    Validate Mortgage Calculation    65000    ${max_mortgage}    ${monthly}

TC-003 Clear And Recalculate
    [Documentation]    Technique: State Transition Testing. 
    ...                Verifies the calculator resets and updates correctly upon new input.
    [Tags]    functional
    Fill Income    65000
    Clear Income Field
    Fill Income    80000
    ${max}=    Get Maximum Mortgage Amount
    Should Not Be Empty    ${max}

TC-004 Boundary Values Test
    [Documentation]    Technique: Boundary Value Analysis (BVA). 
    ...                Tests the extreme low (0) and high (999,999) income limits.
    [Tags]    functional    boundary
    Fill Income    0
    ${res}=    Get Maximum Mortgage Amount
    Should Not Be Empty    ${res}
    Clear Income Field
    Fill Income    999999
    ${res}=    Get Maximum Mortgage Amount
    Should Not Be Empty    ${res}

TC-005 Different Income Amounts
    [Documentation]    Technique: Equivalence Partitioning & Data-Driven Testing. 
    ...                Tests representative income brackets using a data template.
    [Tags]    functional
    [Template]    Test Income Value
    10000
    50000
    100000

TC-006 Input Validation Tests
    [Documentation]    Technique: Negative Testing & Error Guessing. 
    ...                Verifies that non-integer/invalid inputs trigger correct error messages.
    [Tags]             validation    input
    [Template]         Verify Invalid Income Error
    ${EMPTY}         Gross annual income is required
    -                Gross annual income is required
    ABC              Gross annual income is required

TC-007 Responsive Design Test
    [Documentation]    Technique: Compatibility / Responsive Testing. 
    ...                Validates UI element accessibility across Mobile, Tablet, and Desktop viewports.
    [Tags]    ui    responsive
    Set Window Size    375    667
    Element Should Be Visible    ${INCOME_FIELD}
    Set Window Size    768    1024
    Element Should Be Visible    ${INCOME_FIELD}
    Set Window Size    1920    1080
    Element Should Be Visible    ${INCOME_FIELD}