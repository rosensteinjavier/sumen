package SMM::Schema::ResultSet::Organization;
use namespace::autoclean;

use utf8;
use Moose;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;
extends 'DBIx::Class::ResultSet';
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::InflateAsHashRef';

use Data::Verifier;

sub verifiers_specs {
    my $self = shift;
    return {
        create => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name => {
                    required => 1,
                    type     => 'Str',
                },
                address => {
                    required => 0,
                    type     => 'Str',
                },
                postal_code => {
                    required => 0,
                    type     => 'Str',
                },
                city_id => {
                    required => 0,
                    type     => 'Int',
                },
                description => {
                    required => 0,
                    type     => 'Str',
                },
                phone => {
                    required => 0,
                    type     => 'Str',
                },
                email => {
                    required => 0,
                    type     => 'Str',
                },
                website => {
                    required => 0,
                    type     => 'Str',
                },
                subprefecture_id => {
                    required => 0,
                    type     => 'Int',
                },
                organization_type_id => {
                    required => 1,
                    type     => 'Int',
                },
            }
        )
    };
}

sub action_specs {
    my $self = shift;
    return {
        create => sub {
            my %values       = shift->valid_values;
            my $organization = $self->create( \%values );
            return $organization;
        }
    };
}

1;
