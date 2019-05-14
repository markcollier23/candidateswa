import os
import time
def main():
    write(read('senate.html').replace('class="nested"',''),"comment.html")
def listfilter(L, by):
    """
    finds all the L's that has by in it
    """

    c = []
    for n in L:
        if by in n:
            c.append(n)
    return c

'''
Return the entire string of a file
fileName = 'single.txt' will look in current directory
fileName = 'C:/single.txt' will look in C directory
'''
def read(FileName='C:/untitled.txt'):
    f=str(FileName)
    try:
        with open(f) as infile:
            contents=infile.read()
        infile.close()
    except:
        contents="This file does not exist"
    return str(contents)

def getSplitter(file):
    """
    Finds whether the csv file is comma seperated or semi-colon
    """

    r=read(file)
    if ';' in r:
        return ';'
    if ',' in r:
        return ','
    if '\t' in r:
        return '\t'


def readln(FileName='C:/untitled.txt'):
    """
    Returns a list of lines from a file.
    fileName = 'single.txt' will look in current directory
    fileName = 'C:/single.txt' will look in C directory
    """

    return read(FileName).split('\n')


def write(Text='', File='untitled.txt'):
    with open(File,"w") as outfile:
        print(Text,file=outfile)
    outfile.close()

def bitLevel(text,key):
    ans = ""
    for i in range(len(text)):
        ans+=chr(num(text[i])^num(key[i%len(key)]))
    return ans
def bitn(text,key):
    ans = [0] * len(text)
    for i in range(len(text)):
        ans[i] = num(text[i])^num(key[i%len(key)])
    return ans
def num(n):
    try:
        operate = n/3
        return n
    except:
        return ord(n)
def writeln(LineNumber=0, Text='', File='untitled.txt'):
    lin=round(abs(LineNumber))
    f=readln(File)
    if lin>=len(f):
        f+=['']*(lin-len(f))
        f.append(Text)
    else:
        f[lin]=Text
    if f[-1] == "" and f[-2] == "":
        f=f[:-2]
    write("\n".join(f),File)


def assertEquals(expected, actual, message=""):
    """
    For testing whether a particular expression that includes functions return an expected value
    eg. we could test the function with following parameters
    expected = 3
    actual = record(6,2)
    message = 'Function record'
    """

    if expected!=actual:
        print(message,"Test failed")
    else:
        print(message,"Test passed!!")
    print("   Expected value was:")
    print("        ",expected)
    print("   But the actual value is:")
    print("        ",actual)
    return expected

def get_table(FileName='C:/run.csv', Splitter=','):
    """
    Return a 2D array from reading a file
    fileName = 'single.txt' will look in current directory
    fileName = 'C:/single.txt' will look in C directory
    """

    f = readln(FileName)
    t=[]
    for r in f:
        t.append(r.split(Splitter))
    return t


def evalif(n):
    """
    Tries to return a number but if it can't just return the string
    """

    try:
        if '-' in n:
            return n
        return eval(n)
    except:
        return n


def column(t, n):
    """
    Returns column n of t as a list
    """

    col = []
    for row in t:
        col.append(row[n])
    return col


def nospaces(slist):
    """
    Removes spaces or empty Strings from a list
    """

    spacelis = []
    for i in range(len(slist)):
        slist[i]=slist[i].replace(' ','')
        if slist[i]!='':
            spacelis.append(slist[i])
    return spacelis

main()