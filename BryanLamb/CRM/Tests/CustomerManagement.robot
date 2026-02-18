*** Settings ***
Documentation     RF-Level 1 - Section 5
Resource          ../Resources/Main.robot
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
    Import And Add Customers From Xml    ${XML_FILE_PATH}
