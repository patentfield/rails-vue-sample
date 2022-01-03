require "rack/proxy"

class AssetsPathProxy < Rack::Proxy
  include ActionView::Helpers::AssetUrlHelper
  def perform_request(env)
    request = Rack::Request.new(env)
    if request.path =~ /hot-update\.(js|json)/
      if Rails.env.development?
        dev_server = env["HTTP_HOST"].gsub(":3000", ":3035")
        env["HTTP_HOST"] = dev_server
        env["HTTP_X_FORWARDED_HOST"] = dev_server
        env["HTTP_X_FORWARDED_SERVER"] = dev_server
        env["PATH_INFO"] = "/public/assets/" + env["PATH_INFO"].split("/").last
      end
      super
    elsif env["PATH_INFO"].include?("/images/") && !request.path.end_with?(*[".php", ".pl", ".zip", ".rar", ".asp", "admin1", "sysadmins", "src_images_but_dianz_s.png"])
      if Rails.env.development?
        dev_server = env["HTTP_HOST"].gsub(":3000", ":3035")
        env["HTTP_HOST"] = dev_server
        env["HTTP_X_FORWARDED_HOST"] = dev_server
        env["HTTP_X_FORWARDED_SERVER"] = dev_server
      end
      if Rails.env.development?
        env["PATH_INFO"] = "/public/assets/images/" + env["PATH_INFO"].split("/").last
      elsif Rails.env.test?
        env["PATH_INFO"] = asset_path("/assets-test/images/" + env["PATH_INFO"].split("/").last)
      end
      super
    else
      @app.call(env)
    end
  end
end
