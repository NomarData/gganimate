#' @importFrom ggplot2 is.ggplot
as.gganim <- function(x) {
  if (is.gganim(x)) return(x)
  if (!is.ggplot(x)) stop('Only knows how to convert ggplot to gganim', call. = FALSE)
  class(x) <- c('gganim', class(x))
  x$transition <- transition_null()
  x$view <- view_static()
  x$shadow <- shadow_null()
  x$transmuters <- transmuter_list()
  x$ease <- ease_aes('linear')
  x
}
is.gganim <- function(x) inherits(x, 'gganim')

#' @rdname animate
#' @export
print.gganim <- function(x, ...) {
  anim <- animate(x, ...)
  print(anim, info = FALSE)
}
#' @rdname animate
#' @export
knit_print.gganim <- function(x, ...) {
  anim <- animate(x)
  knitr::knit_print(anim)
}

# HELPERS -----------------------------------------------------------------

set_nframes <- function(plot, n) {
  plot$nframes <- n
  plot
}
get_nframes <- function(plot) {
  if (is.null(plot$scene)) plot$nframes
  else plot$scene$nframes
}
