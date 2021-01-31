;;;; Unlike the adjacent number.cl, this file and the functions
;;;; defined here were not included in the original cltl_src.tgz. The
;;;; main function of interest here is MAKE-BOOK-PLOTS, which can be
;;;; called without arguments to produce the same set of plots that
;;;; are included as Figures 12-1 to 12-20 in CLTL2.

;; The following function corresponds to Figure 12-5 from the book,
;; which is given as (z-1)/(z+1). A simplified / stylized version of
;; this plot also appears on the book's cover. Although the book uses
;; z for the complex variable, we use x here in keeping with the other
;; functions defined in number.cl. Interestingly, while this function
;; is included among the figures in the book and on the cover, it is
;; not included in the accompanying source code listing or in the
;; original number.cl from the latex source tgz. Note, however, that
;; the source code listing does include the function
;;
;;   (defun one-minus-over-one-plus (x)
;;     (/ (- 1 x) (+ 1 x)))
;;
;; and the function we're defining here could equivalently be written
;;
;;   (defun minus-one-over-plus-one (x)
;;     (- (one-minus-over-one-plus x)))
;;
;; i.e. the resulting figure is the same as the one produced by
;; ONE-MINUS-OVER-ONE-PLUS, but rotated 180 degrees about the origin.
;;
;; Also note that Figure 12-5 in the online version of the book[1]
;; shows the 180 deg rotated figure, i.e. the graph of (1-z)/(1+z),
;; even though the accompanying text still says (z-1)/(z+1). So
;; presumably the online version is based on an earlier printing or
;; draft of the book that differs slightly from my copy and includes
;; this "bug". On the other hand, the low-res thumbnail included on
;; the frontpage of the online version[2] *does* appear to show the
;; correct image of (z-1)/(z+1). Go figure!
;;
;; [1]:https://web.archive.org/web/20160123034430/https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/_24769_figure12594.gif
;; [2]:https://web.archive.org/web/20201207113504/https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/gif/cltl_sml.gif
(defun minus-one-over-plus-one (x)
  (/ (- x 1) (+ x 1)))

;; SQRT-SQUARE-MINUS-ONE is defined like so in number.cl:
;;
;; (defun sqrt-square-minus-one (x) (sqrt (- 1 (* x x))))
;;
;; which does correspond to the function given for Figure 12-19 in the
;; book, even if SQRT-ONE-MINUS-SQUARE seems like a better name. These
;; two functions only differ by a factor of +/- i, i.e to produce the
;; plot for TRULY-SQRT-SQUARE-MINUS-ONE from the plot for
;; SQRT-SQUARE-MINUS-ONE, rotate quadrant I down into quadrant IV and
;; vice versa.
;;
;; This function is not included in MAKE-BOOK-PLOTS since it's not
;; included in the book, but you can produce its plot with
;;
;; (picture 'truly-sqrt-square-minus-one)
(defun truly-sqrt-square-minus-one (x)
  (sqrt (- (* x x) 1)))

(defun make-book-plots ()
  "Generate the same sequence of plots that appear in CLTL2.

These are Figures 12-1 to 12-20 in section 12.5.3. Branch Cuts,
Principal Values, and Boundary Conditions in the Complex Plane.

http://web.archive.org/web/20210123234031/https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node129.html"
  (with-open-stream (*standard-output* (make-broadcast-stream))
    (mapc #'picture
          '(identity                    ; 12-1
            sqrt                        ; 12-2
            exp                         ; 12-3
            log                         ; 12-4
            minus-one-over-plus-one     ; 12-5
            one-plus-over-one-minus     ; 12-6
            sin                         ; 12-7
            asin                        ; 12-8
            cos                         ; 12-9
            acos                        ; 12-10
            tan                         ; 12-11
            atan                        ; 12-12
            sinh                        ; 12-13
            asinh                       ; 12-14
            cosh                        ; 12-15
            acosh                       ; 12-16
            tanh                        ; 12-17
            atanh                       ; 12-18
            sqrt-square-minus-one       ; 12-19
            sqrt-one-plus-square        ; 12-20
            ))))
