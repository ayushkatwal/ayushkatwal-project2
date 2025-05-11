
File information: The file project2.pl contains the code for the project. devlog.md contains the notes I made before and after every session of working on the project. example.pl and test.pl were provided by Professor Salazar

How to run the code: To compile/run the code after downloading the zip containing all the files is to go to command line and type cd "file path" where file path is wherever you saved the file. For example in my case it would be cd C:\Users\Ayush Katwal\ayushkatwal-project2 Next to run the code in command line type 'swipl project2.pl' and test with any inputs. Example inputs include the following:
basic_map(M), display_map(M), find_exit(M, A). basic_map(M), display_map(M), find_exit(M, [down,left,down]). basic_map(M), display_map(M), find_exit(M, [down,left]). bad_map(M), display(M), find_exit(M, A). gen_map(4, 10,10,M), display_map(M), find_exit(M, A).

Running this code in terminal for me displayed the maps weirdly, however running in wsl made the output look right. 