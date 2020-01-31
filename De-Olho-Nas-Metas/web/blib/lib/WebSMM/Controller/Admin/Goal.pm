package WebSMM::Controller::Admin::Goal;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::Admin::Goal - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/admin/base') : PathPart('goal') : CaptureArgs(0) {
    my ( $self, $c, $id ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    print "\n id:", $id;
    my $api = $c->model('API');

    $api->stash_result( $c, [ 'goals', $id ], stash => 'goal_obj' );

}

sub detail : Chained('object') : PathPart('') Args(0) {
    my ( $self, $c ) = @_;
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'goals' );
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, 'objectives' );
    $c->stash->{select_objectives} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{objectives} } ];

}

sub upload : Chained('base') : ParthPart('upload') : Args(0) {
    my ( $self, $c ) = @_;
}

sub edit : Chained('object') : PathPart('edit') : Args(0) {
    my ( $self, $c, $id ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, 'objectives' );
    $c->stash->{select_objectives} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{objectives} } ];

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
