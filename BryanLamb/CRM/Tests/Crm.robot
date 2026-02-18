*** Settings ***
Documentation     RF-Level 1 - Section 5
Resource          ../Resources/Main.robot
Library           XML
Test Setup        Incognito Mode
Test Teardown     Close Browser

*** Variables ***
${XML_FILE_PATH}    ${CURDIR}/../Resources/users.xml

*** Test Cases ***
Should be able to login
    [Tags]             001    Smoke
    Login With Credentials    ${EMAIL}    ${PASSWORD}

Should be able to add new customer from XML
    [Tags]             002    Functional
    Login With Credentials    ${EMAIL}    ${PASSWORD}
    ${xml_obj}=    Parse XML    ${XML_FILE_PATH}
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
    