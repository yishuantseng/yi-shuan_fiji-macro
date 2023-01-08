//Select Directories================================================================
input = getDirectory("Image Directory");
h2bfiles = getDirectory("H2B Image Directory");
roioutput = getDirectory("ROI Directory");

//cropoutput = getDirectory("Crop Image Destination");

//select roi from h2b files
function roiselection(input,h2binput, roioutput, filename, gemimage,pre,filename2) {
        //run("Bio-Formats", "open=["+h2binput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
        open(h2binput+pre+filename);
        open(input+filename2);
        run("Bio-Formats", "open=["+input+gemimage+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
        selectWindow(pre+filename);
        //run("Duplicate...", "duplicate");
        imagename = File.getNameWithoutExtension(h2binput+pre+filename); //remove the extension of opened filename
        print(filename);
		waitForUser("check ROI");
		//save roi set into a zip file and clean roimanager
		n=roiManager("count");
		if (n<1){
			waitForUser("check ROI");
			n=roiManager("count");
		}
		if (n>0) {
			x=newArray(n);
			for (j=0;j<n;j++){
				x[j]=j;
				roiManager("Select", j);
				print(j+", type="+Roi.getType);
			}
			roiManager("Select", x);
			roiManager("Save", roioutput+imagename+".zip");
			roiManager("Select", x);
			roiManager("Delete");
			run("Close All");
		}
		else {	
			print(i+"\t"+pre+filename);
			run("Close All");
		}
	
}
//CONDUCTING SCRIPTS===================================================================

allfiles = getFileList(input);
Array.sort(allfiles);
//h2b = getFileList(h2bfiles);
//Array.sort(h2b);

//get roi_if movie is odd number (i=0.2.4)
for (i =0; i < allfiles.length; i=i+2) {
	print(i);
	roiselection(input,h2bfiles, roioutput, allfiles[i], allfiles[i],"DNA_",allfiles[i+1]);
}

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