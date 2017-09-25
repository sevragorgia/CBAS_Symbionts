

presence_absence_data<-read.csv("/mnt/localspace/s.vargas/Data/Bacterial_Phylogenomic/Cyanobacteria/Protein_Presence_Absence_by_genome.csv", sep="\t")
head(presence_absence_data)

library(ggplot2)

ggplot(presence_absence_data, aes(Genome, fill=Presence.Absence))+geom_bar()
ggplot(presence_absence_data, aes(Protein, fill=Presence.Absence))+geom_bar()



