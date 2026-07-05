*** Settings ***
Documentation       Resource file containing login-related keywords for the application.

Library             ../../pages/LoginPage.py
Resource            ../locators/login.resource


*** Keywords ***
Login To Application
    [Documentation]    Logs in to the application with the provided username and password.
    [Arguments]    ${username}    ${password}
    Login    ${TXT_USERNAME}    ${TXT_PASSWORD}    ${BTN_LOGIN}    ${username}    ${password}

Verify Successful Login
    [Documentation]    Verifies that the dashboard is displayed after a successful login.
    Verify Dashboard    ${LBL_DASHBOARD}

Verify Invalid Login
    [Documentation]    Verifies that an invalid login shows an error message.
    ${message}=    Verify Login Error    ${LBL_LOGIN_ERROR}
    Should Not Be Empty    ${message}
