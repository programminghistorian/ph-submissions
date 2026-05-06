# Import
import json
import shutil
import pandas as pd
from time import sleep
import streamlit as st
from pathlib import Path
from extract import get_deputies, get_deputies_informations
from transform import top_suppliers, total_expenses, expense_types, expenses_per_month

# Page configuration
st.set_page_config(
    page_title="Streamlit for Exploratory Analysis",
    initial_sidebar_state="expanded",
    layout="wide"
)

# Constants
BASE_API = "https://dadosabertos.camara.leg.br/api/v2"
BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "data"
DEPUTIES_FILE = DATA_DIR / "deputies.json"

# Creating data directory
DATA_DIR.mkdir(parents=True, exist_ok=True)

# Checks
if "exists" not in st.session_state:
    st.session_state["exists"] = False

if "deputies" not in st.session_state:
    st.session_state["deputies"] = pd.DataFrame()

if "selected_deputies" not in st.session_state:
    st.session_state["selected_deputies"] = dict()

if "names_list" not in st.session_state:
    st.session_state["names_list"] = list()

if "poticial_party_column" not in st.session_state:
    st.session_state["poticial_party_column"] = None

if "geographic_region_column" not in st.session_state:
    st.session_state["geographic_region_column"] = None

if "ppc_view_mode" not in st.session_state:
    st.session_state["ppc_view_mode"] = "None"

if "grc_view_mode" not in st.session_state:
    st.session_state["grc_view_mode"] = "None"

# Reading deputies.json, if exists
if DEPUTIES_FILE.exists():

    with open(DEPUTIES_FILE, 'r', encoding="utf-8") as f:
        j = json.loads(f.read())
        st.session_state["deputies"] = pd.DataFrame.from_dict(j["dados"])

    st.session_state["exists"] = True

# Sidebar
with st.sidebar:

    api = st.text_input("Insert API", value=BASE_API, width="stretch", help="Please remove the last \"/\"!")

    if not st.session_state["exists"] or not st.session_state["deputies"].__len__() > 0:

        if st.button("Extract deputies", width="stretch"):

            deputies = get_deputies(api)

            with open(DEPUTIES_FILE, 'w', encoding="utf-8") as f:
                f.write(json.dumps(deputies, indent=4, ensure_ascii=False))

            st.success("Deputies extracted!")

            placeholder = st.empty()

            for i in range(3, 0, -1):
                placeholder.info(f"Restarting in {i}...")
                sleep(1)

            placeholder.info("Restarting now...")
            sleep(0.5)

            st.rerun()

    else:

        st.divider()

        max_size = False if not st.session_state["names_list"].__len__() >= 9 else True

        name = st.selectbox(
            "Select up to 10 deputies",
            help="Click on \"x\" to clear your selection!",
            options=st.session_state["deputies"]["nome"],
            disabled=max_size,
            width="stretch",
            key="names",
            index=None
        )

        if name is not None and name not in st.session_state["names_list"]:
            st.session_state["names_list"].append(name.__str__())

        with st.expander("View list of Deputies", expanded=False, width="stretch"):
            st.write(st.session_state["names_list"])

        if st.button("Clear list of Deputies", width="stretch"):
            st.session_state["names_list"] = list()

        st.caption("Maybe you need to click twice!", width="stretch", text_alignment="center")

        if st.session_state["names_list"].__len__() >= 1:

            st.divider()

            period_mode = st.radio(
                "Period mode",
                options=["slider", "multiselection"],
                width="stretch",
                index=0
            )                

            if period_mode == "slider":

                selected_years_tuple = st.slider(
                    label="Select a period",
                    min_value=0,
                    max_value=26,
                    value=(0, 26),
                    help="\"0\" means 2000, as well \"26\" is 2026!"
                )

                selected_years = list(range(
                    2000 + selected_years_tuple[0],
                    2000 + selected_years_tuple[1] + 1
                ))

            elif period_mode == "multiselection":

                selected_years = st.multiselect(
                    "Select years",
                    options=list(range(2000, 2027)),
                    accept_new_options=True,
                    width="stretch"
                )

            if st.button("Get Deputies' Expenses", width="stretch"):

                st.session_state["selected_deputies"] = get_deputies_informations(
                    st.session_state["names_list"], st.session_state["deputies"],
                    api,
                    selected_years,
                    False
                )

        st.divider()

        tad_expansion = st.checkbox("Expand TAD charts", key="tad_expansion", value=False)
        tsd_expansion = st.checkbox("Expand TSD charts", key="tsd_expansion", value=False)
        format_brl = st.checkbox("Format numbers to BRL?", value=True)

    st.divider()

    if st.button(
        "",
        width="stretch",
        type="primary",
        shortcut="DEL",
        help="Press DEL to delete your data folder!"
    ):

        if DATA_DIR.exists():

            shutil.rmtree(DATA_DIR)

            st.success("`data/` deleted! Please, press `R` to restart!")
            
        else:

            st.warning("Data folder does not exist.")

