import os
from datetime import datetime


class Screenshot:

    def __init__(self, seleniumlib):
        self.sl = seleniumlib

    def _get_screenshot_dir(self):
        folder = os.getenv("SCREENSHOT_DIR", os.path.join(os.getcwd(), "reports", "screenshots"))
        os.makedirs(folder, exist_ok=True)
        return folder

    def capture(self, name="Screenshot"):
        folder = self._get_screenshot_dir()
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        file_name = os.path.join(folder, f"{name}_{timestamp}.png")

        self.sl.capture_page_screenshot(file_name)

        return file_name