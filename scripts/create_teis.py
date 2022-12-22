import os
import pandas as pd
import jinja2
from collections import defaultdict
from datetime import date
from sqlalchemy import create_engine
from tqdm import tqdm


today = date.today()
out_dir = './data/editions'
os.makedirs(out_dir, exist_ok=True)
templateLoader = jinja2.FileSystemLoader(searchpath="./scripts/templates")
templateEnv = jinja2.Environment(loader=templateLoader)
template = templateEnv.get_template('tei_template.xml')

DB_USER = os.environ.get("DB_USER")
DB_PW = os.environ.get("DB_PW")
DB_NAME = os.environ.get("DB_NAME")
DB_HOST = os.environ.get("DB_HOST", "127.0.0.1")
N = None

db_connection_str = f"mysql://{DB_USER}:{DB_PW}@{DB_HOST}/{DB_NAME}"
db_connection = create_engine(db_connection_str)

query = "SELECT * FROM synopse"
df = pd.read_sql(query, con=db_connection)
df.to_csv("hansi.csv", index=False)
if N:
    pass
else:
    N = len(df)

film_df = pd.read_sql("SELECT * FROM filminfo", con=db_connection)
film_df.to_csv("film_df.csv", index=False)
filme = defaultdict(list)
for i, row in film_df.iterrows():
    filme[row['id_besuch']].append(row.to_dict())

kinos = pd.read_sql("SELECT * FROM kinos", con=db_connection)
kinos.to_csv("kinos.csv", index=False)
kino_dict = {
    row['id']: row.to_dict() for i, row in kinos.iterrows()
}

wirte = pd.read_sql("SELECT * FROM orte_danach", con=db_connection)
wirte.to_csv("wirte.csv", index=False)
wirte_dict = {
    row['id']: row.to_dict() for i, row in wirte.iterrows()
}


for i, row in tqdm(df.head(N).iterrows(), total=N):
    context = row.to_dict()
    besuch_id = row['id']
    films = filme[besuch_id]
    wirte_data = wirte_dict[row['ortDanach_id']]
    try:
        kino_data = kino_dict[row['kino_id']]
    except KeyError:
        kino_data = None
    context["kino_data"] = kino_data
    context["wirte_data"] = wirte_data
    context["filme"] = films
    context["current_date"] = f'{today.strftime("%Y-%m-%d")}'
    file_name = os.path.join(out_dir, f"ask__{context['datum']}.xml")
    with open(file_name.lower(), 'w') as f:
        f.write(template.render(**context).replace('&', '&amp;').replace('<u>', '<hi>').replace('</u>', '</hi>'))
