# Dumps SNON data to a JSON graph representation
require "json"
require "socket"

# Get SNON data
print "Connecting to SNON device\n";
socket = TCPSocket.open("192.168.88.101", "200");
socket.print("{}\r\n");

print "Reading SNON data\n";
response = socket.gets;
response = socket.gets;
socket.close;

# Populate graph
print "Generating graph\n";
snon_data = JSON.parse(response);
snon_entities = Array.new();
snon_relations = Array.new();

snon_data.each do |fragment|
	node = Hash.new();
	node["id"] = fragment["eID"];
	node["label"] = fragment["eN"]["*"];
	node["group"] = fragment["eC"];
	node["title"] = "<pre>" + JSON.pretty_generate(fragment).gsub("\n", "<br>") + "</pre>";

	snon_entities << node;
end

snon_data.each do |fragment|
	if(fragment["eR"])
		fragment["eR"].each do |relation|
			relation[1].each do |destination|
				rel = Hash.new();
				rel["from"] = fragment["eID"];
				rel["to"] = destination;
				rel["arrows"] = "to";
				rel["label"] = relation[0];

				snon_relations << rel;
			end
		end
	end
end

graph = Hash.new();
graph["nodes"] = snon_entities;
graph["edges"] = snon_relations;

# Write out the JSON
print "Writing graph to graph.json\n";
file = File.open("graph.json", "w");
file.write(JSON.pretty_generate(graph));
file.close();