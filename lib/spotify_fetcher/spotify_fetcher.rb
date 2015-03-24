require 'pry-byebug'
require 'faraday'
require 'json'


class SpotifyFetcher

  def initialize
    @spotify_data = Faraday.new(:url => 'https://api.spotify.com') do |faraday|
    faraday.request  :url_encoded             # form-encode POST params
    faraday.response :logger                  # log requests to STDOUT
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def album(album_id)
    response = @spotify_data.get "/v1/albums/#{album_id}"
    JSON.parse(response.body)
  end

  def album_artist(album_id)
    response = @spotify_data.get "/v1/albums/#{album_id}"
    JSON.parse(response.body)["artists"][0]["name"]
  end

  def album_tracks(album_id)
    response = @spotify_data.get "/v1/albums/#{album_id}"
    items = JSON.parse(response.body)["tracks"]["items"]
    items.map {|item| item["name"] }
   end

end
