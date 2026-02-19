*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
*** Variables ***
${URL}            https://automationplayground.com/front-office/

*** Keywords ***


Open Landing Page
    Open Browser    ${URL}    chrome
    Maximize Browser Window

Close Browser
    Close All Browsers