#lang rosette 
 
(require "../cosette.rkt" "../util.rkt" "../denotation.rkt" "../cosette.rkt" "../sql.rkt" "../evaluator.rkt" "../syntax.rkt" "../symmetry.rkt" "../test-util.rkt") 
  

(provide ros-instance)  

(current-bitwidth #f)

(define t0 (table-info "input" (list "id" "customer" "total")))
 
(define (q5 tables) 
(SELECT (VALS "t4.min_id1" "t4.customer" "t4.total" )
 FROM (AS (JOIN (AS (SELECT (VALS (VAL-UNOP aggr-min (val-column-ref "t3.id")) )
 FROM (AS (SELECT (VALS "input.id" "input.customer" "input.total" )
 FROM (NAMED (list-ref tables 0))
 WHERE (AND (BINOP "input.id" > "input.total") (TRUE))) ["t3" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list )
 HAVING (TRUE)) ["t1" (list "min_id")]) (AS (SELECT (VALS "t2.customer" "t2.total" (VAL-UNOP aggr-min (val-column-ref "t2.id")) )
 FROM (AS (NAMED (list-ref tables 0)) ["t2" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list "t2.customer" "t2.total" )
 HAVING (TRUE)) ["t5" (list "customer" "total" "min_id")])) ["t4" (list "min_id" "customer" "total" "min_id1")])
 WHERE (AND (BINOP "t4.min_id" >= "t4.min_id1") (BINOP "t4.min_id" (lambda (x y) (not (equal? x y))) "t4.total"))))
 
(define (q4 tables) 
(SELECT (VALS "t4.min_id" "t4.customer" "t4.total" )
 FROM (AS (JOIN (AS (SELECT (VALS "t1.customer" "t1.total" (VAL-UNOP aggr-min (val-column-ref "t1.id")) )
 FROM (AS (NAMED (list-ref tables 0)) ["t1" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list "t1.customer" "t1.total" )
 HAVING (TRUE)) ["t2" (list "customer" "total" "min_id")]) (AS (SELECT (VALS (VAL-UNOP aggr-min (val-column-ref "t5.id")) )
 FROM (AS (SELECT (VALS "input.id" "input.customer" "input.total" )
 FROM (NAMED (list-ref tables 0))
 WHERE (AND (BINOP "input.id" > "input.total") (TRUE))) ["t5" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list )
 HAVING (TRUE)) ["t3" (list "min_id")])) ["t4" (list "customer" "total" "min_id" "min_id1")])
 WHERE (AND (BINOP "t4.min_id" <= "t4.min_id1") (BINOP "t4.total" (lambda (x y) (not (equal? x y))) "t4.min_id1"))))
 
(define (q3 tables) 
(SELECT (VALS "t4.min_id" "t4.customer" "t4.total" )
 FROM (AS (JOIN (AS (SELECT (VALS "t2.customer" "t2.total" (VAL-UNOP aggr-min (val-column-ref "t2.id")) )
 FROM (AS (NAMED (list-ref tables 0)) ["t2" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list "t2.customer" "t2.total" )
 HAVING (TRUE)) ["t1" (list "customer" "total" "min_id")]) (AS (SELECT (VALS "t5.customer" (VAL-UNOP aggr-min (val-column-ref "t5.total")) )
 FROM (AS (SELECT (VALS "input.id" "input.customer" "input.total" )
 FROM (NAMED (list-ref tables 0))
 WHERE (AND (BINOP "input.id" < "input.total") (TRUE))) ["t5" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list "t5.customer" )
 HAVING (TRUE)) ["t3" (list "customer" "min_total")])) ["t4" (list "customer" "total" "min_id" "customer1" "min_total")])
 WHERE (AND (BINOP "t4.min_id" <= "t4.min_total") (BINOP "t4.total" (lambda (x y) (not (equal? x y))) "t4.min_total"))))
 
(define (q2 tables) 
(SELECT (VALS "t1.min_id" "t1.customer" "t1.total" )
 FROM (AS (JOIN (AS (SELECT (VALS (VAL-UNOP aggr-min (val-column-ref "t4.total")) )
 FROM (AS (SELECT (VALS "input.id" "input.customer" "input.total" )
 FROM (NAMED (list-ref tables 0))
 WHERE (AND (BINOP "input.id" < "input.total") (TRUE))) ["t4" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list )
 HAVING (TRUE)) ["t2" (list "min_total")]) (AS (SELECT (VALS "t5.customer" "t5.total" (VAL-UNOP aggr-min (val-column-ref "t5.id")) )
 FROM (AS (NAMED (list-ref tables 0)) ["t5" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list "t5.customer" "t5.total" )
 HAVING (TRUE)) ["t3" (list "customer" "total" "min_id")])) ["t1" (list "min_total" "customer" "total" "min_id")])
 WHERE (AND (BINOP "t1.min_total" >= "t1.min_id") (BINOP "t1.min_total" (lambda (x y) (not (equal? x y))) "t1.total"))))
 
(define (q1 tables) 
(SELECT (VALS "t5.min_id" "t5.customer1" "t5.total" )
 FROM (AS (JOIN (AS (SELECT (VALS "t4.customer" (VAL-UNOP aggr-min (val-column-ref "t4.total")) )
 FROM (AS (SELECT (VALS "input.id" "input.customer" "input.total" )
 FROM (NAMED (list-ref tables 0))
 WHERE (AND (BINOP "input.id" < "input.total") (TRUE))) ["t4" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list "t4.customer" )
 HAVING (TRUE)) ["t2" (list "customer" "min_total")]) (AS (SELECT (VALS "t1.customer" "t1.total" (VAL-UNOP aggr-min (val-column-ref "t1.id")) )
 FROM (AS (NAMED (list-ref tables 0)) ["t1" (list "id" "customer" "total")])
 WHERE (TRUE)
 GROUP-BY (list "t1.customer" "t1.total" )
 HAVING (TRUE)) ["t3" (list "customer" "total" "min_id")])) ["t5" (list "customer" "min_total" "customer1" "total" "min_id")])
 WHERE (AND (BINOP "t5.min_total" >= "t5.min_id") (BINOP "t5.min_total" (lambda (x y) (not (equal? x y))) "t5.total"))))

(define ros-instance (list q1 q2 (list t0)))
