from jinja2 import Template
from plotly.graph_objects import Figure

def save_html(fig : Figure, number : int, output_html_path : str) -> None:
    jinja_data = {
        "number" : number,
        "image" : fig.to_html(full_html = False, auto_play = False, 
                              include_plotlyjs = False, include_mathjax = False)
    }

    with open(output_html_path, "w", encoding = "utf-8") as output_file : 
        with open("./images_interactives/template.html") as template_file :
            j2_template = Template(template_file.read())
            output_file.write(j2_template.render(jinja_data))