# Main tabs
tab_all_deputies, tab_selected_deputies = st.tabs(["All deputies (TAD)", "Selected deputies (TSD)"])

with tab_all_deputies:

    if st.session_state["exists"] and st.session_state["deputies"].__len__() > 0:

        with st.expander("View all deputies", expanded=tad_expansion, width="stretch"):
            st.dataframe(st.session_state["deputies"])

        tad_col1, tad_col2 = st.columns(2)

        with tad_col1:

            st.session_state["poticial_party_column"] = st.selectbox(
                "Political Party Column",
                help="Click on \"x\" to clear your selection!",
                options=st.session_state["deputies"].keys(),
                width="stretch",
                index=None
            )

            if st.session_state["poticial_party_column"] is not None:

                counts_ppc = st.session_state["deputies"][st.session_state["poticial_party_column"]].value_counts().reset_index()
                counts_ppc["percentage"] = counts_ppc["count"] / counts_ppc["count"].sum() * 100

                with st.container(border=True, width="stretch", horizontal_alignment="center", vertical_alignment="center"):

                    st.session_state["ppc_view_mode"] = st.radio(
                        "View mode",
                        ["Table (with %)", "Chart"],
                        width="stretch",
                        horizontal=True,
                        label_visibility="collapsed",
                        key="ppc_vm_button"
                    )

                    if st.session_state["ppc_view_mode"] == "Chart":

                        st.bar_chart(
                            counts_ppc,
                            x=st.session_state["poticial_party_column"],
                            y="count",
                            width="stretch",
                            horizontal=True,
                            sort=False
                        )

                    elif st.session_state["ppc_view_mode"] == "Table (with %)":

                        st.write(counts_ppc)

        with tad_col2:

            st.session_state["geographic_region_column"] = st.selectbox(
                "Geographic Region Column",
                help="Click on \"x\" to clear your selection!",
                options=st.session_state["deputies"].keys(),
                width="stretch",
                index=None
            )

            if st.session_state["geographic_region_column"] is not None:

                counts_grc = st.session_state["deputies"][st.session_state["geographic_region_column"]].value_counts().reset_index()
                counts_grc["percentage"] = counts_grc["count"] / counts_grc["count"].sum() * 100

                with st.container(border=True, width="stretch", horizontal_alignment="center", vertical_alignment="center"):

                    st.session_state["grc_view_mode"] = st.radio(
                        "View mode",
                        ["Table (with %)", "Chart"],
                        width="stretch",
                        horizontal=True,
                        label_visibility="collapsed",
                        key="grc_vm_button"
                    )

                    if st.session_state["grc_view_mode"] == "Chart":

                        st.bar_chart(
                            counts_grc,
                            x=st.session_state["geographic_region_column"],
                            y="count",
                            width="stretch",
                            horizontal=True,
                            sort=False
                        )
                    
                    elif st.session_state["grc_view_mode"] == "Table (with %)":

                        st.write(counts_grc)

with tab_selected_deputies:

    if st.session_state["exists"] and len(st.session_state["deputies"]) > 0:

        deputies_items = list(st.session_state["selected_deputies"].items())

        for i in range(0, len(deputies_items), 2):

            cols = st.columns(2)

            for j in range(2):

                if i + j >= len(deputies_items):
                    continue

                depute, info = deputies_items[i + j]

                depute_id = st.session_state["deputies"].loc[
                    st.session_state["deputies"]["nome"] == depute,
                    "id"
                ].values

                depute_id = depute_id[0] if len(depute_id) > 0 else None

                depute_photo = st.session_state["deputies"].loc[
                    st.session_state["deputies"]["nome"] == depute,
                    "urlFoto"
                ].values

                photo_url = depute_photo[0] if len(depute_photo) > 0 else None

                with cols[j]:

                    with st.container(border=True):

                        with st.container(horizontal_alignment="center"):
                            
                            st.image(
                                image=photo_url,
                                width=200,
                                output_format="PNG",
                                caption=f"Depute ID: {depute_id}",
                                link=photo_url
                            )

                            st.subheader(
                                depute,
                                text_alignment="center"
                            )

                        expenses = info.get("expense", [])

                        if not expenses:

                            st.write("No expense data")
                            continue

                        monthly_expenses = expenses_per_month(expenses)

                        with st.expander("Expenses per month", expanded=tsd_expansion):

                            st.line_chart(monthly_expenses)
                            
                            st.metric("Total expenses", total_expenses(
                                monthly_expenses, format_brl
                                )
                            )

                        with st.expander("Main suppliers", expanded=tsd_expansion):

                            st.bar_chart(
                                top_suppliers(expenses),
                                width="stretch",
                                horizontal=True,
                                sort=False
                            )

                        with st.expander("Types of expenses", expanded=tsd_expansion):
                            
                            st.bar_chart(
                                expense_types(expenses),
                                width="stretch",
                                horizontal=True,
                                sort=True
                            )