*** Settings ***
Resource            ../resources/keywords/common.resource
Resource            ../resources/keywords/login.resource

Suite Setup         Launch Application
Suite Teardown      Close Application
Test Teardown       Run Keyword If Test Failed    Take Failure Screenshot


*** Test Cases ***
Valid Login
    [Documentation]    Verifies that a user can log in successfully with valid credentials.
    Login To Application    ${USERNAME}    ${PASSWORD}
    Verify Successful Login

Invalid Login
    [Documentation]    Verifies that an invalid password shows the expected login error.
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
