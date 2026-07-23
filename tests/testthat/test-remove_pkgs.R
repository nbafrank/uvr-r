test_that("remove_pkgs works and errors on empty packages", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE) # installs uvr if needed

  expect_no_error(
    remove_pkgs("jsonlite", bin = path, dir = temp_dir, quiet = TRUE)
  )
  expect_error(
    remove_pkgs(character(0), quiet = TRUE),
    "must be a non-NA character vector with length > 0"
  )
})

test_that("remove_pkgs removes the package from uvr.toml and uvr.lock (#19)", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE)

  # Present in the manifest and lockfile after add()
  toml_before <- paste(
    readLines(file.path(temp_dir, "uvr.toml")),
    collapse = "\n"
  )
  expect_match(toml_before, "jsonlite", fixed = TRUE)
  expect_false(is.na(locked_version(temp_dir, "jsonlite")))

  remove_pkgs("jsonlite", bin = path, dir = temp_dir, quiet = TRUE)

  toml_after <- paste(
    readLines(file.path(temp_dir, "uvr.toml")),
    collapse = "\n"
  )
  expect_no_match(toml_after, "jsonlite", fixed = TRUE)
  expect_true(is.na(locked_version(temp_dir, "jsonlite")))
})

test_that("remove_pkgs + sync removes the package from the library (#19)", {
  skip_on_cran()
  skip_if_offline()
  # sync only prunes unused packages from the library since uvr 0.4.3
  # (0.4.2 printed the "run uvr sync to remove" hint but never pruned)
  if (package_version(.get_uvr_version()) < "0.4.3") {
    skip("library pruning on sync requires uvr >= 0.4.3")
  }
  temp_dir <- .make_temp_dir()
  cache_dir <- file.path(temp_dir, ".uvr-test-cache")
  withr::local_envvar(
    UVR_PACKAGES_DIR = file.path(temp_dir, ".uvr-test-packages")
  )
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE)

  sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))

  remove_pkgs("jsonlite", bin = path, dir = temp_dir, quiet = TRUE)
  sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)
  expect_false(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))

  # The cache is deliberately untouched by remove: entries persist for
  # future installs and are cleaned via cache_clean() (#19 "cache?").
  packages_dir <- Sys.getenv("UVR_PACKAGES_DIR")
  expect_true(
    length(list.files(packages_dir, pattern = "^jsonlite-")) > 0
  )
})
