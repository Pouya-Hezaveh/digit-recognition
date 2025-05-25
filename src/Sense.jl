module Sense
include("Brain.jl")


function seeDigit(drawing)
    rgb_matrix = decodeJPEG(drawing)
    return Brain.detectNumber(rgb_matrix)
end

function decodeJPEG(img)
	
end



end