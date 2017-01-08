# --------------------------------------------------------------------------- #
# htmlwidgets
# iconArray
# @mfontcada - 15/06/2016
# --------------------------------------------------------------------------- #

#' iconArray ------------------------------------------------------------------
#' iconArray
#'
#' Create an icon array visualization.
#'
#' @examples
#' values <- sample(seq(0,1,0.1), 10*10, TRUE)
#' iconArray(10, 10, bar = values)
#' # Color
#' iconArray(10, 10, bar = values, color = sample(c("red", "blue"), 100, TRUE))
#' # Opacity
#' iconArray(10, 10, bar = values, opacity = sample(seq(0, 1, 0.1), 10*10, TRUE))
#' # Border
#' iconArray(10, 10, bar = values, border = sample(0:1, 10 * 10, TRUE))
#' # Labels
#' iconArray(10, 10, bar = values, labels = sample(c("O", "X"), 10 * 10, TRUE))
#'
#' # Complete example
#' iconArray(10, 10, bar = values,
#'           border = rep(1, 100),
#'           color = sample(c("red", "blue"), 100, TRUE),
#'           opacity = sample(seq(0, 1, 0.1), 10*10, TRUE),
#'           labels = seq(1, 100))
#'
#' @import htmlwidgets
#'
#' @export
iconArray <- function(nrow, ncol, gap = 5,
                      color = NULL, opacity = NULL, bar = NULL,
                      border = NULL, labels = NULL, ids = NULL,
                      width = NULL, height = NULL) {

  grid <- expand.grid(row = seq(1, nrow), col = seq(1, ncol))

  if (is.null(color)) color <- rep("#DDD", nrow(grid))

  if (is.null(opacity)) opacity <- rep(1, nrow(grid))

  if (is.null(border)) border <- rep(0, nrow(grid))

  if (is.null(labels)) labels <- rep("", nrow(grid))

  if (is.null(ids)) ids <- paste0("icon", seq(1, nrow(grid)))

  # forward options using x
  x = list(
    nrow = nrow,
    ncol = ncol,
    gap = gap,
    grid = grid,
    color = color,
    opacity = opacity,
    bar = bar,
    border = border,
    labels = labels,
    ids = ids
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'iconArray',
    x,
    width = width,
    height = height,
    package = 'iconArray'
  )
}
# --------------------------------------------------------------------------- #

# iconArrayOutput -------------------------------------------------------------
#' Shiny bindings for iconArray
#'
#' Output and render functions for using iconArray within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a iconArray
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name iconArray-shiny
#'
#' @export
iconArrayOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'iconArray', width, height, package = 'iconArray')
}
# --------------------------------------------------------------------------- #

# renderIconArray ------------------------------------------------------------
#' @rdname iconArray-shiny
#' @export
renderIconArray <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, iconArrayOutput, env, quoted = TRUE)
}
# --------------------------------------------------------------------------- #
