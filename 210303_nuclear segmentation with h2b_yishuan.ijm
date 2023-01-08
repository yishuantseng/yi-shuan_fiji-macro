//Select Directories================================================================
h2binput = getDirectory("H2B Image Directory");
roioutput = getDirectory("ROI Directory");
cropoutput = getDirectory("Crop Image Destination");

//HOUSEKEEPING SCRIPTS===============================================================

//put filename, including extension, into list
h2b = getFileList(h2binput);
//roi = getFileList(roioutput);

//select roi from h2b files
function roiselection(h2binput, roioutput, filename) {
        //open(h2binput+filename); //to open images without the bioformats importer
        run("Bio-Formats", "open=["+h2binput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
        imagename = File.getNameWithoutExtension(h2binput+filename); //remove the extension of opened filename
		//select roi and add them into roi manager
		run("Smooth");
		setAutoThreshold("Yen dark");
		setOption("BlackBackground", true);
		waitForUser("select threshold");
		run("Convert to Mask");
		run("Erode");
		//run("Erode");
		//run("Erode");
		run("Fill Holes");
		run("Remove Outliers...", "radius=24 threshold=50 which=Bright");
		run("Dilate");
		run("Dilate");
		//run("Dilate");
		//run("Fill Holes");
		run("Watershed");
		run("Analyze Particles...", "size=25-Infinity circularity=0.4-1.00 add");
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
			close();
		}
		else {	
			print(i+"\t"+filename);
			close();
		}
}
//CONDUCTING SCRIPTS===================================================================

//get roi
for (i = 0; i < h2b.length; i++)
        roiselection(h2binput, roioutput, h2b[i]);
if (isOpen("Log")){
	selectWindow("Log");
	saveAs("Text", cropoutput+"no-ROI.txt");
}
run("Close");