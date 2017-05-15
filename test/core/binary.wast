(module "\00asm\01\00\00\00")
(module "\00asm" "\01\00\00\00")
(module $M1 "\00asm\01\00\00\00")
(module $M2 "\00asm" "\01\00\00\00")

(assert_malformed (module "") "unexpected end")
(assert_malformed (module "\01") "unexpected end")
(assert_malformed (module "\00as") "unexpected end")
(assert_malformed (module "asm\00") "magic header not detected")
(assert_malformed (module "msa\00") "magic header not detected")
(assert_malformed (module "msa\00\01\00\00\00") "magic header not detected")
(assert_malformed (module "msa\00\00\00\00\01") "magic header not detected")
(assert_malformed (module "asm\01\00\00\00\00") "magic header not detected")
(assert_malformed (module "wasm\01\00\00\00") "magic header not detected")
(assert_malformed (module "\7fasm\01\00\00\00") "magic header not detected")
(assert_malformed (module "\80asm\01\00\00\00") "magic header not detected")
(assert_malformed (module "\82asm\01\00\00\00") "magic header not detected")
(assert_malformed (module "\ffasm\01\00\00\00") "magic header not detected")

;; 8-byte endian-reversed.
(assert_malformed (module "\00\00\00\01msa\00") "magic header not detected")

;; Middle-endian byte orderings.
(assert_malformed (module "a\00ms\00\01\00\00") "magic header not detected")
(assert_malformed (module "sm\00a\00\00\01\00") "magic header not detected")

;; Upper-cased.
(assert_malformed (module "\00ASM\01\00\00\00") "magic header not detected")

;; EBCDIC-encoded magic.
(assert_malformed (module "\00\81\a2\94\01\00\00\00") "magic header not detected")

;; Leading UTF-8 BOM.
(assert_malformed (module "\ef\bb\bf\00asm\01\00\00\00") "magic header not detected")

(assert_malformed (module "\00asm") "unexpected end")
(assert_malformed (module "\00asm\01") "unexpected end")
(assert_malformed (module "\00asm\01\00\00") "unexpected end")
(assert_malformed (module "\00asm\00\00\00\00") "unknown binary version")
(assert_malformed (module "\00asm\0d\00\00\00") "unknown binary version")
(assert_malformed (module "\00asm\0e\00\00\00") "unknown binary version")
(assert_malformed (module "\00asm\00\01\00\00") "unknown binary version")
(assert_malformed (module "\00asm\00\00\01\00") "unknown binary version")
(assert_malformed (module "\00asm\00\00\00\01") "unknown binary version")
