#lang video

(require video/render
         racket/file)

(define WIDTH 1920)
(define HEIGHT 1080)
(define logo "logo.png")
(define tmp (make-temporary-file "~a.mp4"))

(multitrack
 (color "black" #:properties (hash "width" WIDTH
                                   "height" HEIGHT
                                   "start" 0
                                   "end" 6))
 (overlay-merge 0 0 (/ WIDTH 2) (/ HEIGHT 2))
 (clip logo)
 (overlay-merge (/ WIDTH 2) 0 (/ WIDTH 2) (/ HEIGHT 2))
 (clip logo)
 (overlay-merge 0 (/ HEIGHT 2) (/ WIDTH 2) (/ HEIGHT 2))
 (clip logo)
 (overlay-merge (/ WIDTH 2) (/ HEIGHT 2) (/ WIDTH 2) (/ HEIGHT 2))
 (clip logo))
(fade-transition 4)
(clip tmp)
(fade-transition 1)
(clip tmp)
(fade-transition 1)
(clip tmp)
(fade-transition 1)
(clip tmp)

(define main
  (render/pretty
(apply playlist
 (for/list ([i (in-range 1)])
   (multitrack
    (color "black" #:properties (hash "width" WIDTH
                                      "height" HEIGHT))
    (overlay-merge 0 0 (/ WIDTH 2) (/ HEIGHT 2))
    (apply playlist
           (for/list ([i (in-range 2)])
             (external-video "running.rkt")))
    (overlay-merge (/ WIDTH 2) 0 (/ WIDTH 2) (/ HEIGHT 2))
    (external-video "flying.rkt")
    (overlay-merge 0 (/ HEIGHT 2) (/ WIDTH 2) (/ HEIGHT 2))
    (apply playlist
           (for/list ([i (in-range 5)])
             (external-video "chirping.rkt")))
    (overlay-merge (/ WIDTH 2) (/ HEIGHT 2) (/ WIDTH 2) (/ HEIGHT 2))
    (apply playlist
           (for/list ([i (in-range 2)])
             (external-video "jumping.rkt"))))))
tmp))