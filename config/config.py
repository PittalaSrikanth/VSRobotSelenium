import os

environment = os.getenv("ENV", "qa").lower()

if environment == "dev":
    from config.dev import *

elif environment == "qa":
    from config.qa import *

else:
    raise Exception(f"Unknown Environment : {environment}")