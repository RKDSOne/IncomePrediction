
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(stringr)
library(caret)
library(randomForest)
library(e1071)
library(ggplot2)

all = read.csv("CleanData.csv")
load(file="fit.obj")
#prp = predict(fit, newdata=val)
#cm = confusionMatrix(prp, val$income)
pred = "Unknown"

getPrediction = function(newdata) {
    predict(fit, newdata=newdata)
}

shinyServer(function(input, output) {
    pred = reactive({
        newdata = data.frame(age=input$age, workclass=input$workclass, education=input$education, 
                             marital.status=input$maritalstatus, occupation=input$occupation,
                             relationship=input$relationship, race=input$race, sex=input$gender,
                             hour.per.week=input$hoursperweek)
        getPrediction(newdata)
    })
    output$oAge = renderPrint({input$age})
    output$oHoursperweek = renderPrint({input$hoursperweek})
    output$oGender = renderPrint({input$gender})
    output$oRelationship = renderPrint({input$relationship})
    output$oRace = renderPrint({input$race})
    output$oEducation = renderPrint({input$education})
    output$oMaritalStatus = renderPrint({input$maritalstatus})
    output$oOccupation = renderPrint({input$occupation})
    output$oWorkclass = renderPrint({input$workclass})
    #output$oPrediction = renderPrint(cm)
    
#     output$oPrediction = renderPrint({
#         newdata = data.frame(age=input$age, workclass=input$workclass, education=input$education, 
#                              marital.status=input$maritalstatus, occupation=input$occupation,
#                              relationship=input$relationship, race=input$race, sex=input$gender,
#                              hour.per.week=input$hoursperweek);
#         x = predict(fit, newdata=newdata); 
#         
#     })

     output$oPrediction = renderText({
#         newdata = data.frame(age=input$age, workclass="Private", education="Bachelors", 
#                              marital.status="Married", occupation="Sales",
#                              relationship="Husband", race="Caucasian", sex="Male",
#                              hour.per.week=20)
#     x = predict(fit, newdata=newdata)
        ifelse(pred() == "<=50K", 
           "Prediction: You will make less than 50K", 
           "Prediction: You will make more than 50K")
    })
    

    output$OccupationHist <- renderPlot({
        all$coccupation = ifelse(all$occupation==input$occupation & all$income==pred(), TRUE, FALSE)
        ggplot(all, aes(x=occupation, fill=income, alpha=coccupation)) + 
            geom_bar(position="fill", binwidth=1) + theme_bw() + 
            scale_alpha_discrete(range=c(0.5, 1), guide=FALSE) + coord_flip() +
            ggtitle("Occupation") + ylab("Income Distribution") + xlab("") +
            theme(panel.grid.minor=element_blank(), 
                  panel.grid.major=element_blank(),
                  legend.position = "bottom")
    })

    output$RaceHist <- renderPlot({
        all$crace = ifelse(all$race==input$race & all$income==pred(), TRUE, FALSE)
        ggplot(all, aes(x=race, fill=income, alpha=crace)) + 
            geom_bar(position="fill", binwidth=1) + theme_bw() + 
            scale_alpha_discrete(range=c(0.5, 1), guide=FALSE) + coord_flip() +
            ggtitle("Ethnicity") + ylab("Income Distribution") + xlab("") +
            theme(panel.grid.minor=element_blank(), 
                  panel.grid.major=element_blank(),
                  legend.position = "bottom")
    })

    output$WorkclassHist <- renderPlot({
    all$cworkclass = ifelse(all$workclass==input$workclass & all$income==pred(), TRUE, FALSE)
    ggplot(all, aes(x=workclass, fill=income, alpha=cworkclass)) + 
        geom_bar(position="fill", binwidth=1) + theme_bw() + 
        scale_alpha_discrete(range=c(0.5, 1), guide=FALSE) + coord_flip() +
        ggtitle("Work Class") + ylab("Income Distribution") + xlab("") +
        theme(panel.grid.minor=element_blank(), 
              panel.grid.major=element_blank(),
              legend.position = "bottom")
    })

    output$EducationHist <- renderPlot({
    all$ceducation = ifelse(all$education==input$education & all$income==pred(), TRUE, FALSE)
    ggplot(all, aes(x=education, fill=income, alpha=ceducation)) + 
        geom_bar(position="fill", binwidth=1) + theme_bw() + 
        scale_alpha_discrete(range=c(0.5, 1), guide=FALSE) + coord_flip() +
        ggtitle("Education") + ylab("Income Distribution") + xlab("") +
        theme(panel.grid.minor=element_blank(), 
              panel.grid.major=element_blank(),
              legend.position = "bottom")
    })

    output$MaritalStatusHist <- renderPlot({
    all$cmarital.status = ifelse(all$marital.status==input$maritalstatus & all$income==pred(), TRUE, FALSE)
    ggplot(all, aes(x=marital.status, fill=income, alpha=cmarital.status)) + 
        geom_bar(position="fill", binwidth=1) + theme_bw() + 
        scale_alpha_discrete(range=c(0.5, 1), guide=FALSE) + coord_flip() +
        ggtitle("Marital Status") + ylab("Income Distribution") + xlab("") +
        theme(panel.grid.minor=element_blank(), 
              panel.grid.major=element_blank(),
              legend.position = "bottom")
    })

    output$RelationshipHist <- renderPlot({
    all$crelationship = ifelse(all$relationship==input$relationship & all$income==pred(), TRUE, FALSE)
    ggplot(all, aes(x=relationship, fill=income, alpha=crelationship)) + 
        geom_bar(position="fill", binwidth=1) + theme_bw() + 
        scale_alpha_discrete(range=c(0.5, 1), guide=FALSE) + coord_flip() +
        ggtitle("Relationship") + ylab("Income Distribution") + xlab("") +
        theme(panel.grid.minor=element_blank(), 
              panel.grid.major=element_blank(),
              legend.position = "bottom")
    })

    output$SexHist <- renderPlot({
    all$csex = ifelse(all$sex==input$gender & all$income==pred(), TRUE, FALSE)
    ggplot(all, aes(x=sex, fill=income, alpha=csex)) + 
        geom_bar(position="fill", binwidth=1) + theme_bw() + 
        scale_alpha_discrete(range=c(0.5, 1), guide=FALSE) + coord_flip() +
        ggtitle("Gender") + ylab("Income Distribution") + xlab("") +
        theme(panel.grid.minor=element_blank(), 
              panel.grid.major=element_blank(),
              legend.position = "bottom")
    })

})
