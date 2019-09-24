#!/Users/zk/anaconda3/bin/python
#coding:utf-8
import argparse
import os
import re
import sys
from os import walk
from colorama import init 
from termcolor import colored 
from colorama import Fore, Back, Style 

def padding(dirpath,rawFileName,numbermatching,apply,fill,head):
    m = re.search(numbermatching,rawFileName)
    if m :
        start =m.start()
        end = m.end()
        if fill < (end-start):
            start = end - fill

        formatNum = rawFileName[start:end].zfill(fill)
        if head:
            targetFileName = formatNum+"-"+rawFileName
            print(targetFileName)
        else:
            targetFileName = re.sub(re.compile(numbermatching),formatNum,rawFileName)

        print(colored(rawFileName, 'red'),"->", colored(targetFileName, 'green'))
        if apply:
            os.rename(dirpath+"/"+rawFileName, dirpath+"/"+targetFileName)
    else:
        print(rawFileName + " not parsed")

def paths(mypath):
    mypath = os.path.expanduser(mypath)
    for (dirpath, dirnames, filenames) in walk(mypath):
        yield (dirpath,dirnames,filenames)


def main(args):
    for (dirpath,dirnames,filenames) in  paths(args.directory):
        print(dirpath+"/")
        for filename in filenames:
            padding(dirpath,filename,args.regex,args.apply,args.padding,args.head)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
             formatter_class=argparse.RawDescriptionHelpFormatter,
             description='''
Ex: 
    # change current directory 
    padding_file_head_index.py -p .
''',
    )

    parser.add_argument("-d",'--directory', type=str, required=True, help='filenames in directory to replace')
    parser.add_argument("-r",'--regex', type=str, default="^(\d+)", help='number regex to locate')
    parser.add_argument("-p",'--padding', type=int, default=3, help='zero padding number')
    
    parser.add_argument("-a",'--apply', action='store_true',  help='apply,  real chanage the file name! ')
    parser.add_argument('--head', action='store_true',  help='move index to head, use with -r ')

    args = parser.parse_args()
    if not args.apply:
        print("----------"+colored('preview',"green")+"------------")
    main(args)
    if not args.apply:
        print("-----------------------------")
        print(colored('advice: apply the change with -a arg ','red'))


