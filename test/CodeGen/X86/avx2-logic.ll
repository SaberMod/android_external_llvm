; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=core-avx2 -mattr=+avx2 | FileCheck %s

; CHECK: vpandn
; CHECK: vpandn  %ymm
; CHECK: ret
define <4 x i64> @vpandn(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %y = xor <4 x i64> %a2, <i64 -1, i64 -1, i64 -1, i64 -1>
  %x = and <4 x i64> %a, %y
  ret <4 x i64> %x
}

; CHECK: vpand
; CHECK: vpand %ymm
; CHECK: ret
define <4 x i64> @vpand(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %x = and <4 x i64> %a2, %b
  ret <4 x i64> %x
}

; CHECK: vpor
; CHECK: vpor %ymm
; CHECK: ret
define <4 x i64> @vpor(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %x = or <4 x i64> %a2, %b
  ret <4 x i64> %x
}

; CHECK: vpxor
; CHECK: vpxor %ymm
; CHECK: ret
define <4 x i64> @vpxor(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %x = xor <4 x i64> %a2, %b
  ret <4 x i64> %x
}

; CHECK: vpblendvb
; CHECK: vpblendvb %ymm
; CHECK: ret
define <32 x i8> @vpblendvb(<32 x i8> %x, <32 x i8> %y) {
  %min_is_x = icmp ult <32 x i8> %x, %y
  %min = select <32 x i1> %min_is_x, <32 x i8> %x, <32 x i8> %y
  ret <32 x i8> %min
}
