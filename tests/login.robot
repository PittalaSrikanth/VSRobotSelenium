*** Settings ***
Documentation       Test suite for login functionality of the application.
Metadata            Author=Srikanth    Environment=QA    Browser=Chrome

Resource            ../resources/keywords/common.resource
Resource            ../resources/keywords/login.resource

Suite Teardown      Quit Browser
Test Setup          Launch Application
Test Teardown       Run Keyword If Test Failed    Take Failure Screenshot

Test Tags           login


*** Test Cases ***
Valid Login
    [Documentation]    Verifies that a user can log in successfully with valid credentials.
    [Tags]    regression
    Login To Application    ${USERNAME}    ${PASSWORD}
    Verify Successful Login

Invalid Login
    [Documentation]    Verifies that an invalid password shows the expected login error.
    [Tags]    regression
    Login To Application    Admin    WrongPassword
    Verify Invalid Login

Empty Username
    [Documentation]    Verifies that leaving the username empty shows the expected login error.
    Login To Application    ${EMPTY}    admin123
    Verify Invalid Login

Empty Password
    [Documentation]    Verifies that leaving the password empty shows the expected login error.
    Login To Application    Admin    ${EMPTY}
    Verify Invalid Login

Empty Credentials
    [Documentation]    Verifies that empty credentials show the expected login error.
    Login To Application    ${EMPTY}    ${EMPTY}
    Verify Invalid Login
