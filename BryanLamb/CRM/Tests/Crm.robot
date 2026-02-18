*** Settings ***
Documentation     RF-Levle 1 - Section 5
Resource          ../Resources/Main.robot
Test Setup        Incognito Mode
Test Teardown     Close Browser


*** Test Cases ***
Should be able to login
    [Tags]             001    Smoke
    Login 

Should be able to add new customer
    [Tags]             002    Functional
    Login
    Add New Customer    tweety@parrot.com    Tweety    Bird    Amsterdam    AK    male


