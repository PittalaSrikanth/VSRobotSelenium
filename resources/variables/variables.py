try:
	import config.config as cfg
except Exception:
	import os, sys
	ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
	if ROOT not in sys.path:
		sys.path.insert(0, ROOT)
	import config.config as cfg

URL = cfg.BASE_URL

USERNAME = cfg.USERNAME

PASSWORD = cfg.PASSWORD

BROWSER = cfg.BROWSER

HEADLESS = cfg.HEADLESS

IMPLICIT_WAIT = cfg.IMPLICIT_WAIT

EXPLICIT_WAIT = cfg.EXPLICIT_WAIT

PAGE_LOAD_TIMEOUT = cfg.PAGE_LOAD_TIMEOUT