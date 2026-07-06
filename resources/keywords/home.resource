*** Settings ***
Documentation       Resource file containing home page navigation keywords.

Library             ../../pages/HomePage.py


*** Keywords ***
Navigate To Admin
    [Documentation]    Opens the Admin page from the home navigation menu.
    Open Admin

Navigate To PIM
    [Documentation]    Opens the PIM page from the home navigation menu.
    Open Pim

Navigate To Leave
    [Documentation]    Opens the Leave page from the home navigation menu.
    Open Leave

Logout From Application
    [Documentation]    Logs the current user out of the application.
    Logout
Enter_username
    [Arguments]    ${USERNAME}
    Wait Until Element Is Visible    ${USERNAME_INPUT}    15 seconds
    Clear Element Text    ${USERNAME_INPUT}
    Input Text    ${USERNAME_INPUT}    ${USERNAME}

Enter_Password
    [Arguments]   ${PASSWORD}
    Wait Until Element Is Visible    ${PASSWORD_INPUT}    15 seconds
    Clear Element Text    ${PASSWORD_INPUT}
    Input Text    ${PASSWORD_INPUT}    ${PASSWORD}

Enter_lgnBtn
    Wait Until Element Is Visible    ${LOGIN_BTN}    15 seconds
    Click Button    ${LOGIN_BTN}

LoginToApplication
    [Arguments]    ${USERNAME}    ${PASSWORD}
    Wait Until Element Is Visible    ${USERNAME_INPUT}    15 seconds
    Clear Element Text    ${USERNAME_INPUT}
    Input Text    ${USERNAME_INPUT}    ${USERNAME}
    Wait Until Element Is Visible    ${PASSWORD_INPUT}    15 seconds
    Clear Element Text    ${PASSWORD_INPUT}
    Input Text    ${PASSWORD_INPUT}    ${PASSWORD}
    Wait Until Element Is Visible    ${LOGIN_BTN}    15 seconds
    Click Button    ${LOGIN_BTN}