import json
import yaml
import pandas as pd


class DataReader:

    def read_excel(self, file, sheet):

        df = pd.read_excel(file, sheet_name=sheet)

        return df.to_dict("records")

    def read_json(self, file):

        with open(file, encoding="utf-8") as f:

            return json.load(f)    