*** Settings ***
Resource          ../Resources/Common.robot


*** Keywords ***
Add to cart
    Click Element    ${BOLT_SHIRT_IMG}
    Page Should Contain    Sauce Labs Bolt T-Shirt
    Page Should Contain    ${Tshirt_Price}
    Click Button    ${add-to-cart}
    Element Should Be Visible    ${remove}
    Log    Successfully added Sauce Labs Bolt T-Shirt to the cart