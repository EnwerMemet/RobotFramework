*** Settings ***
Documentation     Gherkin Steps for SauceDemo
Resource          ../Main.robot

*** Keywords ***
Given The User Has Navigated To The SauceDemo Website
    Common.Open Website    ${URL}

When The User Logs In As A "standard_user"
    LoginPage.Login As Standard User

And The User Adds The Bike Light To The Cart
    CartPage.Add To Cart

The Bike should be added to the Cart
    CartPage.Verify Item Is Added To Cart
