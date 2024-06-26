## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("oeli")

## -----------------------------------------------------------------------------
### 1. Create a `Storage` object:
my_storage <- Storage$new()

# 2. Add elements along with identifiers:
my_storage$
  add(42, c("number", "rational"))$
  add(pi, c("number", "!rational"))$
  add("fear of black cats", c("text", "!rational"))$
  add("wearing a seat belt", c("text", "rational"))$
  add(mean, "function")

# 3. What elements are stored?
print(my_storage)

# 4. Extract elements based on identifiers:
my_storage$get("rational")
my_storage$get("!rational")
my_storage$get(c("text", "!rational"))
my_storage$get("all") # get all elements
my_storage$get(c("text", "!text"))
my_storage$get(c("text", "!text"), logical = "or")

# 5. Extract elements based on ids:
my_storage$get(ids = 4:5)
my_storage$get(ids = 4:5, id_names = TRUE) # add the ids as names

