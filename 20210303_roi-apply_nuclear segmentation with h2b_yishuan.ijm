//Select Directories================================================================
roioutput = getDirectory("ROI Directory");
geminput = getDirectory("GEM Image Directory");
cropoutput = getDirectory("Crop Image Destination");

//HOUSEKEEPING SCRIPTS===============================================================

//put filename, including extension, into list
gemimage = getFileList(geminput);
print(gemimage.length); //original gemimage array
roi = getFileList(roioutput);
if (File.exists(cropoutput+"no-ROI.txt")){"
	noroi=File.openAsString(cropoutput+"no-ROI.txt");
	rows=split(noroi,"\n");
	order=newArray(rows.length);
	name=newArray(rows.length);
	for(i=0;i<rows.length;i++){
		columns=split(rows[i], "\t");
		order[i]=parseInt(columns[0]);
		name[i]=columns[1];
	}
	re_order=Array.reverse(order);
	for(i=0;i<order.length;i++){
		gemimage=Array.deleteIndex(gemimage,re_order[i]);
	}
}
//check edited gemimage array
for(i=0;i<gemimage.length;i++){
	print(i+" "+gemimage[i]);
}
print(gemimage.length);

//FUNTION SCRIPTS=====================================================================
//apply roi to gem image and crop images
function cropimage(geminput, roioutput, cropoutput, gemimage, roi) {
		roiManager("Open", roioutput+roi);
		n=roiManager("count");
		run("Bio-Formats", "open=["+geminput+gemimage+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");//to open images without the bioformats importer;
		imagename = File.getNameWithoutExtension(geminput+gemimage); //remove the extension of opened filename
		substring_roi=substring(roi, 4, 17);
		substring_gemimage=substring(gemimage, 0, 13);
		if (substring_roi==substring_gemimage){
			//apply roi set on the gem image
			for (j = 0; j < n; j++) {
				selectWindow(gemimage);
				roiManager("Select", j);
				//run("Crop");
				run("Duplicate...", "duplicate");
				if (j<10) //save the cropped file. edit if you can to change the filename style
					saveAs("Tiff", cropoutput+imagename+"_00"+(j+1)+".tif");
				else {
					saveAs("Tiff", cropoutput+imagename+"_0"+(j+1)+".tif");
				}
			}
			//clean roimanager
			x=newArray(n);
			for (k=0;k<n;k++){
				x[k]=k;
			}
			roiManager("Select", x);
			roiManager("Delete");
			run("Close All");
		}
} 

//CONDUCTING SCRIPTS===================================================================
        
//apply roi to gem images and crop
for (i = 0; i < gemimage.length; i++)
        cropimage(geminput, roioutput, cropoutput, gemimage[i], roi[i]);




