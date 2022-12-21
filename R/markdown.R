markdown_link_enum_if_any <- function(base_names, caption = "Links") {
  
  if (length(base_names) == 0L) {
    return("")
  }
  
  markdown_link_enum(
    caption = caption, 
    base_url = "https://kwb-r.github.io/kwb.impetus/", 
    base_names = base_names
  )
}

markdown_link_enum <- function(caption, base_url, base_names) {
  paste0(
    caption, ":\n\n", 
    markdown_enum(markdown_link(base_names, paste0(base_url, base_names)))
  )
}

markdown_enum <- function(x) {
  paste0("- ", x, collapse = "\n\n")
}

markdown_link <- function(name, url) {
  sprintf("[%s](%s)", name, url)
}
