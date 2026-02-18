*** Settings ***
Library           String

#robot -d Results demo.robot
*** Variables ***
${string}        dit is ook een string

*** Test Cases ***
Ik ga een string manupuleren
    VAR  ${string}       Ik ga een string manupuleren
    VAR  ${number}        2
    VAR  @{fruit}         appel    peer   banaan
    VAR  ${auto}          BMW      Audi   Mercedes
    ${new_string}    Convert To Upper Case    string=${string} 
    Should Be Equal    ${new_string}    IK GA EEN STRING MANUPULEREN 
