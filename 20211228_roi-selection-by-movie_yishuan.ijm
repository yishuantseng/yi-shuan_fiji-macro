//Select Directories================================================================
input = getDirectory("Movie Directory");
roioutput = getDirectory("ROI Directory");
//cropoutput = getDirectory("Crop Image Destination");

//HOUSEKEEPING SCRIPTS===============================================================

//put filename, including extension, into list
//h2b = getFileList(h2binput);
//roi = getFileList(roioutput);

//select roi from h2b files
function roiselection(input,roioutput,gemimage) {
        //open(h2binput+filename); //to open images without the bioformats importer
        //run("Bio-Formats", "open=["+h2binput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
        run("Bio-Formats", "open=["+input+gemimage+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		imagename = File.getNameWithoutExtension(input+gemimage);
		run("Duplicate...", "title=t1_"+gemimage);
		selectWindow("t1_"+gemimage);
		save(roioutput+"t1_"+imagename+".tif");
		run("ROI Manager...");
		waitForUser("check ROI");
		roiManager("Add");
		//save roi set into a zip file and clean roimanager
		n=roiManager("count");
		if (n>0) {
			x=newArray(n);
			for (j=0;j<n;j++){
				x[j]=j;
			}
			roiManager("Select", x);
			roiManager("Save", roioutput+imagename+".zip");
			roiManager("Select", x);
			roiManager("Delete");
			run("Close All");
		}
		else {	
			print(i+"\t"+gemimage);
			close();
		}
}
//CONDUCTING SCRIPTS===================================================================

allfiles = getFileList(input);
//for test
//for (i = 0; i < 2; i++) {
//	roiselection(input,roioutput,allfiles[i]);
//}

//get roi_if there are only movie files
for (i = 0; i < allfiles.length; i++) {
	roiselection(input,roioutput,allfiles[i]);
}

//get roi_if movie is odd number (i=0.2.4)
//for (i = 0; i < h2b.length; i++) {
//	roiselection(input,h2bfiles, roioutput, h2b[i], allfiles[2*i]);
//}

//get roi_if movie is even number (i=1.3.5)
//for (i = 0; i < h2b.length; i++) {
	//if (i==0) {
	//roiselection(input,h2bfiles, roioutput, h2b[i], allfiles[i]);
	//}
	//else {
	//roiselection(input,h2bfiles, roioutput, h2b[i], allfiles[2*i+1]);
	//}
//}
//if (isOpen("Log")){
	//selectWindow("Log");
	//saveAs("Text", cropoutput+"no-ROI.txt");
//}
//run("Close");