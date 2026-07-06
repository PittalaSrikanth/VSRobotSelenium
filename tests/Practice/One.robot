*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}    chrome
${USERNAME}    Admin
${PASSWORD}    admin123

*** Test Cases ***
Login Test
    [Documentation]   This test case verifies the login functionality of the application.
    [Tags]    login    smoke
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text Into Alert    xpath=//input[@name='username']    ${USERNAME}
    Input Text Into Alert    xpath=//input[@name='password']    ${PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Close Browser
    Close All Browsers

TestingLoop
    FOR     ${ittt}     IN RANGE     1    10
        Log      ${ittt}
        Sleep    1s
    END

*** Keywords ***