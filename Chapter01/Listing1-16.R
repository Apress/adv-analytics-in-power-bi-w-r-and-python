library(tidyverse)
set.seed(50)
probs <- c(0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033,
0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.01, 0.01, 0.01,
0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.015, 0.015, 0.015, 0.015,
0.015, 0.015, 0.015, 0.015, 0.015, 0.015, 0.0133, 0.0133, 0.0133, 0.0133,
0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133,
0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133,
0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.0133, 0.017,
0.015, 0.015, 0.015, 0.015, 0.015, 0.015, 0.015, 0.015, 0.015, 0.01, 0.01,
0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.0033, 0.0033, 0.0033,
0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033, 0.0033,
0.0033, 0.0033, 0.0033)
weights <- 265:364
names <- c("Liam Galles", "Noah Raymond", "William Hammontree",
           "James Zaremba", "Oliver Zurcher", "Benjamin Hilker", "Elijah Loken",
            "Lucas Lewter", "Mason Straus", "Logan Work", "Alexander Jarret",
            "Ethan Wey", "Jacob Adolphsen", "Michael Solt", "Daniel Welcome", 
            "Henry Portman", "Jackson Tichenor", "Sebastian Free", "Aiden Papp",
            "Matthew Lenzi", "Samuel Rinaldo", "David Goines", "Joseph Asuncion",
            "Carter Philhower", "Owen Freeborn", "Wyatt Ice",
            "John Mcguckin", "Jack Soden", "Luke Humfeld", "Jayden Natera",
            "Dylan Galles", "Grayson Raymond", "Levi Hammontree", "Isaac Zaremba",
            "Gabriel Zurcher", "Julian Hilker", "Mateo Loken", "Anthony Lewter",
            "Jaxon Straus", "Lincoln Work", "Joshua Jarret", "Christopher Wey",
            "Andrew Adolphsen", "Theodore Solt", "Caleb Welcome",
            "Ryan Portman", "Asher Tichenor", "Nathan Free", "Thomas Papp",
            "Leo Lenzi", "Isaiah Rinaldo", "Charles Goines", "Josiah Asuncion",
            "Hudson Philhower", "Christian Freeborn", "Hunter Ice",
            "Connor Mcguckin", "Eli Soden", "Ezra Humfeld", "Aaron Natera",
            "Landon Galles", "Adrian Raymond", "Jonathan Hammontree",
            "Nolan Zaremba", "Jeremiah Zurcher", "Easton Hilker", "Elias Loken",
            "Colton Lewter", "Cameron Straus", "Carson Work", "Robert Jarret",
            "Angel Wey", "Maverick Adolphsen", "Nicholas Solt", "Dominic Welcome",
            "Jaxson Portman", "Greyson Tichenor", "Adam Free", "Ian Papp",
            "Austin Lenzi", "Santiago Rinaldo", "Jordan Goines", "Cooper Asuncion",
            "Brayden Philhower", "Roman Freeborn", "Evan Ice", "Ezekiel Mcguckin",
            "Xavier Soden", "Jose Humfeld", "Jace Natera", "Jameson Adolphsen",
            "Leonardo Solt", "Bryson Welcome", "Axel Portman", "Everett Tichenor",
            "Parker Free", "Kayden Papp", "Miles Lenzi", "Sawyer Rinaldo", "Jason Goines"
        )

linemen_weights <- sample(weights, 100, replace = TRUE, prob= probs)
plot.data <- data.frame(names, linemen_weights)

ggplot(plot.data, aes(linemen_weights)) +
    geom_histogram(binwidth = 20) +
    labs(title = "geom_histogram") +
    theme_minimal()