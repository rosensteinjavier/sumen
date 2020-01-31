package SMM::Schema::ResultSet::ProjectAcceptPorcentage;
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
                user_id => {
                    required => 1,
                    type     => 'Int',
                },
                progress => {
                    required => 1,
                    type     => 'Str',
                },
                project_id => {
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
            my %values = shift->valid_values;
            not defined $values{$_} and delete $values{$_} for keys %values;

            my $project_event = $self->create( \%values );
            return $project_event;
        }
    };
}

1;
