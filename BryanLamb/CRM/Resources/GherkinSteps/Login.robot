*** Settings ***
Documentation     Gherkin Steps for Login feature
Resource          ../Main.robot

*** Keywords ***
Given the user is on the login page
    No Operation

When the user logs in with valid credentials
    Login With Credentials    ${EMAIL}    ${PASSWORD}

Then the dashboard should be visible
    Page Should Contain    Our Happy Customers
