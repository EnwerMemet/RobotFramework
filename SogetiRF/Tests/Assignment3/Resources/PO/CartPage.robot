*** Settings ***
Documentation     Cart Page - Page Object
Resource          ../Main.robot

*** Keywords ***
Add To Cart
    Click Element    ${BOLT_SHIRT_IMG}
    Page Should Contain    Sauce Labs Bolt T-Shirt
    Page Should Contain    ${TSHIRT_PRICE}
    Click Button    ${ADD_TO_CART}

Verify Item Is Added To Cart
    Element Should Be Visible    ${REMOVE_BUTTON}
    Log    Successfully added Sauce Labs Bolt T-Shirt to the cart
