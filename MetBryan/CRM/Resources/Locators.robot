*** Settings ***
Library           SeleniumLibrary

*** Variables ***
#Homepage
${URL}                        https://automationplayground.com/crm/login.html
${NAV_SIGN_IN}                Link=Sign In

#Addmin Page
${NAV_NEW_CUSTOMER}           id=new-customer
${HEADER_ADD_CUSTOMER}        xpath=//h2[text()='Add Customer']

#Add Customer Form
${INPUT_LOGIN_EMAIL}          id=email-id
${INPUT_LOGIN_PASSWORD}       id=password
${BTN_LOGIN_SUBMIT}           css:button[type="submit"]
${INPUT_EMAIL}                css:input[type='email']
${INPUT_FIRSTNAME}            id=FirstName
${INPUT_LASTNAME}             id=LastName
${INPUT_CITY}                 id=City
${SELECT_STATE}               id=StateOrRegion
${RADIO_GENDER}               gender
${CHECKBOX_PROMO}             name=promos-name
${BTN_SUBMIT}                 Submit
${MSG_DASHBOARD_CHECK}        Our Happy Customers
${MSG_CONFIRMATION}           New customer added.