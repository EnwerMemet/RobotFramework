*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${L_username}    id=user-name
${L_password}     id=password
${login_button}    id=login-button
*** Test Cases ***
Login to the website
    [Documentation]    This test case verifies that user can login to the website successfully.
    # Skip    Skipping this test because I am debugging another part.
    Open Browser    https://www.saucedemo.com/    chrome
    Login to Sauce Demo Website    user_name=standard_user    password=secret_sauce
    Sleep    2s
    Close Browser


Test Currency Conversion
    [Documentation]     Assignment 4
    ${Result}=    Check Currency    USD    EUR    100
    Log To Console    Converted amount: ${Result} EUR
    ${Result}=    Check Currency    USD    GBP    100
    Log To Console    Converted amount: ${Result} GBP
    ${Result}=    Check Currency    GBP    EUR    100
    Log To Console    Converted amount: ${Result} EUR


Test title of the page
    [Documentation]     Assignment 5
    ${Actual_Title}=   Retrive the title of the page    https://www.saucedemo.com/    chrome    class:login_logo
    Should Be Equal As Strings    ${Actual_Title}    Swag Labs
    
    
*** Keywords ***
Login to Sauce Demo Website
    [Arguments]    ${user_name}    ${password}    
    Maximize Browser Window
    Title Should Be    Swag Labs
    Input Text    ${L_username}   ${user_name}    
    Input Text    ${L_password}      ${password}  
    Click Button    ${login_button}
    Log    Successfully logged in as standard_user


Check Currency
    [Arguments]   ${Currency1}    ${Currency2}   ${Amount}
    IF  '${Currency1}' == 'USD' and '${Currency2}' == 'EUR'
        ${Converted_amount}=    Evaluate    ${Amount} * 0.85
        Should be Equal As Numbers    ${Converted_amount}    85
        RETURN    ${Converted_amount} 
    ELSE IF   '${Currency1}' == 'USD' and '${Currency2}' == 'GBP'
        ${Converted_amount}=    Evaluate    ${Amount} * 0.74
        Should Be Equal As Numbers    ${Converted_amount}    74
        RETURN    ${Converted_amount} 
    ELSE IF   '${Currency1}' == 'GBP' and '${Currency2}' == 'EUR'
        ${Converted_amount}=    Evaluate    ${Amount} * 1.1425
        Should Be Equal As Numbers    ${Converted_amount}    114.25
        RETURN    ${Converted_amount} 
    ELSE
        Log    Conversion not supported    WARN
    END



Retrive the title of the page
    [Arguments]     ${URL}        ${Browser}      ${Locator}
    Open Browser    ${URL}    ${Browser} 
    ${Title}=  Get Text    ${Locator}
    Log To Console    message: ${Title}
    RETURN    ${Title}

        
