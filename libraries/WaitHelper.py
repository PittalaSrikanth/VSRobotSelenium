from robot.libraries.BuiltIn import BuiltIn


class WaitHelper:

    def __init__(self):
        try:
            self.sl = BuiltIn().get_library_instance('SeleniumLibrary')
        except Exception:
            self.sl = None

    def _require_sl(self):
        if self.sl is None:
            raise RuntimeError('SeleniumLibrary is not available in this environment')

    def wait_visible(self, locator, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = BuiltIn().get_variable_value('${DEFAULT_TIMEOUT}', '20s')
        self.sl.wait_until_element_is_visible(locator, timeout)

    def wait_enabled(self, locator, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = BuiltIn().get_variable_value('${DEFAULT_TIMEOUT}', '20s')
        self.sl.wait_until_element_is_enabled(locator, timeout)

    def wait_contains(self, text, timeout=None):
        self._require_sl()
        if timeout is None:
            timeout = BuiltIn().get_variable_value('${DEFAULT_TIMEOUT}', '20s')
        self.sl.wait_until_page_contains(text, timeout)