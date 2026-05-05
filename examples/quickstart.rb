require "pixelapi"

client = PixelAPI::Client.new(ENV["PIXELAPI_KEY"])

# Generate AI image
r = client.generate("product photo of red sneakers, white background, studio lighting")
puts "generated: #{r["output_url"]} (used #{r["credits_used"]} credits)"
client.save(r, "out/sneakers.png")

# Remove background
r = client.remove_background("https://pixelapi.dev/demo/photo.jpg")
puts "bg-removed: #{r["output_url"]} (used #{r["credits_used"]} credits)"
