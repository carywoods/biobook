use DBI and then connected
to a particular database system using the appropriate driver module, then the
database system can be changed at any time without severely impacting the
program2. All that is required is to change the program to use the driver module
for the newly selected database system. This typically involves changing only a
single line of code. Everything else stays the same.
In practice, each driver includes a series of ''enhancements'' that provide a
mechanism to access database system-specific functionality. Although this can
be very convenient, it is best avoided, as accessing database system-specific
functionality defeats the whole purpose of using DBI in the first place.
Maxim 13.1 If at all possible,
avoid the use of database driver ''enhancements''.
requires more work from the programmer than does DBI.