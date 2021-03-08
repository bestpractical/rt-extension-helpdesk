use strict;
use warnings;
package RT::Extension::HelpDesk;

our $VERSION = '0.01';

=head1 NAME

RT-Extension-HelpDesk - Simple help desk vertical for RT.

=head1 DESCRIPTION

This extension provides a simple L<initialdata|https://docs.bestpractical.com/rt/latest/initialdata.html/> file
to insert some sane help desk defaults. See the L<CONFIGURATION|CONFIGURATION> section for more information
on these defaults.

=head1 RT VERSION

Works with RT 5.

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item C<make initdb>

Only run this the first time you install this module.

If you run this twice, you may end up with duplicate data
in your database.

If you are upgrading this module, check for upgrading instructions
in case changes need to be made to your database.

=item Edit your F</opt/rt5/etc/RT_SiteConfig.pm>

Add this line:

    Plugin('RT::Extension::HelpDesk');

=item Clear your mason cache

    rm -rf /opt/rt5/var/mason_data/obj

=item Restart your webserver

=back


=head1 WHAT THIS EXTENSION DOES

This extension adds some useful help desk configurations to get started.

It create a new queue, the L<Support Queue> for tracking all of the incoming help desk requests.
On this queue some sensible default rights are set. The first group granted rights is the "Everyone" group.
This is an "internal" group to RT, and as the name implies it encompasses every user in RT.

=begin HTML

<p><img width="500px" src="https://static.bestpractical.com/images/helpdesk/everyone_group_rights.png"
alt="Group rights for 'Everyone' group on 'Support' queue" /></p>

=end HTML

With a typical support desk setup, these rights are exactly whats needed. Anyone is able to write into our support
address with a help desk question, and they can always reply and follow-up on that request.

It is also desirable to have a group to track and elevate the rights of our support representatives. The L<Support Group>
is created for just this purpose.

=begin HTML

<p><img width="500px" src="https://static.bestpractical.com/images/helpdesk/support_group_rights.png"
alt="Group rights for 'Support' group on 'Support' queue" /></p>

=end HTML

Here additional rights are granted to the support representatives, mainly the rights center around being able to
own and edit tickets in the support queue.

Since we have a specific queue for help desk request it also makes a lot of sense to make a specific workflow for these
request. In RT a ticket workflow is known as the L<Lifecycle|https://docs.bestpractical.com/rt/latest/customizing/lifecycles.html>.

=begin HTML

<p><img width="500px" src="https://static.bestpractical.com/images/helpdesk/support_lifecycle.png"
alt="Lycycle for 'Support' queue" /></p>

=end HTML

The support lifecycle here uses custom statuses such as "waiting for customer" and "waiting for support" for which we can enable some
handy automation around.

The automation applied to the support queue is designed to allow support reps to more easily keep track of support
request that they should be working on. There are two new "Scrips" ( A scrip is the internal automation for RT ) that
are added L<On Requestor Correspond Update Status To "waiting for support"> and L<On Non-Requestor Correspond Update Status To "waiting for customer">.
These scrips handle switching the status of a support ticket based on who last updated the ticket, the customer or the support rep.

This allows for the support rep to know based on the status of a ticket, whether the customer is waiting to hear back from them
or they are waiting to hear back from the customer.

=head1 CONFIGURATION

=over

=item Support Queue

This extension creates a new queue named "Support". This queue is
where incoming support request should be created.

=item Support Group

This group is created by the extension and granted rights to perform typical
support opperations on tickets in the support group. You should add any support
representative users to this group.

=item On Requestor Correspond Update Status To "waiting for support"

Automation to switch ticket status to "waiting for support" when a requestor replies to a ticket,
the requestor is typically the customer who is asking for support.

=item On Non-Requestor Correspond Update Status To "waiting for customer"

Automation to switch ticket status to "waiting for customer" when a user
who is not a requestor on the ticket replies on the ticket. This usually means
the support representative in charge of the ticket sent an email to the customer
and is waiting for some feedback.

=back

=head1 AUTHOR

Best Practical Solutions, LLC E<lt>modules@bestpractical.comE<gt>

=for html <p>All bugs should be reported via email to <a
href="mailto:bug-RT-Extension-HelpDesk@rt.cpan.org">bug-RT-Extension-HelpDesk@rt.cpan.org</a>
or via the web at <a
href="http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-HelpDesk">rt.cpan.org</a>.</p>

=for text
    All bugs should be reported via email to
        bug-RT-Extension-HelpDesk@rt.cpan.org
    or via the web at
        http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-HelpDesk

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2021 by Best Practical LLC

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
