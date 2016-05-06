# Line style for axes
set style line 80 lt 0
set style line 80 lt rgb "#000000"

# Line style for grid
set style line 81 lt 3  # dashed
set style line 81 lt rgb "#808080" lw 0.5  # grey


set grid back linestyle 81
set border 3 back linestyle 80 # Remove border on top and right.  These
             # borders are useless and make it harder
             # to see plotted lines near the border.
    # Also, put it in grey; no need for so much emphasis on a border.
set xtics nomirror
set ytics nomirror

# Line styles: try to pick pleasing colors, rather
# than strictly primary colors or hard-to-see colors
# like gnuplot's default yellow.  Make the lines thick
# so they're easy to see in small plots in papers.
set style line 1 lt 1
set style line 2 lt 1
set style line 3 lt 1
set style line 4 lt 1
set style line 5 lt 1
set style line 1 lt rgb "#A00000" lw 1 pt 7
set style line 2 lt rgb "#00A000" lw 1 pt 9
set style line 3 lt rgb "#5060D0" lw 1 pt 5
set style line 4 lt rgb "#F25900" lw 1 pt 13
set style line 5 lt rgb "#000000" lw 1 pt 7

set style line 6 lt rgb "#A00000" lw 1 pt 7
set style line 7 lt rgb "#00A000" lw 1 pt 9
set style line 8 lt rgb "#5060D0" lw 1 pt 5
set style line 9 lt rgb "#F25900" lw 1 pt 13
set style line 10 lt rgb "#000000" lw 1 pt 7


