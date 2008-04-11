#!/usr/bin/perl -w

use strict;
use Bugzilla::Testopia::TestCase;

my $vars = Bugzilla->hook_args->{vars};
my $cgi = Bugzilla->cgi;

if ($cgi->param('case_id')) {
    my $case = Bugzilla::Testopia::TestCase->new($cgi->param('case_id'));
    ThrowUserError("testopia-read-only", {'object' => $case}) unless $case->canedit;
    
    $case->attach_bug($vars->{'id'});

    $vars->{'case'} = $case;
}
if ($cgi->param('caserun_id')) {
    my $caserun = Bugzilla::Testopia::TestCaseRun->new($cgi->param('caserun_id'));
    ThrowUserError("testopia-read-only", {'object' => $caserun}) unless $caserun->canedit;
    
    $caserun->attach_bug($vars->{'id'});

    $vars->{'caserun'} = $caserun;
}

