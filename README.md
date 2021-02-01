# Code from CLtL2 to generate plots of complex functions

This repo contains the code from Common Lisp the Language, 2nd Edition that generates PostScript files to render the plots of various complex functions that appear in Figures 12-1 to 12-20 on pp. 317-336.

The book figures are neat, but the image quality in my old paperback edition is not very good and the gifs included in the [html version of the book][cltl2] aren't much better. In [at least one case][cltl2-fig-12-5] the online Figure seems to be [incorrect](https://github.com/appleby/cltl2-book-plots/blob/master/make-book-plots.cl#L7).

The source code listing that generated these plots appears in the book starting on page 339. You can find it online [here][cltl2-12.5.3], but there are a handful of functions that have been truncated (`STRAIGHT-LINE`, `SPLICE`). These errors don't appear in the book or the latex sources, so probably they were introduced in the latex2html conversion process (as mentioned in the Known Bugs section on the [front page][cltl2]). The errors are easy to fix, but that same website also provides a [tgz of the original latex sources][cltl2-tgz], which conveniently contains the lisp code in a file called `number.cl`.

This repo just contains that same [`number.cl`](number.cl) with a small handful of [minor tweaks](#changes-from-the-original) to get it to work with modern Common Lisp and PostScript implementations, plus a new convenience function to generate all the plots in [`make-book-plots.cl`](make-book-plots.cl).

# Downloading pre-generated PDFs

Pre-generated plots are checked in under the plots directory. These have been converted from the original PostScript output to PDF for easier web viewing, and enlarged 2x from the original 28 picas to a luxurious 56 picas. Hence, if you zoom to 50%, they should appear about the same size as in the book.

* [Figure 12-1 identity](plots/identity-plot.pdf)
* [Figure 12-2 sqrt](plots/sqrt-plot.pdf)
* [Figure 12-3 exp](plots/exp-plot.pdf)
* [Figure 12-4 log](plots/log-plot.pdf)
* [Figure 12-5 (z-1)/(z+1)](plots/minus-one-over-plus-one-plot.pdf)
* [Figure 12-6 (1+z)/(1-z) ](plots/one-plus-over-one-minus-plot.pdf)
* [Figure 12-7 sin](plots/sin-plot.pdf)
* [Figure 12-8 asin](plots/asin-plot.pdf)
* [Figure 12-9 cos](plots/cos-plot.pdf)
* [Figure 12-10 acos](plots/acos-plot.pdf)
* [Figure 12-11 tan](plots/tan-plot.pdf)
* [Figure 12-12 atan](plots/atan-plot.pdf)
* [Figure 12-13 sinh](plots/sinh-plot.pdf)
* [Figure 12-14 asinh](plots/asinh-plot.pdf)
* [Figure 12-15 cosh](plots/cosh-plot.pdf)
* [Figure 12-16 acosh](plots/acosh-plot.pdf)
* [Figure 12-17 tanh](plots/tanh-plot.pdf)
* [Figure 12-18 atanh](plots/atanh-plot.pdf)
* [Figure 12-19 sqrt(1-z<sup>2</sup>)](plots/sqrt-square-minus-one-plot.pdf)
* [Figure 12-20 sqrt(1+z<sup>2</sup>)](plots/sqrt-one-plus-square-plot.pdf)

# Generating the PostScript files

To generate the book plots, just do the following in your REPL.

1. Load the source files. Note that these files don't contain any `IN-PACKAGE` form, so they will be loaded into the current package. Maybe someday I'll put them in a package and write an asd file, but probably not. Also note that loading `number.cl` may produce a bunch of `STYLE-WARNING`s about undefined functions. The functions are not really undefined, just undefined at the point they are referenced. I could "fix" these by reordering the definitions, but don't want to introduce a bunch of unnecessary diffs from the original. Please ignore.

    (load "number.cl")
    (load "make-book-plots.cl")

2. Optionally, set `TEXT-WIDTH-IN-PICAS` to change the size of the output images. The default is 28 picas and a pica is 1/6 inch, so by default they are ~4.67 inches square.

    (setf text-width-in-picas 28)

3. Call `(make-book-plots)` to generate the PostScript files. They will be created in the current directory with names like `sin-plot.ps`, etc.

# Changes from the original

Only two small changes were required to get the code working on my laptop with recent versions of SBCL, CCL, and ghostscript<sup>1</sup>

1. Rename the locally bound function `CLOSE` in `PARAMETRIC-PATH` to `CLOSE-ENOUGH` to avoid a package lock violation on the `COMMON-LISP` package, which of course exports `CL:CLOSE`. I could have instead added a `DEFPACKAGE` + `SHADOW` + `IN-PACKAGE` to shadow the symbol, but renaming felt like a smaller diff.

2. Use `~F` rather than `~S` to format any floats. `~S` prints as if by `PRIN1`, i.e. the output is suitable for `READ`, which means that any float types that differ from `*READ-DEFAULT-FLOAT-FORMAT*` get a suffix appended, say "d0" for double floats. Preview.app and ps2pdf would then choke on these float-type suffixes when attempting to process the output files. Actually, I am not sure if `~F` is guaranteed to produce output that a PostScript interpreter will understand, but it [Works on My Machine][WOMM].

Beyond that there are handful of minor tweaks like to cleanup trailing white space, fix a `STYLE-WARNING` in `REPAIR-QUADRANT`, update `PICTURE` usage examples in comments, fix a small indentation issue, and set the PostScript PageSize attribute to be just large enough to contain the images, so that they are centered on the page rather than fixed at the bottom-left corner of a much larger page. Finally, I added the stuff in [make-book-plots.cl](make-book-plots.cl) as a convenience to generate the full list of figures that appear in the book.

<sup>1</sup> Tested with SBCL 2.0.11, CCL 1.12, ghostscript 9.53.3, and Preview 11.0 on macOS 10.15.7.

# Full color experience

Just for fun, here are the same set of figures plotted using Will Bolden's nifty [Complex Function Plotter][CFP].

* [Figure 12-1 identity](https://people.ucsc.edu/~wbolden/complex/#z)
* [Figure 12-2 sqrt](https://people.ucsc.edu/~wbolden/complex/#sqrt(z))
* [Figure 12-3 exp](https://people.ucsc.edu/~wbolden/complex/#exp(z))
* [Figure 12-4 log](https://people.ucsc.edu/~wbolden/complex/#log(z))
* [Figure 12-5 (z-1)/(z+1)](https://people.ucsc.edu/~wbolden/complex/#(z-1)/(z+1))
* [Figure 12-6 (1+z)/(1-z) ](https://people.ucsc.edu/~wbolden/complex/#(1+z)/(1-z))
* [Figure 12-7 sin](https://people.ucsc.edu/~wbolden/complex/#sin(z))
* [Figure 12-8 asin](https://people.ucsc.edu/~wbolden/complex/#asin(z))
* [Figure 12-9 cos](https://people.ucsc.edu/~wbolden/complex/#cos(z))
* [Figure 12-10 acos](https://people.ucsc.edu/~wbolden/complex/#acos(z))
* [Figure 12-11 tan](https://people.ucsc.edu/~wbolden/complex/#tan(z))
* [Figure 12-12 atan](https://people.ucsc.edu/~wbolden/complex/#atan(z))
* [Figure 12-13 sinh](https://people.ucsc.edu/~wbolden/complex/#sinh(z))
* [Figure 12-14 asinh](https://people.ucsc.edu/~wbolden/complex/#asinh(z))
* [Figure 12-15 cosh](https://people.ucsc.edu/~wbolden/complex/#cosh(z))
* [Figure 12-16 acosh](https://people.ucsc.edu/~wbolden/complex/#acosh(z))
* [Figure 12-17 tanh](https://people.ucsc.edu/~wbolden/complex/#tanh(z))
* [Figure 12-18 atanh](https://people.ucsc.edu/~wbolden/complex/#atanh(z))
* [Figure 12-19 sqrt(1-z<sup>2</sup>)](https://people.ucsc.edu/~wbolden/complex/#sqrt(1-z*z))
* [Figure 12-20 sqrt(1+z<sup>2</sup>)](https://people.ucsc.edu/~wbolden/complex/#sqrt(1+z*z))

[cltl2]:https://www.cs.cmu.edu/Groups/AI/html/cltl/cltl2.html

[cltl2-tgz]:https://web.archive.org/web/20210126135655/http://www.cs.cmu.edu/afs/cs.cmu.edu/project/ai-repository/ai/lang/lisp/doc/cltl/cltl_src.tgz

[cltl2-12.5.3]:https://web.archive.org/web/20210123234031/https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node129.html

[cltl2-fig-12-5]:https://web.archive.org/web/20160123034430/https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/_24769_figure12594.gif

[WOMM]:https://blog.codinghorror.com/the-works-on-my-machine-certification-program/

[CFP]:https://people.ucsc.edu/~wbolden/complex
