require "net/http"
require "uri"
require "json"
require "fileutils"

module PixelAPI
  class Error < StandardError; end
  class AuthError < Error; end
  class CreditsError < Error; end
  class RateLimitError < Error; end

  class Client
    BASE_URL = "https://api.pixelapi.dev"

    def initialize(api_key, base_url: BASE_URL, timeout: 120)
      @api_key = api_key
      @base_url = base_url
      @timeout = timeout
    end

    def generate(prompt)
      post("/v1/image/generate", prompt: prompt)
    end

    def remove_background(image_url)
      post("/v1/image/remove-background", image_url: image_url)
    end

    def upscale(image_url, scale: 4)
      post("/v1/image/upscale", image_url: image_url, scale: scale)
    end

    def face_restore(image_url)
      post("/v1/image/face-restore", image_url: image_url)
    end

    def save(result, path)
      raise Error, "no output_url" unless result["output_url"]
      uri = URI.parse(result["output_url"])
      data = Net::HTTP.get(uri)
      FileUtils.mkdir_p(File.dirname(path))
      File.binwrite(path, data)
    end

    private

    def post(endpoint, params)
      uri = URI.parse(@base_url + endpoint)
      req = Net::HTTP::Post.new(uri)
      req["X-API-Key"] = @api_key
      req.set_form_data(params)
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https", read_timeout: @timeout) { |http| http.request(req) }
      case res.code.to_i
      when 401 then raise AuthError, "invalid API key"
      when 402 then raise CreditsError, "insufficient credits"
      when 429 then raise RateLimitError, "rate limit exceeded"
      when 400..599 then raise Error, "PixelAPI error #{res.code}: #{res.body}"
      end
      JSON.parse(res.body)
    end
  end
end
