*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections


*** Variables ***
${base_url}    https://jsonplaceholder.typicode.com


*** Test Cases ***
Verify a Single Post
    [Documentation]    Test case to get and verify the details of a single post.
    Create Session    first_test    ${base_url}
    ${response}=    GET On Session    first_test    /posts/1
    
    Status Should Be    200    ${response}
    
    ${json_body}=    To JSON    ${response.text}
    Log    JSON Body: ${json_body}
    
    Should Contain    ${json_body}[title]    repellat
    Should Be Equal As Strings    ${json_body}[userId]    1


Create a New Post
    [Documentation]    Test case to create a new post via a POST request.
    Create Session    create_post_session    ${base_url}
    
    &{post_body}=    Create Dictionary
    ...    title=foo
    ...    body=bar
    ...    userId=1
    
    ${response}=    POST On Session    create_post_session    /posts    json=&{post_body}
    
    Status Should Be    201    ${response}
    
    ${body}=    To JSON    ${response.text}
    
    Should Be Equal As Strings    ${body}[id]    101
    Should Be Equal As Strings    ${body}[title]    foo