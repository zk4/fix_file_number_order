## rename your numberd files 


``` bash
python3 fix_file_number_order.py -d .
1.aaa.mp4  -> 001.aaa.mp4
2.bbb.mp4  -> 002.bbb.mp4

.
.
.
.
15.ccc.mp4 -> 015.ccc.mp4

```

## usage 
**preview**
``` 
fix_file_number_order.py -d ./

```

![preview](https://github.com/zk4/fix_file_number_order/blob/master//preview.jpg)

**apply**
if you are satisfied with the preview , apply it with -a 

```
fix_file_number_order.py -ad ./  

```
![apply](https://github.com/zk4/fix_file_number_order/blob/master//apply.jpg)

**change padding**
```
fix_file_number_order.py -ad ./  -p  10

# you can also shrink it back
fix_file_number_order.py -ad ./  -p  1

```
![padding](https://github.com/zk4/fix_file_number_order/blob/master//padding.jpg)
![shrink](https://github.com/zk4/fix_file_number_order/blob/master//shrink.jpg)
## help
```  bash
usage: fix_file_number_order.py [-h] -d DIRECTORY [-r REGEX] [-p PADDING] [-a]

Ex: 
    # change current directory 
    padding_file_head_index.py -p .

optional arguments:
  -h, --help            show this help message and exit
  -d DIRECTORY, --directory DIRECTORY
                        filenames in directory to replace
  -r REGEX, --regex REGEX
                        number regex to locate
  -p PADDING, --padding PADDING
                        zero padding number
  -a, --apply           apply, real chanage the file name!


```