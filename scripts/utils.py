import requests
import io
import pandas as pd


GDRIVE_BASE_URL = "https://docs.google.com/spreadsheet/ccc?key="

def gsheet_to_df(sheet_id):
    url = f"{GDRIVE_BASE_URL}{sheet_id}&output=csv"
    r = requests.get(url)
    print(r.status_code)
    data = r.content
    df = pd.read_csv(io.BytesIO(data))
    return df