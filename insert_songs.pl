#/usr/bin/perl -w

# this is really "insert songs that got votes," not all songs.  need another source for that (vote page?)

  my $playlistID	= $ARGV[0];

  if(!defined $playlistID || ($playlistID + 0) != $playlistID)
  {
    print "perl insert_songs.pl [playlistID] < votesFile.csv\n";
    exit(1);
  }

  my %songs;

  while(<STDIN>)
  {
    next if $_ !~ /[a-z]/;
    next if $_ =~ /First song choice/;

    #print "$_";
    $_	=~ s/""/"/g;

    my @fields	= split /","/, $_;

    foreach my $song ($fields[2], $fields[3], $fields[4])
    {
#print "$song\n";
      my ($artist, $title)	= split / - /, $song;
      $artist	=~ s/'/''/g;
      $songs{$song}{artist}	= $artist;
      $title	=~ s/"//g;
      $title	=~ s/'/''/g;
      $songs{$song}{title}	= $title;
    }
  }

  foreach my $song (keys %songs)
  {
#    print "$song : $songs{$song}{artist} : $songs{$song}{title}\n";


#    printf "EXEC Spotify.spInsertSong '%s', '%s'\n",	# spInsertPlaylistSong calls this now
#      , $songs{$song}{artist}, $songs{$song}{title};
    printf "EXEC Spotify.spInsertPlaylistSong %d, '%s', '%s', 1\n",
      , $playlistID, $songs{$song}{artist}, $songs{$song}{title};
  }
