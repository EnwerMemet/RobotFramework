Documentation    Basic API Testing
*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Quick Get Request Test
    Create Session    api_session    ${BASE_URL}    verify=${True}
    ${response}=      GET On Session    api_session    /users/2
    Should Be Equal As Strings    ${response.status_code}    200
    ${name}=          Get From Dictionary    ${response.json()}    name
    Log    message: The name of the user is ${name}
    Should Be Equal As Strings    ${name}    Ervin Howell
Quick POST Request Test
    Create Session    api_session    ${BASE_URL}    verify=${True}
    ${user_data}=     Create Dictionary     name=Enwer     username=tester
    ${header}=        Create Dictionary     Content-Type=application/json
    ${response}=      POST On Session    api_session    /users    json=${user_data}    headers=${header}
    Status Should Be    201    ${response}
    ${response_data}=    Set Variable    ${response.json()}
    Log    The response data is ${response_data}
    Should Be Equal As Strings    ${response_data}[name]    Enwer

Filter users With Query Parameters
    Create Session    api_session    ${BASE_URL}    verify=${True}
    ${query_params}=  Create Dictionary     username=Bret
    ${response}=      GET On Session    api_session    /users    params=${query_params}
    Should Be Equal As Strings    ${response.status_code}    200
    ${users}=         Set Variable    ${response.json()}
    ${First_User}=    Get From List    ${users}    0
    Log    The email of ${First_User}[username] is ${First_User}[email]

Verify API returns 404 for invalid users
    Create Session    api_session    ${BASE_URL}    verify=${True}
    ${response}=      GET On Session    api_session    /users/7777    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    404
    Log    Verified: The API correctly returns 404 for non-existent user with ID 7777