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
