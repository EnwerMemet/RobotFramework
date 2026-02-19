*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Main.robot

*** Variables ***


*** Test Cases ***
Login and Add to Cart
    Open Website    ${URL}
    Login As standard_user
    Add to cart