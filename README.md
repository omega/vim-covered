# vim-covered

Inspired by: http://use.perl.org/use.perl.org/_Ovid/journal/36030.html

Depends on:

* https://metacpan.org/module/Devel::CoverX::Covered
* https://github.com/tyru/current-func-info.vim/ (optional)

Simply put, it gives you two functions: `Coverage()` and `ReTest()`. The first
one gives you a location-list of either tests that cover the file (or sub) you
are in, or if you are in a test file, it will give you a list of what source
files are covered by this test file.

`ReTest()` in a testfile will simply run prove on the file and show the TAP in
a new buffer. If you are in a source file, it will re-run the tests that cover
the source file, and if you are in a sub (and have current-func-info installed)
it will rerun testfiles that cover the current function.

In addition, it has a syntax highligher for TAP to make that window look
a little nicer on test output :)
