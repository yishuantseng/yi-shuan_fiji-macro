input = getDirectory("Image Directory");
h2bfiles = getDirectory("H2B Image Directory");

function splitchannel(input,h2bfiles,filename,name) {
		run("Bio-Formats", "open=["+input+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		selectWindow(filename);
		run("Split Channels");
		selectWindow("C5-"+filename);
		imagename = File.getNameWithoutExtension(input+name); //remove the extension of opened filename
		saveAs("Tiff",h2bfiles+"5EU_"+imagename+".tif");
		run("Close All");
}

allfiles = getFileList(input);
Array.sort(allfiles);
//Array.show(allfiles);

//process every other files
//for (i = 0; i < allfiles.length; i++) {
    //if (i%2==1) {
    //print (i);
    //splitchannel(input, h2bfiles, allfiles[i],allfiles[i-1]);
    //}
//}

//process every files
for (i = 0; i < allfiles.length; i++) {
    splitchannel(input, h2bfiles, allfiles[i],allfiles[i]);
}