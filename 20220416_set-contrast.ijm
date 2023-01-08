input = getDirectory("Image Directory");
output = getDirectory("output Directory");

allfiles = getFileList(input);
Array.sort(allfiles);

function setcontrast(input,output, filename){
	open(input+filename);
    selectWindow(filename);
    Stack.setChannel(3);
	setMinAndMax(90, 400);
    Stack.setChannel(4);
	setMinAndMax(125, 4000);
    Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	Stack.setActiveChannels("0011");
	run("RGB Color");
	saveAs("Tiff", output+filename+"(RGB).tif");
	run("Close All");
}

for (i =0; i < allfiles.length; i=i+1) {
	setcontrast(input,output, allfiles[i]);
}

//for (i =0; i < allfiles.length; i=i+1) {
	//setcontrast(input,output, allfiles[i]);
//}


