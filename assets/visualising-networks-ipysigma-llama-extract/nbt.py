import json

#import matplotlib.pyplot as plt
import time
from pathlib import Path

import networkx as nx
from ipysigma import Sigma


# Utility function to get the current timestamp in a specific format
def get_timestamp():
    return time.strftime("%Y%m%d%H%M%S")

# Function to convert bibliographic JSON input data to a NetworkX graph
def convert_json_to_nx(date_range: str):
    # Open the JSON file containing the parsed data
    file_path = Path("data") / "in" / f"nbt_index_{date_range}.json"
    with file_path.open("r") as f:
        data = json.load(f)
        
    # Extract the bibliographic catalogue data from the JSON
    catalogue_items = data["results"]["bindings"]
    item_dict_list = []
    
    # Define edges and nodes for the graph representation of the bibliographic data
    edges = []
    nodes = {}
    
    # Iterate through each bibliographic record and extract the relevant information.
    for x in catalogue_items:

        if x is not None:
            itemdata = x
            # Create a dictionary for each catalogue item
            item = {
                "uri": itemdata.get("uri").get("value"),
                "title": itemdata.get("name").get("value"),
                "language": itemdata.get("language").get("value"),
                "date": itemdata.get("jaar").get("value"),
                "pref_subject": itemdata.get("preflabel").get("value").lower() if itemdata.get("preflabel") is not None else None,
                "narrower_subject": itemdata.get("narrowerlabel").get("value").lower() if itemdata.get("narrowerlabel") is not None else None,
                "broader_subject": itemdata.get("broaderlabel").get("value").lower() if itemdata.get("broaderlabel") is not None else None,
            }
            item_dict_list.append(item)

            # Define edges for the catalogue graph
            # Add edges based on the relationships between titles and subjects
            # and between subjects themselves (broader and narrower)
            if item["title"] is not None and item["pref_subject"] is not None:
                edges.append((item["pref_subject"], item["title"]))
                if item["narrower_subject"] is not None:
                    edges.append((item["pref_subject"], item["narrower_subject"]))
                    edges.append((item["narrower_subject"], item["title"]))
                if item["broader_subject"] is not None:
                    edges.append((item["pref_subject"], item["broader_subject"]))
                    edges.append((item["broader_subject"], item["title"]))

            # Define nodes for the catalogue graph
            keys_title_to_extract = ["title", "pref_subject", "narrower_subject", "broader_subject", "date", "language", "uri"]
            keys_subject_to_extract = ["pref_subject", "narrower_subject", "broader_subject"]
            for node_attributes in item_dict_list:
                node_title = node_attributes["title"]
                node_pref_subject = node_attributes["pref_subject"]
                node_narrower_subject = node_attributes["narrower_subject"]
                node_broader_subject = node_attributes["broader_subject"]

                # Create sub-dictionaries for title and subject nodes with relevant attributes
                sub_dict_title = {key: node_attributes[key] for key in keys_title_to_extract if key in node_attributes and node_attributes[key] is not None}
                sub_dict_title["type"] = "book"
                sub_dict_subject = {key: node_attributes[key] for key in keys_subject_to_extract if key in node_attributes and node_attributes[key] is not None}
                sub_dict_subject["type"] = "subject"
                
                if node_title is not None:
                    nodes[node_title] = sub_dict_title
                if node_pref_subject is not None:
                    nodes[node_pref_subject] = sub_dict_subject
                if node_narrower_subject is not None:
                    nodes[node_narrower_subject] = sub_dict_subject
                if node_broader_subject is not None:
                    nodes[node_broader_subject] = sub_dict_subject

    #print(edges)
    #print(nodes)
    
    G = nx.DiGraph()
    for edge in edges:
        G.add_edge(edge[0], edge[1])

    nx.set_node_attributes(G, nodes)
    #nx.draw(G, with_labels=True)
    #plt.savefig("filename.png")
    
    # Save as GML files
    # gml_output_path = Path("data") / "out" / "gml" / f"nbt_index_{date_range}.gml"
    # nx.write_gml(G, gml_output_path)

    # Create a Sigma visualization
    Sigma(
        G,
        )
    output_path = Path("data") / "out" / f"nbt_index_{date_range}.html"
    Sigma.write_html(
        G,
        output_path,
        fullscreen=True,
        node_metrics=["louvain"],
        node_color="pref_subject",
        node_size_range=(3, 30),
        node_shape = "type",
        node_shape_mapping = {
            "book": "book_2",
            "subject": "label"
            },
        max_categorical_colors=50,
        default_edge_type="curve",
        default_node_label_size=14,
        node_size=G.degree,
        label_density=2
    )

if __name__ == "__main__":
    date_ranges = [
        "1800-1825",
        "1826-1850",
        "1851-1875",
        "1876-1900",
        "1901-1925",
        "1926-1950",
        "1951-1975",
        "1976-2000"
    ]
    for dr in date_ranges:
        convert_json_to_nx(dr)
    #convert_json_to_nx("1800-1825")    
