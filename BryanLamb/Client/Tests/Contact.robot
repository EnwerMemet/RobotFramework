Documentation     Contact Page - Test Cases
*** Settings ***
Resource          ../Resources/Main.robot
Test Setup        Common.Open Landing Page
*** Test Cases ***
Scenario: Client should be able to view the Contact page
    [Tags]    001    Smoke
    Given ContactPage.The client is on the landing page
    When The client should be able to click the Contact Link
    Then The Contact page should be displayed correctly

Scenario: Client should be able to fill and send the Contact form
    [Tags]    002    Smoke
    Given ContactPage.The client is on the landing page
    When The client should be able to click the Contact Link
    And The client should be able to fill out the contact form
    Then The client should be able to submit the contact form

    