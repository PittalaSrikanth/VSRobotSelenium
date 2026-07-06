*** Settings ***
Documentation       Locator variables for the home page.


*** Variables ***
${MENU_ADMIN}           xpath=//span[text()='Admin']

${MENU_PIM}             xpath=//span[text()='PIM']

${MENU_LEAVE}           xpath=//span[text()='Leave']

${MENU_TIME}            xpath=//span[text()='Time']

${MENU_RECRUITMENT}     xpath=//span[text()='Recruitment']

${MENU_MYINFO}          xpath=//span[text()='My Info']

${BTN_PROFILE}          xpath=//img[contains(@class,'useravatar')]

${BTN_LOGOUT}           xpath=//a[text()='Logout']
