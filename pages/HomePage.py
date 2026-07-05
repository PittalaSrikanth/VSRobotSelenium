import os, sys
# Ensure project root is on sys.path so imports like `from pages.BasePage` work
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if ROOT not in sys.path:
    sys.path.insert(0, ROOT)

from pages.BasePage import BasePage


class HomePage(BasePage):

    ADMIN = "xpath=//span[text()='Admin']"

    PIM = "xpath=//span[text()='PIM']"

    LEAVE = "xpath=//span[text()='Leave']"

    PROFILE = "xpath=//img[contains(@class,'useravatar')]"

    LOGOUT = "xpath=//a[text()='Logout']"

    def open_admin(self):

        self.click(self.ADMIN)

    def open_pim(self):

        self.click(self.PIM)

    def open_leave(self):

        self.click(self.LEAVE)

    def logout(self):

        self.click(self.PROFILE)

        self.click(self.LOGOUT)