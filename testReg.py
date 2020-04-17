
import argparse
import os
import re
import sys
from os import walk
from colorama import init 
from termcolor import colored 
from colorama import Fore, Back, Style 

numbermatching="(\d+)(?<=.mp4)"
rawFileName="aaa.3.mp4"
fill=3
m = re.search(numbermatching,rawFileName)
if m :
    start =m.start()
    end = m.end()
    if fill < (end-start):
        start = end - fill
    formatNum = rawFileName[start:end].zfill(fill)
    targetFileName = formatNum+" "+targetFileName
    print(targetFileName)

