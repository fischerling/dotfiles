function register_mail -a email description website
	ssh muhq@muhq.space "echo \"$email;$description;$website\" >> email-addressen.csv"
end
