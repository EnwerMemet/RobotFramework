*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary




*** Variables ***
${base_url}    https://thetestingworldapi.com



*** Test Cases ***
First_Test_Case
    Create Session    API_tesitng    ${base_url}
    ${response}=    GET On Session    API_tesitng    /api/studentsDetails/1001
    ${json_response}=    To Json    ${response}
    ${status_code}=  Convert To String    ${response.status_code}
    Log To Console    Status Code: ${status_code}