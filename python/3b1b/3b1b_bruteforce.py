""" Programming answer to the following 3b1b puzzle:
'Consider S: {1,2,3...2000}. How many subsets of S
have a sum divisible by 5?'

The answer will be provided in an analytical sense,
but I want to program it out for fun first."""

from itertools import combinations as cmb
import logging

# Logging configuration
log_format = "%(levelname)s %(asctime)s - %(message)s"
logging.basicConfig(filename='3b1b.log',
					filemode='w',
					format=log_format,
					level=logging.INFO)
logger = logging.getLogger()

# Defining the set, S, and intialising the output dict
SIZE = 50 
S = set(range(1,SIZE+1))
logger.info(f'set S: {S}')
output_dict = dict()

for i in range(1,SIZE+1):
	logger.info(f'subset size: {i}')
	output_dict[i] = 0 
	subsets = cmb(S,i)  # all subsets of size 'i'
	for s in subsets:
		if sum(s) % 5 == 0:
			logger.info(f'subset {s} is divisible by 5')
			output_dict[i] += 1
	logger.info(f"tally for subset size {i}: {output_dict[i]}")

total_sum = sum(output_dict.values())

logger.info(f'output dictionary: {output_dict}')
logger.info(f'the final tally for S of size {SIZE} is {total_sum}')
print(f'output dictionary: {output_dict}')
print(f'the final tally for S of size {SIZE} is {total_sum}')

