# Command-line tools performance for data analysis

Command-line tools were shown in [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) to outperform hadoop clusters by more than 200 times when performing simple parsing and counting tasks on formatted data. However, the employed scripts may yield incorrect results even for well-formed data, and may lead to false expectations when the scripts are based on other command-line utilities. Here I fix the parsing problems of those scripts and compare their performance when built solely on BASH. Finally, I raise concerns about the maintenance status of the utility mawk used by those scripts and the idea as a faster drop-in for awk. Our results show that the performance of command-line tools might vary widely even for seemingly equivalent scripts.
 
## Introduction

The analysis performed in [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) aimed at assessing whether using Hadoop for computing win/loss ratios in chess games was actually detrimental to performance when compared to command-line (CL) tools. To that end, data in portable game notation (PGN; see [Wikipedia](https://en.wikipedia.org/wiki/Portable_Game_Notation) and the [PGN standard](http://www.saremba.de/chessgml/standards/pgn/pgn-complete.htm)) was downloaded from [this repository](https://github.com/rozim/ChessData), and analysed through a series of CL scripts. The time taken by each CL script was recorded and compared to that of a previous study that performed the same analysis on Hadoop, showing that CL tools could be more than 200 times faster than Hadoop-based solutions for the given task. 

However, that analysis has at least three shortcomings that here I aim to resolve. First, the CL scripts are not suitable for accurately parsing well-formed PGN files, let alone detect malformed ones, which hampers the extent to which their results can be trusted. Second, performance improvements are not accurately related to the changes in the CL scripts, which can be improved even further. Third, the analysis does not warn against certain CL solutions that may perform worse than Hadoop.

## Chess-games data

The chess-game data here used come from the same repository, but I did not downloaded gigabytes of data as [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) did. Instead, I downloaded [this single file](https://github.com/rozim/ChessData/blob/master/mega2400_part_01.pgn) of about 25 MB which I called `cgdata.pgn`. Certainly, I could have just simulated the data, but downloading that single file was faster.

To perform the tests, I duplicated the file above 100 times and also concatenated them into a single file. In an attempt to factor our any interference from I/O devices, I did not clear the cache between runs. The files are small enough to fit into the main memory but not big enough to fit into L3, let alone L1. I repeated the runs several times (unless they took too long) and computed the median and quantiles. 

## Performance of the original script in my test machine

A modified version of the most performant script shown in [this article](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html) is reproduced below

```bash
for i in {00..99}; do printf "cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '
		/Result/ { 
			split($0, a, "-")
			res = substr(a[1], length(a[1]), 1)
			if (res == 1) white++ 
			if (res == 0) black++ 
			if (res == 2) draw++ 
		} 
		END { 
			print white+black+draw, white, black, draw 
		}' \
	| mawk '{ games += $1; white += $2; black += $3; draw += $4; } 
		END { print games, white, black, draw }'
```

The modification affects the first line of code which now reuses the same file. This script run in 4.13 s. 

To test whether feeding different files had any effect, I replaced `00` in the first line with `$i`. That script run in 4.10 s. Since the difference is negligible, the tests below will be conducted reusing a single file. 

## Performance improvements

The performance of the script above can be improve by removing unnecessary operations. For example, the computation of `games` can be moved to the `END` part of the last mawk. In addition, the consecutive `if` testing the value of `res` can be linked together with `else` clauses to avoid visiting them all once the value of `res` is known. These modifitions yield the following script

```bash
for i in {00..99}; do printf "cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '
		/Result/ { 
			split($0, a, "-")
			res = substr(a[1], length(a[1]), 1)
			if (res == 1) white++ 
			else if (res == 0) black++ 
			else if (res == 2) draw++ 
		} 
		END { 
			print white, black, draw 
		}' \
	| mawk '{ white += $1; black += $2; draw += $3; } 
		END { print white+black+draw, white, black, draw }'
```
which runs in 3.84 s.

In addition, the script can use arrays instead of `if` conditions, as shown below

```bash
for i in {0..99}; do printf -- "data/cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '
		/Result/ { 
			split($0, a, "-")
			res[substr(a[1], length(a[1]), 1)]++
		} 
		END { 
			print res[1], res[0], res[2] 
		}' \
	| mawk '{white += $1; black += $2; draw += $3; } 
		END { print white+black+draw, white, black, draw }'
```
With this modification, the script run in 3.21 s.

Finally, the `substr` could be removed as shown below

```bash
for i in {0..99}; do printf -- "data/cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '
		/Result/ { res[$2]++ } 
		END { print res["\"1-0\"]"], res["\"0-1\"]"], res["\"1/2-1/2\"]"] }' \
	| mawk '{white += $1; black += $2; draw += $3; } 
		END { print white+black+draw, white, black, draw }'
```
With this modification, the script run in 2.96 s.


## Safety improvements

Like the original script, the improved versions are not strictly compliant with the [PGN standard](http://www.saremba.de/chessgml/standards/pgn/pgn-complete.htm). Specifically, all the scripts search for a row containing `Result`, but word could be part of a comment, as opposed to the actual field containing the result. Whether any such row would affect the outcome is debatable, but I would argue that the last script, being based on longer string sequences, has more chances of produce correct resutls. 

The problems can be fixed by replacing `/Result/` with `/^\[Result / && NF==2`, yielding the following script

```bash
for i in {0..99}; do printf -- "data/cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '
		/^\[Result / && NF==2 { res[$2]++ } 
		END { print res["\"1-0\"]"], res["\"0-1\"]"], res["\"1/2-1/2\"]"] }' \
	| mawk '{white += $1; black += $2; draw += $3} 
		END { print white+black+draw, white, black, draw }'
```
This script is safer and runs faster, in just 2.74 s. 

However, note that the replacement above is not commutative. If I would have replaced `/Result/` with `NF==2 && /^\[Result /`, the performance would have drop dramatically, with the script running in 8.38 s. Further, one could hypothesize that replacing the regular expression `/^\[Result /` with a fixed expression `$1 == "[Result"` should improve the performace, but turned out not to be the case. Such script run in 8.89 s.

Another problem with all scripts is that they fail to take into account that the `Results` field can also have a fourth value, anmely `*`. This symbol indicates that the game is inconclusive, abandoned, or in any other state than the other values. Turns out that, in the analysed pgn file, 300 games are have results with values `*`, which were ignore both by the original script and by the improved ones above. This can be fixed by adding  another value to the output, yielding the following scripts

```bash
for i in {0..99}; do printf -- "data/cgdata.00.pgn\0"; done \
	| xargs -0 -n4 -P4 mawk '
		/^\[Result / && NF==2 { res[$2]++ } 
		END { print res["\"1-0\"]"], res["\"0-1\"]"], res["\"1/2-1/2\"]"], res["\"*\"]"] }' \
	| mawk '{white += $1; black += $2; draw += $3; unknown += $4} 
		END { print white+black+draw+unknown, white, black, draw, unknown }'
```
This script now is not only safer but produces correct results and runs in 2.76 s.


## The cost of pure bash and cat

To be continued...

# References

+ Original article: [https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html]
+ Bash reference manual: [https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html]
+ MAWK website: [https://invisible-island.net/mawk/mawk.html#related_mawk]
+ MAWK pitfalls: [https://brenocon.com/blog/2009/09/dont-mawk-awk-the-fastest-and-most-elegant-big-data-munging-language/]
+ AWK user guide: [https://www.gnu.org/software/gawk/manual/gawk.html]
+ PGN format: [https://en.wikipedia.org/wiki/Portable_Game_Notation]
+ PGN standard: [http://www.saremba.de/chessgml/standards/pgn/pgn-complete.htm]
+ Chess-game data repository: [https://github.com/rozim/ChessData]
+ Useless use of cat award: [http://porkmail.org/era/unix/award.html]
