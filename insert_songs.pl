#/usr/bin/perl -w

# this is really "insert songs that got votes," not all songs.  need another list for that.

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

    printf "IF NOT EXISTS (SELECT 1 FROM Spotify.Song WHERE Artist = '%s' AND Title = '%s') INSERT INTO Spotify.Song (Artist, Title) VALUES ('%s', '%s')\n",
      , $songs{$song}{artist}, $songs{$song}{title}, $songs{$song}{artist}, $songs{$song}{title}
  }
