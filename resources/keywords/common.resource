*** Settings ***
Documentation       Common reusable keywords for browser interaction and page verification.

Library             OperatingSystem
Library             SeleniumLibrary
Variables           ../variables/variables.py
Library             ../../libraries/WaitHelper.py


*** Variables ***
${REPORTS_DIR}          ${CURDIR}/../reports
${SCREENSHOT_DIR}       ${REPORTS_DIR}/screenshots


*** Keywords ***
Initialize Test Output
    [Documentation]    Creates the reports and screenshot directories for every run.
    Create Directory    ${REPORTS_DIR}
    Create Directory    ${SCREENSHOT_DIR}
    Set Screenshot Directory    ${SCREENSHOT_DIR}

Launch Application
    [Documentation]    Opens the configured browser and prepares the application for interaction.
    Initialize Test Output
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}

Close Application
    [Documentation]    Closes the currently open browser.
    Close Browser

Take Failure Screenshot
    [Documentation]    Captures a screenshot when a test step fails.
    Capture Page Screenshot

Wait Until Page Loaded
    [Documentation]    Waits until the page body is available.
    Wait Until Page Contains Element    xpath=//body

Click
    [Documentation]    Waits for and clicks the specified element.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Enter Text
    [Documentation]    Waits for the element and enters the provided text.
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    ${text}

Clear And Enter Text
    [Documentation]    Clears the target field and enters the provided text.
    [Arguments]    ${locator}    ${text}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Verify Page Contains
    [Documentation]    Verifies that the page contains the provided text.
    [Arguments]    ${text}
    Page Should Contain    ${text}
