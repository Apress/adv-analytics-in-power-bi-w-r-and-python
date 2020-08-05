library(tidyverse)
library(readxl)

combine_sheets <- function(path) {

    df <- path %>%
        excel_sheets() %>%
        set_names() %>%
        map_df(.f = ~read_excel(path = path, sheet = .x), .id = "sheet")

        return(df)

}

setwd("./ExcelFiles/")
files <- list.files(".")
combined_workbooks <- map_df(files, combine_sheets)