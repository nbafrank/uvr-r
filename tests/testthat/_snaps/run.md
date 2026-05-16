# run works and requires script argument

    Code
      cat(paste(expect_no_error(run(script = "test.R", bin = path, dir = temp_dir,
        quiet = TRUE)), collapse = "\n"))
    Output
      > print("Hello World")
      [1] "Hello World"
      > 

