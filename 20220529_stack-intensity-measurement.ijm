input = getDirectory("Image Directory");
roioutput = getDirectory("ROI Directory");

function roiselection(input,roioutput,filename) {
        open(input+filename);
        selectWindow(filename);
        //run("Duplicate...", "duplicate");
        imagename = File.getNameWithoutExtension(input+filename); //remove the extension of opened filename
        //print(filename);
        selectWindow(filename);
        Stack.setChannel(3);
        setMinAndMax(80, 130);
		Stack.setChannel(4);
		setMinAndMax(105, 750);
        makeRectangle(345, 308, 25, 25);
		waitForUser("check ROI");
		//save roi set into a zip file and clean roimanager
		n=roiManager("count");
		if (n<1){
			waitForUser("check ROI");
			n=roiManager("count");
		}
		if (n%2 == 1){
			waitForUser("check ROI");
			n=roiManager("count");
		}
		if (n>0) {
			x=newArray(n);
			for (j=0;j<n;j++){
				x[j]=j;
				roiManager("Select", j);
				//print(j+", type="+Roi.getType);
			}
			selectWindow(filename);
			run("Split Channels");
			selectWindow("C3-"+filename);
			roiManager("Select", x);
			roiManager("Measure")
			roiManager("Save", roioutput+imagename+".zip");
			roiManager("Select", x);
			roiManager("Delete");
			run("Close All");
		}
		else {	
			print(i+"\t"+filename);
			run("Close All");
		}
	
}

allfiles = getFileList(input);
Array.sort(allfiles);
//run("Set Measurements...", "area mean min integrated display redirect=None decimal=3");
for (i =245; i < allfiles.length; i=i+2) {
	if (endsWith(allfiles[i], ".tif")) {
		roiselection(input,roioutput, allfiles[i]);
		}
	}
