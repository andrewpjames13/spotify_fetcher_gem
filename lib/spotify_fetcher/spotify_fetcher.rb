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

  # Album

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

  def album_artwork(album_id)
    response = @spotify_data.get "/v1/albums/#{album_id}"
    JSON.parse(response.body)["images"][0]["url"]
  end

  # Artist

  def artist(artist_id)
   response = @spotify_data.get "/v1/artists/#{artist_id}"
   JSON.parse(response.body)
  end

  def artist_name(artist_id)
   response = @spotify_data.get "/v1/artists/#{artist_id}"
   JSON.parse(response.body)["name"]
  end

  def artist_genres(artist_id)
   response = @spotify_data.get "/v1/artists/#{artist_id}"
   JSON.parse(response.body)["genres"]
  end

  def artist_popularity(artist_id)
   response = @spotify_data.get "/v1/artists/#{artist_id}"
   JSON.parse(response.body)["popularity"]
  end

  def artist_related(artist_id)
   response = @spotify_data.get "/v1/artists/#{artist_id}/related-artists"
   JSON.parse(response.body)
 end

 def artist_related_names(artist_id)
   response = @spotify_data.get "/v1/artists/#{artist_id}/related-artists"
   artist = JSON.parse(response.body)["artists"]
   artist.map {|artist| artist["name"]}
 end
 
end
