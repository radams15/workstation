use Exporter /import/;

our @EXPORT_OK = qw/ comment_line comment_block /;

my %comments = (
    py => ['#', ''],
    pl => ['#', ''],
    cgi => ['#', ''],
    c => ['//', ''],
    cpp => ['//', ''],
    Makefile => ['#', ''],
    sh => ['#', ''],
);

my ($comment_start, $comment_end) = &comment_chars($curbuf->Name);

## Internal Functions ##

=pod
=head1 comment_chars
Internal function to find the correct characters to comment
the current file.
Dies if filetype not defined.
Internal function to comment characters on a line.
=cut
sub comment_chars {
    my ($file_name) = @_;

    (my $ext = lc $file_name) =~ s/.*\.//g;

    if(grep {$ext} keys %comments) {
        return @{$comments{$ext}};
    }

    die "Cannot find comment character for filetype: '$ext'\n";
}

=pod
=head1 comment_row
Internal function to comment characters on a line.
=cut
sub comment_row {
    my ($row) = @_;

    my $line = $curbuf->Get($row);

    my $commented = $line;
    if($line =~ /(\s*)\Q$comment_start\E (.*) \Q$comment_end\E/) {
        $commented = $1.$2;
    } else {
        $commented =~ s/(\s*)(.*)/$1$comment_start $2 $comment_end/;
    }

    $curbuf->Set($row, $commented);
}


## Exposed Functions ##

sub comment_line {
    my ($row, $col) = $curwin->Cursor;

    &comment_row($row);
}

sub comment_block {
    my ($comment_start, $comment_end) = &comment_chars($curbuf->Name);
    my ($row, $col) = $curwin->Cursor;

    my (undef, $row_start, $col_start, undef) = split /\s/, (VIM::Eval('getpos("\'<")'))[1];
    my (undef, $row_end, $col_end, undef) = split /\s/, (VIM::Eval('getpos("\'>")'))[1];

    for ($row_start .. $row_end) {
        &comment_row($_);
    }
}

1;
