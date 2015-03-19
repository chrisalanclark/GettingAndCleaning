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

* fBodyAcc  
* fBodyAccJerk  
* fBodyGyro  
* fBodyGyroJerk  

Using the three axial components (X, Y, and Z) of these nine signals, a magnitude (Mag) was calculated for each measurement of each of the nine signals.
For each of the four components (X, Y, Z, and Mag) of each of the nine signals, the mean and the standard deviation over the 128 measurements of each window was retained (many other calculations were done, however our dataset is only concerned with the mean and standard deviation).  
Finally, the 72 resulting columns of data were normalized (over all observations, test and training) to provide features with a range from -1 to 1.  
Note that fBodyGyroJerk-[XYZ]-mean() and fBodyGyroJerk-[XYZ]-std() are missing without explanation from the provided feature set, so we in fact end up with 66 features.  
The combined training and test datasets have a total of 10299 observations, each of which contains the above described calculations for one 2.56 second window (128 measurements).


## tidy_summary.txt
The data file produced, tidy_summary.txt, groups by activity and subject id and provides the mean across observations (2.56 second windows) of the 66 features described above (so the mean across windows of the **normalized** mean and standard deviation of the signal within each window).  
It also provides, for downstream calculations, the number of observations (2.56 second windows) in each group.  
The variables were also renamed slightly, to simplify, and reordered, to keep everything related to a single signal together.

###  Variable naming convention for means in tidy_summary.txt  
The following naming convention was used for the 66 columns calculating a mean.

* first letter (t or f)
    * t: time domain  
    * f: frequency domain  
    
* signal name (after the first letter, up to the first period)  
Body was stripped from the old names to simplify and reduce typing, and GravityAcc was changed to just Gravity.  Acc therefore refers explicitly to the more colloquial meaning of acceleration due to motion, and Gravity simply to acceleration due to gravity.  Gyro refers to measures of angular velocity.
    * Acc
    * AccJerk
    * Gravity
    * Gyro
    * GyroJerk
    
* component of the signal, or magnitude (after the first period)
    * X
    * Y
    * Z
    * Mag
    
* aggregate function applied to the 128 measurements of the window  (after the second period)  
    * mean
    * std


## Variable names

* activity
The activity the subject was observed doing during the time of the 2.56 second windows
    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING
