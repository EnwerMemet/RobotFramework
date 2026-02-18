*** Settings ***
Resource          ../../Resources/Main.robot

*** Keywords ***
The client is on the landing page
    Log To Console    message: The client is on the landing page

The client should be able to click the Services Link
    Click Link    ${Services_Link} 

The Services page should be displayed correctly
    Page Should Contain    ${Header_Services} 


