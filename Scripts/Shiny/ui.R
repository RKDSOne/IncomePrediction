
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  # Not using titlepanel because I like titles centered
  title ="Estimating Income using Machine Learning",
  h1("Estimating Income using Machine Learning", align="center"),
  br(),
  
  fluidRow(
      column(4,
             wellPanel(
                 sliderInput("age",
                             "Age:",
                             min = 18,
                             max = 70,
                             value = 37),
                 sliderInput("hoursperweek",
                             "Hours Per Week:",
                             min = 10,
                             max = 80,
                             value = 40),
                 radioButtons("gender", "Gender:",
                              list("Male" = "Male",
                                   "Female" = "Female")),
                 selectInput("race", "Ethnicity:", 
                             choices = c("Caucasian", "American Indian", "Asia Pacific Islander", "African American", 
                                         "Other")),
                 selectInput("education", "Education Level:", 
                             choices = c("Bachelors", "10th", "11th", "12th",
                                         "1st-4th", "5th-6th", "7th-8th",
                                         "9th", "Associate Academic", "Associate Vocational",
                                         "Doctorate", "High School", 
                                         "Masters", "Preschool", "Professional School", 
                                         "College")),
                 selectInput("maritalstatus", "Marital Status:", 
                             choices = c("Married", "Divorced", 
                                         "Married Spouse Absent", "Never Married", "Separated", 
                                         "Widowed")),
                 selectInput("occupation", "Occupation:", 
                             choices = c("Administrative Clerical", "Armed Forces",
                                         "Craft Repair", "Executive Managerial", "Farming",
                                         "Cleaners", "Machine Operators", "Other Service Industry",
                                         "Private House Service", "Specialty Professional", "Protective Services",
                                         "Sales", "Tech Support", "Transport", "Other")),
                 selectInput("workclass", "Work Class:", 
                             choices = c("Federal Government", "Local Government", 
                                         "Never Worked", "Private", "Self-employed Incorporated", 
                                         "Self-employed Not Incorporated", "State Government", 
                                         "Without Pay", "Other")),   
                 selectInput("relationship", "Relationship Status:", 
                             choices = c("Husband", "Not in Family", "Other Relative", 
                                         "Own Child", "Unmarried", "Wife")),
                 submitButton("Update view")
             )
      ),
      column(8,
             p("
    The annual income of an individual can often be estimated from their social and professional characteristics. 
    This project uses Machines Learning to predict whether an individual would make more or less than 50,000 USD a year. 
    The training data is based on the ", a("adult dataset", href="https://archive.ics.uci.edu/ml/datasets/Adult"), "from UCI. 
    The data is from 1994, hence all the predictions are also for that year.
    The predictive model is based on random forest algorithm and has an accuracy of 82.1% and a Kappa of 49.4%.
               "),
             p("
    To use this app, please select the various individual characteristics on the left panel and click \"Update view\". 
    The application will then give you a prediction and where you stand in the various descriptive statistics gathered from the data.
               "),
             p("
        Please be patient as it might take a few seconds for the website to load.
               "),
                 
             h2(textOutput("oPrediction")),
             
             #         h4("Age: "),
             #         verbatimTextOutput("oAge"),
             #         h4("Hoursperweek: "),
             #         verbatimTextOutput("oHoursperweek"),
             #         h4("Gender: "),
             #         verbatimTextOutput("oGender"),
             #         h4("Relationship: "),
             #         verbatimTextOutput("oRelationship"),
             #         h4("Race: "),
             #         verbatimTextOutput("oRace"),
             #         h4("Education: "),
             #         verbatimTextOutput("oEducation"),
             #         h4("MaritalStatus: "),
             #         verbatimTextOutput("oMaritalStatus"),
             #         h4("Occupation: "),
             #         verbatimTextOutput("oOccupation"),
             #         h4("Workclass: "),
             #         verbatimTextOutput("oWorkclass"),
             fluidRow(
                 column(6, plotOutput("MaritalStatusHist")),
                 column(6, plotOutput("RelationshipHist"))
             ),
             fluidRow(
                 column(6, plotOutput("EducationHist")),
                 column(6, plotOutput("OccupationHist"))
             ),
             fluidRow(
                 column(6, plotOutput("WorkclassHist")),
                 column(6, plotOutput("RaceHist"))

             ),
             fluidRow(
                 column(6, offset=3, plotOutput("SexHist"))
             )
      )
    )
))
