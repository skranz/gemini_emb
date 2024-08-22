import pathlib
import textwrap

import google.generativeai as genai
import os

import sys

# main

text_file = sys.argv[1]
out_file = sys.argv[2]
#model_name = sys.argv[1]
model_name = "models/text-embedding-004"

#print ('\nmodel=', model_name)
print ('\ntext_file=', text_file)
#print ('\nout_file=', out_file)

API_KEY = os.environ['API_KEY']
genai.configure(api_key=API_KEY)

text = pathlib.Path(text_file).read_text()

#print("\nText:\n", text)

response = genai.embed_content(model=model_name,content=text)

#print("\nresponse.text:\n")
print(str(response['embedding'])[:30], '... TRIMMED]')

pathlib.Path(out_file).write_text(str(response['embedding']))
