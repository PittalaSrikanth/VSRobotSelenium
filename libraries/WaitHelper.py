from SeleniumLibrary import SeleniumLibrary


class WaitHelper:

    def __init__(self):
        self.sl = SeleniumLibrary()

    def wait_visible(self, locator, timeout="20s"):

        self.sl.wait_until_element_is_visible(locator, timeout)

    def wait_enabled(self, locator, timeout="20s"):

        self.sl.wait_until_element_is_enabled(locator, timeout)

    def wait_contains(self, text, timeout="20s"):

        self.sl.wait_until_page_contains(text, timeout)