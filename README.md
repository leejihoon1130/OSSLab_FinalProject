# OSS Lab Final Project(HGU 2021-1)
### 21500479, Lee JiHoon, HGU, CSEE
#### Project name : Course application and timetable production with Shell Script
#### Video(Youtube) Link : 


## What does this project do?😊
###### Users can choose the class you want to take at the HGU CSEE and write a timetable. A warning is given if the entered classes overlap in time. If users enter classes without ovelapping classes, they will be informed by calculating the number of classes and the total credit, and a timetable will be created with the file name they wrote together when entering executing sentence.


## Why is this project useful?😁
###### Students have difficulty in checking overlapping classes when they make a timetable before registering for classes. It prevents this and they can know the total credit at the same tiem. Finally, they can receive the timetable as a CSV file, which makes it more convenient.


## How do I get started?😉
###### There are three files(test.sh, temp.csv, schedule.csv) in total.
> ###### test.sh : Execution file
> ###### temp.csv : CSV file with HGU CSEE's classes organized
> ###### schedule.csv : arbitrarily CSV file before the timetable be created.
###### The order of execution is described below.
******
1. ###### When you ren test.sh, you can write down the CSV file name of the timetable you want to create.
      ###### ex) *$ ./test.sh my_schedule.csv*
2. ###### Enter the class code.
      ###### ex) Class : *ECE20016*
      ###### ✔ *A class with more than two sections is asked to enter the section.* ✔
      ###### ex) Section : *2*
3. ###### At the end of the input, if "break" is entered, the program will end.
      ###### ex) Class : *break*
4. ###### You can see the number of classes and credits you applied for.
5. ###### Within the same folder, a CSV-type timetable is created with the file name specified above.
      ###### ex) *$ cat my_schedule.csv*


## Where can I get more help, if I need it?😎
###### If you have any help about the program or need further development, please contact me at the e-mail below.
###### *leejihoon1130@gmail.com*


## References😘
###### https://gist.github.com/ihoneymon/652be052a0727ad59601
###### https://www.lesstif.com/lpt/bash-shell-script-programming-26083916.html
