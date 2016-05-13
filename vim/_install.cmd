
if !VERBOSE!==Y echo mklink /d %USERPROFILE%/vimfile %CD%
if !VERBOSE!==Y echo mklink %USERPROFILE%/_vsvimrc %CD%\vsvimrc.vim
if !TEST!==N mklink /d %USERPROFILE%/vimfile %CD%
if !TEST!==N mklink %USERPROFILE%/_vsvimrc %CD%\vsvimrc.vim
