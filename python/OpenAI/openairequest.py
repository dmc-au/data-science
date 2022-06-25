import argparse
import os
import openai
import json
import logging
from conf import openaikey # Key stored in variable 'openaikey'

# Logging configuration
log_format = "%(levelname)s %(asctime)s - %(message)s"
logging.basicConfig(filename='openai_log.log',
					filemode='a',
					format=log_format,
					level=logging.INFO)
logger = logging.getLogger()

# API Key definition
openai.api_key = openaikey  # Ensure your API key is stored in conf.py 

# Submit the prompt
def submit_prompt(prompt, temperature=0.7):
	response = openai.Completion.create(
	  engine="text-davinci-002",
	  prompt=prompt,
	  temperature=temperature,
	  max_tokens=64,
	  top_p=1.0,
	  frequency_penalty=0.0,
	  presence_penalty=0.0
	)
	return response

# Main function
if __name__ == '__main__':
	# Gather command-line arguments
	parser = argparse.ArgumentParser()
	parser.add_argument('--prompt',type=str,help='The prompt to submit to OpenAI')
	parser.add_argument('--temp',type=float,default=0.7,help='OpenAI completion temperature')
	args = parser.parse_args()

	response = submit_prompt(args.prompt, args.temp)
	
	# Append the prompt and OpenAI's response to the log file
	logger.info(f'prompt: "{args.prompt}"') 
	logger.info(f'response: {response}')

	# Print just the text part of the response to terminal
	print(f'{response.choices[0].text}\n\n')  # to match OpenAI's 2 line prepend
