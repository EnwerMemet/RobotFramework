*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary




*** Variables ***
${base_url}    https://thetestingworldapi.com



*** Test Cases ***
First Test Case
    [Documentation]    Test case to get student details.
    Create Session    API_testing    ${base_url}
    ${response}=    GET On Session    API_testing    /api/studentsDetails/1001
    ${json_response}=    To Json    ${response.text}
    ${status_code}=    Convert To String    ${response.status_code}
    Log To Console    Status Code: ${status_code}
    Log To Console    Response: ${json_response}