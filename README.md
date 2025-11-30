# XMLToStruct
Convert an XML to a ColdFusion structure

This function was more of an exercise after stumbling across a similar function on Ben Nadel's [page](https://www.bennadel.com/blog/4193-ask-ben-converting-an-xml-document-into-a-nested-coldfusion-struct.htm)
to handle XML that also includes multiple elements and attributes. This function, however, does not hanlde an XML node that has child elements as well as node text.

Syntax:
<code>XMLToStruct(XML, *&lt;CreateArrays [true|false]&gt;*)</code>

```xml
<notes>
	<sent>
		<to>Mike</to>
		<message>Please don't forget the donuts</message>
	</sent>
	<received>
		<from>Roger</from>
		<message>I'll look for them</message>
	</received>
	<received>
		<from>Roger</from>
		<message>Found them!</message>
	</received>
</notes>
```
<code>writeoutput(XML);</code><br>
<img width="442" height="463" alt="image" src="https://github.com/user-attachments/assets/ca1aa512-f9d8-421c-93cd-0cebc5edabd9" />

XML Nodes that exist only once are not created as an array by default, but if *true* is passed as the second parameter to XMLToStruct, all nodes are created as arrays.

<code>writeoutput(XML,true);</code><br>
<img width="510" height="562" alt="image" src="https://github.com/user-attachments/assets/12c6c141-443b-48d4-b0c1-aa82e9488705" />

Taking a partial sample from [Microsoft Learn's site]([https://www.bennadel.com/blog/4193-ask-ben-converting-an-xml-document-into-a-nested-coldfusion-struct.htm](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/ms762271(v=vs.85)))
that contains complex structures including attributes.
```xml
<PurchaseOrder OrderID="PO12345">
	<Customer>
		<Name>John Doe</Name>
		<Address>
			<Street>123 Main St</Street>
			<City>Anytown</City>
			<ZipCode>12345</ZipCode>
		</Address>
	</Customer>
	<Items>
		<Item ID="A001">
			<Description>Laptop</Description>
			<Quantity>1</Quantity>
			<Price>1200.00</Price>
		</Item>
		<Item ID="B002">
			<Description>Mouse</Description>
			<Quantity>2</Quantity>
			<Price>25.00</Price>
		</Item>
	</Items>
	<TotalAmount Currency="USD">1250.00</TotalAmount>
</PurchaseOrder>
```
<code>writeoutput(XML);</code><br>
<img width="780" height="1000" alt="image" src="https://github.com/user-attachments/assets/e2908448-2c69-43d4-9c3c-74daa4d0b522" />

The XML Attributes variable is defined as an array if the node is also of an array. If a node doesn't have attributes while others do, the array element is defined as a null. The function <code>arrayIsDefined</code> can be used to determine the existance of it.
<code>writeoutput(XML);</code><br>
```xml
<doc>
	<item>a</item>
	<item d="1">b</item>
	<item>c</item>
</doc>
```
<code>writeoutput(XML);</code><br>
<img width="496" height="417" alt="image" src="https://github.com/user-attachments/assets/c05d2379-c754-4ea4-9d0b-1a897547d9cb" />

