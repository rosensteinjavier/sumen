package SMM::Controller::API::Organization;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::Organization',
    object_key  => 'organization',
    result_attr => { prefetch => [ { 'city' => 'state' }, 'subprefecture', 'user_follow_counsils' ] },
    search_ok => { id => 'Int' },

    update_roles => [qw/superadmin user admin webapi organization counsil counsil_master/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('organizations') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
}

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') {
}

sub result_GET {
    my ( $self, $c ) = @_;

    my $organization = $c->stash->{organization};

    my @campaigns = $organization->campaigns->search( undef, { prefetch => 'events' } )->all;
    my $follow_counsil = $organization->user_follow_counsils->search( { active => 1 } )->count;
    use DDP;
    p $organization;

    my $subpref;
    $subpref =
      map { $_ ? ( +{ id => $_->id, name => $_->name, latitude => $_->latitude, longitude => $_->longitude, } ) : () }
      ( $organization->subprefecture )
      if $organization->subprefecture;

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $organization->$_, }
                  qw/
                  id
                  name
                  address
                  postal_code
                  description
                  phone
                  email
                  website
                  subprefecture_id
                  /
            ),
            follow_counsil => $follow_counsil,
            city           => {
                $organization->city
                ? (
                    (
                        map { $_ => $organization->city->$_, }
                          qw/
                          id
                          name
                          /
                    ),
                    state => {
                        (
                            map { $_ => $organization->city->state->$_, }
                              qw/
                              id
                              name
                              /
                        )
                    }
                  )
                : (),
            },
            events => [
                map {
                    my $c = $_;
                    map {
                        my $e = $_;
                        (
                            +{

                                id          => $e->id,
                                name        => $e->name,
                                description => $e->description,
                                date        => $e->date->datetime,

                            }
                          )
                      } ( $c->events ),
                  } (@campaigns),

            ],
            campaigns => [
                map {
                    my $e = $_;
                    (
                        +{

                            id          => $e->id,
                            name        => $e->name,
                            description => $e->description,
                            start_in    => $e->start_in->datetime,
                            end_on      => $e->end_on->datetime,
                            address     => $e->address,
                        }
                      )
                  } (@campaigns),

            ],

            subprefecture => $subpref

        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $organization = $c->stash->{organization};

    $organization->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params       = { %{ $c->req->params } };
    my $organization = $c->stash->{organization};

    $organization->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location => $c->uri_for( $self->action_for('result'), [ $organization->id ] )->as_string,
        entity => { id => $organization->id }
      ),
      $c->detach
      if $organization;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') {
}

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

    if ( $c->req->params->{organization_type} ) {
        $rs = $rs->search( { 'organization_type.id' => $c->req->params->{organization_type} },
            { join => ['organization_type'] } );
    }
    $rs = $rs->search( undef, { order_by => { -asc => [qw/me.name/] } } );
    $self->status_ok(
        $c,
        entity => {
            organizations => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              address
                              postal_code
                              description
                              phone
                              email
                              website
                              complement
                              /
                        ),
                        city => {
                            (
                                map { $_ => $r->{city}{$_}, }
                                  qw/
                                  id
                                  name
                                  /
                            ),
                            state => {
                                (
                                    map { $_ => $r->{city}{state}{$_}, }
                                      qw/
                                      id
                                      name
                                      /
                                )
                            }
                        },
                        url => $c->uri_for_action(
                            $self->action_for('result'),
                            [ $r->{id} ]
                        )->as_string
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $organization = $c->stash->{collection}->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'), [ $organization->id ] )->as_string,
        entity => { id => $organization->id }
    );
}

sub subpref : Chained('base') : Args(0) {
}

1;
