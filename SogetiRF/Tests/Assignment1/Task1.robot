*** Settings ***
Documentation    Read and validate XML data using the XML library in Robot Framework.
Library       XML   use_lxml=${True}
Suite Setup    Read XML

*** Variables ***
# Reads from root folder
${XML_PATH}    ${EXECDIR}${/}SogetiRF${/}Resources${/}data.xml

*** Test Cases ***
Testcase1a Get Parrot with the name Tweety
    ${name}=    Get Element Text    ${xml}    user[type='Parrot']/name
    Should Be Equal As Strings    ${name}     Tweety

Testcase1b Get Black Dog with the name Mr.Snuffles
    ${name}=    Get Element Text    ${xml}    user[type='Black Dog']/name
    Should Be Equal As Strings    ${name}    Mr.Snuffles

Testcase1c Get the third user name
    ${name}=    Get Element Text    ${xml}    user[3]/name
    Should Be Equal As Strings    ${name}     Rudy

Testcase1d Test XML user length
    ${users}=  Get Elements  ${xml}    user
    ${length}=    Get Length    ${users}
    Should Be Equal As Integers    ${length}    3

*** Keywords ***
Read XML
    ${temp_xml}=    Parse XML    ${XML_PATH}
    Set Suite Variable    ${xml}    ${temp_xml}