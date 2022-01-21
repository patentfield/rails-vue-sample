class PagesController < ApplicationController
  def home
  end

  def search
    uri = URI.parse("https://ped.uspto.gov/api/queries")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    headers = { "Content-Type" => "application/json" }

    q = "microsoft"
    ped_params = {
      "qf":"firstNamedApplicant",
      "searchText":"firstNamedApplicant:(#{q})",
      "fl":"applId appFilingDate patentTitle firstNamedApplicant",
      "mm":"100%",
      "df":"patentTitle",
      "facet":"false"
    }
    ped_response = http.post(uri.path, ped_params.to_json, headers)
    result = JSON.parse(ped_response.body)
    render json: result["queryResults"]["searchResponse"]["response"]
  end
end
