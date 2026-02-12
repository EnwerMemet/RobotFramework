*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Get_Post_Info
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    /posts/1
    ${status_code}=  Convert To String    ${response.status_code}
    Log To Console    Status Code: ${status_code}
    Should Be Equal    ${status_code}    200

    ${json_body}=    To Json    ${response.text}
    Log To Console    ${json_body}

    ${title}=    Set Variable    ${json_body['title']}
    Log To Console    Title: ${title}
    Should Contain    ${title}    repellat
