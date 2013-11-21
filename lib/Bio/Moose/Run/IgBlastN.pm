use MooseX::Declare;
use Method::Signatures::Modifiers;

class Bio::Moose::Run::IgBlastN {
    with 'MooseX::Role::Cmd';

    sub build_bin_name { 'igblastn' }

    has 'query' => (
        is            => 'rw',
        isa           => 'Str|Path::Class::File',
        required      => 1,
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        documentation => 'Input Fasta file',
    );

    has 'igdata' => (
        is     => 'rw',
        isa    => 'Str',
        traits => ['CmdOpt'],
        cmdopt_env => 'IGDATA',
        required   => 1,
        default    => '/work/bioinformatics/igblast'
    );

    #Implementing all options from igblastn
    has 'germline_db_V' => (
        is            => 'rw',
        isa           => 'Str',
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        documentation => 'Germline DB V',
    );

    has 'germline_db_D' => (
        is            => 'rw',
        isa           => 'Str',
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        documentation => 'Germline DB D',
    );

    has 'germline_db_J' => (
        is            => 'rw',
        isa           => 'Str',
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        documentation => 'Germline DB J',
    );

    has 'organism' => (
        is            => 'rw',
        isa           => 'Str',
        default       => 'human',
        required      => 1,
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        documentation => 'Organism',
    );

    has 'domain_system' => (
        is            => 'rw',
        isa           => 'Str',
        default       => 'kabat',
        required      => 1,
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        documentation => 'Domain System [imgt or kabat]',
    );

    has 'auxiliary_data' => (
        is            => 'rw',
        isa           => 'Str',
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',

    );

    has 'show_translation' => (
        is            => 'rw',
        isa           => 'Bool',
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        default       => 1,
    );

    has 'outfmt' => (
        is            => 'rw',
        isa           => 'Int',
        traits        => ['CmdOpt'],
        cmdopt_prefix => '-',
        default       => 4,
        required      => 1,
        documentation => 'Output format [3,4 or 7]',
    );

    method _build_cmd_line {
        my @args = $self->cmd_args;
        my $arg_line = join " ", @args;
        return 'command: "'.$ENV{IGDATA} . $self->bin_name . ' ' . $arg_line . '"';
    }

    method out_as_string {
        $self->run();
        my $str;
        $str .= $_ foreach @{$self->stdout};
        return $str;
    }

}
