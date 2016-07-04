# BLAST Sequence Alignment

This project uses the BLAST+ genetic sequence alignment tool to find likely biblical sources for every sentence in the Book of Mormon.

## Installation

Install BLAST+ on Mac OS:
```
brew install homebrew/science/blast
```

Install ruby gems:
```
bundle install
```

*Note:* You'll need `ruby 2.3` and `bundler` installed.

### Prepare the King James Bible FASTA file

```
cd data
bundle exec ruby ../kjv.rb >kjv.fasta
```

### Prepare the Book of Mormon FASTA file

```
cd data
bundle exec ruby ../bom.rb >bom.fasta
```

### Create the BLAST database

```
cd data
makeblastdb -in kjv.fasta -parse_seqids -dbtype prot
```

## Search

Search for a specific index/verse:
```
$ blastdbcmd -db kjv.fasta -entry GENESIS-1-1-A
>GENESIS-1-1-A 
INTHEBEGINNINGGODCREATEDTHEHEAVENANDTHEEARTH
```

Here's a sample query file, e.g. query.faa:
```
>TEST-1
DARKNESS WAS AN INTERESTING THING
>TEST-2
DID THE FIRMAMENT ALWAYS LOOK LIKE THAT
```

Then search for closest matches:
```
cd data
$ blastp -query query.fasta -db kjv.fasta
```

## Find Book of Mormon Sequences

```
cd data
$ blastp -query bom.fasta -db kjv.fasta -culling_limit 5 >results.txt
```

The results will show signficant alignments (if any) and the character-aligned best matches.

## Sample Results

```
Query= 1 NEPHI-1-3-B

Length=25
                                                                      Score     E
Sequences producing significant alignments:                          (Bits)  Value

1-CORINTHIANS-16-21-A  unnamed protein product                        35.8    3e-06
PHILEMON-1-19-A  unnamed protein product                              37.0    4e-06
1-SAMUEL-25-33-A  unnamed protein product                             37.0    4e-06
GALATIANS-6-11-A  unnamed protein product                             33.1    6e-05
2-CHRONICLES-6-15-B  unnamed protein product                          27.7    0.009
2-TIMOTHY-4-11-A  unnamed protein product                             23.5    0.21 

>GALATIANS-6-11-A unnamed protein product
Length=54

 Score = 33.1 bits (74),  Expect = 6e-05, Method: Compositional matrix adjust.
 Identities = 15/15 (100%), Positives = 15/15 (100%), Gaps = 0/15 (0%)

Query  11  WITHMINEOWNHAND  25
           WITHMINEOWNHAND
Sbjct  40  WITHMINEOWNHAND  54
```

The complete output (`results.txt`) is about 45 MB.

## Misc

Handy reference for BLAST to BLAST+:
http://www.vicbioinformatics.com/documents/Quick_Start_Guide_BLAST_to_BLAST+.pdf

Index sequences cannot contain ":"
so, for biblical verse refs, use this format:
`BOOK-CHAPTER-VERSE-PART`, e.g. `GENESIS-1-1-A`

Spaces appear to be automatically removed from FASTA files.
