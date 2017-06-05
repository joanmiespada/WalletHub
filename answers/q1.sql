SELECT name, votes, @ranking := @ranking +1 as rank FROM votes v,(SELECT @ranking:=0) r ORDER BY v.votes;
