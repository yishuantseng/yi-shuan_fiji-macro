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
        roiManager("Open", h2binput+imagename+".zip");
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

f_list = newArray("Ctrl-MeOH_0min_vLH78_vLH80-20uL_60x_027.tif","Ctrl-MeOH_30min_vLH78_vLH80-20uL_60x_025.tif","Ctrl-MeOH_1hr_vLH78_vLH80-20uL_60x_019.tif","Ctrl-MeOH_1hr_vLH78_vLH80-20uL_60x_021.tif","Ctrl-MeOH_2hr_vLH78_vLH80-20uL_60x_019.tif","Ctrl-MeOH_3hr_vLH78_vLH80-20uL_60x_011.tif","Ctrl-MeOH_3hr_vLH78_vLH80-20uL_60x_025.tif","Ctrl-MeOH_4hr_vLH78_vLH80-20uL_60x_031.tif","Ctrl-MeOH_5hr_vLH78_vLH80-20uL_60x_003.tif","Ctrl-MeOH_5hr_vLH78_vLH80-20uL_60x_005.tif","Ctrl-MeOH_5hr_vLH78_vLH80-20uL_60x_023.tif","Ctrl-MeOH_5hr_vLH78_vLH80-20uL_60x_031.tif","LMB_0min_vLH78_vLH80-20uL_60x_009.tif","LMB_0min_vLH78_vLH80-20uL_60x_027.tif","LMB_30min_vLH78_vLH80-20uL_60x_009.tif","LMB_30min_vLH78_vLH80-20uL_60x_015.tif","LMB_30min_vLH78_vLH80-20uL_60x_027.tif","LMB_30min_vLH78_vLH80-20uL_60x_031.tif","LMB_1hr_vLH78_vLH80-20uL_60x_013.tif","LMB_1hr_vLH78_vLH80-20uL_60x_019.tif","LMB_1hr_vLH78_vLH80-20uL_60x_023.tif","LMB_1hr_vLH78_vLH80-20uL_60x_031.tif","LMB_2hr_vLH78_vLH80-20uL_60x_015.tif","LMB_2hr_vLH78_vLH80-20uL_60x_017.tif","LMB_2hr_vLH78_vLH80-20uL_60x_019.tif","LMB_3hr_vLH78_vLH80-20uL_60x_007.tif","LMB_3hr_vLH78_vLH80-20uL_60x_023.tif","LMB_3hr_vLH78_vLH80-20uL_60x_031.tif","LMB_4hr_vLH78_vLH80-20uL_60x_001.tif","LMB_4hr_vLH78_vLH80-20uL_60x_003.tif","LMB_4hr_vLH78_vLH80-20uL_60x_013.tif","LMB_4hr_vLH78_vLH80-20uL_60x_023.tif","LMB_4hr_vLH78_vLH80-20uL_60x_027.tif","LMB_4hr_vLH78_vLH80-20uL_60x_031.tif","LMB_5hr_vLH78_vLH80-20uL_60x_001.tif","LMB_5hr_vLH78_vLH80-20uL_60x_005.tif","LMB_5hr_vLH78_vLH80-20uL_60x_009.tif","LMB_5hr_vLH78_vLH80-20uL_60x_015.tif","LMB_5hr_vLH78_vLH80-20uL_60x_027.tif","LMB_5hr_vLH78_vLH80-20uL_60x_031.tif");
//f_list = newArray("Ctrl-DMSO_1hr_vLH78_vLH80-20uL_60x_007.tif","Ctrl-DMSO_2hr_vLH78_vLH80-20uL_60x_007.tif","Ctrl-DMSO_2hr_vLH78_vLH80-20uL_60x_029.tif","Ctrl-DMSO_3hr_vLH78_vLH80-20uL_60x_007.tif","Ctrl-DMSO_3hr_vLH78_vLH80-20uL_60x_029.tif","Ctrl-DMSO_4hr_vLH78_vLH80-20uL_60x_005.tif","Ctrl-DMSO_4hr_vLH78_vLH80-20uL_60x_015.tif","Selinexor_0min_vLH78_vLH80-20uL_60x_009.tif","Selinexor_0min_vLH78_vLH80-20uL_60x_021.tif","Selinexor_0min_vLH78_vLH80-20uL_60x_027.tif","Selinexor_1hr_vLH78_vLH80-20uL_60x_017.tif","Selinexor_1hr_vLH78_vLH80-20uL_60x_021.tif","Selinexor_1hr_vLH78_vLH80-20uL_60x_025.tif","Selinexor_1hr_vLH78_vLH80-20uL_60x_027.tif","Selinexor_3hr_vLH78_vLH80-20uL_60x_009.tif","Selinexor_3hr_vLH78_vLH80-20uL_60x_021.tif","Selinexor_3hr_vLH78_vLH80-20uL_60x_023.tif","Selinexor_3hr_vLH78_vLH80-20uL_60x_025.tif","Selinexor_3hr_vLH78_vLH80-20uL_60x_027.tif","Selinexor_2hr_vLH78_vLH80-20uL_60x_015.tif","Selinexor_2hr_vLH78_vLH80-20uL_60x_021.tif","Selinexor_2hr_vLH78_vLH80-20uL_60x_023.tif","Selinexor_2hr_vLH78_vLH80-20uL_60x_025.tif","Selinexor_2hr_vLH78_vLH80-20uL_60x_027.tif","Selinexor_4hr_vLH78_vLH80-20uL_60x_005.tif","Selinexor_4hr_vLH78_vLH80-20uL_60x_009.tif","Selinexor_4hr_vLH78_vLH80-20uL_60x_023.tif","Selinexor_4hr_vLH78_vLH80-20uL_60x_025.tif","Selinexor_4hr_vLH78_vLH80-20uL_60x_027.tif","Selinexor_5hr_vLH78_vLH80-20uL_60x_021.tif","Selinexor_5hr_vLH78_vLH80-20uL_60x_023.tif","Selinexor_5hr_vLH78_vLH80-20uL_60x_025.tif","Selinexor_5hr_vLH78_vLH80-20uL_60x_027.tif");
//f_list = newArray("Ctrl-DMSO_24hr_vLH26_60x_007.tif");
//Array.show(f_list);
//get roi_if movie is odd number (i=0.2.4)
for (i = 0; i < f_list.length; i++) {
	print(i);
	roiselection(input,h2bfiles, roioutput, f_list[i], f_list[i],"DNA_");
}
//for (i = 9; i < f_list.length; i++) {
	//roiselection(input,h2bfiles, roioutput, f_list[i], f_list[i],"H2B_");
//}

