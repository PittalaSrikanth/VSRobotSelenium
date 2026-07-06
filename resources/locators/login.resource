*** Settings ***
Documentation       Locator variables for the login page.


*** Variables ***
${TXT_USERNAME}         xpath=//input[@name='username']

${TXT_PASSWORD}         xpath=//input[@name='password']

${BTN_LOGIN}            xpath=//button[@type='submit']

${LBL_DASHBOARD}        xpath=//h6[text()='Dashboard']

${LBL_LOGIN_ERROR}      xpath=//p[contains(@class,'alert-content-text')]
${USERNAME_INPUT}   xpath://input[@name='username']
${PASSWORD_INPUT}  xpath://input[@name='password']
${LOGIN_BTN}    xpath://button[@type='submit']
