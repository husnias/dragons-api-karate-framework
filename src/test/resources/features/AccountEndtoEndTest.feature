@Regression
Feature: Account Testing

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End to End Account testing
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    * def autoPlateNum = dataGenerator.getNumberPlate()
    * def autoPhoneNum = dataGenerator.getPhoneNumber()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      { 
      "email": "#(autoEmail)",
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
    #address
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = response.id
    And request
      """
      {
      
      "addressType": "House",
      "addressLine1": "32353 Sunrise street",
      "city": "woodbridge",
      "state": "VA",
      "postalCode": "22191",
      "countryCode": "string",
      "current": true
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.addressType == "House"
    #add car
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = response.id
    And request
      """
      {
      
      "make": "Audi",
      "model": "A6",
      "year": "2023",
      "licensePlate": "#(autoPlateNum )"
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.licensePlate == autoPlateNum
    #add phone
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = response.id
    And request
      """
      {      
      "phoneNumber": "#(autoPhoneNum)",
      "phoneExtension": "205",
      "phoneTime": "Morning",
      "phoneType": "cell"
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.phoneNumber == autoPhoneNum
    #Get account
    Given path "/api/accounts/get-account"
    And param primaryPersonId = response.id
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
    
