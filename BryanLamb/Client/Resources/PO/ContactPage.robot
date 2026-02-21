*** Settings ***
Resource          ../../Resources/Main.robot

*** Keywords ***
The client is on the landing page
    No Operation

The client should be able to click the Contact Link
    Click Link    ${Contact_Link}

The Contact page should be displayed correctly
    Page Should Contain    ${Header_Contact}

The client should be able to fill out the contact form
    Input Text    ${Name_Field}        John Doe
    Input Text    ${Email_Field}       john@secmail.com
    Input Text    ${phone_Field}       555-555-5555
    Input Text    ${Message_Field}     Hello, I am interested in your services. Please contact me.

The client should be able to submit the contact form
    Click Button    ${Submit_Button}
    Sleep    2s 



