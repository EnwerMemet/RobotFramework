*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Main.robot

*** Variables ***


*** Test Cases ***
Login and Add to Cart
    Common.Open Website    ${URL}
    LoginPage.Login As standard_user
    CartPage.Add to cart