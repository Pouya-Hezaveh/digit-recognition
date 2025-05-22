using Genie.Router, Genie.Renderer.Html, Genie.Requests
include("src/Brain.jl")

function f(x)
  println("Done!")
end

route("/") do
  serve_static_file("index.html")
end

route("/see", method=POST) do
  img = postpayload(:drawing)
  if img != Nothing
    # Calling digit recognition function
    println(img[1])
    predicted_digit = Brain.detectNumber(img);
    #predicted_digit = Brain.detectNumber(img)
    return "{\"msg\": \"$predicted_digit\"}"
  else
    return "{\"msg\": \"*** No image under drawing key uploaded.\"}"
  end
end
