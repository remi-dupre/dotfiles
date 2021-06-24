# Defined via `source`
function pc --wraps='python -c "from math import * ; from fractions import Fraction ; print($argv)"' --description 'alias pc python -c "from math import * ; from fractions import Fraction ; print($argv)"'
  python -c "from math import * ; from fractions import Fraction ; print($argv)" $argv; 
end
