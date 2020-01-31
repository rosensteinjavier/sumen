package WebSMM::Controller::Register::Counsil;
use Moose;
use utf8;
use DateTime;
use JSON::XS;
use DateTime::Format::Pg;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/register/base') : PathPart('cadastro') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->response->headers->header( 'charset' => 'utf-8' );
    $c->stash->{template_wrapper} = 'func';
}

sub register : Chained('base') : PathPart('conselho') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    if ( $c->user ) {
        $c->detach( 'Form::Login' => 'after_login' );
    }

    if ( $c->req->params->{key} ) {

        $api->stash_result(
            $c,
            'invite_counsil/key_check',
            method => 'POST',
            params => {
                email => $c->req->params->{email},
                hash  => $c->req->params->{key},
            }
        );
        if ( $c->stash->{error} ) {
            $c->detach( '/form/redirect_ok',
                [ \'/login', {}, 'A chave informada está expirada.' ] );
        }

    }
    if ( $c->req->params->{pre_id} ) {
        $api->stash_result(
            $c,
            [ 'pre_registrations', $c->req->params->{pre_id} ],
            stash => 'pre_registrations'
        );
    }

    if ( exists( $c->stash->{form_error}{birth_date} ) ) {
        my $now = DateTime->now;

        my $body = { %{ $c->stash->{body} } };

        my $form = $c->model('Form');

        $form->format_date( $body, 'birth_date' );

#TODO  limpar a string com uma regex retirando os caracteres que vem com a mascara de data
        if ( $body->{birth_date} != '--' ) {
            my $dt =
              DateTime::Format::Pg->parse_datetime( $body->{birth_date} );

            my $interval = $now->subtract_datetime($dt);

            if ( $interval->years < 18 ) {
                $c->stash->{too_young} = 1;
            }
        }
    }

    $c->stash->{template} = 'auto/register_counsil.tt';
}

__PACKAGE__->meta->make_immutable;

1;
