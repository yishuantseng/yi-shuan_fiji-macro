input = getDirectory("Image Directory");
h2bfiles = getDirectory("H2B Image Directory");
roioutput = getDirectory("ROI Directory");

//select roi from h2b files
function roiselection(input,h2binput, roioutput, filename, gemimage,pre) {
        //open(h2binput+filename); //to open images without the bioformats importer
        //run("Bio-Formats", "open=["+h2binput+filename+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
        open(h2binput+pre+filename);
        run("Bio-Formats", "open=["+input+gemimage+"] autoscale color_mode=Grayscale rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
        selectWindow(pre+filename);
        //run("Duplicate...", "duplicate");
        imagename = File.getNameWithoutExtension(h2binput+pre+filename); //remove the extension of opened filename
		waitForUser("check ROI");
		//save roi set into a zip file and clean roimanager
		n=roiManager("count");
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
			print(i+"\t"+"H2B_"+filename);
			run("Close All");
		}
	
}
//CONDUCTING SCRIPTS===================================================================

//f_list = newArray("Ctrl-MeOH_0min_vLH26_60x_021.tif","Ctrl-MeOH_15min_vLH26_60x_021.tif","Ctrl-MeOH_30min_vLH26_60x_021.tif","Ctrl-MeOH_70min_vLH26_60x_021.tif","Ctrl-MeOH_5hr_vLH26_60x_021.tif");
f_list = newArray("Ctrl-DMSO_24hr_vLH26_60x_007.tif");
//Array.show(f_list);
//get roi_if movie is odd number (i=0.2.4)
for (i = 0; i < f_list.length; i++) {
	print(i);
	roiselection(input,h2bfiles, roioutput, f_list[i], f_list[i],"DNA_");
}
//for (i = 9; i < f_list.length; i++) {
	//roiselection(input,h2bfiles, roioutput, f_list[i], f_list[i],"H2B_");
//}
