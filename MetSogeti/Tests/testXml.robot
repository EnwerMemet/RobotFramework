*** Settings ***
Library           XML   user_lxml= ${True}

*** Test Cases ***
Test XML
    ${xml}=    Parse XML    source=data.xml
    ${users}=  Get Elements  source=${xml}    xpath=//user
    ${active_length}=    Get Length    ${users}
    Should Be Equal as integers    ${active_length}    4
*** Test Cases ***
Get First User Name
    ${xml}=    Parse XML    source=data.xml
    ${name}=    Get Element Text    ${xml}    user[2]/firstname
    Should Be Equal As Strings    ${name}    Enwer

