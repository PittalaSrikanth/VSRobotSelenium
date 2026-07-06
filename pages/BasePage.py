import os

from robot.libraries.BuiltIn import BuiltIn


class BasePage:

    def __init__(self):
        try:
            self.sl = BuiltIn().get_library_instance('SeleniumLibrary')
        except Exception:
            self.sl = None
        self.default_timeout = BuiltIn().get_variable_value('${DEFAULT_TIMEOUT}', '20s')

    def _require_sl(self):
        if self.sl is None:
            raise RuntimeError('SeleniumLibrary is not available in this environment')


    def type(self, locator, value):
        self.clear_and_type(locator, value)

    def clear_and_type(self, locator, value):
        self._require_sl()
        self.sl.clear_element_text(locator)
        self.sl.input_text(locator, value)

    def wait_until_visible(self, locator, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = self.default_timeout
        self.sl.wait_until_element_is_visible(locator, timeout)

    def wait_until_clickable(self, locator, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = self.default_timeout
        self.sl.wait_until_element_is_enabled(locator, timeout)

    def scroll_to(self, locator):
        self._require_sl()
        self.sl.scroll_element_into_view(locator)

    def _screenshot_path(self, file_name='page_screenshot.png'):
        folder = os.getenv('SCREENSHOT_DIR', os.path.join(os.getcwd(), 'reports', 'screenshots'))
        os.makedirs(folder, exist_ok=True)
        return os.path.join(folder, file_name)

    def take_screenshot(self):
        self._require_sl()
        self.sl.capture_page_screenshot(self._screenshot_path('page_screenshot.png'))

    def get_title(self):
        self._require_sl()
        return self.sl.get_title()

    def _close_browser(self):
        self._require_sl()
        self.sl.close_browser()

    def click(self, locator, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = self.default_timeout
        self.sl.wait_until_element_is_visible(locator, timeout)
        self.sl.click_element(locator)

    def enter_text(self, locator, value, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = self.default_timeout
        self.sl.wait_until_element_is_visible(locator, timeout)
        self.sl.clear_element_text(locator)
        self.sl.input_text(locator, value)

    def enter_password(self, locator, value, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = self.default_timeout
        self.sl.wait_until_element_is_visible(locator, timeout)
        self.sl.clear_element_text(locator)
        self.sl.input_password(locator, value)

    def getText(self, locator):
        self._require_sl()
        return self.sl.get_text(locator)

    def is_visible(self, locator):
        self._require_sl()
        return self.sl.is_element_visible(locator)

    def capture(self, file_name='failure.png'):
        self._require_sl()
        self.sl.capture_page_screenshot(self._screenshot_path(file_name))
