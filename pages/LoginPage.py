import os, sys
# Ensure project root is on sys.path so imports like `from pages.BasePage` work
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if ROOT not in sys.path:
    sys.path.insert(0, ROOT)

from pages.BasePage import BasePage

class LoginPage(BasePage):

    def login(self, username_locator,
                    password_locator,
                    login_button_locator,
                    username,
                    password):
        self.enter_text(username_locator, username)
        self.enter_password(password_locator, password)
        self.click(login_button_locator)

    def verify_dashboard(self, dashboard_locator):
        self.wait_until_visible(dashboard_locator)

    def verify_login_error(self, error_locator):
        return self.get_text(error_locator)