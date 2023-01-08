h2bfolder = getDirectory("H2B Image Directory");
roifolder = getDirectory("ROI Directory");
maskfolder = getDirectory("Mask Directory");

function createmask(inputfolder, roifolder, maskfolder, image, roi) {
	roiManager("Open", roifolder+roi);
	run("Bio-Formats", "open=["+inputfolder+image+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	imagename = File.getNameWithoutExtension(inputfolder+image); //remove the extension of opened filename
	selectWindow(image);
	roiManager("Combine");
	run("Create Mask");
	selectWindow("Mask");
	saveAs("Tiff", maskfolder+imagename+"_mask.tif");
	n=roiManager("count");
	x=newArray(n);
		for (k=0;k<n;k++){
			x[k]=k;
		}
	roiManager("Select", x);
	roiManager("Delete");
	run("Close All");
}

h2b=getFileList(h2bfolder);
roi=getFileList(roifolder);

for (i=0; i< h2b.length; i++)
	createmask(h2bfolder,roifolder,maskfolder,h2b[i],roi[i]);