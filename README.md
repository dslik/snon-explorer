# snon-explorer

Reads SNON fragments from devices and visualizes them as a graph

## Running the visualizer

Step 1:

Generate the SNON data dump by running the following Ruby program:

```
% ruby snon-dump.rb
```

Step 2:

Run a local web browser using Python:

```
python3 -m http.server
```

Step 3:

```
Open http://localhost:8000/ in your web browser
```


## Syntax of JSON file

Based on Vis documentation: https://github.com/almende/vis/blob/master/examples/network/data/datasets.html

```
{
    "nodes": [
        {"id": 1, "label": "Node 1", "title": "Title popup<br>on mouseover"},
        {"id": 2, "label": "Node 2"},
        {"id": 3, "label": "Node 3"},
        {"id": 4, "label": "Node 4", "color": "#228888"},
        {"id": 5, "label": "Node 5"}
    ],
    "edges": [
        {"from": 1, "to": 3, "label": "label"},
        {"from": 1, "to": 2},
        {"from": 2, "to": 4, "arrows": "to"},
        {"from": 2, "to": 5}
    ]
}
```
