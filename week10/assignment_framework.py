#!/usr/bin/env python3

import sys

import numpy as np

from fasta import readFASTA


#====================#
# Read in parameters #
#====================#

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code

# Read the scoring matrix into a dictionary
fs = open(sys.argv[2])
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# Read in the actual sequences using readFASTA

import sys

input_sequences = readFASTA(open(sys.argv[1]))

seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]


#=====================#
# Initialize F matrix #
#=====================#

n = len(sequence1)
m = len(sequence2)

F_matrix = np.zeros((n+1,m+1),int)


#=============================#
# Initialize Traceback Matrix #
#=============================#

traceback_matrix = np.zeros((n+1,m+1),int)

#===================#
# Populate Matrices #
#===================#

gap_penalty = int(sys.argv[3])

# sigma is scoring matrix dicionary with keys as (nt 0, nt 1), and values as the score

# Add the top row and first column gap penalties
for i in range(1, n+1):
    F_matrix[i,0] = F_matrix[i-1, 0] + gap_penalty
    traceback_matrix[i,0] = traceback_matrix[i-1,0] + gap_penalty

for i in range(1, m+1):
    F_matrix[0, i] = F_matrix[0, i-1] + gap_penalty 
    traceback_matrix[0, i] = traceback_matrix[0, i-1] + gap_penalty


# populate F_mmatrix
for x in range(1, n+1):
    for y in range(1,m+1):
        up_score = F_matrix[x-1, y] + gap_penalty
        left_score = F_matrix[x, y-1] + gap_penalty
		# only the diagonal score would change from the class example where the match and mismatch scores are - don't need an if statement here, just look up by letter in sequence
        diagonal_score = F_matrix[x-1, y-1] + sigma.get((sequence1[x-1], sequence2[y-1]))
        best_score = max(up_score, left_score, diagonal_score)
        F_matrix[x,y] = best_score
# print(F_matrix)

# populate traceback_matrix
for x in range(1, n+1):
    for y in range(1,m+1):
        up_score = traceback_matrix[x-1, y] + gap_penalty
        left_score = traceback_matrix[x, y-1] + gap_penalty
		# only the diagonal score would change from the class example where the match and mismatch scores are - don't need an if statement here, just look up by letter in sequence
        diagonal_score = traceback_matrix[x-1, y-1] + sigma.get((sequence1[x-1], sequence2[y-1]))
        
        best_score = max(up_score, left_score, diagonal_score)

        if diagonal_score == up_score and diagonal_score == left_score:
            best_score = diagonal_score
        elif up_score == left_score and up_score > diagonal_score:
              best_score = up_score        
		
        traceback_matrix[x,y] = best_score
# print(traceback_matrix)

#========================================#
# Follow traceback to generate alignment #
#========================================#

# The aligned sequences are assumed to be strings named sequence1_aligment and sequence2_alignment in later code

sequence1_alignment = ''
sequence2_alignment = ''

x = len(sequence1)
y = len(sequence2)

while x > 0 or y > 0 :
	# matix is len(x) x len(y) and we have to start at the bottom right
    current_val = traceback_matrix[x, y]
    left_val = traceback_matrix[x - 1, y]
    up_val = traceback_matrix[x, y-1]
    diag_val = traceback_matrix[x-1 , y-1]
    
    if left_val > up_val and left_val > diag_val:
        sequence1_alignment += sequence1[x-1]
        sequence2_alignment += '-'
        x -= 1 
    elif up_val >= left_val and up_val > diag_val:
        sequence1_alignment += '-'
        sequence2_alignment += sequence2[y-1]
        y -= 1
    elif diag_val >= left_val and diag_val >= up_val:
        sequence1_alignment += sequence1[x-1] # this was giving an index error so I think this is the right way to do this?
        sequence2_alignment += sequence2[y-1] # this was giving an index error so I think this is the right way to do this?
        x -= 1
        y -= 1
    else:
          print(f'diag_val {diag_val}, up_val {up_val}, left_val {left_val}')
          raise KeyError(f"Error in tracebook values!")


sequence1_alignment = sequence1_alignment[::-1] # its easier to add them all and then just reverse it - had to look this line up
sequence2_alignment = sequence2_alignment[::-1]

#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '


#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.
out_file = sys.argv[4]
output = open(out_file, 'w')

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_alignment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')


#=============================#
# Calculate sequence identity #
#=============================#

percent_seq_id_1 = identity_alignment.count('|')/n
percent_seq_id_2 = identity_alignment.count('|')/m

#======================#
# Print alignment info #
#======================#

# You need the number of gaps in each sequence, the sequence identity in each sequence, and the total alignment score

print(f'Gaps in sequence 1: {sequence1_alignment.count('-')}, Gaps in sequence 2: {sequence2_alignment.count('-')}')
print(f'Percent identity of seq1: {percent_seq_id_1*100}, Precent identity of seq2: {percent_seq_id_2*100}')
print(f'alignment score {traceback_matrix[n, m]}')
