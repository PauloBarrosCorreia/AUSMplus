set ylabel "density"
plot [] [0:1] 'solution.dat' u 1:2 t 'AUSM' w p
set term pdf
set output 'density.pdf'
replot
set output
set terminal x11

set ylabel "velocity"
plot 'solution.dat' u 1:3 t 'AUSM'  w p
set term pdf
set output 'velocity.pdf'
replot
set output
set terminal x11

set ylabel "pressure"
plot [] [0:1] 'solution.dat' u 1:4t 'AUSM' w p
set term pdf
set output 'pressure.pdf'
replot
set output
set terminal x11


