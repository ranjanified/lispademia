(in-package #:cl-pcl)

(defmacro define-generic-binary-class (name (&rest superclasses) slots read-method)
  (with-gensyms (object stream)
    `(progn
       (eval-when (:compile-toplevel :load-toplevel :execute)
	 (setf (get ',name 'slots) ',(mapcar #'first slots))
	 (setf (get ',name 'superclasses) ',superclasses))
       
       (defclass ,name ,superclasses
	 ,(mapcar #'slot->defclass-slot slots))

       ,read-method
       
       (defmethod write-object progn ((,object ,name) ,stream)
	 (declare (ignorable ,stream))
	 (with-slots ,(new-class-all-slots slots superclasses) ,object
	   ,@(mapcar #'(lambda (s) (slot->write-value s stream)) slots))))))

(defmacro define-binary-class (name (&rest superclasses) slots)
  (with-gensyms (object stream)
    `(define-generic-binary-class ,name ,superclasses ,slots
       (defmethod read-object progn ((,object ,name) ,stream)
	 (declare (ignore ,stream))
	 (with-slots ,(new-class-all-slots slots superclasses) ,object
	   ,@(mapcar #'(lambda (s) (slot->read-value s stream)) slots))))))

(defmacro define-tagged-binary-class (name (&rest superclasses) slots &rest options)
  (with-gensyms (type object stream)
    `(define-generic-binary-class ,name ,superclasses ,slots
      (defmethod read-value ((,type (eql ',name)) ,stream &key)
        (let* ,(mapcar #'(lambda (x) (slot->binding x stream)) slots)
          (let ((,object
                 (make-instance 
                  ,@(or (cdr (assoc :dispatch options))
                        (error "Must supply :dispatch form."))
                  ,@(mapcan #'slot->keyword-arg slots))))
            (read-object ,object ,stream)
            ,object))))))

;; (define-binary-class id3-tag
;;   ((identifier (iso-8859-1-string :length 3))
;;    (major-version   u1)
;;    (revision        u1)
;;    (flags           u1)
;;    (size            id3-tag-size)
;;    (frames          (id3-frames :tag-size size))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defclass id3-tag ()
;;   ((identifier    :initarg :identifier    :accessor identifier)
;;    (major-version :initarg :major-version :accessor major-version)
;;    (revision      :initarg :revision      :accessor revision)
;;    (flags         :initarg :flags         :accessor flags)
;;    (size          :initarg :size          :accessor size)
;;    (frames        :initarg :frames        :accessor frames)))

;; (defgeneric read-value (type stream &key)
;;   (:documentation "Read a value of the given type from the stream"))

;; (defgeneric write-value (obj-type out-stream obj-val &key)
;;   (:documentation "Write a value of the given type to the stream"))

;; (defmethod read-value ((type (eql 'id3-tag)) in-stream &key)
;;   (let ((object (make-instance 'id3-tag)))
;;     (with-slots (identifier major-version revision flags size frames) object
;;       (setf identifier    (read-value 'iso-8859-1-string in-stream :length 3))
;;       (setf major-version (read-value 'u1 in-stream))
;;       (setf revision      (read-value 'u1 in-stream))
;;       (setf flags         (read-value 'u1 in-stream))
;;       (setf size          (read-value 'id3-encoded-size in-stream))
;;       (setf frames        (read-value 'id3-frames in-stream :tag-size size)))
;;     object))

;; (defun read-id3-tag (in)
;;   (let ((tag (make-instance 'id3-tag)))
;;     (with-slots (identifier major-version revision flags size frames) tag
;;       (setf identifier    (read-iso-8859-1-string in :length 3))
;;       (setf major-version (read-u1 in))
;;       (setf revision      (read-u1 in))
;;       (setf flags         (read-u1 in))
;;       (setf size          (read-id3-encoded-size in))
;;       (setf frames        (read-id3-frames in :tag-size size)))
;;     tag))

;; (defmethod write-value ((type (eql 'id3-tag)) out-stream tag-value &key))
;; (defun write-id3-tag (tag out-stream)
;;   (error "not implemented"))

;; (defmethod read-value ((type (eql 'u1)) in-stream &key))
;; (defun read-u1 (in-stream)
;;   (error "not implemented"))

;; (defmethod write-value ((type (eql 'u1)) out-stream out-val &key))
;; (defun write-u1 (out)
;;   (error "not implemented"))

;; (defmethod read-value ((type (eql 'iso-8859-1-string)) in-stream &key length))
;; (defun read-iso-8859-1-string (in-stream &key length)
;;   (error "not implemented"))

;; (defmethod write-value ((type (eql 'u1)) out-stream obj-val &key length))
;; (defun write-iso-8859-1-string (out-stream &key length)
;;   (error "not implemented"))

;; (defmethod read-value ((type (eql 'id3-encoded-size)) in-stream &key))
;; (defun read-id3-encoded-size (in-stream)
;;   (error "not implemented"))

;; (defmethod write-value ((type (eql 'id3-encoded-size)) out-stream obj-val &key))
;; (defun write-id3-encoded-size (size out-stream)
;;   (error "not implemented"))

;; (defmethod read-value ((type (eql 'id3-frames)) in &key tag-size))
;; (defun read-id3-frames (in-stream &key tag-size)
;;   (error "not implemented"))

;; (defmethod write-value ((type (eql 'id3-frames)) out-stream obj-val &key tag-size))
;; (defun write-id3-frames (frames out-stream &key tag-size)
;;   (error "not implemented"))
