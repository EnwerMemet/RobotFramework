*** Settings ***
Library    CalculatorLibrary.py

*** Test Cases ***
Test Addition
    ${sum} =    Add Numbers    5    3
    Should Be Equal As Numbers    ${sum}    8