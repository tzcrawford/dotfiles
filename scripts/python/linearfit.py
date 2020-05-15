#!/usr/bin/python
#Will perform a linear fit on any delimiter-separated plaintext data file
#could modify for more complex function
#really meant for experimental data, does error analysis and outputs chi square and relevant info

#select how you want to handle your expected errors with either scolumn, constanterr, or relativeerr

import numpy as np
from scipy.optimize import curve_fit

inputfile="$HOME/data.csv"
outputfile="$HOME/data_out.txt"
delimiter=","
numheaderlines=1
xcolumn=1 #column independent variable data is saved, counting from 1
ycolumn=2 #column dependent variable data is saved, counting from 1
scolumn=3 #column experimental err in y is saved (1 STANDARD DEVATION, NOT VARIANCE). Use 0 if using a constant err or relativeerr
constanterr=[False,0.1] #absolute error in same units as y (if you don't have a column)
relativeerr=[False,0.1] #relative error (fraction of) of y (if you don't have a column)
initialguess=[1,1] #initial guess for the parameters in the model (we will iteratively determine them)

def model(x,m,b):
    return m*x+b
numberofparameters=2

def main(x,y,s):

    #let's do the fit.
    fit=curve_fit(f=model,xdata=x,ydata=y,p0=initialguess,sigma=s,absolute_sigma=True)
    popt,pcov=fit #the fit will return two matrices. popt = the fit parameters, pcov = the covariance matrix (err in parameters)
    fit_m,fit_b=popt
    
    #how well do we know the fit parameters?
    err_m=np.sqrt(np.diag(pcov)[0])
    err_b=np.sqrt(np.diag(pcov)[1])
    print("m = " + str(fit_m) + " +/- " + str(err_m))
    print("b = " + str(fit_b) + " +/- " + str(err_b) + "\n")
    print("The covariance matrix is:\n" + str(pcov) + "\n")
    ###pg75 in theory notebook
    corr=generatecorrelation(pcov)
    print("The correlation matrix is:\n" + str(corr))
    print("You want the off-diagonal elements to be ~0, ~1 means those two fit parameters are highly coupled.\nIf they are highly coupled, you may consider adjusting your model.\nFor instance y=mx+b --> y=m(x-x0)+(b-b0)\n")

    #how good was the fit? Calculating Chi Squared...
    dummy=list()
    for i in range(len(y)):
        dummy.append( ( (y[i]-model(x[i],fit_m,fit_b)) / s[i] )**2 )
    chisq=sum(dummy)
    del dummy
    print("Chi Squared: " + str(chisq))
    chisqreduced=chisq/(len(y)-numberofparameters)
    print("Chi Squared Reduced: " + str(chisqreduced) + "\n")

    #how good was the fit? Calculating R Squared...
    ybar=sum([i for i in y])/len(y) #average of y
    SStot=sum([ (i-ybar)**2 for i in y]) #total sum of squares
    SSres=sum([ (y[i]-model(x[i],fit_m,fit_b))**2 for i in range(len(y))]) #sum of squares of residuals
    rsquared=1-(SSres/SStot)
    print("R Squared: " + str(rsquared))
    print(str(100*rsquared) + "% of the variation in y can be explained by the model")

    return fit_m,fit_b,err_m,err_b,chisq,chisqreduced,rsquared,pcov,corr

def generatecorrelation(cov):
    corr=cov #just to mimic it's size.
    for i in range(len(cov)): #each row
        for j in range(len(cov[i])): #each column
            corr[i][j]=cov[i][j]/np.sqrt( np.diag(cov)[i] * np.diag(cov)[j]  )
            

    return corr

def readfile(inputfile):
    f=open(inputfile,'r')
    data=f.readlines()
    for i in range(numheaderlines): #remove any header from the file
        del data[0]
    x=list();y=list();s=list();
    for i in range(len(data)):
        line=data[i].strip("\n").split(delimiter)
        x.append(float(line[xcolumn-1]))
        y.append(float(line[ycolumn-1]))
        if scolumn==0:
            if constanterr[0]==True:
                s.append(constanterr[1])
            elif relativeerr[0]==True:
                s.append(relativeerr[1]*y[i])
            else:
                print("Please specify an error in Y")
                exit()
        else:
            s.append(float(line[scolumn-1]))
    return x,y,s

def writefile(outputfile):
    f=open(outputfile,"w")
    print("m = " + str(fit_m) + " +/- " + str(err_m))
    print("b = " + str(fit_b) + " +/- " + str(err_b) + "\n")
    print("The covariance matrix is:\n" + str(pcov) + "\n")
    print("The correlation matrix is:\n" + str(corr))
    print("You want the off-diagonal elements to be ~0, ~1 means those two fit parameters are highly coupled.\nIf they are highly coupled, you may consider adjusting your fit.\nFor instance y=mx+b --> y=m(x-x0)+(b-b0)\n")
    print("Chi Squared: " + str(chisq))
    print("Chi Squared Reduced: " + str(chisqreduced) + "\n")
    print("R Squared: " + str(rsquared))
    print(str(100*rsquared) + "% of the variation in y can be explained by the model")

    return fit_m,fit_b,err_m,err_b,chisq,chisqreduced,rsquared,pcov,corr

if __name__ == "__main__":
    x,y,s=readfile(inputfile)
    fit_m,fit_b,err_m,err_b,chisq,chisqreduced,rsquared,pcov,corr=main(x,y,s)
    writefile(fit_m,fit_b,err_m,err_b,chisq,chisqreduced,rsquared,pcov,corr)
