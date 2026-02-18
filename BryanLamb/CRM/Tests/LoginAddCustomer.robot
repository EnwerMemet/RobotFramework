*** Settings ***
Documentation     Test CRM Customer Management - Gherkin Steps
Resource          ../Resources/Main.robot
Test Setup        Incognito Mode
Test Teardown     Close Browser

*** Variables ***
${XML_FILE_PATH}    ${CURDIR}${/}..${/}Resources${/}users.xml

*** Test Cases ***
Scenario: Admin should be able to login successfully
    [Tags]    001    Smoke
    Given the user is on the login page
    When the user logs in with valid credentials
    Then the dashboard should be visible

Scenario: Admin should be able to bulk add customers from an XML data source
    [Tags]    002    Functional
    Given the user is logged into the CRM system
    When the user imports and adds customers from "${XML_FILE_PATH}"
    Then all customers should be added successfully
