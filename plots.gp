set ylabel "density"
plot 'tmp' u 1:2 t 'AUSM' w l
set term pdf
set output 'density.pdf'
replot
set output
set terminal x11

#pause -1

set ylabel "pressure"
plot 'tmp' u 1:4t 'AUSM' w l
set term pdf
set output 'pressure.pdf'
replot
set output
set terminal x11

#pause -1

set ylabel "velocity"
plot 'tmp' u 1:3 t 'AUSM'  w l
set term pdf
set output 'velocity.pdf'
replot
set output
set terminal x11
