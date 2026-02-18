*** Settings ***
Documentation     RF-Levle 1 - Section 5
Library           SeleniumLibrary
Resource          ../../Resources/Common.robot
Resource          ../../Resources/Locators.robot


*** Keywords ***
Add New Customer
    [Arguments]    ${email}    ${first_name}    ${last_name}    ${city}    ${state}    ${gender}
    Click Link                       ${NAV_NEW_CUSTOMER}
    Wait Until Element Is Visible    ${HEADER_ADD_CUSTOMER}
    Input Text                       ${INPUT_EMAIL}        ${email}
    Input Text                       ${INPUT_FIRSTNAME}    ${first_name}
    Input Text                       ${INPUT_LASTNAME}     ${last_name}
    Input Text                       ${INPUT_CITY}         ${city}
    Select From List By Value        ${SELECT_STATE}       ${state}
    Select Radio Button              ${RADIO_GENDER}       ${gender}
    Select Checkbox                  ${CHECKBOX_PROMO}
    Click Button                     ${BTN_SUBMIT}
    Wait Until Page Contains         ${MSG_CONFIRMATION}    10s

