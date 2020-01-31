package SMM::Mailer::Template;

use utf8;
use Moose;
use Template::Tiny;

use namespace::autoclean;
use MIME::Lite;
use DateTime;
use Encode;

has content => ( is => 'ro' );
has to      => ( is => 'ro' );
has title   => ( is => 'ro' );
has cc      => ( is => 'ro', isa => 'ArrayRef', default => sub { [] } );
has subject => ( is => 'ro' );
has from    => ( is => 'ro' );

my %assets = ( 'logo.png' => 'image/png', );

sub build_email {
    my ( $self, $fixed_to ) = @_;

    my ( $user, $to );
    if ( ref $self->to && $self->to->can('_build_email') ) {
        $user = $self->to;
        $to   = $user->email;
    }
    else {
        die "cant call _build_email on to\n";
    }
    $to = $fixed_to if $fixed_to;

    my $email = MIME::Lite->new(
        To      => Encode::encode( 'MIME-Header', $to ),
        Subject => Encode::encode( 'MIME-Header', $self->subject ),
        Type    => q{multipart/related},
        From    => $self->from
    );

    return $user->_build_email( $email, $self->title, $self->content );

}

sub build_email_without_user {
    my ( $self, $fixed_to ) = @_;

    my ( $user, $to );
    if ( $self->to ) {
        $to = $self->to;
    }
    else {
        die "cant find email on to\n";
    }

    $to = $fixed_to if $fixed_to;

    my $email = MIME::Lite->new(
        To      => Encode::encode( 'MIME-Header', $to ),
        Subject => Encode::encode( 'MIME-Header', $self->subject ),
        Type    => q{multipart/related},
        From    => $self->from
    );

    return {
        email   => $email,
        title   => $self->title,
        content => $self->content
    };

}

sub build_many_emails {
    my ( $self, $fixed_to ) = @_;

    my ( $user, $to );
    if ( ref $self->to && $self->to->can('_build_many_emails') ) {
        $user = $self->to;
        $to   = $user->email;
    }
    else {
        die "cant call _build_email on to\n";
    }
    $to = $fixed_to if $fixed_to;

    my $email = MIME::Lite->new(
        To      => Encode::encode( 'MIME-Header', $to ),
        Subject => Encode::encode( 'MIME-Header', $self->subject ),
        Type    => q{text},
        Data    => q{  },
        From    => $self->from
    );

    return $user->_build_many_emails( $email, $self->title, $self->content );

}

1;
