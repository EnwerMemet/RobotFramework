*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.saucedemo.com/
${header_title}    Swag Labs
${user_name}    id=user-name
${password}    id=password
${login_button}    id=login-button
${title}     Products
${BOLT_SHIRT_IMG}    css:img[data-test="inventory-item-sauce-labs-bolt-t-shirt-img"]
${Tshirt_Price}=    15.99
${add-to-cart}    id=add-to-cart
${remove}    id=remove