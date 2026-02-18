Documentation     Team Page - Test Cases
*** Settings ***
Resource          ../Resources/Main.robot
Test Setup        Common.Open Landing Page
*** Test Cases ***
Scenario: Client should be able to view the Team page
    [Tags]    001    Smoke
    Given TeamPage.The client is on the landing page
    When The client should be able to click the Team Link
    Then The Team page should be displayed correctly