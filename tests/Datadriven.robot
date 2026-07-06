*** Settings ***
Library             SeleniumLibrary
Resource            ../resources/keywords/common.resource
Resource            ../resources/keywords/login.resource
Library             DataDriver    file=${CURDIR}/../data/LoginData.xlsx    sheet_name=Sheet1

Suite Setup         Launch Application
Suite Teardown      Quit Browser
Test Setup          Go To    ${URL}
Test Template       Invalid Login


*** Test Cases ***
Login With Excel Data    ${USERNAME}    ${PASSWORD}


*** Keywords ***
Invalid Login
    [Arguments]    ${USERNAME}    ${PASSWORD}
    Enter_username    ${USERNAME}
    Enter_Password    ${PASSWORD}
    Enter_lgnBtn
