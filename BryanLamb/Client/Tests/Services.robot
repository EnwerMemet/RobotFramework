Documentation     Services Page - Test Cases
*** Settings ***
Resource          ../Resources/Main.robot
Test Setup        Common.Open Landing Page
*** Test Cases ***
Scenario: Client should be able to view the Services page
    [Tags]    001    Smoke
    Given ServicesPage.The client is on the landing page
    When The client should be able to click the Services Link
    Then The Services page should be displayed correctly