#/usr/bin/perl -w

  my %results;

  while(<STDIN>)
  {
    next if $_ !~ /[a-z]/;
    next if $_ =~ /First song choice/;

    #print "$_";
    $_	=~ s/""/"/g;

    my @fields	= split /","/, $_;

#    print "$fields[2]\n";	# 1st
#    print "$fields[3]\n";	# 2nd
#    print "$fields[4]\n";	# 3rd

    if(!defined $results{$fields[2]})
    {
      $results{$fields[2]}{1}	= 0;	# 1st
      $results{$fields[2]}{2}	= 0;	# 2nd
      $results{$fields[2]}{3}	= 0;	# 3rd
      $results{$fields[2]}{p}	= 0;	# points
    }
    if(!defined $results{$fields[3]})
    {
      $results{$fields[3]}{1}	= 0;	# 1st
      $results{$fields[3]}{2}	= 0;	# 2nd
      $results{$fields[3]}{3}	= 0;	# 3rd
      $results{$fields[3]}{p}	= 0;	# points
    }
    if(!defined $results{$fields[4]})
    {
      $results{$fields[4]}{1}	= 0;	# 1st
      $results{$fields[4]}{2}	= 0;	# 2nd
      $results{$fields[4]}{3}	= 0;	# 3rd
      $results{$fields[4]}{p}	= 0;	# points
    }

    $results{$fields[2]}{1}	+= 1;
    $results{$fields[2]}{p}	+= 3;
    $results{$fields[3]}{2}	+= 1;
    $results{$fields[3]}{p}	+= 2;
    $results{$fields[4]}{3}	+= 1;
    $results{$fields[4]}{p}	+= 1;
  }

  print "Points\t1st\t2nd\t3rd\tSong\n";

  my @songs	= sort { $results{$b}{1} <=> $results{$a}{1} } keys %results;
  @songs	= sort { $results{$b}{p} <=> $results{$a}{p} } @songs;

  foreach my $song (@songs)
  {
    my $r = $results{$song};
    printf "%d\t%d\t%d\t%d\t%s\n",
      $r->{p}
    , $r->{1}#" || ""
    , $r->{2}#" || ""
    , $r->{3}#" || ""
    , $song;
  }

