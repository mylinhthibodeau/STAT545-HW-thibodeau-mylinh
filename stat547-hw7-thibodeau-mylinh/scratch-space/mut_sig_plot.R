
suppressMessages(library(tidyverse))

mut_sig.txt %>%
	group_by("Substitution.Type") %>%
	ggplot(aes(x=Substitution.Type, y=Signature.3)) +
	geom_point()
	