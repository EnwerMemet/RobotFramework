*** Settings ***
Resource          ../../Resources/Main.robot

*** Keywords ***
The client is on the landing page
    Log To Console    message: The client is on the landing page

The client should be able to click the Team Link
    Click Link    Team

The Team page should be displayed correctly
    Page Should Contain    Our Amazing Team


