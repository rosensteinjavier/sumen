package SMM::Controller::API::OrganizationType;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::OrganizationType',
    object_key  => 'organization_type',
    result_attr => {},
    search_ok   => {
        id => 'Int'
    },

    update_roles =>
      [qw/superadmin user admin webapi organization counsil counsil_master/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('organization_types') :
  CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $organization = $c->stash->{organization_type};
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $organization->$_, }
                  qw/
                  id
                  name
                  type
                  /
            ),

        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $organization = $c->stash->{organization_type};

    $organization->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params       = { %{ $c->req->params } };
    my $organization = $c->stash->{organization_type};

    $organization->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $organization->id ] )
          ->as_string,
        entity => { id => $organization->id }
      ),
      $c->detach
      if $organization;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

    $rs = $rs->search( undef, { order_by => { -asc => [qw/me.name/] } } );
    $self->status_ok(
        $c,
        entity => {
            organization_types => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              type
                              /
                        ),
                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $organization = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $organization->id ] )
          ->as_string,
        entity => {
            id => $organization->id
        }
    );
}

1;
