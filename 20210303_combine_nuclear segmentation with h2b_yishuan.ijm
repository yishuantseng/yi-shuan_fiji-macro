//Select Directories================================================================
h2binput = getDirectory("H2B Image Directory");
roioutput = getDirectory("ROI Directory");
geminput = getDirectory("GEM Image Directory");
cropoutput = getDirectory("Crop Image Destination");

//FUNTION SCRIPTS=====================================================================
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

//apply roi to gem image and crop images
function cropimage(geminput, roioutput, cropoutput, gemimage, roi) {
		roiManager("Open", roioutput+roi);
		n=roiManager("count");
		run("Bio-Formats", "open=["+geminput+gemimage+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");//to open images without the bioformats importer;
		imagename = File.getNameWithoutExtension(geminput+gemimage); //remove the extension of opened filename
		substring_roi=substring(roi, 4, 17); //extract name info from roi file
		substring_gemimage=substring(gemimage, 0, 13); //extract name info from gemimage files
		if (substring_roi==substring_gemimage){ //double check the gemimage name and roi name
			//apply roi set on the gem image
			for (j = 0; j < n; j++) {
				selectWindow(gemimage);
				roiManager("Select", j);
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

//get roi
//put filename, including extension, into list
h2b = getFileList(h2binput);

//run roiselection function
for (i = 0; i < h2b.length; i++)
        roiselection(h2binput, roioutput, h2b[i]);
if (isOpen("Log")){
	selectWindow("Log");
	saveAs("Text", cropoutput+"no-ROI.txt");
}
run("Close");
//================================================================
//apply roi to gem images and crop
//put filename, including extension, into list
gemimage = getFileList(geminput);
//print(gemimage.length); //original gemimage array
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
//for(i=0;i<gemimage.length;i++){
	//print(i+" "+gemimage[i]);
//}
//print(gemimage.length);

//run cropimage function
for (i = 0; i < gemimage.length; i++)
        cropimage(geminput, roioutput, cropoutput, gemimage[i], roi[i]);

        