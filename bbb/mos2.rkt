#lang video

(require video/render
         racket/file)

(define WIDTH 1920)
(define HEIGHT 1080)

(apply playlist
 (for/list ([i (in-range 1)])
   (multitrack
    (color "black" #:properties (hash "width" WIDTH
                                      "height" HEIGHT))
    (overlay-merge 0 0 (/ WIDTH 2) HEIGHT)
    (apply playlist
           (for/list ([i (in-range 6)])
             (external-video "running.rkt")))
    (overlay-merge (/ WIDTH 2) 0 (/ WIDTH 2) HEIGHT)
        (apply playlist
           (for/list ([i (in-range 2)])
             (external-video "flying.rkt"))))))
