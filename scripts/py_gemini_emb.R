example = function() {
  setwd("~/repbox/gemini/gemini_py")
  #pip_install("-q -U google-generativeai")
  py_run_script("gemini.py")
}

get_py_bin = function() {
  "python3"
}


py_run_script = function(file, args=list(), dir = getwd(),py_bin = get_py_bin()) {
  if (basename(file)==file) {
    file = file.path(dir, file)
  }

  cmd = paste0(py_bin, ' "',file,'"')
  if (length(args)>0) {
    cmd = paste0(cmd," ", paste0(unlist(args), collapse=" "))
  }
  cat(cmd)
  system(cmd)
}


run_gemini_emb_with_py = function(text_file, out_dir = "output") {
  library(jsonlite)

  if (!dir.exists(out_dir)) dir.create(out_dir)
  out_file = file.path(out_dir, basename(text_file))
  if (file.exists(out_file)) file.remove(out_file)

  py_run_script("/root/scripts/gemini_emb.py",args=list(text_file = text_file, out_file=out_file))
}


