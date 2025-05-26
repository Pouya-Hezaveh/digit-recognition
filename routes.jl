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

  test_case =  [
    [[101,100,100],[102,100,100]],
    [[103,100,100],[104,100,100]],
    [[105,100,100],[106,100,100]],
    [[107,100,100],[108,100,100]]
    ]
  println(Sense.convertRGBtoGrayscale(test_case))

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
