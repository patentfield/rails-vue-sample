require "open-uri"

module WebpackBundleHelper
  class BundleNotFound < StandardError; end

  def javascript_bundle_tag(entry, **options)
    path = asset_bundle_path("#{entry}.js")

    options = {
      src: path,
      defer: false,
    }.merge(options)

    options.delete(:defer) if options[:async]

    javascript_include_tag "", **options
  end

  def stylesheet_bundle_tag(entry, **options)
    path = asset_bundle_path("#{entry}.css")

    options = {
      href: path,
    }.merge(options)

    stylesheet_link_tag "", **options
  end

  private

  def asset_server
    port = Rails.env === "development" ? "3035" : "3000"
    "#{request.protocol}#{request.host}:#{port}"
  end

  def pro_manifest
    File.read("public/assets/manifest.json")
  end

  def dev_manifest
    OpenURI.open_uri("#{asset_server}/public/assets/manifest.json").read
  end

  def test_manifest
    File.read("public/assets-test/manifest.json")
  end

  def manifest
    return @manifest ||= JSON.parse(pro_manifest) if Rails.env.production? || Rails.env.staging?
    return @manifest ||= JSON.parse(dev_manifest) if Rails.env.development?
    return @manifest ||= JSON.parse(test_manifest)
  end

  def valid_entry?(entry)
    return true if manifest.key?(entry)
    raise BundleNotFound, "Could not find bundle with name #{entry}"
  end

  def asset_bundle_path(entry, **options)
    valid_entry?(entry)
    if Rails.env.development?
      asset_path("#{asset_server}/public/assets/" + manifest.fetch(entry), **options)
    elsif Rails.env.test?
      asset_path("/assets-test/" + manifest.fetch(entry), **options)
    else
      asset_path("/assets/" + manifest.fetch(entry), **options)
    end
  end
end
