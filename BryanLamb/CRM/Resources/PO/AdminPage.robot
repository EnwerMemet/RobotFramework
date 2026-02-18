*** Settings ***
Documentation     Admin Page - Page Object
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

Import And Add Customers From Xml
    [Arguments]    ${path}
    ${xml_obj}=    Parse XML    ${path}
    @{users_list}=    Get Elements    ${xml_obj}    User
    FOR    ${user}    IN    @{users_list}
        ${mail}=      Get Element Text    ${user}    Email
        ${first}=     Get Element Text    ${user}    FirstName
        ${last}=      Get Element Text    ${user}    LastName
        ${city}=      Get Element Text    ${user}    City
        ${state}=     Get Element Text    ${user}    State
        ${gender}=    Get Element Text    ${user}    Gender
        Add New Customer    ${mail}    ${first}    ${last}    ${city}    ${state}    ${gender}
    END
