*** Settings ***
Library             SeleniumLibrary        
Library             OperatingSystem
Library             XML
Library             Collections
Resource            Locators.robot
Resource            Common.robot
Resource            PO/AdminPage.robot
Resource            PO/LoginPage.robot
Resource            GherkinSteps/Login.robot
Resource            GherkinSteps/Customer.robot