+ subject  
The id of the subject (number from 1 to 30)  
+ observations
The number of observations (2.56 second windows) which went into calculating the following means
+ tAcc.X.mean          
Mean of tBodyAcc-mean()-Z          
* tAcc.Y.mean          
Mean of tBodyAcc-mean()-X          
* tAcc.Z.mean        
Mean of tBodyAcc-mean()-Y          
* tAcc.Mag.mean      
Mean of tBodyAccMag-mean()         
* tAcc.X.std         
Mean of tBodyAcc-std()-X           
* tAcc.Y.std         
Mean of tBodyAcc-std()-Y           
* tAcc.Z.std         
Mean of tBodyAcc-std()-Z           
* tAcc.Mag.std       
Mean of tBodyAccMag-std()          
* tGravity.X.mean    
Mean of tGravityAcc-mean()-X       
* tGravity.Y.mean    
Mean of tGravityAcc-mean()-Y       
* tGravity.Z.mean    
Mean of tGravityAcc-mean()-Z       
* tGravity.Mag.mean  
Mean of tGravityAccMag-mean()      
* tGravity.X.std     
Mean of tGravityAcc-std()-X        
* tGravity.Y.std     
Mean of tGravityAcc-std()-Y        
* tGravity.Z.std     
Mean of tGravityAcc-std()-Z        
* tGravity.Mag.std   
Mean of tGravityAccMag-std()       
* tAccJerk.X.mean    
Mean of tBodyAccJerk-mean()-X      
* tAccJerk.Y.mean    
Mean of tBodyAccJerk-mean()-Y      
* tAccJerk.Z.mean    
Mean of tBodyAccJerk-mean()-Z      
* tAccJerk.Mag.mean  
Mean of tBodyAccJerkMag-mean()     
* tAccJerk.X.std     
Mean of tBodyAccJerk-std()-X       
* tAccJerk.Y.std     
Mean of tBodyAccJerk-std()-Y       
* tAccJerk.Z.std     
Mean of tBodyAccJerk-std()-Z       
* tAccJerk.Mag.std   
Mean of tBodyAccJerkMag-std()      
* tGyro.X.mean       
Mean of tBodyGyro-mean()-X         
* tGyro.Y.mean       
Mean of tBodyGyro-mean()-Y         
* tGyro.Z.mean       
Mean of tBodyGyro-mean()-Z         
* tGyro.Mag.mean     
Mean of tBodyGyroMag-mean()        
* tGyro.X.std        
Mean of tBodyGyro-std()-X          
* tGyro.Y.std        
Mean of tBodyGyro-std()-Y          
* tGyro.Z.std        
Mean of tBodyGyro-std()-Z          
* tGyro.Mag.std      
Mean of tBodyGyroMag-std()         
* tGyroJerk.X.mean   
Mean of tBodyGyroJerk-mean()-X     
* tGyroJerk.Y.mean   
Mean of tBodyGyroJerk-mean()-Y     
* tGyroJerk.Z.mean   
Mean of tBodyGyroJerk-mean()-Z     
* tGyroJerk.Mag.mean 
Mean of tBodyGyroJerkMag-mean()    
* tGyroJerk.X.std    
Mean of tBodyGyroJerk-std()-X      
* tGyroJerk.Y.std    
Mean of tBodyGyroJerk-std()-Y      
* tGyroJerk.Z.std    
Mean of tBodyGyroJerk-std()-Z      
* tGyroJerk.Mag.std  
Mean of tBodyGyroJerkMag-std()     
* fAcc.X.mean        
Mean of fBodyAcc-mean()-X          
* fAcc.Y.mean        
Mean of fBodyAcc-mean()-Y          
* fAcc.Z.mean        
Mean of fBodyAcc-mean()-Z          
* fAcc.Mag.mean      
Mean of fBodyAccMag-mean()         
* fAcc.X.std         
Mean of fBodyAcc-std()-X           
* fAcc.Y.std         
Mean of fBodyAcc-std()-Y           
* fAcc.Z.std         
Mean of fBodyAcc-std()-Z           
* fAcc.Mag.std       
Mean of fBodyAccMag-std()          
* fAccJerk.X.mean    
Mean of fBodyAccJerk-mean()-X      
* fAccJerk.Y.mean    
Mean of fBodyAccJerk-mean()-Y      
* fAccJerk.Z.mean    
Mean of fBodyAccJerk-mean()-Z      
* fAccJerk.Mag.mean  
Mean of fBodyBodyAccJerkMag-mean() 
* fAccJerk.X.std     
Mean of fBodyAccJerk-std()-X       
* fAccJerk.Y.std     
Mean of fBodyAccJerk-std()-Y       
* fAccJerk.Z.std     
Mean of fBodyAccJerk-std()-Z       
* fAccJerk.Mag.std   
Mean of fBodyBodyAccJerkMag-std()  
* fGyro.X.mean       
Mean of fBodyGyro-mean()-X         
* fGyro.Y.mean       
Mean of fBodyGyro-mean()-Y         
* fGyro.Z.mean       
Mean of fBodyGyro-mean()-Z         
* fGyro.Mag.mean     
Mean of fBodyBodyGyroMag-mean()    
* fGyro.X.std        
Mean of fBodyGyro-std()-X          
* fGyro.Y.std        
Mean of fBodyGyro-std()-Y          
* fGyro.Z.std        
Mean of fBodyGyro-std()-Z          
* fGyro.Mag.std      
Mean of fBodyBodyGyroMag-std()     
* fGyroJerk.Mag.mean 
Mean of fBodyBodyGyroJerkMag-mean()
* fGyroJerk.Mag.std  
Mean of fBodyBodyGyroJerkMag-std() 
