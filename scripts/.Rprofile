options(warnPartialMatchArgs = TRUE, warnPartialMatchDollar = TRUE, warnPartialMatchAttr = TRUE)

### GENERAL OPTIONS -----------------------------

options(
  prompt          = "> ",
  continue        = "+ ",
  width           = 80,
  scipen          = 100,
  warn            = 0,
  editor          = "Atom",
  stringsAsFactor = TRUE,
  tab.width       = 2
)

### GRAPHICAL DEVICE DIMENSIONS -----------------

grDevices::quartz.options(
  width  = 6,
  height = 5
)

### CRAN MIRROR ---------------------------------

local({
  r <- getOption("repos")
  r["CRAN"] <- "http://cran.rstudio.com/"
  options(repos = r)
})

### QUIT R WITHOUT SAVING -----------------------

.env <- new.env()
.env$q <- function(save = "no", ...) {
  quit(save = save, ...)
}
attach(.env, warn.conflicts = FALSE)
