*** Settings ***
Documentation     Use variables to store centralize data. 
Resource          ../Resources/Main.robot


*** Variables ***
${List_Of_Names}    Rob Smith    Jane Doe    John Doe

*** Test Cases ***
List Variable Example
    Log    ${List_Of_Names}
    Log    ${List_Of_Names}[0]
    Log    ${List_Of_Names}[1]
    Log    ${List_Of_Names}[2]
Scalar Variable Example
    @{List_Of_Names} =    Set Variable    Rob Smith    Jane Doe    John Doe
    Log    ${List_Of_Names}[0]
    Log    ${List_Of_Names}[1]
    Log    ${List_Of_Names}[2]

Best Practice Example - Use Create list for Lists
    @{List_Of_Names} =    Create List    Rob Smith    Jane Doe    John Doe
    Log    ${List_Of_Names}[0]
    Log    ${List_Of_Names}[1]
    Log    ${List_Of_Names}[2]
