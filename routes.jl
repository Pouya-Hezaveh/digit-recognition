using Genie.Router, Genie.Renderer.Html, Genie.Requests

function f(x)
  println("Done!")
end

route("/") do
  serve_static_file("index.html")
end

route("/see", method=POST) do
  println(postpayload(:drawing))
  if postpayload(:drawing) != Nothing
    # Call your digit recognition model here
    predicted_digit = 5
    return "{\"msg\": \"$predicted_digit\"}"
  else
    return "{\"msg\": \"*** No image under drawing key uploaded.\"}"
  end
end
