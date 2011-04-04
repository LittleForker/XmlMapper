
import System
import System.IO
import System.Collections
import System.Xml
import System.Net
import System.Text
import System.Windows.Forms

import Saxon.Api from "saxon9he-api"

class Merger(Object):

	def MergeDocuments(xslPath as string):  
		basePath = System.IO.Directory.GetCurrentDirectory()
		xslPath = basePath + "\\" + xslPath
		print xslPath
		
		memoryStream = MemoryStream();
		outMemoryStream = MemoryStream(1024);

		#origine fittizia
		xmlDocument = XmlDocument()
		xmlDocument.AppendChild(xmlDocument.CreateXmlDeclaration("1.0", "utf-8", "yes"));
		documentElement = xmlDocument.CreateElement("Root");
		xmlDocument.AppendChild(documentElement);

		xmlDocument.Save(memoryStream);


		memoryStream.Seek(0, SeekOrigin.Begin);

		processor = Processor();

		transformer = processor.NewXsltCompiler().Compile(Uri(xslPath)).Load();

		# Set the root node of the source document to be the initial context node
		transformer.SetInputStream(memoryStream, Uri("http://casa.it"));
		#transformer.SetParameter(QName("", "", "files"), XdmAtomicValue("dbinfo.xml;webdata.xml;xmldata.xml"));

		# Create a serializer, with output to the standard output stream
		serializer = Serializer();
		#serializer.SetOutputStream(outMemoryStream);

		sb = StringBuilder();
		tw = StringWriter(sb);
		serializer.SetOutputWriter(tw);



		# Transform the source XML and serialize the result document
		transformer.Run(serializer);


		result = XmlDocument();
		result.LoadXml(sb.ToString());

		return result;
		
merger = Merger();

print "merge started"
xmlDoc = merger.MergeDocuments("xsl\\merge.xslt")
print "merge finished"

xmlDoc.Save("result.xml")