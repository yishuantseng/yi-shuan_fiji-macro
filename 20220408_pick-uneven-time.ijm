input = getDirectory("Image Directory");
output = getDirectory("Output Directory");
allfiles = getFileList(input);
Array.sort(allfiles);

function pickuneven (input,gemimage) {
	run("Bio-Formats", "open=["+input+gemimage+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	selectWindow(gemimage);
	time = Property.get("dAvgPeriodDiff");
	//if (time < 10){
		print(i+"\t"+gemimage+"\t"+time);
	//}
	run("Close All");
}


//get roi_if movie is odd number (i=0.2.4)
for (i =0; i < allfiles.length; i=i+2) {
	if (endsWith(allfiles[i], ".tif")) {
		pickuneven(input,allfiles[i]);
	}
}

selectWindow("Log");
saveAs("Text", output+"avgtime.txt");
run("Close");