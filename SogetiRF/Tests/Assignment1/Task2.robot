*** Settings ***
Documentation    This test suite verifies the functionality of E-commerse website. 
Library    SeleniumLibrary


*** Test Cases ***
Add an item to the cart and verify the item price
    [Documentation]    This test case verifies that the price of an item is displayed correctly on the website.
    Open Browser    https://topgeschenken.nl/    chrome
    Click Button    id=CookieConsentIOAccept
    Click Link    id=item-2909
    Wait Until Element Is Visible    css:#producten > :first-child
    Click Element    css:#producten > :first-child 
    ${price}=    Get Text    css:span.product-price
    Should Be Equal As Strings    ${price}    11,95
    Sleep    2s
    Close Browser
