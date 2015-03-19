---
title: "Code Book for Getting and Cleaning Data Course Project"
author: "Chris Clark"
date: "Wednesday, March 18, 2015"

---

##Brief description of source data
The source data was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .  
Within that zipfile, you can refer to features_info.txt as well as README.txt for more information.  
In summary, subjects were observed carrying out certain activities while wearing a smartphone on their waist. The smartphone measured triaxial linear acceleration and angular velocity (tBodyGyro) at a rate of 50hz. These measurements were processed in overlapping (50%) 2.56 second windows (128 measurements/window).  
The acceleration signal was divided into components due to gravity (tGravityAcc) and due to movement (tBodyAcc).  The velocity signal (tBodyGyro) and the acceleration due to movement signal (tBodyAcc) were then derived in time to obtain tBodyGyroJerk and tBodyAccJerk.  
All except the gravity component then had a Fourier Transform applied to obtain the following frequency dimension signals:    
*fBodyAcc  
*fBodyAccJerk  
*fBodyGyro  
*fBodyGyroJerk  
Using the three axial components (X, Y, and Z) of these nine signals, a magnitude (Mag) was calculated for each measurement of each of the nine signals.  
For each of the four components (X, Y, Z, and Mag) of each of the nine signals, the mean and the standard deviation over the 128 measurements of each window was retained (many other calculations were done, however our dataset is only concerned with the mean and standard deviation).  
Finally, the 72 resulting columns of data were normalized (over all observations, test and training) to provide features with a range from -1 to 1.  
Note that fBodyGyroJerk-[XYZ]-mean() and fBodyGyroJerk-[XYZ]-std() are missing without explanation from the provided feature set, so we in fact end up with 66 features.  
The combined training and test datasets have a total of 10299 observations, each of which contains the above described calculations for one 2.56 second window (128 measurements).


##  Variable naming convention for signal means in tidy_summary.txt

* first letter (t or f)
    *t: time domain  
    *f: frequency domain
* signal name (after the first letter to the first period)  
Body was stripped from the old names to simplify and reduce typing, and GravityAcc was changed to just Gravity.  Acc therefore refers explicitly to the more colloquial meaning of acceleration due to motion, and Gravity simply to acceleration due to gravity.  Gyro refers to measures of angular velocity.
    *Acc
    *AccJerk
    *Gravity
    *Gyro
    *GyroJerk
* component (X,y,Z) of the signal, or magnitude (Mag) (after the first period)
    *X
    *Y
    *Z
    *Mag
* aggregate function applied to the 128 measurements of the window (mean, or std for standard deviation) (after the second period)


## Variable names
*activity

