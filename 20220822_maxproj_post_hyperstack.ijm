imagefolder = getDirectory("Image Directory");
hyperfolder = getDirectory("Hyperstack Directory");
maxfolder = getDirectory("Maxproj Image Directory");


function maxproject(imageinput, maxoutput, hyperoutput, filename){
	open(hyperoutput+"Hyper_"+filename);
	//run("Bio-Formats", "open=["+imageinput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	imagename = File.getNameWithoutExtension(imageinput+filename);
	selectWindow("Hyper_"+imagename+".tif");
	run("Z Project...", "projection=[Max Intensity] all");
	selectWindow("MAX_"+"Hyper_"+filename);
	saveAs("Tiff", maxoutput+"MAX_"+imagename+".tif");
	run("Close All");
}


image=getFileList(imagefolder);

for(i=0;i<image.length;i++){
	maxproject(imagefolder,maxfolder,hyperfolder, image[i]);
}


//for(i=0;i<2;i++){
//	maxproject(imagefolder,maxfolder,hyperfolder,image[i]);
//}