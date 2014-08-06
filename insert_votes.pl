#/usr/bin/perl -w

# who voted for what

  my $playlistID	= $ARGV[0];

  if(!$playlistID || ($playlistID + 0) != $playlistID)
  {
    print "perl insert_votes.pl [playlistID] < votesFile.csv\n";
    exit(1);
  }

  my %votes;

  while(<STDIN>)
  {
    next if $_ !~ /[a-z]/;
    next if $_ =~ /First song choice/;

    #print "$_";
    $_	=~ s/""/"/g;

    my @fields	= split /","/, $_;

    $fields[1]	=~ /(.+)\@.+/;
    my $voter	= $1;

    foreach my $song ($fields[2], $fields[3], $fields[4])
    {
#print "$song\n";
      my ($artist, $title)	= split / - /, $song;
      $artist	=~ s/'/''/g;
      $title	=~ s/"//g;
      $title	=~ s/'/''/g;

      if($song eq $fields[2])
      {
        $votes{$voter}{artist1}	= $artist;
        $votes{$voter}{title1}	= $title;

      } elsif($song eq $fields[3]) {
        $votes{$voter}{artist2}	= $artist;
        $votes{$voter}{title2}	= $title;

      } elsif($song eq $fields[4]) {
        $votes{$voter}{artist3}	= $artist;
        $votes{$voter}{title3}	= $title;
      }
    }
  }

  foreach my $v (keys %votes)
  {
    printf "EXEC Spotify.spInsertVote %d, '%s', '%s', '%s', '%s', '%s', '%s', '%s'\n",
      $playlistID, $v,
      $votes{$v}{artist1}, $votes{$v}{title1},
      $votes{$v}{artist2}, $votes{$v}{title2},
      $votes{$v}{artist3}, $votes{$v}{title3};
  }
