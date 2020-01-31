package CatalystX::Plugin::Lexicon;

use Moose;
with 'MooseX::Emulate::Class::Accessor::Fast';
use MRO::Compat;
use Catalyst::Exception ();
use Data::Dumper;

use overload ();
use Carp;

use namespace::clean -except => 'meta';

our $VERSION = '0.35';
$VERSION = eval $VERSION;

my $resultset;
my $cache;
my $current_lang;

my $cache_lang_prefix = '/tmp/cache.lang.';

sub setup {
    my $c = shift;

    $c->maybe::next::method(@_);

    return $c;
}

sub initialize_after_setup {
    my ( $self, $c ) = @_;

    $c->setup_lexicon_plugin($c);
}

sub setup_lexicon_plugin {
    my ( $self, $c ) = @_;

    my $db = $c->model('DB');
    $resultset = $db->resultset('Lexicon');
    $c->config->{default_lang} ||= 'pt-br';
    $c->config->{forced_langs} ||= 'pt-br';

    $current_lang = $c->config->{default_lang};

}

sub lexicon_reload_all {
    unlink glob("$cache_lang_prefix*");
}

sub lexicon_reload_self {

    my $rs = $resultset->search( undef,
        { result_class => 'DBIx::Class::ResultClass::HashRefInflator' } );

    $cache = {};
    while ( my $r = $rs->next ) {
        $cache->{ $r->{lang} }{ $r->{lex_key} } = $r->{lex_value};
    }

    my $cache_lang_file = "$cache_lang_prefix$$";
    open my $FG, '>', $cache_lang_file;
    print $FG '1';
    close $FG;
}

sub loc {
    my ( $c, $text, $origin_lang, @conf ) = @_;

    return $text if ( !defined $text || $text eq '' );

    $text =~ s/^\s+//;
    $text =~ s/\s+$//;

    my $default = $c->config->{default_lang};

    $origin_lang = $origin_lang ? $origin_lang : $default;

    my $cache_lang_file = "$cache_lang_prefix$$";
    unless ( -e $cache_lang_file ) {
        &lexicon_reload_self;
    }

    if ( exists $cache->{$current_lang}{$text} ) {
        return $cache->{$current_lang}{$text};
    }
    else {

        my @add_langs = split /,/, $c->config->{forced_langs};

        foreach my $lang (@add_langs) {
            my $str = $lang eq $origin_lang ? $text : "? $text";
            $cache->{$lang}{$text} = $str;

            my $exists = $resultset->search(
                {
                    lex     => '*',
                    lang    => $lang,
                    lex_key => $text,
                }
            )->count;

            if ( $exists == 0 ) {
                eval {
                    $resultset->create(
                        {
                            lex         => '*',
                            lang        => $lang,
                            lex_key     => $text,
                            lex_value   => $str,
                            origin_lang => $origin_lang
                        }
                    );
                };
            }
        }
        return $current_lang eq $origin_lang ? $text : "? $text";
    }

}

sub set_lang {
    my ( $c, $lang ) = @_;
    $current_lang = $lang;
}

sub get_lang {
    my ($c) = @_;
    return $current_lang;
}

__PACKAGE__;

__END__

# use $c->logx('your message', ? {indicator_id => 123}) anywhere you want.
