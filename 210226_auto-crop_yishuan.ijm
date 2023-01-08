//Select a file and get the information of the file
filepath = File.openDialog("Select a File");
outputimage = getDirectory("Crop Image Output");
outputroi = getDirectory("ROI Output");
fullname = File.getName(filepath);
name = File.getNameWithoutExtension(filepath);

//*****Select rois and save them in roimanager first*****

//function scripts
n=roiManager("count");
function cropimage (filepath,fullname,name,outputimage){
	for (i=0;i<n;i++){
		//open the file
	    run("Bio-Formats", "open=["+filepath+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		selectWindow(fullname);
		roiManager("Select", i);
		run("Crop");
		//save cropped images
		if (i<10)
			saveAs("Tiff", outputimage+name+"-0"+(i+1)+".tif");
		else
			saveAs("Tiff", outputimage+name+(i+1)+".tif");
		close();
	}
}

//run function
cropimage(filepath,fullname,name,outputimage);

//save and clean ROI manager
x=newArray(n);
for (j=0;j<n;j++){
    x[j]=j;
}
roiManager("Select", x);
roiManager("Save", outputroi+"ROI_"+name+".zip");
roiManager("Delete");
