input = getDirectory("Image Directory");
sumfolder = getDirectory("SUM Directory");
maskfolder = getDirectory("mask Directory");
roioutput = getDirectory("ROI Directory");

function intmeasure(sumfolder, maskfolder, roioutput, filename){
	open(sumfolder+"SUM_"+filename);
	imagename = File.getNameWithoutExtension(filename);
	open(maskfolder+"DAPI_SUM_"+imagename+"_cp_masks.tif");
	run("Label image to ROIs", "rm=[RoiManager[size=15, visible=true]]");
	n=roiManager("count");
	x=newArray(n);
	for (j=0;j<n;j++){
		x[j]=j;
		roiManager("Select", j);
		//print(j+", type="+Roi.getType);
	}
	roiManager("Select", x);
	selectWindow("SUM_"+filename);
	Stack.setChannel(3);
	roiManager("Measure")
	roiManager("Save", roioutput+"DNA_"+imagename+".zip");
	roiManager("Select", x);
	roiManager("Delete");
	run("Close All");
    
}


allfiles = getFileList(input);
Array.sort(allfiles);
run("Set Measurements...", "area mean standard min integrated kurtosis display redirect=None decimal=3");
for (i=0;i<allfiles.length; i++){
	if (endsWith(allfiles[i], ".tif")) {
			intmeasure(sumfolder, maskfolder, roioutput, allfiles[i]);
			}
}
//allfiles.length
