*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Get Post Info
    [Documentation]    Test case to get and verify post details.
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    /posts/1
    Log To Console    Status Code: ${response.status_code}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${json_body}=    To Json    ${response.text}
    Log To Console    ${json_body}

    ${title}=    Set Variable    ${json_body['title']}
    Log To Console    Title: ${title}
    Should Contain    ${title}    repellat
