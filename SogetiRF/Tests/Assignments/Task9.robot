*** Settings ***
Documentation    Assignment 9 - Verify the titles of the products on the Products page.
Library          SeleniumLibrary    run_on_failure=None
Resource         ./Common.robot
Resource         ./Locators.robot
Test Setup       Open Browser In Incognito    ${SauceDemo_URL}     ${chrome} 
Test Teardown    Close All Browsers

*** Variables ***
@{PRODUCT_ITEMS}    Sauce Labs Backpack    Sauce Labs Bike Light    
...                 Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    
...                 Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)
${Item_name}    css:div.inventory_item_name

*** Test Cases ***
Verify Titles of Products
    [Tags]    009    Smoke    Products
    Login SauceDemo    ${USERNAME}    ${PASSWORD}    ${LOGIN_BUTTON}    ${SauceDemo_URL}
    Verify Product Titles    ${PRODUCT_ITEMS}    ${Item_name} 

*** Keywords ***
Verify Product Titles
    [Arguments]    ${List}    ${Locator_Selector}
    # Fetch the elements to create a "list-like" object for the loop
    ${Elements}=    Get WebElements    ${Locator_Selector}
    
    FOR    ${item}    IN    @{List}
        FOR    ${El}    IN    @{Elements}
            ${title}=    Get Text    ${El}
            IF    "${title}" == "${item}"
                Log To Console    Product Title: ${item}
            END
        END
    END