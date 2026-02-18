*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
*** Variables ***
${URL}            https://automationplayground.com/front-office/

*** Keywords ***


Open Landing Page
    Open Browser    ${URL}    chrome

