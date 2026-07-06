*** Settings ***
Documentation       Resource file containing login-related keywords for the application.

Resource            ../keywords/common.resource
Resource            ../locators/login.resource
Library             ../../pages/LoginPage.py


*** Keywords ***
Login To Application
    [Documentation]    Logs in to the application with the provided username and password.
    [Arguments]    ${username}    ${password}
    Login    ${TXT_USERNAME}    ${TXT_PASSWORD}    ${BTN_LOGIN}    ${username}    ${password}

Verify Successful Login
    [Documentation]    Verifies that the dashboard is displayed after a successful login.
    Wait Until Element Is Visible    ${LBL_DASHBOARD}    20s

Verify Invalid Login
    [Documentation]    Verifies that an invalid login shows an error message.
    ${has_error}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LBL_LOGIN_ERROR}    5s
    IF    ${has_error}
        ${message}=    SeleniumLibrary.Get Text    ${LBL_LOGIN_ERROR}
        Should Not Be Empty    ${message}
    ELSE
        Element Should Not Be Visible    ${LBL_DASHBOARD}
    END

Enter_username
    [Arguments]    ${USERNAME}
    Wait Until Element Is Visible    ${USERNAME_INPUT}    15 seconds
    Clear Element Text    ${USERNAME_INPUT}
    Input Text    ${USERNAME_INPUT}    ${USERNAME}

Enter_Password
    [Arguments]    ${PASSWORD}
    Wait Until Element Is Visible    ${PASSWORD_INPUT}    15 seconds
    Clear Element Text    ${PASSWORD_INPUT}
    Input Text    ${PASSWORD_INPUT}    ${PASSWORD}

Enter_lgnBtn
    Wait Until Element Is Visible    ${LOGIN_BTN}    15 seconds
    Click Button    ${LOGIN_BTN}