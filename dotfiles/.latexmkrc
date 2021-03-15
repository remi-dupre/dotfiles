$dvi_previewer = 'start xdvi -linkstyle 0 -expertmode 0 -watchfile 1.5';
$ps_previewer  = 'start gv --watch';
$pdf_previewer = 'start okular';
$pdflatex=q/xelatex %O -shell-escape -synctex=1 %S/
