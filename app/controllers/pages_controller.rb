class PagesController < ApplicationController
  def home
  end

  def search
    uri = URI.parse("https://ped.uspto.gov/api/queries")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === "https"
    headers = { "Content-Type" => "application/json" }

    responses = []
    x = []
    y = []
    search_word = params[:q]
    search_word.split(" OR ").each do |q|
      ped_params = {
        # "fq":["firstNamedApplicant:\"#{q}\""],
        "fq":["appFilingDate:[2014-01-01T00:00:00Z TO 2014-12-31T23:59:59Z]",
        "appStatus:\"Patented Case\""],
        # "searchText":"*:*",
        "searchText":"firstNamedApplicant:(#{q})",
        "fl":"applId appFilingDate patentTitle firstNamedApplicant",
        "mm":"100%",
        "df":"patentTitle",
        "facet":"false"
      }
      ped_response = http.post(uri.path, ped_params.to_json, headers)
      result = JSON.parse(ped_response.body)
      response = result["queryResults"]["searchResponse"]["response"]
      responses.push(response)
      x.push(q)
      y.push(response["numFound"])
    end
    search_histories = []
    if user_signed_in?
      SearchHistory.create({
        user_id: current_user.id,
        search_word: search_word
      })
      search_histories = SearchHistory.where(user_id: current_user.id).order(id: :desc)
    end
    trace = {
      "x" => x,
      "y" => y
    }
    results = {
      "responses" => responses,
      "histories" => search_histories,
      "trace" => trace
    }
    render json: results
  end

  def index
    search_histories = []
    if user_signed_in?
      search_histories = SearchHistory.where(user_id: current_user.id).order(id: :desc)
    end
    results = {
      "histories" => search_histories
    }
    render json: results
  end

  def destroy
    destroy_id = params[:q]
    search_histories = []
    if user_signed_in?
      SearchHistory.find(destroy_id).destroy!
      search_histories = SearchHistory.where(user_id: current_user.id).order(id: :desc)
    end
    results = {
      "histories" => search_histories
    }
    render json: results
  end
end
