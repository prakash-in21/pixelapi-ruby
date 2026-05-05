Gem::Specification.new do |s|
  s.name        = "pixelapi"
  s.version     = "1.0.0"
  s.summary     = "Official Ruby SDK for PixelAPI — AI image, video, audio, 3D API"
  s.description = "Ruby client for PixelAPI: image generation, background removal, upscaling, face restoration, audio, voice, 3D, more. From $0.001/image. 100 free credits."
  s.authors     = ["PixelAPI"]
  s.email       = "support@pixelapi.dev"
  s.files       = ["lib/pixelapi.rb"]
  s.require_paths = ["lib"]
  s.homepage    = "https://pixelapi.dev"
  s.license     = "MIT"
  s.required_ruby_version = ">= 2.6"
  s.metadata = {
    "documentation_uri" => "https://pixelapi.dev/docs",
    "source_code_uri" => "https://github.com/prakash-in21/pixelapi-ruby",
    "bug_tracker_uri" => "https://github.com/prakash-in21/pixelapi-ruby/issues"
  }
end
