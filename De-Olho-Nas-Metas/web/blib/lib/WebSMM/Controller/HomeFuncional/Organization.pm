package WebSMM::Controller::HomeFuncional::Organization;
use Moose;
use namespace::autoclean;
use JSON;
use Path::Class qw(dir);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Goal - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('organization') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $api = $c->model('API');
    $api->stash_result(
        $c,
        [ 'organizations', $id ],
        stash => 'organization_obj'
    );
    if ( $c->user ) {
        $api->stash_result(
            $c,
            [ 'users', $c->user->obj->id ],
            stash => 'user_obj',
        );
        $c->stash->{user_obj}->{role} =
          { map { $_ => 1 } @{ $c->stash->{user_obj}->{roles} } };
        $c->stash->{do_i_follow} =
          grep { $_ eq $id } @{ $c->stash->{user_obj}->{counsils_i_follow} };
    }

}

sub detail : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c, $id ) = @_;
    my $api = $c->model('API');

}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api               = $c->model('API');
    my $organization_type = $c->req->params->{organization_type}
      if $c->req->params->{organization_type};
    $api->stash_result( $c, 'subprefectures' );
    $api->stash_result(
        $c, 'organizations',

        params =>
          { organization_type => $organization_type ? $organization_type : '' }
    );
    $api->stash_result( $c, 'organization_types' );

    my $group_by = {};
    push @{ $group_by->{ uc( substr( $_->{name}, 0, 1 ) ) } }, $_
      for @{ $c->stash->{organizations} };
    push @{ $group_by->{count} }, scalar( @{ $c->stash->{organizations} } );

    $c->stash->{select_organization_types} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{organization_types} } ];
    $c->stash->{organizations} = $group_by;
    my @order = sort keys %$group_by;
    $c->stash->{order} = \@order;

}

sub user_follow_counsil : Chained('base') : PathPart('user_follow_counsil') :
  Args(0) {

    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $user_id    = $c->req->param('user_id');
    my $counsil_id = $c->req->param('counsil_id');

    $api->stash_result(
        $c,
        'user_follow_counsil',
        method => 'POST',
        params => { user_id => $user_id, counsil_id => $counsil_id },
    );
    $c->res->status(400), $c->detach unless $c->stash->{counsil};
    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body( JSON::encode_json( $c->stash->{counsil} ) );

}

sub user_stop_counsil : Chained('base') : PathPart('user_stop_counsil') :
  Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $user_id    = $c->req->param('user_id');
    my $counsil_id = $c->req->param('counsil_id');

    $api->stash_result(
        $c, [ 'users', $user_id, 'counsil', $counsil_id ],
        method => 'POST',
        stash  => 'counsil'
    );
    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body( JSON::encode_json( $c->stash->{counsil} ) );

}

sub edit : Chained('base') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $params = { %{ $c->req->params } };

    my $organization_id = $c->user->obj->organization_id;

    $api->stash_result(
        $c, [ 'organizations', $organization_id ],
        params => $params,
        method => 'PUT',
    );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }

    my $avatar = $c->req->upload('avatar');

    if ($avatar) {
        my $path =
          dir( $c->config->{organization_picture_path} )->resolve . '/'
          . $organization_id;
        unless ( -e $path ) {
            mkdir $path;
        }

        $avatar->copy_to( $path . '/' . $organization_id . '.jpg' );
    }

    $c->detach( '/form/redirect_ok',
        [ \'/user/perfil/conselho', {}, 'Cadastrado com sucesso!', ] );

    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body( JSON::encode_json( $c->stash->{counsil} ) );

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
