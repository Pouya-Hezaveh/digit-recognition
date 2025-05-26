module Sense
include("Brain.jl")

# This function returns the grayscale for a RGB pixel
function toGrayscale(R, G, B)
	# This formula is based on the average person's relative perception of brightness.
	return 0.299R + 0.587G + 0.114B
end

# Gets a RGB matrix as an input, and returns a Grayscale matrix
function convertRGBtoGrayscale(rgb_matrix)
	gray_matrix = []

	for i in rgb_matrix
		push!(gray_matrix, [])
		for j in i
			push!(last(gray_matrix), toGrayscale(j[1], j[2], j[3]))
		end
	end

	return gray_matrix
end

function decodeJPEG(img)
	#! Don't forget to develop this function
	return [[[200,200,200]]]
end

function doPreprocess(image)
	rgb_matrix = decodeJPEG(image)
	return convertRGBtoGrayscale(rgb_matrix)
end

function seeDigit(image)
	image = doPreprocess(image)
	return Brain.detectNumber(image)
end



end