Documentation     Team Page - Test Cases
*** Settings ***
Resource          ../Resources/Main.robot
Test Setup        Common.Open Landing Page
Test Teardown     Common.Close Browser

*** Test Cases ***
Scenario: Client should be able to view the Team page
    [Documentation]    Verifies navigation from the landing page to the Team page.
    [Tags]    001    Smoke
    Log    message: Starting test case for Team page navigation
    Given TeamPage.The client is on the landing page
    When The client should be able to click the Team Link
    Then The Team page should be displayed correctly