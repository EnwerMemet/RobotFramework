*** Settings ***
Library    SeleniumLibrary    run_on_failure=None
*** Variables ***
${url}    https://wise.com/us/currency-converter/
${cookie_accept}        id:twcc__accept-button
${currency_dropdown}    id:source-inputSelectedCurrency
${Search_Currency}      id:source-inputSelectedCurrencySearch
${Currensy}             INR
*** Test Cases ***
Check currency
    [Documentation]    This test case verifies that the currency conversion is working correctly on the website.
    Open Browser    ${url}    chrome
    Click Button    ${cookie_accept}
    Scroll Element Into View    locator=${currency_dropdown}
    Click Element    ${currency_dropdown}
    Input Text    ${Search_Currency}     ${Currensy}
    Sleep    2s
    Close Browser
*** Keywords ***
Set Currency
    [Arguments]    ${currency}
    Click Element    ${currency_dropdown}
    Input Text    ${currency_dropdown}    ${currency}