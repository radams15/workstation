# use Exporter /import/; 
# our @EXPORT_OK = qw/ comment_line comment_block /; 

my %comments = (
    python => ['#', ''],
    perl => ['#', ''],
    cgi => ['#', ''],
    c => ['//', ''],
    cpp => ['//', ''],
    java => ['//', ''],
    Makefile => ['#', ''],
    sh => ['#', ''],
    dockerfile => ['#', ''],
    yaml => ['#', ''],
    asm => [';', ''],
    html => ['<!--', '-->'],
    vimrc => ['"', ''],
);

my %themes = (
    light => 'gruvbox',
    dark => 'gruvbox'
);

my ($comment_start, $comment_end);

## Internal Functions ##

=pod
=head1 comment_chars
Internal function to find the correct characters to comment
the current file.
Dies if filetype not defined.
=cut
sub comment_chars {
    my ($file_name) = @_;

    my (undef, $filetype) = VIM::Eval('&filetype');

    if(grep {$filetype} keys %comments) {
        return @{$comments{$filetype}};
    }

    (my $ext = lc $file_name) =~ s/.*\.//g;
    if(grep {$ext} keys %comments) {
        return @{$comments{$ext}};
    }

    return (undef, undef);
}

=pod
=head1 comment_row
Internal function to comment characters on a line.
=cut
sub comment_row {
    my ($row) = @_;

    unless ($comment_start or $comment_end) {
        ($comment_start, $comment_end) = &comment_chars($curbuf->Name);
        
        unless ($comment_start or $comment_end) {
            VIM::Msg("Cannot find comment character for filetype: '$ext'");
            return;
        }
    }

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
    my ($row, $col) = $curwin->Cursor;

    unless ($comment_start or $comment_end) {
        ($comment_start, $comment_end) = &comment_chars($curbuf->Name);
        
        unless ($comment_start or $comment_end) {
            VIM::Msg("Cannot find comment character for filetype: '$ext'");
            return;
        }
    }
    
    my (undef, $row_start, $col_start, undef) = split /\s/, (VIM::Eval('getpos("\'<")'))[1];
    my (undef, $row_end, $col_end, undef) = split /\s/, (VIM::Eval('getpos("\'>")'))[1];

    for ($row_start .. $row_end) {
        &comment_row($_);
    }
}

sub set_theme {
    my $cmdout = `env LD_LIBRARY_PATH= dbus-send --session --dest=org.gnome.SettingsDaemon.Color --print-reply /org/gnome/SettingsDaemon/Color org.freedesktop.DBus.Properties.Get string:'org.gnome.SettingsDaemon.Color' string:'NightLightActive'`;

    my $theme;
    my $bg;

    if($cmdout =~ /boolean true/g) {
        $theme = $themes{dark};
        $bg = 'dark';
    } else {
        $theme = $themes{light};
        $bg = 'light';
    }

    VIM::DoCommand("color $theme");
    VIM::DoCommand("set bg=$bg");
}

1;
