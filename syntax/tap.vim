if exists("b:current_syntax")
    finish
endif

syntax match tapNoise "\v^.*$"
syntax match tapFile "\v^.* \.+ $"
syntax match tapFail "\vnot ok( \d+)?.*$"
syntax match tapPass "\vok( \d+)?.*$"
syntax match tapDiag "\v#.*$"

syntax match tapPlan "\v\d+\.\.\d+"

syntax match tapEndFail "\v^Result: FAIL$"
syntax match tapEndPass "\v^Result: PASS$"
syntax match tapEndPass "\v^All tests successful.$"

syntax match tapEndDubious "\v^Dubious, .*$"

hi clear Conceal

highlight link tapFile Underlined
highlight link tapEndPass Statement
highlight link tapEndFail Error
highlight link tapEndDubious Type
highlight link tapDiag Comment
hi! link tapPass Statement
hi! link tapFail Error
highlight link tapPlan Identifier
highlight link tapName Constant
highlight link tapNoise Comment



let b:current_syntax = "tap"
