Documentation     Contact Page - Test Cases
*** Settings ***
Resource          ../Resources/Main.robot
Test Setup        Common.Open Landing Page
Test Teardown     Common.Close Browser

*** Test Cases ***
Scenario: Client should be able to view the Contact page
    [Documentation]    Verifies navigation from the landing page to the Contact page.
    [Tags]    001    Smoke
    Log    message: Starting test case for Contact page navigation
    Given ContactPage.The client is on the landing page
    When The client should be able to click the Contact Link
    Then The Contact page should be displayed correctly

Scenario: Client should be able to fill and send the Contact form
    [Documentation]    This test case verifies that the client can fill out and submit the contact form on the Contact page.
    [Tags]    002    Smoke
    Log    message: Starting test case for Contact form submission
    Given ContactPage.The client is on the landing page
    When The client should be able to click the Contact Link
    And The client should be able to fill out the contact form
    Then The client should be able to submit the contact form

    