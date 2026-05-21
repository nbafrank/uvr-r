# run works and requires script argument

    Code
      cat(paste(expect_no_error(run(script = "test.R", bin = path, dir = temp_dir,
        quiet = TRUE)), collapse = "\n"))
    Output
      
      R version 4.6.0 (2026-04-24 ucrt) -- "Because it was There"
      Copyright (C) 2026 The R Foundation for Statistical Computing
      Platform: x86_64-w64-mingw32/x64
      
      R is free software and comes with ABSOLUTELY NO WARRANTY.
      You are welcome to redistribute it under certain conditions.
      Type 'license()' or 'licence()' for distribution details.
      
      R is a collaborative project with many contributors.
      Type 'contributors()' for more information and
      'citation()' on how to cite R or R packages in publications.
      
      Type 'demo()' for some demos, 'help()' for on-line help, or
      'help.start()' for an HTML browser interface to help.
      Type 'q()' to quit R.
      
      > print("Hello World")
      [1] "Hello World"
      > 

