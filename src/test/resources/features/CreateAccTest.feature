@Regression
Feature: Create Account Test

  Background: API Test Setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      { "email":"#(autoEmail)" ,
      		"firstName": "HusniaS",
      		"lastName": "sidiqi","title": "Ms.",
      		"gender": "FEMALE","maritalStatus": "MARRIED",
      		"employmentStatus": "student",
      		"dateOfBirth": "1988-07-17"
      		} 
      """
    When method post
    Then status 201
    Then print response
    And assert response.email == autoEmail
