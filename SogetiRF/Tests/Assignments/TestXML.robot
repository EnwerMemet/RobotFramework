*** Settings ***
Documentation    Read and validate XML data using the XML library in Robot Framework.
Library       XML   use_lxml=${True}
Library    ../../../.venv/lib/python3.12/site-packages/SeleniumLibrary/__init__.py
Suite Setup    Read XML

*** Variables ***
# Reads from root folder
${XML_PATH}    ${EXECDIR}${/}SogetiRF${/}Resources${/}data.xml

*** Test Cases ***
Testcase1a Get Parrot with the name Tweety
    [Documentation]    Assignment 1 - Testcase 1a
    ${name}=    Get Element Text    ${xml}    user[type='Parrot']/name
    Should Be Equal As Strings    ${name}     Tweety

Testcase1b Get Black Dog with the name Mr.Snuffles
    [Documentation]    Assignment 1 - Testcase 1b
    ${name}=    Get Element Text    ${xml}    user[type='Black Dog']/name
    Should Be Equal As Strings    ${name}    Mr.Snuffles

Testcase1c Get the third user name
    [Documentation]    Assignment 1 - Testcase 1c
    ${name}=    Get Element Text    ${xml}    user[3]/name
    Should Be Equal As Strings    ${name}     Rudy

Testcase1d Test XML user length
    [Documentation]    Assignment 1 - Testcase 1d
    ${users}=  Get Elements  ${xml}    user
    ${length}=    Get Length    ${users}
    Should Be Equal As Integers    ${length}    3

*** Keywords ***
Read XML
    ${temp_xml}=    Parse XML    ${XML_PATH}
    Set Suite Variable    ${xml}    ${temp_xml}