*** Settings ***
Library           XML   user_lxml= ${True}

*** Test Cases ***
Testcase1a Get Parrot with the name Tweety
    ${xml}=    Parse XML    source=//data.xml
    ${name}=    Get Element Text    ${xml}    user[type='Parrot']/name
    Should Be Equal As Strings    ${name}     Tweety
Testcase1b Get Black Dog with the name Mr.Snuffles
    ${xml}=    Parse XML    source=data.xml
    ${name}=    Get Element Text    ${xml}    user[type='Black Dog']/name
    Should Be Equal As Strings    ${name}    Mr.Snuffles
Testcase1c Get the third user name
    ${xml}=    Parse XML    source=data.xml
    ${name}=    Get Element Text    ${xml}    user[3]/name
    Should Be Equal As Strings    ${name}     Rudy

Testcase1d Test XML user length
    ${xml}=    Parse XML    source=data.xml
    ${users}=  Get Elements  source=${xml}    xpath=//user
    ${active_length}=    Get Length    ${users}
    Should Be Equal as integers    ${active_length}    3

