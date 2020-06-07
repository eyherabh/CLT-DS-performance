# Command-line tools performance for data analysis

Command-line tools were shown in [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) to outperform hadoop clusters by more than 200 times when performing simple parsing and counting tasks on formatted data. However, the employed scripts may yield incorrect results even for well-formed data, and may lead to false expectations when the scripts are based on other command-line utilities. Here we fix the parsing problems of those scripts and compare their performance when built solely on BASH. Finally, we raise concerns about the maintenance status of the utility mawk used by those scripts and the idea as a faster drop-in for awk. Our results show that the performance of command-line tools might vary widely even for seemingly equivalent scripts.

## Introduction

The analysis performed in [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) aimed at assessing whether using Hadoop for computing win/loss ratios in chess games was actually detrimental to performance when compared to command-line (CL) tools. To that end, data in portable game notation (PGN; see [Wikipedia](https://en.wikipedia.org/wiki/Portable_Game_Notation) and the [PGN standard](http://www.saremba.de/chessgml/standards/pgn/pgn-complete.htm)) was downloaded from [this repository](https://github.com/rozim/ChessData), and analysed through a series of CL scripts. The time taken by each CL script was recorded and compared to that of a previous study that performed the same analysis on Hadoop, showing that CL tools could be more than 200 times faster than Hadoop-based solutions for the given task. 

However, that analysis has at least three shortcomings that here we aim to resolve. First, the CL scripts are not suitable for accurately parsing well-formed PGN files, let alone detect malformed ones, which hampers the extent to which their results can be trusted. Second, performance improvements are not accurately related to the changes in the CL scripts, which can be improved even further. Third, the analysis does not warn against certain CL solutions that may perform worse than Hadoop.  

## Chess-games data

To perform our analysis, we did not downloaded gigabytes of data as [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) did, but only one single file which was used within a loop. Actually, we could have just used simulated data, downloading [this single file](https://github.com/rozim/ChessData/blob/master/mega2400_part_01.pgn) of just 26MB was faster.


# References

+ Original article: [https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html]
+ Bash reference manual: [https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html]
+ MAWK website: [https://invisible-island.net/mawk/mawk.html#related_mawk]
+ MAWK pitfalls: [https://brenocon.com/blog/2009/09/dont-mawk-awk-the-fastest-and-most-elegant-big-data-munging-language/]
+ AWK user guide: [https://www.gnu.org/software/gawk/manual/gawk.html]
+ PGN format: [https://en.wikipedia.org/wiki/Portable_Game_Notation]
+ PGN standard: [http://www.saremba.de/chessgml/standards/pgn/pgn-complete.htm]
+ Chess-game data repository: [https://github.com/rozim/ChessData]
