*** Settings ***
Documentation       Home Page Test Suite

Resource            ../resources/keywords/common.resource
Resource            ../resources/keywords/login.resource
Resource            ../resources/keywords/home.resource

Suite Setup         Launch Application
Suite Teardown      Close Application
Test Teardown       Run Keyword If Test Failed    Take Failure Screenshot


*** Test Cases ***
Verify Home Page After Login
    [Documentation]    Verify user lands on Home page after successful login
    [Tags]    smoke    regression

    Login To Application    ${USERNAME}    ${PASSWORD}
    Verify Successful Login

Navigate To Admin Module
    [Documentation]    Verify Admin module navigation
    [Tags]    regression

    Login To Application    ${USERNAME}    ${PASSWORD}
    Verify Successful Login

    Navigate To Admin

Navigate To PIM Module
    [Documentation]    Verify PIM module navigation
    [Tags]    regression

    Login To Application    ${USERNAME}    ${PASSWORD}
    Verify Successful Login

    Navigate To PIM

Navigate To Leave Module
    [Documentation]    Verify Leave module navigation
    [Tags]    regression

    Login To Application    ${USERNAME}    ${PASSWORD}
    Verify Successful Login

    Navigate To Leave

Logout Successfully
    [Documentation]    Verify user logout
    [Tags]    smoke

    Login To Application    ${USERNAME}    ${PASSWORD}
    Verify Successful Login

    Logout From Application
