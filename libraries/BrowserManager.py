import os
import sys
import socket
import urllib.parse

from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.edge.options import Options as EdgeOptions
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.edge.service import Service as EdgeService
from selenium.webdriver.firefox.service import Service as FirefoxService

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if ROOT not in sys.path:
    sys.path.insert(0, ROOT)

from config.config import *


class BrowserManager:

    def __init__(self):
        self.driver = None

    def start_browser(self):

        browser = BROWSER.lower()

        if browser == "chrome":

            options = ChromeOptions()

            if HEADLESS:
                options.add_argument("--headless=new")
            if INCOGNITO:
                options.add_argument("--incognito")

            options.add_argument("--start-maximized")
            options.add_argument("--disable-notifications")
            options.add_argument("--disable-popup-blocking")
            options.add_argument("--disable-extensions")
            options.add_argument("--disable-infobars")

            self.driver = webdriver.Chrome(
                service=ChromeService(),
                options=options
            )

        elif browser == "edge":

            options = EdgeOptions()

            if HEADLESS:
                options.add_argument("--headless=new")

            options.add_argument("--start-maximized")

            self.driver = webdriver.Edge(
                service=EdgeService(),
                options=options
            )

        elif browser == "firefox":

            options = FirefoxOptions()

            if HEADLESS:
                options.add_argument("-headless")

            self.driver = webdriver.Firefox(
                service=FirefoxService(),
                options=options
            )

        else:

            raise Exception(f"Unsupported Browser : {browser}")

        self.driver.maximize_window()

        self.driver.implicitly_wait(IMPLICIT_WAIT)

        self.driver.set_page_load_timeout(PAGE_LOAD_TIMEOUT)

        # Try resolving the hostname before navigating to avoid WebDriver errors
        try:
            host = urllib.parse.urlparse(BASE_URL).hostname
            if host:
                socket.gethostbyname(host)
        except Exception:
            print(f"Warning: cannot resolve host for BASE_URL='{BASE_URL}'. Skipping navigation.")
            return self.driver

        try:
            self.driver.get(BASE_URL)
        except Exception as e:
            print(f"Warning: navigation to BASE_URL failed: {e}")
            return self.driver

        return self.driver

    def close_browser(self):

        if self.driver:

            self.driver.quit()