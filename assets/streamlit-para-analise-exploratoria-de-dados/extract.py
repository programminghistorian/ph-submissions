# Import
import requests
import pandas as pd

# Functions
def get_deputies(api):

    res = requests.get("/".join([api, "deputados"]))
    deputies = res.json()

    return deputies

def get_deputies_informations(deputies_names: list, df: pd.DataFrame, api: str, years: list, debug: False):

    data = dict()

    for depute in deputies_names:

        depute_id = str(df.loc[df["nome"] == depute, "id"].values[0])

        total_expenses = []
        urls_debug = list()

        for y in years:
            url = f"{api}/deputados/{depute_id}/despesas?ano={y}&ordem=ASC&ordenarPor=ano"

            if debug:
                urls_debug.append(url)

            resp = requests.get(url).json()["dados"]
            total_expenses.extend(resp)

        data[depute] = {
            "expense": total_expenses
        }

    if debug:
        return data, urls_debug
    else:
        return data