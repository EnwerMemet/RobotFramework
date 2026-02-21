*** Settings ***
Documentation    Assignment 3 
Library    SeleniumLibrary
Resource    ../Resources/Main.robot

*** Variables ***


*** Test Cases ***
Scenario: Login and add a product to the shopping cart
    [Tags]             003    Smoke    Cart
    Given The user has navigated to the SauceDemo website 
    When The user logs in as a "standard_user" 
    And The user adds the bike light to the cart
    Then The Bike should be added to the Cart