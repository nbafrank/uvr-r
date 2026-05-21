# import works and create lockfile if desired

    Code
      cat(paste(readLines(file.path(temp_dir, "uvr.toml")), collapse = "\n"))
    Output
      [project]
      name = "uvr-test"
      r_version = "4.5.3"
      
      [dependencies]
      markdown = "*"
      
      [dependencies.mime]
      git = "yihui/mime"
      rev = "1763e0dcb72fb58d97bab97bb834fc71f1e012bc"

