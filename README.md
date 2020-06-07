# Command-line tools performance for data analysis

Command-line tools were shown to outperform hadoop clusters by more than 200 times when performing simple parsing and counting tasks on formatted data (see [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html)). However, the employed scripts may yield incorrect results even for well-formed data, and may lead to false expectations when the scripts are based on other command-line utilities. Here we fix the parsing problems of those scripts and compare their performance when built solely on BASH. Finally, we raise concerns about the maintenance status of the utility mawk used by those scripts and the idea as a faster drop-in for awk. Our results show that the performance of command-line tools might vary widely even for seemingly equivalent scripts.

# References
Original article: [https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html]
MAWK website: [https://invisible-island.net/mawk/mawk.html#related_mawk]
MAWK pitfalls: [https://brenocon.com/blog/2009/09/dont-mawk-awk-the-fastest-and-most-elegant-big-data-munging-language/]
PGN format: [https://en.wikipedia.org/wiki/Portable_Game_Notation]
Bash reference manual: [https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html]
AWK user guide: [https://www.gnu.org/software/gawk/manual/gawk.html]
