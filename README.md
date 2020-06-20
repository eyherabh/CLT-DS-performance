# Command-line tools performance for data analysis

Command-line tools were shown in [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) to outperform hadoop clusters by more than 200 times when performing simple parsing and counting tasks on formatted data. However, the employed scripts may yield incorrect results even for well-formed data, and may lead to false expectations when the scripts are based on other command-line utilities. Here I fix the parsing problems of those scripts and compare their performance when built solely on BASH. Finally, I raise concerns about the maintenance status of the utility mawk used by those scripts and the idea as a faster drop-in for awk. Our results show that the performance of command-line tools might vary widely even for seemingly equivalent scripts.

[Continue reading ...](ARTICLE_EyherabideHG_2020_Command-line_tools_performance_for_data_analysis.md)

# LICENSING

The file data/cgdata.pgn is a copy of https://raw.githubusercontent.com/rozim/ChessData/master/mega2400_part_01.pgn. Please refer to that repository for licensing and copyright matters.

All other files are licensed under the GPLv3 license (see [LICENSE](LICENSE)).

