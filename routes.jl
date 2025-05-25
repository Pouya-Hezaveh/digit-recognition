using Genie.Router, Genie.Renderer.Html, Genie.Requests, Base64
include("src/Sense.jl")

function f(x)
  println("Done!")
end

route("/") do
  serve_static_file("index.html")
end

route("/see", method=POST) do
  img = base64decode(postpayload(:drawing))

  #println(postpayload(:drawing))
  #println(base64decode(postpayload(:drawing)))
  
  if img != Nothing
    # Calling digit recognition function
    predicted_digit = Sense.seeDigit(img);
    return "{\"msg\": \"$predicted_digit\"}"
  else
    return "{\"msg\": \"*** No image under drawing key uploaded.\"}"
  end
end
