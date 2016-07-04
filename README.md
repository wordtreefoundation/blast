# BLAST Sequence Alignment

This project uses the BLAST+ genetic sequence alignment tool to find likely biblical sources for every sentence in the Book of Mormon.

## Installation

Install BLAST+ on Mac OS:
```
brew install homebrew/science/blast
```

Index sequences cannot contain ":"
so, for biblical verse refs, use this format:
`BOOK-CHAPTER-VERSE-PART`, e.g. `GENESIS-1-1-A`

Spaces appear to be automatically removed from FASTA files.

### Prepare the King James Bible FASTA file

```
cd data
ruby ../kjv.rb >kjv.fasta
```

### Prepare the Book of Mormon FASTA file

```
cd data
ruby ../bom.rb >bom.fasta
```

### Create the BLAST database

```
cd data
makeblastdb -in kjv.fasta -parse_seqids -dbtype prot
```

## Search

Search for a specific index/verse:
```
$ blastdbcmd -db kjv.faa -entry GENESIS-1-1-A
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
$ blastp -query query.fasta -db kjv.fasta
```

## Find Book of Mormon Sequences

```
$ blastp -query bom.fasta -db kjv.fasta -culling_limit 5 >results.txt
```

The results will show signficant alignments (if any) and the character-aligned best matches.

## Misc

Handy reference for BLAST to BLAST+:
http://www.vicbioinformatics.com/documents/Quick_Start_Guide_BLAST_to_BLAST+.pdf

