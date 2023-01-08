imagefolder = getDirectory("Image Directory");
hyperfolder = getDirectory("Hyperstack Directory");
maxfolder = getDirectory("Maxproj Image Directory");


function maxproject(imageinput, maxoutput, hyperoutput, filename){
	open(imageinput+filename);
	//run("Bio-Formats", "open=["+imageinput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	imagename = File.getNameWithoutExtension(imageinput+filename);
	selectWindow(filename);
	getDimensions(width, height, channels, slices, frames);
	if (slices>600){
		run("Stack to Hyperstack...", "order=xyczt(default) channels=2 slices=29 frames=12 display=Color");
	}
	if ((slices>300) && (slices <600)){
		run("Stack to Hyperstack...", "order=xyczt(default) channels=2 slices=29 frames=7 display=Color");
	}
	if (slices<300){
		run("Stack to Hyperstack...", "order=xyczt(default) channels=2 slices=29 frames=1 display=Color");
	}
	getDimensions(width, height, channels, slices, frames);
	//print(width, height, channels, slices, frames);
	run("Channels Tool...");
	Stack.setChannel(1);
	run("Grays");
	Stack.setChannel(2);
	run("Green");
	if (channels==3){
		Stack.setChannel(3);
		run("Red");
	}
	if (channels==4){
		Stack.setChannel(3);
		run("Red");
		Stack.setChannel(4);
		run("Magenta");
	}
	selectWindow(filename);
	saveAs("Tiff", hyperoutput+"Hyper_"+imagename+".tif");
	selectWindow("Hyper_"+imagename+".tif");
	run("Z Project...", "projection=[Max Intensity] all");
	selectWindow("MAX_"+"Hyper_"+filename);
	saveAs("Tiff", maxoutput+"MAX_"+imagename+".tif");
	run("Close All");
}

function maxproject02(imageinput, maxoutput, filename){
	//open(imageinput+filename);
	run("Bio-Formats", "open=["+imageinput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	imagename = File.getNameWithoutExtension(imageinput+filename);
	selectWindow(filename);
	run("Z Project...", "projection=[Max Intensity] all");
	saveAs("Tiff", maxoutput+"MAX_"+imagename+".tif");
	run("Close All");
}

//no z stack, and no max projection
function maxproject03(imageinput, maxoutput, hyperoutput, filename){
	open(imageinput+filename);
	//run("Bio-Formats", "open=["+imageinput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	imagename = File.getNameWithoutExtension(imageinput+filename);
	selectWindow(filename);
	getDimensions(width, height, channels, slices, frames);
	run("Stack to Hyperstack...", "order=xyczt(default) channels=4 slices=1 frames=13 display=Color");
	getDimensions(width, height, channels, slices, frames);
	//print(width, height, channels, slices, frames);
	run("Channels Tool...");
	Stack.setChannel(1);
	run("Grays");
	Stack.setChannel(2);
	run("Green");
	if (channels==3){
		Stack.setChannel(3);
		run("Red");
	}
	if (channels==4){
		Stack.setChannel(3);
		run("Red");
		Stack.setChannel(4);
		run("Magenta");
	}
	selectWindow(filename);
	saveAs("Tiff", hyperoutput+"Hyper_"+imagename+".tif");
	selectWindow("Hyper_"+imagename+".tif");
	//run("Z Project...", "projection=[Max Intensity] all");
	//selectWindow("MAX_"+"Hyper_"+filename);
	//saveAs("Tiff", maxoutput+"MAX_"+imagename+".tif");
	run("Close All");
}


//no time lapse, sum projection
function maxproject04(imageinput, maxoutput, hyperoutput, filename){
	open(imageinput+filename);
	//run("Bio-Formats", "open=["+imageinput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	imagename = File.getNameWithoutExtension(imageinput+filename);
	selectWindow(filename);
	getDimensions(width, height, channels, slices, frames);
	run("Stack to Hyperstack...", "order=xyczt(default) channels=4 slices=13 frames=1 display=Color");
	getDimensions(width, height, channels, slices, frames);
	//print(width, height, channels, slices, frames);
	run("Channels Tool...");
	Stack.setChannel(1);
	run("Grays");
	Stack.setChannel(2);
	run("Blue");
	Stack.setChannel(3);
	run("Green");
	Stack.setChannel(4);
	run("Magenta");
	}
	selectWindow(filename);
	saveAs("Tiff", hyperoutput+"Hyper_"+imagename+".tif");
	selectWindow("Hyper_"+imagename+".tif");
	run("Z Project...", "projection=[Sum Slices] all");
	selectWindow("SUM_"+"Hyper_"+filename);
	saveAs("Tiff", maxoutput+"SUM_"+imagename+".tif");
	run("Close All");
}
image=getFileList(imagefolder);

for(i=0;i<image.length;i++){
	maxproject04(imagefolder,maxfolder,hyperfolder, image[i]);
}


//for(i=0;i<2;i++){
//	maxproject(imagefolder,maxfolder,hyperfolder,image[i]);
//}