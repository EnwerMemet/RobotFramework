*** Settings ***
Documentation     Gherkin Steps for Customer Management feature
Resource          ../Main.robot

*** Keywords ***
Given the user is logged into the CRM system
    LoginPage.Login With Credentials    ${EMAIL}    ${PASSWORD}

When the user imports and adds customers from "${path}"
    AdminPage.Import And Add Customers From Xml    ${path}

Then all customers should be added successfully
    Wait Until Page Contains    ${MSG_CONFIRMATION}    10s
