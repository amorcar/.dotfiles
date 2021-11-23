function fish_greeting
  # echo (set_color white)(whoami)
end
function fish_greeting_bak
  set color1 5E81AC
  set color2 81A1C1
  set color3 88C0D0
  set color4 8FBCBB

  set first_line (set_color blue)(whoami)@(hostname)
  set second_line (set_color yellow)Uptime': '(set_color white)(uptime | sed 's/.*up \([^,]*\), .*/\1/')(set_color blue)
  set brew_cellar_pckgs (ls (brew --cellar) | wc -l)
  set brew_cask_pckgs (ls (brew --caskroom) | wc -l)
  set brew_pkgs (math $brew_cask_pckgs + $brew_cellar_pckgs)
  set third_line (set_color blue)Packages': '(set_color white)$brew_pkgs

  set fourth_line (set_color yellow)Version': '(set_color white)(echo $FISH_VERSION)
  set fifth_line 'Hi :)'


    echo '                 '(set_color $color1)'___
  ___======____='(set_color $color2)'-'(set_color $color1)'-'(set_color $color2)'-='(set_color $color3)')
/T            \_'(set_color $color1)'--='(set_color $color2)'=='(set_color $color3)')    '$first_line'
[ \ '(set_color $color2)'('(set_color $color1)'0'(set_color $color2)')   '(set_color $color3)'\~    \_'(set_color $color1)'-='(set_color $color2)'='(set_color $color3)')    '$second_line'
 \      / )J'(set_color $color2)'~~    \\'(set_color $color1)'-='(set_color $color3)')    '$third_line(set_color blue)'
  \\\\___/  )JJ'(set_color $color2)'~'(set_color $color1)'~~   '(set_color $color3)'\)     '$fourth_line(set_color blue)'
   \_____/JJJ'(set_color $color2)'~~'(set_color $color1)'~~    '(set_color $color3)'\\    '$fifth_line(set_color blue)'
   '(set_color $color2)'/ '(set_color $color1)'\  '(set_color $color1)', \\'(set_color $color3)'J'(set_color $color2)'~~~'(set_color $color1)'~~     '(set_color $color2)'\\
  (-'(set_color $color1)'\)'(set_color $color3)'\='(set_color $color2)'|'(set_color $color1)'\\\\\\'(set_color $color2)'~~'(set_color $color1)'~~       '(set_color $color2)'L_'(set_color $color1)'_
  '(set_color $color2)'('(set_color $color3)'\\'(set_color $color2)'\\)  ('(set_color $color1)'\\'(set_color $color2)'\\\)'(set_color $color3)'_           '(set_color $color1)'\=='(set_color $color2)'__
   '(set_color $color3)'\V    '(set_color $color2)'\\\\'(set_color $color3)'\) =='(set_color $color2)'=_____   '(set_color $color1)'\\\\\\\\'(set_color $color2)'\\\\
          '(set_color $color3)'\V)     \_) '(set_color $color2)'\\\\'(set_color $color1)'\\\\JJ\\'(set_color $color2)'J\)
                      '(set_color $color3)'/'(set_color $color2)'J'(set_color $color1)'\\'(set_color $color2)'J'(set_color $color3)'T\\'(set_color $color2)'JJJ'(set_color $color3)'J)
                      (J'(set_color $color2)'JJ'(set_color $color3)'| \UUU)
                       (UU)'(set_color normal)
end

