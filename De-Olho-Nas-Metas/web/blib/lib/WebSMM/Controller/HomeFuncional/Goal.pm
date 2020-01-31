package WebSMM::Controller::HomeFuncional::Goal;
use Moose;
use namespace::autoclean;
use utf8;
use List::MoreUtils qw/uniq/;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Goal - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('goal') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, [ 'goals', $id ], stash => 'goal_obj' );
    $c->stash->{goal_obj}->{goal_porcentages}->{owned} =
      int( $c->stash->{goal_obj}->{goal_porcentages}->{owned} );
    $c->stash->{goal_obj}->{goal_porcentages}->{remainder} =
      int( $c->stash->{goal_obj}->{goal_porcentages}->{remainder} );

    if ( $c->user ) {
        $api->stash_result(
            $c,
            [ 'users', $c->user->obj->id ],
            stash => 'user_obj',
        );
        $c->stash->{user_obj}->{role} =
          { map { $_ => 1 } @{ $c->stash->{user_obj}->{roles} } };

        $c->stash->{do_i_follow} =
          grep { $_ eq $id } @{ $c->stash->{user_obj}->{projects_i_follow} };
    }

}

sub detail : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, 'objectives' );
    $api->stash_result( $c, 'regions' );

    my $count = 0;
    for my $n ( 1 .. 6 ) {
        $count++ if $c->stash->{goal_obj}->{ 'qualitative_progress_' . $n };
    }
    $c->stash->{goal_obj}->{progress_count} = $count;
    my @empresas;
    my %uniqs = map {
        $_->{business_name} =>
          { name => $_->{business_name}, url => $_->{business_name_url} }
    } @{ $c->stash->{goal_obj}->{budgets} };

    $c->stash->{business_names} =
      [ sort { $a->{name} cmp $b->{name} } values %uniqs ];
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'objectives' );
    $api->stash_result( $c, 'regions' );
    $api->stash_result( $c, 'goals' );
}

sub type : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    my $type_id = $c->req->param('type_id');
    my $api     = $c->model('API');

    my $res = $api->stash_result(
        $c, 'goals',
        params => {
            type_id => $type_id
        }
    );
    $c->stash->{without_wrapper} = 1;
}

sub region_by_cep : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach unless $c->req->param('latitude');
    $c->detach unless $c->req->param('longitude');

    $c->detach unless $c->req->param('latitude') =~ qr/^(\-?\d+(\.\d+)?)$/;
    $c->detach unless $c->req->param('longitude') =~ qr/^(\-?\d+(\.\d+)?)$/;

    my $lnglat =
      join( q/ /, $c->req->param('longitude'), $c->req->param('latitude') );

    my $api = $c->model('API');

    my $res = $api->stash_result(
        $c, 'goals',
        params => {
            lnglat => $lnglat
        }
    );
    $c->stash->{message} = 1 if $c->stash->{error};
    $c->stash->{without_wrapper} = 1;

}

sub comment : Chained('base') : PathParth('comment') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $user_id = $c->req->param('user_id');
    my $text    = $c->req->param('text');
    my $goal_id = $c->req->param('goal_id');

    $user_id = 53 if $c->req->param('user_id') eq "";
    $api->stash_result(
        $c,
        'comment_goals',
        method => 'POST',
        params =>
          { user_id => $user_id, description => $text, goal_id => $goal_id }
    );

    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body(
        JSON::encode_json(
            {
                message =>
'Seu comentário foi enviado para moderação, aguarde aprovação.'
            }
        )
    );
}

sub set_progress : Chained('base') : PathParth('set_progress') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $owned   = $c->req->param('owned');
    my $goal_id = $c->req->param('goal_id');

    my $remainder = 100 - $owned;
    $api->stash_result(
        $c,
        'progress_goal_counsil',
        method => 'POST',
        params =>
          { owned => $owned, remainder => $remainder, goal_id => $goal_id }
    );
    my $interation =
        'O conselheiro '
      . $c->user->obj->name
      . ' alterou a porcentagem para '
      . $owned . '%';

    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body(
        JSON::encode_json(
            { message => 'Alteração realizada com sucesso.' }
        )
    );
}

sub search_by_types : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;
    my $lat  = $c->req->param('latitude');
    my $long = $c->req->param('longitude');
    $lat  = "" unless $lat =~ qr/^(\-?\d+(\.\d+)?)$/;
    $long = "" unless $long =~ qr/^(\-?\d+(\.\d+)?)$/;

    my $lnglat = join( q/ /, $long, $lat ) if $lat && $long;

    my $type_id   = $c->req->param('type_id');
    my $region_id = $c->req->param('region_id');
    my $api       = $c->model('API');

    my $res = $api->stash_result(
        $c, 'goals',
        params => {
            region_id => $region_id ? $region_id : "",
            type_id   => $type_id   ? $type_id   : "",
            lnglat    => $lnglat    ? $lnglat    : ""
        }
    );
    $c->res->status(200);
    $c->detach( '/form/as_json', [ { goals => $c->stash->{goals} } ] );
}

=encoding utf8

=head1 AUTHOR

development,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
