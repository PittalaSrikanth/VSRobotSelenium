import os

from SeleniumLibrary import SeleniumLibrary


class BasePage:

    def __init__(self):
        try:
            self.sl = SeleniumLibrary()
        except Exception:
            self.sl = None

    def _require_sl(self):
        if self.sl is None:
            raise RuntimeError('SeleniumLibrary is not available in this environment')


    def type(self, locator, value):
        self._require_sl()
        self.sl.clear_element_text(locator)
        self.sl.input_text(locator, value)

    def clear_and_type(self, locator, value):
        self._require_sl()
        self.sl.clear_element_text(locator)
        self.sl.input_text(locator, value)

    def wait_until_visible(self, locator, timeout="20s"):
        self._require_sl()
        self.sl.wait_until_element_is_visible(locator, timeout)

    def wait_until_clickable(self, locator, timeout="20s"):
        self._require_sl()
        self.sl.wait_until_element_is_enabled(locator, timeout)

    def scroll_to(self, locator):
        self._require_sl()
        self.sl.scroll_element_into_view(locator)

    def _screenshot_path(self, file_name="page_screenshot.png"):
        folder = os.getenv("SCREENSHOT_DIR", os.path.join(os.getcwd(), "reports", "screenshots"))
        os.makedirs(folder, exist_ok=True)
        return os.path.join(folder, file_name)

    def take_screenshot(self):
        self._require_sl()
        self.sl.capture_page_screenshot(self._screenshot_path("page_screenshot.png"))

    def get_title(self):
        self._require_sl()
        return self.sl.get_title()

    def _close_browser(self):
        self._require_sl()
        self.sl.close_browser()
    

    def click(self, locator):
        self.sl.wait_until_element_is_visible(locator, "20s")
        self.sl.click_element(locator)

    def enter_text(self, locator, value):
        self.sl.wait_until_element_is_visible(locator, "20s")
        self.sl.clear_element_text(locator)
        self.sl.input_text(locator, value)

    def enter_password(self, locator, value):
        self.sl.wait_until_element_is_visible(locator, "20s")
        self.sl.clear_element_text(locator)
        self.sl.input_password(locator, value)

    def get_text(self, locator):
        return self.sl.get_text(locator)

    def is_visible(self, locator):
        return self.sl.is_element_visible(locator)


    def capture(self, file_name="failure.png"):
        self.sl.capture_page_screenshot(self._screenshot_path(file_name))
