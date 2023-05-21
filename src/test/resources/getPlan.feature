@Regression
Feature: get Plan code

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Test Api EndPoint
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
