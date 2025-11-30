<cfscript>
public any function XMLToStruct(required XML XMLObj, boolean CreateArrays=false) {
	var Node=StructNew("ordered-casesensitive");
	var Attribs=StructNew("ordered-casesensitive");
	var HoldNode="";
	var i=0; 
	var Key="";
	var AttribKey="";
	var AttribI=0;
	var tmp="";

	if (structKeyExists(XMLObj,"XmlRoot")) {
		if (Arguments.CreateArrays) {
			// Treat the root as an array and recurse past the root
			Node[XMLObj.XmlRoot.XmlName]=ArrayNew(1);
			Node[XMLObj.XmlRoot.XmlName][1]=XMLToStruct(XMLObj.XmlRoot, Arguments.CreateArrays);
		} else {
			// Recurfse past the root
			Node[XMLObj.XmlRoot.XmlName]=XMLToStruct(XMLObj.XmlRoot, Arguments.CreateArrays);
		}
		return Node;
	} else {
		if (ArrayLen(XMLObj.XmlChildren) EQ 0) {
			Node=XMLObj.XmlText.trim();
		} else {
			for (i=1; i LTE ArrayLen(XMLObj.XmlChildren); i++) {
				// Extract Node
				Key=XMLObj.XmlChildren[i].XmlName.trim();
				HoldNode=XMLToStruct(XMLObj.XmlChildren[i], Arguments.CreateArrays);
				if (StructKeyExists(Node,Key) EQ "NO")
				{
					if (Arguments.CreateArrays AND IsSimpleValue(HoldNode) EQ "NO") {
						// Set the node as an array
						Node[Key]=ArrayNew(1);
						Node[Key][1]=HoldNode;
					} else {
						// Set the node
						Node[Key]=HoldNode;
					}
				} else {
					if (IsArray(Node[Key]) EQ "NO") {
						// Key already exist, convert it to an array if not already one
						tmp=Node[Key];
						Node[Key]=ArrayNew(1);
						Node[Key][1]=tmp;
						if (StructKeyExists(Node,"#Key#.XmlAttributes")) {
							// Convert the attribs to an array
							tmp=Node["#Key#.XmlAttributes"];
							Node["#Key#.XmlAttributes"]=ArrayNew(1);
							Node["#Key#.XmlAttributes"][1]=tmp;
						}
					}
					// Append node
					AttribI=ArrayLen(Node[Key]) + 1;
					Node[Key][AttribI]=HoldNode;
				}
				// Check for Attributes
				if (StructCount(XMLObj.XmlChildren[i].XmlAttributes) GT 0) {
					// Extract node attributes
					Attribs=StructNew("ordered-casesensitive");
					for (AttribKey in StructKeyList(XMLObj.XmlChildren[i].XmlAttributes)) {
						Attribs[AttribKey]=XMLObj.XmlChildren[i].XmlAttributes[AttribKey];
					}
					if (StructKeyExists(Node,"#Key#.XmlAttributes") EQ "NO") {
						if (IsArray(Node[Key])) {
							// The main node is an array, set the attributes to be an array
							Node["#Key#.XmlAttributes"]=ArrayNew(1);
							Node["#Key#.XmlAttributes"][ArrayLen(Node[Key])]=Attribs;
						} else {
							// Set the attribs
							Node["#Key#.XmlAttributes"]=Attribs;
						}
					} else {
						if (IsArray(Node["#Key#.XmlAttributes"]) EQ "NO") {
							// Convert to an array
							tmp=Node["#Key#.XmlAttributes"];
							Node["#Key#.XmlAttributes"]=ArrayNew(1);
							Node["#Key#.XmlAttributes"][1]=tmp;
						}
						// Append the node
						Node["#Key#.XmlAttributes"][AttribI]=Attribs;
					}
				} else {
					if (StructKeyExists(Node,"#Key#.XmlAttributes")) {
						// If no attribs but preveious attribs set, define it as null
						Node["#Key#.XmlAttributes"][AttribI]=JavaCast("null", "");
					}
				}
			}
		}
	}
	
	return Node;
}
</cfscript>
