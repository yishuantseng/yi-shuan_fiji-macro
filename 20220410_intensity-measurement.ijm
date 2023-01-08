input = getDirectory("Image Directory");
roioutput = getDirectory("ROI Directory");

function roiselection(input,roioutput,filename) {
        open(input+filename);
        selectWindow(filename);
        //run("Duplicate...", "duplicate");
        imagename = File.getNameWithoutExtension(input+filename); //remove the extension of opened filename
        //print(filename);
        makeRectangle(345, 308, 25, 25);
		waitForUser("check ROI");
		//save roi set into a zip file and clean roimanager
		n=roiManager("count");
		if (n!=4){
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

for (i =234; i < allfiles.length; i=i+1) {
	if (endsWith(allfiles[i], ".tif")) {
		roiselection(input,roioutput, allfiles[i]);
		}
	}
