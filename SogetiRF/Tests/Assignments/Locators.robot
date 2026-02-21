*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                https://www.saucedemo.com/
${HEADER_TITLE}      Swag Labs
${USER_NAME}         id=user-name
${PASSWORD}          id=password
${LOGIN_BUTTON}      id=login-button
${TITLE}              Products
${BOLT_SHIRT_IMG}    css:img[data-test="inventory-item-sauce-labs-bolt-t-shirt-img"]
${TSHIRT_PRICE}      15.99
${ADD_TO_CART}       id=add-to-cart
${REMOVE_BUTTON}     id=remove
