class MusicLibraryController

  def initialize(path = "./db/mp3s")
    music_import = MusicImporter.new(path)
    music_import.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = ""
    while input != "exit"
      input = gets.strip
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    Song.all.sort_by { |song| song.name }.each.with_index(1) do |song, i|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by { |artist| artist.name }.each.with_index(1) do |artist, i|
      puts "#{i}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by { |genre| genre.name }.each.with_index(1) do |genre, i|
      puts "#{i}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.find_by_name(input).class == Artist

      songs = Song.all.select { |song| song.artist.name == input }
      songs.sort_by { |song| song.name }.each.with_index(1) do |song, i|
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end

    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if Genre.find_by_name(input).class == Genre

      songs = Song.all.select { |song| song.genre.name == input }
      songs.sort_by { |song| song.name }.each.with_index(1) do |song, i|
        puts "#{i}. #{song.artist.name} - #{song.name}"
      end

    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i - 1
    if input >= 1 and input < Song.all.size
      song = Song.all.sort_by { |song| song.name }[input]
      artist = song.artist.name
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

end
