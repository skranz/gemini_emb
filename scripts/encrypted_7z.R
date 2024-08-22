extract_all_zip = function(dir) {
  zips = list.files(dir, glob2rx("*.zip"), full.names = TRUE, ignore.case = TRUE)
  if (length(zips)>0) {
    for (zip in zips) {
      unzip(zipfile = zip, exdir=dir)
    }
  }
  
}

extract_all_encrypted_7z = function(dir) {
  # Extract possibly compressed article PDF
  key = Sys.getenv("ENCRYPT_KEY")
  #print(paste0("Key = ", key))
  zips = list.files(dir, glob2rx("*.7z"), full.names = TRUE)
  if (length(zips)>0) {
    for (zip in zips) {
      extract.7z(dir, zip = zip, password = key)
    }
  }
}



to.7z = function(path, zip=paste0(basename(path),".7z"), password = NULL) {
  switch = ""
  if (!is.null(password)) {
    switch = paste0(" -p",password," ")
  }
  os =
  cmd = paste0('7z a ', zip, ' ', path,' ',  switch)
  cat(cmd)
  system(cmd)
}

extract.7z = function(path, zip=paste0(basename(path),".7z"), password = NULL) {
  oldwd = getwd()
  setwd(path)
  switch = ""
  if (!is.null(password)) {
    switch = paste0(" -p",password," ")
  }
  cmd = paste0('7z x ', zip, ' -y ',  switch)
  cat("\n", cmd,"\n")
  system(cmd,ignore.stdout = TRUE)
  setwd(oldwd)
}


to.7z = function(path, zip=paste0(basename(path),".7z"), password = NULL) {
  switch = ""
  if (!is.null(password)) {
    switch = paste0(" -p",password," ")
  }
  cmd = paste0('7z a ', zip, ' ', path,' ',  switch)
  cat(cmd)
  system(cmd)
}
