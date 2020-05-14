#!/usr/bin/python
import math
#here a is data, b is argument
def multiply(a,b):
    return a*b
def add(a,b):
    return a+b
def power(a,b):
    return a**b
def exponentiate(a,b):
    return b**a
def log(a,b):
    return math.log(a,b)
def operation(inputfile,outputfile,delimiter,numheaderlines,targetcolumn,argument,function):
        #inputfile and outputfile must exist as directory strings when inputted
        #delimiter is a string for what delimits the columns in the inputfile
        #numheaderlines is the number of lines to ignore at the top of the file
        #targetcolumn is which column you are doing the operation on
        #argument is what number you are multiplying/adding
        #function is either multiply,add,etc
        
        #numheaderlines, targetcolumn, and factor must be float or int
        #TARGET COLUMN COUNTS FROM ONE, NOT ZERO
        
        print("Importing: " + str(inputfile))
        f=open(inputfile,"r") #opens input file
        lines = list() #declaring a list variable where each element is a string for each line in the input file
        lines=f.readlines() #populating lines
        f.close() #close inputfile

        #gather headerlines to put in outputfile
        header=list() #declaring a list where each element is the string of a header line
        for i in range(numheaderlines):
                header.append(lines[0])
                del lines[0]

        #Does the calculation and outputs
        f=open(outputfile,"w") #opens output file
        
        for line in header:
            f.write(line)

        for line in lines: #line + individual element within lines
                linelist=line.split(delimiter) #separate
                
                significance=determine_significance(linelist[targetcolumn-1]) #determine how many digits are after the decimal so we can round and output the same number
                linelist[targetcolumn-1] = float(linelist[targetcolumn-1]) #convert to a float so we can do math on it. This may change the number of digits after the decimal
                linelist[targetcolumn-1] = function(linelist[targetcolumn-1],argument) #actual calculation
                round(linelist[targetcolumn-1],significance) #round back to the appropriate significance
                linelist[targetcolumn-1] = str(linelist[targetcolumn-1]) #convert back to string

                #Now, we generate the string to write to the file for this line
                for i in range(len(linelist)):
                        if(i == 0):
                                outputstring = linelist[0]
                        else:
                                outputstring = outputstring + delimiter + linelist[i] #add each element of linelist (each number in each column) to a string
                if( targetcolumn == len(linelist)):
                        f.write(outputstring + "\n") #idk it fixes it
                else:
                        f.write(outputstring)

        f.close() #Close the file

        print("Calculation complete, file written.")
        
        return

def determine_significance(s):
    #s = str(x)
    if not '.' in s:
        return 0
    return len(s) - s.index('.') - 1

def getArgs(argv=None):
    parser=argparse.ArgumentParser(description="Do math on a column of data in a file")
    parser.add_argument("targetcolumn",type=int, default=None, help="Which column to do math on?")
    parser.add_argument("argument",type=float, help="Declare the argument you are doing math with")
    parser.add_argument("inputfile",type=str, help="The path of the file to do the math on")
    parser.add_argument("-o","--output", type=str, default=None, help="Declare path to output the data")
    parser.add_argument("-m","--multiply", action="store_true", default=False, help="Enable if you are multiplying the argument to the data")
    parser.add_argument("-a","--add", action="store_true", default=False, help="Enable if you are adding the argument to the data")
    parser.add_argument("-p","--power", action="store_true", default=False, help="Enable for data^argument")
    parser.add_argument("-e","--exponentiate", action="store_true", default=False, help="Enable for argument^data")
    parser.add_argument("-log","--log", action="store_true", default=False, help="Enable for log_argument(data)")
    parser.add_argument("-hl","--header-lines", type=int, default=0, help="Number of lines to ignore at the top of the file")
    parser.add_argument("-d","--delimiter", type=int, default=1, help="Set the delimiter between columns 1=\'\\t\' [default], 2=\',\'")
    return parser.parse_args(argv)

class MainClass: #objects of this class are options during calculation
    #declare what kind of attributes object can have
    def __init__(self,targetcolumn=1,argument=None,inputfile=None,outputfile=None,multiply=False,add=False,power=False,exponentiate=False,log=False,numheaderlines=0,delimiter=1):
        self.targetcolumn = targetcolumn
        self.argument = argument
        self.inputfile = inputfile

        if outputfile == None:
            outputfile = str(inputfile) + '.output'
        self.outputfile = outputfile

        self.multiply = multiply
        self.add = add
        self.power = power
        self.exponentiate = exponentiate
        self.log = log
        self.operations = [self.multiply,self.add,self.power,self.exponentiate,self.log]

        self.numheaderlines = numheaderlines
        
        delimiters=['\t',',']
        self.delimiter = delimiters[int(delimiter)-1]

if __name__ == '__main__': #In the case we run this script directly, as opposed to import
    import argparse
    args=getArgs()
    options=MainClass(args.targetcolumn,args.argument,args.inputfile,args.output,args.multiply,args.add,args.power,args.exponentiate,args.log,args.header_lines,args.delimiter)
    
    if options.operations.count(True) > 2: #If the user said to do more than one operation (multiply, add, etc)
        print("You should not add and multiply at the same time")
        quit()
    if options.operations.count(True) <= 0: #If the user picked no operation
        print("You should pick an operation to perform")
        quit()
    
    #Here we assign the choice operation to variable f
    fs=[multiply,add,power,exponentiate,log]
    for i,j in enumerate(options.operations):
        if j==True:
            f=fs[i]
    
    #Here we do the operation
    operation(options.inputfile,options.outputfile,options.delimiter,options.numheaderlines,options.targetcolumn,options.argument,f)
