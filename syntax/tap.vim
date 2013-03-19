if exists("b:current_syntax")
    finish
endif

syntax match tapNoise "\v^.*$"
syntax match tapFile "\v^.* \.+ $"
if has('conceal')
    set conceallevel=2
    syntax match tapPass "\vok( \d+)?" conceal cchar=✓
    syntax match tapFail "\vnot ok( \d+)?" conceal cchar=✗
else
    syntax match tapFail "\vnot ok( \d+)?"
    syntax match tapPass "\vok( \d+)?"
endif
syntax match tapDiag "\v#.*$"
syntax match tapName "\v- .*$"

syntax match tapPlan "\v\d+\.\.\d+"

syntax match tapEndFail "\v^Result: FAIL$"
syntax match tapEndPass "\v^Result: PASS$"
syntax match tapEndPass "\v^All tests successful.$"

syntax match tapEndDubious "\v^Dubious, .*$"


highlight link tapFile Underlined
highlight link tapEndPass Statement
highlight link tapEndFail Error
highlight link tapEndDubious Type
highlight link tapFail Error
highlight link tapPass Statement
highlight link tapDiag Comment
highlight link tapPlan Identifier
highlight link tapName Constant
highlight link tapNoise Comment



let b:current_syntax = "tap"
