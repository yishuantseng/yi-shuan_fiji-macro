input = getDirectory("Image Directory"); //not movie file
roioutput = getDirectory("ROI Directory");

function roiselection(input,roioutput,filename) {
        //open(input+filename);
        //selectWindow(filename);
        //run("Duplicate...", "duplicate");
        imagename = File.getNameWithoutExtension(input+filename); //remove the extension of the filename
        //print(filename);
        makeRectangle(20, 20, 984, 984);
		roiManager("Add");
		roiManager("Select", 0);
		roiManager("Save", roioutput+imagename+".roi");
		roiManager("Select", 0);
		roiManager("Delete");
		//run("Close All");
}

allfiles = getFileList(input);
Array.sort(allfiles);

open(input+allfiles[0]); //use a single image as a template to save the same roi with different filenames
for (i = 0; i < allfiles.length; i=i+1) {
	if (endsWith(allfiles[i], ".tif")) {
		roiselection(input,roioutput, allfiles[i]);
		}
	}
