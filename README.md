#ABOUT:
This software takes in barcoded fastq files and outputs the number of reads reflecting each varaint.

##TO USE:

Download the file and unarchive as you choose. All contents can be found at github.com/susinmotion/MDS_UserVersion. An easy-to-read version of this document can also be found at that URL.

##RUNNING THE PROGRAM:

Type `./shell.sh >output.txt&` and press enter. <br>
A debug file will be saved to "output.txt". The end of this file will say "I'm done" when the program has finished running<br>
The process could take between 15 minutes and 12 hours, depending on the memory of your computer and the size of the files.

##RESULTS:
An output file will be created for each ROI(Gene) and Phase listed, named [GENE]_[PHASE].txt and including a list of variants and counts for a given ROI/Phase.
~~In addition, users can opt to output a file named "summary.txt" containing variants for each barcode for all ROI/phase combinations by setting OUTPUT_SUMMARY_FILE TRUE in the config file. This file is HUGE and will take up valuable memory. Setting this parameter is not recommended.~~

##SETTING PARAMETERS:
Below is an explanation of the components of the user interface. 

`My data is zipped`<br>
Click the box if your data is zipped. 

`Filenames, comma separated`<br>
List of input files, comma separated (eg. example.fastq.gz,example2.fastq.gz). 
All files for a given run must be zipped or unzipped. Each file must be zipped separately, but the program can tolerate a number of zipped formats. Special characters (| ' " ` , : ;) are not permitted in filenames.

`Inclusion Threshold`<br>
How many reads of the same barcode constitutes a trial. Reads that don't meet this threshold will be excluded from analyses. The recommended lower limit for this value is 3. range 1-20*DO WE WANT TO GIVE THE USER THE OPTION TO PUT IN MANY VALUES FOR THIS?*

`Number of ROIs`<br>
Number of genes to be analyzed. range 1-10.

`Barcode Length`<br>
Number of random bases that constitute a barcode

`Create ROIs`<br>
Pressing this button opens an ROI window for each of the ROIs indicated in *Number of ROIs*.

###ROI WINDOW PARAMETERS

`gene`<br>
Name of the gene of interest, used for labeling output files. 

`fwd. align sequence`<br>
`target sequence`<br>
`rev. align sequence`<br>

The program handles reverse complements, so no need to list these separately. Targets should not include the alignment sequences. 

`Max Phase`<br>
The greatest number of bases preceding the barcode. For example, if you have reads with 0, 2, 6, and 7 bases preceding the barcode, put 7 here. Setting this parameter causes fields for phase shifts to be shown.

`Fwd. phase <-> rev. phase` <br>
If the phases from reverse complement reads do not correspond directly to those in forward reads, phase shifts may be listed here. 
At this point, output files for all phases in the phase range are created regardless of whether data from these phases is present in the sample. Make sure that phases of interest in reverse complement reads are mapped to phases of interest in forward reads.

##UNDERSTANDING YOUR RESULTS:
Three sets of files will be output:

~~* summary_IMPORTANT.txt~~
* [GENE]_[PHASE].txt, for each gene/phase combination
* [GENE]_[PHASE]matrix.txt, for each gene/phase combination

~~**summary_IMPORTANT.txt** includes a list of all barcodes that met the threshold of importance, any variants found, and the number of times they were encountered for each phase/gene combination.~~


**[GENE]_[PHASE].txt files** contain the name of the gene, the phase number, the number of barcodes with sufficient reads in this ROI/phase (this threshold is user set in "config.cfg"), the total number of variants found, and a list of variants.
Substitutions are noted Position Base TimesFound
Indels are noted Position Length TimesFound. A negative length indicates a deletion; a positive length indicates an insertion.

example gene1_0.txt:
```
ROI: gene1
Phase: 0
Total nodes checked: 10
Total variants found: 4
1 G 46
1 N 1
2 N 1
2 1 1
2 -5 50
```
2 G 46 denotes that the third base (position 2, starting at 0) was replaced by G 46 times in the sample.
2 -5 50 denotes that a deletion of 5 base pairs starting at the 3rd base (position 2) was found 50 times in the sample. 

**[GENE]_[PHASE]matrix.txt files** contain 5 rows and n columns, where n is the length of the target sequence. Each row indicates a base (A,C,G,T,N) and each column indicates a position in the target sequence, so a row/column pair represents a particular substitution. Numbers in each position in the matrix represent the proportion (of the total number of substitutions for that gene/phase combo) that that substitution was found.

