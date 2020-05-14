#!/usr/bin/python
#This script will return a list of discrete points in rgb space that lie on the vector between any two points in rgb space in an arbitrary number of steps.
#It was originally intended to create a list of colors on a gradient between to colors, such as #0000FF and #FFFFFF,  that could be used for a series of traces on a graph (which could be specified via hex color in gnuplot)

#main will take hexidecimal colors and return hexidecimal colors
#calculation will take an rgb vector and return an rgb vector

n=2
xhex="#FFFFFF"
yhex="#000000"

def main(n,xhex,yhex):
#n is an integer number of steps
#xhex is the starting hexidecimal color e.g. the string '#FFFFFF'
#yhex is the ending hexidecimal color
    
    
#Input sanity check
    if( (not isinstance(xhex,str)) or (len(xhex)!=7) ):
        print("Starting color not valid, should be of form \'#XXXXXX\'")
        return
    if( (not isinstance(yhex,str)) or (len(yhex)!=7) ):
        print("Ending color not valid, should be of form \'#XXXXXX\'")
        return
    if not isinstance(n,int):
        try:
            n=int(n)
        except:
            print("Number of steps not valid, should be an int.")
            return
   
#Now converting xhex and yhex to rgb vectors, to be held in x and y
    xhex=xhex[1:] #deletes the # at the beginning of the string
    yhex=yhex[1:]

    a=xhex[0:2] #separate the hexadecimals into components in rgb space
    b=xhex[2:4]
    c=xhex[4:]
    d=yhex[0:2]
    e=yhex[2:4]
    f=yhex[4:]

    g=[a,b,c,d,e,f]
    for i in range(len(g)):
        try:
            g[i]=int(g[i],16) #convert hex to base 10 for individual color component
        except ValueError:
            print("Inputted point(s) not valid hexadecimal.")
            return
    x=g[:3]
    y=g[3:]
    del a,b,c,d,e,f,g

    zs=calculation(n,x,y)

    zhexs=list() #will hold the hexadecimal colors to be outputted
    for j in range(len(zs)):
        z=zs[j] #z is the iterator for the individual element of zs
        zhex=str() #will hold the hexadecimal at this z
        for i in range(len(z)):
            partzhex=hex(z[i])[2:] #will generate a 2-digit hex string corresponding to this component, e.g. 255->'FF'. The [2:] will exclude the unnecessary '0x' that begin the output of hex().
            if(len(partzhex)==1): #want to make sure this component's hex is two digits, i.e. 0-->00 and e-->0e but 42 stays 24
                partzhex='0'+partzhex
            zhex+=partzhex
        zhex='#'+zhex
        zhexs.append(zhex)
        del zhex

    return zhexs

def calculation(n,x,y):
    zs=list() #This is a list that will hold the rgb triplets to be returned
    for m in range(n): #m is the iterator over n
        z=list() #This is an iterator for one rgb triplet in zs
        for i in range(3): #for each r,g,b
            z.append(int( x[i] + ( (y[i]-x[i])/(n-1) )*m )) #point on difference vector plus starting vector (x[i]). int() to round to the nearest whole number
        zs.append(z)
        del z
    return zs

if __name__ == "__main__":
    print(main(n,xhex,yhex))