|Variable Name|Description|
|-------------|-----------|
|activity|The activity of the subject during the time periods from which the means were calculated|
|subject|The id of the subject of the experiment during the time periods from which the means were calculated|
tAcc.X.mean          3 Mean of tBodyAcc-mean()-Z          
tAcc.Y.mean          1 Mean of tBodyAcc-mean()-X          
tAcc.Z.mean          2 Mean of tBodyAcc-mean()-Y          
tAcc.Mag.mean      201 Mean of tBodyAccMag-mean()         
tAcc.X.std           4 Mean of tBodyAcc-std()-X           
tAcc.Y.std           5 Mean of tBodyAcc-std()-Y           
tAcc.Z.std           6 Mean of tBodyAcc-std()-Z           
tAcc.Mag.std       202 Mean of tBodyAccMag-std()          
tGravity.X.mean     41 Mean of tGravityAcc-mean()-X       
tGravity.Y.mean     42 Mean of tGravityAcc-mean()-Y       
tGravity.Z.mean     43 Mean of tGravityAcc-mean()-Z       
tGravity.Mag.mean  214 Mean of tGravityAccMag-mean()      
tGravity.X.std      44 Mean of tGravityAcc-std()-X        
tGravity.Y.std      45 Mean of tGravityAcc-std()-Y        
tGravity.Z.std      46 Mean of tGravityAcc-std()-Z        
tGravity.Mag.std   215 Mean of tGravityAccMag-std()       
tAccJerk.X.mean     81 Mean of tBodyAccJerk-mean()-X      
tAccJerk.Y.mean     82 Mean of tBodyAccJerk-mean()-Y      
tAccJerk.Z.mean     83 Mean of tBodyAccJerk-mean()-Z      
tAccJerk.Mag.mean  227 Mean of tBodyAccJerkMag-mean()     
tAccJerk.X.std      84 Mean of tBodyAccJerk-std()-X       
tAccJerk.Y.std      85 Mean of tBodyAccJerk-std()-Y       
tAccJerk.Z.std      86 Mean of tBodyAccJerk-std()-Z       
tAccJerk.Mag.std   228 Mean of tBodyAccJerkMag-std()      
tGyro.X.mean       121 Mean of tBodyGyro-mean()-X         
tGyro.Y.mean       122 Mean of tBodyGyro-mean()-Y         
tGyro.Z.mean       123 Mean of tBodyGyro-mean()-Z         
tGyro.Mag.mean     240 Mean of tBodyGyroMag-mean()        
tGyro.X.std        124 Mean of tBodyGyro-std()-X          
tGyro.Y.std        125 Mean of tBodyGyro-std()-Y          
tGyro.Z.std        126 Mean of tBodyGyro-std()-Z          
tGyro.Mag.std      241 Mean of tBodyGyroMag-std()         
tGyroJerk.X.mean   161 Mean of tBodyGyroJerk-mean()-X     
tGyroJerk.Y.mean   162 Mean of tBodyGyroJerk-mean()-Y     
tGyroJerk.Z.mean   163 Mean of tBodyGyroJerk-mean()-Z     
tGyroJerk.Mag.mean 253 Mean of tBodyGyroJerkMag-mean()    
tGyroJerk.X.std    164 Mean of tBodyGyroJerk-std()-X      
tGyroJerk.Y.std    165 Mean of tBodyGyroJerk-std()-Y      
tGyroJerk.Z.std    166 Mean of tBodyGyroJerk-std()-Z      
tGyroJerk.Mag.std  254 Mean of tBodyGyroJerkMag-std()     
fAcc.X.mean        266 Mean of fBodyAcc-mean()-X          
fAcc.Y.mean        267 Mean of fBodyAcc-mean()-Y          
fAcc.Z.mean        268 Mean of fBodyAcc-mean()-Z          
fAcc.Mag.mean      503 Mean of fBodyAccMag-mean()         
fAcc.X.std         269 Mean of fBodyAcc-std()-X           
fAcc.Y.std         270 Mean of fBodyAcc-std()-Y           
fAcc.Z.std         271 Mean of fBodyAcc-std()-Z           
fAcc.Mag.std       504 Mean of fBodyAccMag-std()          
fAccJerk.X.mean    345 Mean of fBodyAccJerk-mean()-X      
fAccJerk.Y.mean    346 Mean of fBodyAccJerk-mean()-Y      
fAccJerk.Z.mean    347 Mean of fBodyAccJerk-mean()-Z      
fAccJerk.Mag.mean  516 Mean of fBodyBodyAccJerkMag-mean() 
fAccJerk.X.std     348 Mean of fBodyAccJerk-std()-X       
fAccJerk.Y.std     349 Mean of fBodyAccJerk-std()-Y       
fAccJerk.Z.std     350 Mean of fBodyAccJerk-std()-Z       
fAccJerk.Mag.std   517 Mean of fBodyBodyAccJerkMag-std()  
fGyro.X.mean       424 Mean of fBodyGyro-mean()-X         
fGyro.Y.mean       425 Mean of fBodyGyro-mean()-Y         
fGyro.Z.mean       426 Mean of fBodyGyro-mean()-Z         
fGyro.Mag.mean     529 Mean of fBodyBodyGyroMag-mean()    
fGyro.X.std        427 Mean of fBodyGyro-std()-X          
fGyro.Y.std        428 Mean of fBodyGyro-std()-Y          
fGyro.Z.std        429 Mean of fBodyGyro-std()-Z          
fGyro.Mag.std      530 Mean of fBodyBodyGyroMag-std()     
fGyroJerk.Mag.mean 542 Mean of fBodyBodyGyroJerkMag-mean()
fGyroJerk.Mag.std  543 Mean of fBodyBodyGyroJerkMag-std() 
