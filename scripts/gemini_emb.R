MAX_RUNTIME_SEC = 5*60*60 # max runtime on Github

create_embeddings = function() {
  start_time = as.numeric(Sys.time())
  
  API_KEY = Sys.getenv("API_KEY")
  setwd("~")
  outdir = "output"
  if (.Platform$OS.type == "windows") {
    setwd("C:/libraries/gpt/gemini/gemini_emb")
  }
  source("scripts/py_gemini_emb.R")

  source("scripts/encrypted_7z.R")
  extract_all_encrypted_7z("~/input")
  
  
  
  text_files = list.files("~/input",glob2rx("*.txt"), full.names = TRUE, recursive = TRUE)
  #cat("\nInput files:\n")
  #print(text_files)
  
  
  for (text_file in text_files) {
    run_gemini_emb_with_py(text_file, outdir)
    
    # Check total run time
    cur_time = as.numeric(Sys.time())
    if (cur_time - start_time > MAX_RUNTIME_SEC) {
      cat("\nStop because total runtime exceeded ", MAX_RUNTIME_SEC, " seconds.\n")
      return()
    }
    
  }
  
  #cat("\nOutput files:\n")
  #print(list.files(outdir,full.names = TRUE))
  
  cat("\n\nFINISHED\n\n")
}

